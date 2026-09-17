# How It Works

A walkthrough of the design, for people. If you are an AI assistant looking for what to
actually do, read [`generation-procedure.md`](generation-procedure.md) instead — this
file explains the shape of the system, not the steps.

Three questions get answered here: does this run on any machine, what happens when you
start it somewhere new, and what actually occurs when someone generates a document.

---

## 1. One brain, many mouths

The framework supports Claude Code, OpenAI Codex, GitHub Copilot, opencode, Devin,
Cursor and anything else that reads `AGENTS.md`. It does that without maintaining six
versions of anything.

All the logic lives in exactly one file. Everything else points at it.

```
                  +--------------------------------------+
                  |  docs/generation-procedure.md        |
                  |  278 lines -- ALL the logic          |
                  |  tool-neutral: zero vendor names     |
                  +-------------------^------------------+
                                      |  "read this and follow it"
    +-----------+-----------+---------+-------+-----------+---------------+
  Codex      Copilot     opencode           Devin    Claude Code    anything else
 37 lines    38 lines    40 lines          README     51 lines     (AGENTS.md only)
```

The four invocable adapters total **166 lines against the procedure's 278**. None of
them contains generation logic — each declares a command in its tool's own format and
then delegates.

That ratio is the whole point. Change how a document gets generated and you change one
file; every assistant inherits it. There is no drift to police, because there is nothing
to keep in sync.

The procedure earns the word "neutral" literally: it names no vendor's tool. Instead of
`Glob` or `WebFetch` it says "list files matching a pattern" and "fetch a URL". A
[purity check](compatibility.md) enforces this — the neutral files are grepped for
vendor tool names and must come back empty.

## 2. How an assistant finds it

Two discovery mechanisms, working together rather than competing.

### Automatic: `AGENTS.md`

The cross-tool standard. Codex, Copilot, Devin, opencode, Cursor, Windsurf, Zed and
Aider read it from the directory you start in, with no configuration. There is one at
each level, so you are oriented wherever you land:

| You start in | It loads | Where it sends you |
|--------------|----------|--------------------|
| Your config repo (the usual place) | `<config-repo>/AGENTS.md` | `../confluence-framework/docs/generation-procedure.md` |
| `confluence-framework/` | `confluence-framework/AGENTS.md` | The procedure, plus what to read per task |

Both files are versioned, so they arrive with a clone — there is nothing to create by
hand.

Claude Code is the exception: it reads `CLAUDE.md`, whose first line is `@AGENTS.md`.
Same source, different entry point.

### Invocable: the adapter

Each assistant declares commands in its own format. This is where the real differences
live — and they are entirely about syntax:

| Assistant | Adapter file | Argument style |
|-----------|--------------|----------------|
| OpenAI Codex | `~/.codex/prompts/doc-confluence.md` | positional `$1 $2 $3` |
| GitHub Copilot | `.github/prompts/doc-confluence.prompt.md` | `${input:type:...}`, needs `mode: agent` |
| opencode | `.opencode/commands/doc-confluence.md` | `$ARGUMENTS`, with `agent: build` |
| Claude Code | `.claude/skills/doc-confluence/SKILL.md` | `$tipo $tema $target` |

All four are invoked the same way: `/doc-confluence`. Install commands per assistant are
in [`compatibility.md`](compatibility.md) and [`../adapters/README.md`](../adapters/README.md).

**None of them is required.** The first mechanism is enough on its own: an assistant that
has read `AGENTS.md` will follow the procedure from a plain-language request, and the
procedure asks for the type and subject anyway. The adapters exist so you can type
`/doc-confluence api-spec Payments` instead of a sentence — they change the ergonomics,
not what is possible.

Devin has no slash commands. It follows `AGENTS.md` from a plain request — see
[`../adapters/devin/README.md`](../adapters/devin/README.md).

## 3. What happens when someone generates a document

Say you type `/doc-confluence api-spec "Payments Service"`. Each step below links to the
rule that governs it; the rules themselves live only in the procedure.

| Step | What happens | What you see |
|------|--------------|--------------|
| [0](generation-procedure.md#step-0-resolve-the-roots) | A POSIX `sh` block locates the config repo and the framework by searching `.`, `..` and siblings, reading the `Framework path` row to confirm | Two **absolute** roots printed, plus the config, the standards header and the `api-spec` template preloaded -- one call |
| [1](generation-procedure.md#step-1-read-the-project-configuration) | Reads the project's values | Prefix `ACME`, space `ACMEWEB`, language, frentes |
| [2](generation-procedure.md#step-2-resolve-the-source) | Decides where technical detail comes from: your third argument, else the `Code Repositories` row for the frente, else it asks | The source it settled on. Relative paths resolve from the config repo, never the current directory |
| [3](generation-procedure.md#step-3-validate-the-document-type) | Checks `api-spec` is one of the eleven types | The valid list, if you got it wrong |
| [4](generation-procedure.md#step-4-gather-information) | Asks only for what it cannot read from code | For `api-spec`: service name, endpoints, authentication |
| [5](generation-procedure.md#step-5-analyze-the-source) | Reads the source, guided by a per-type table -- for `api-spec`, OpenAPI files, route definitions, auth middleware | Real values extracted from your code, not guesses |
| [6](generation-procedure.md#step-6-generate-the-document) | Fills the template | Title `[ACME-BACK] API Specification -- Payments Service`, mandatory labels, Page Properties table |
| [7](generation-procedure.md#step-7-resolve-the-output-path) | Files it under a folder named for the source | `output/payments-api/api-spec_payments-service_2026-09-07.md` |
| [8](generation-procedure.md#step-8-delivery-summary) | Reports what it did | Resolved roots, source analyzed, folder used, remaining placeholders |

Two rules run through all of it, and they are the reason the output is trustworthy:
nothing that could not be extracted from the source or supplied by you is invented — it
stays a `{placeholder}` — and no secret **value** is ever copied out of a `.env` or CI
file, only variable names plus a pointer to the project's secrets manager.

**Steps 0 through 8 are the same file in every assistant.** Not equivalent
implementations — the same 278 lines, read at runtime.

## 4. Where they actually diverge

Three things differ between assistants. Two are cosmetic. One is not.

| | Differs how | Matters? |
|---|---|---|
| Discovery | `AGENTS.md` vs `CLAUDE.md` vs `.github/copilot-instructions.md` | No -- all reach the same procedure |
| Command syntax | `$1` vs `${input:...}` vs `$ARGUMENTS` | No -- the adapter absorbs it |
| **Reading outside the starting repo** | Filesystem access, per assistant | **Yes** |

That third one decides whether **Mode B** works — running from the config repo and
pointing at an external local path, instead of putting an instruction file inside the
code repo.

- **Local CLI assistants** (Claude Code, Codex, opencode) run on your machine with real
  filesystem access. Mode B works once the folder is granted.
- **Editor-embedded assistants** (Copilot, Cursor, Windsurf) are scoped to the open
  workspace. Add the target repo as a second workspace folder and it works.
- **Cloud agents** (Devin) run in a VM built from a Git repo. They have no path to your
  local disk. **Mode B is impossible** — and no adapter can fix that, because it is an
  architectural property, not a formatting one.

When Mode B is unavailable the framework still works: use Mode A (an `AGENTS.md` inside
the code repo), or pass a URL as the source, which cloud agents can fetch.

The per-assistant matrix, and how each one grants folder access, is in
[`compatibility.md`](compatibility.md).

## Does it run on any machine?

Yes, with two caveats worth knowing up front.

The framework is plain markdown — no dependencies, no build, no runtime. Setup is
cloning two repos as siblings and copying one adapter file. macOS, Linux, WSL and
Windows via Git Bash all work; the shell block carries explicit guards for Windows path
formats and CRLF checkouts.

The caveats: **Mode B depends on your assistant**, per the table above. And a config
repo shared across machines should use **relative** paths in its `Code Repositories`
table — absolute ones are specific to whoever wrote them.

Setting up somewhere new: [`customization-guide.md`](customization-guide.md) ->
Starting on a new machine.
