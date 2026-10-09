# Assistant Adapters

One thin entry point per AI assistant. Every adapter does the same thing: declare the
command in that tool's own format, then point at `docs/generation-procedure.md`.

> **These are optional.** Every supported assistant reads `AGENTS.md`, which already
> points at the generation procedure, so asking in plain language works with nothing
> installed. An adapter adds the `/doc-confluence` shortcut and its argument hints — a
> convenience, not a capability.

**No adapter restates the generation logic.** That lives in one file so it cannot
drift. If you are adding support for a new assistant, copy the shape of an existing
adapter — do not copy the procedure into it.

Every assistant sits at the same level here, Claude Code included —
[`claude-code/`](claude-code/) holds its skill, agent and Mode A template. Nothing
assistant-specific lives at the repository root.

Why the adapters are this thin, and what that buys:
[`../docs/how-it-works.md`](../docs/how-it-works.md).

## Install

One script installs any of them. Run it **from your config repo** — the per-repo
adapters land there:

```bash
../confluence-framework/scripts/install-adapter.sh claude-code     # or codex, devin, opencode, copilot
../confluence-framework/scripts/install-adapter.sh codex devin     # several at once
../confluence-framework/scripts/install-adapter.sh all --dry-run   # see what it would do
```

It finds the framework from its own location, so the same command works whichever
layout you chose — adjust only the path you call it by. It is POSIX `sh`, like Step 0 of
the procedure: macOS, Linux, and Windows under Git Bash or WSL.

| Option | Effect |
|--------|--------|
| `--target DIR` | Where the per-repo adapters (opencode, Copilot) go. Default: the current directory |
| `--force` | Replace an installed adapter that differs from the framework's. Without it, a difference is reported and left alone |
| `--link` | Symlink instead of copying, so framework changes apply without reinstalling. For people working on the framework itself. Not available on Windows, where Git Bash silently copies |
| `--dry-run` | Print what would happen, change nothing |

Rerunning it is safe: an adapter already up to date is reported as such. After pulling a
new framework version, rerun it with `--force` to refresh copied adapters.

What goes where:

| Assistant | From the framework | To | Scope |
|-----------|--------------------|-----|-------|
| **Claude Code** | `claude-code/skills/doc-confluence`<br>`claude-code/agents/confluence-doc` | `~/.claude/skills/`<br>`~/.claude/agents/` | all projects |
| **OpenAI Codex** | `codex/doc-confluence.md` | `~/.codex/prompts/` | all projects |
| **Devin Local / CLI** | `devin/skills/doc-confluence` | `~/.config/devin/skills/`<br>Windows: `%APPDATA%\devin\skills\` | all projects |
| **opencode** | `opencode/doc-confluence.md` | `.opencode/commands/` | this repo |
| **GitHub Copilot** | `copilot/doc-confluence.prompt.md`<br>`copilot/copilot-instructions.md` | `.github/prompts/`<br>`.github/copilot-instructions.md` | this repo |
| **Devin cloud** | see `devin/README.md` | — | — |

The script holds this table as code; if a destination changes, change it there and here.

All of them are invoked as `/doc-confluence <type> <subject> [source]`. Devin cloud
follows `AGENTS.md` from a natural-language request, or `@skills:doc-confluence` once the
skill is committed to the repo.

## Where the framework lives

The examples above call the script by `../confluence-framework/`, the **sibling** layout.
If you put the framework inside your config repo as a submodule, call it as
`./confluence-framework/scripts/install-adapter.sh` — nothing else changes. Both layouts
are described in
[`../docs/customization-guide.md`](../docs/customization-guide.md) -> Choosing a layout.

## Before you rely on Mode B

Mode B — running from the config repo and pointing at an **external local path** —
needs an assistant that can read outside the repo it started in. Local CLI assistants
can, Devin Local included; Copilot needs the folder added to the workspace; Devin cloud
cannot at all. The matrix
in `../docs/compatibility.md` is explicit about this.
