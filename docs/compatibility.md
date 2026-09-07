# Assistant Compatibility

What each AI assistant can actually do with this framework, and how to set it up.

The generation logic itself (`docs/generation-procedure.md`) is tool-neutral and
identical everywhere. What differs is three things: how the assistant discovers the
instructions, whether it offers an invocable command, and — the one that really
matters — **whether it can read a folder outside the current repo**.

---

## Matrix

| Assistant | Discovers instructions via | Invocable command | Mode A | Mode B (external local path) | Link as source |
|-----------|---------------------------|-------------------|--------|------------------------------|----------------|
| **Claude Code** | `CLAUDE.md` (with `@AGENTS.md` import) | `/doc-confluence` | yes | yes | yes |
| **OpenAI Codex** | `AGENTS.md` | `~/.codex/prompts/doc-confluence.md` | yes | yes, subject to sandbox settings | if web access is enabled |
| **opencode** | `AGENTS.md` | `.opencode/command/doc-confluence.md` | yes | yes | yes |
| **GitHub Copilot** | `AGENTS.md` or `.github/copilot-instructions.md` | `.github/prompts/doc-confluence.prompt.md` | yes | partial — needs the folder added to the workspace | yes |
| **Devin** | `AGENTS.md` | Knowledge / Skills | yes | **no** | yes |
| **Cursor, Windsurf, Zed, Aider, Gemini CLI, Jules, Amazon Q** | `AGENTS.md` | varies | yes | varies by tool | varies |

**Mode A** = you work inside the code repo being documented.
**Mode B** = you work from the config repo and point at an external path or URL.

---

## The Mode B limitation, stated plainly

Mode B needs the assistant to read files outside the repository it was started in.
That is an architectural property, not a formatting one — no adapter can add it.

- **Local CLI assistants** (Claude Code, Codex, opencode) run on your machine with
  filesystem access. Mode B works once you grant access to the folder.
- **Editor-embedded assistants** (Copilot in VS Code, Cursor, Windsurf) are scoped to
  the open workspace. Add the target repo as a second workspace folder and it works;
  otherwise it does not.
- **Cloud agents** (Devin) run in a VM built from a Git repository. They have no path
  to your local disk at all. **Mode B is not possible.** Use Mode A instead — put an
  `AGENTS.md` in the code repo — or point at a URL, which cloud agents can fetch.

If Mode B is unavailable, the framework still works: use Mode A, or supply the
technical details yourself and let the document be generated with `{placeholder}`
markers for what could not be extracted.

---

## Granting access to an external folder

| Assistant | How |
|-----------|-----|
| Claude Code | `/add-dir /path/to/repo` in the session, or `permissions.additionalDirectories` in `settings.json` |
| OpenAI Codex | Governed by the sandbox/approval mode; start Codex from a directory that contains both repos, or widen the writable/readable roots in `~/.codex/config.toml` |
| opencode | Runs with your user's filesystem permissions; start it from a directory containing both repos |
| GitHub Copilot (VS Code) | **File > Add Folder to Workspace**, then save as a multi-root workspace |
| Devin | Not applicable — no local disk access |

A reliable trick for every local assistant: start the session from the **parent
directory** that contains both `confluence-framework/` and your config repo. The root
resolution in Step 0 of the procedure searches `.`, `..` and siblings, so it finds
both from there — and the `AGENTS.md` at that level orients the assistant automatically.

Setting all of this up from scratch: `customization-guide.md` -> Starting on a new machine.

---

## Setup per assistant

All adapters live in `adapters/`. Each is thin — it points at
`docs/generation-procedure.md` rather than restating the logic.

### Claude Code

```bash
cp -r .claude/skills/doc-confluence ~/.claude/skills/
cp -r .claude/agents/confluence-doc ~/.claude/agents/
```

Then `/doc-confluence <type> <subject> [target-path-or-url]`.

Claude Code reads `CLAUDE.md`, which imports `AGENTS.md` on its first line, so both
conventions stay in sync.

### OpenAI Codex

```bash
mkdir -p ~/.codex/prompts
cp adapters/codex/doc-confluence.md ~/.codex/prompts/
```

`AGENTS.md` is picked up automatically from the repo root. Then `/doc-confluence` in
the Codex session.

### opencode

```bash
mkdir -p .opencode/command
cp adapters/opencode/doc-confluence.md .opencode/command/
```

`AGENTS.md` is picked up automatically. Then `/doc-confluence` in opencode.

### GitHub Copilot

```bash
mkdir -p .github/prompts
cp adapters/copilot/doc-confluence.prompt.md .github/prompts/
cp adapters/copilot/copilot-instructions.md .github/copilot-instructions.md
```

Then `/doc-confluence` in Copilot Chat, in agent mode.

Copilot reads `AGENTS.md` too; `.github/copilot-instructions.md` is provided for
setups that predate that support.

### Devin

See `adapters/devin/README.md`. Put `AGENTS.md` in the repo root and add the
framework's standards to Devin's Knowledge. Mode B does not apply — see above.

### Anything else

Copy `examples/agents-md-example.md` to your repo root as `AGENTS.md` and fill in the
six variables. Any assistant that reads `AGENTS.md` will follow the procedure without
further setup; it just will not have a dedicated slash command.

---

## Windows

Independent of assistant. The shell block in Step 0 of the procedure is POSIX `sh`
and runs under Git Bash or WSL. Use forward slashes in `project-config.md` paths.
Full detail in `docs/customization-guide.md` -> Windows notes.
