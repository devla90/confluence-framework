# Assistant Compatibility

What each AI assistant can actually do with this framework, and how to set it up.

This is a reference matrix. For the narrative -- why the design is shaped this way and
what happens end to end when someone generates a document -- read
[`how-it-works.md`](how-it-works.md).

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
| **opencode** | `AGENTS.md` | `.opencode/commands/doc-confluence.md` | yes | yes | yes |
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

A reliable rule for every local assistant: start the session from **your config repo**.
The root resolution in Step 0 searches `.`, `..` and siblings, so it finds the framework
from there whichever layout you chose — and the config repo's own `AGENTS.md`, which is
versioned and arrives with the clone, orients the assistant automatically.

Setting all of this up from scratch: `customization-guide.md` -> Starting on a new machine.

---

## Optional: install a slash command

**None of this is required.** Every assistant below reads `AGENTS.md`, which already
points at the generation procedure — asking in plain language ("generate a func-spec for
the login feature") works with nothing installed. What an adapter buys you is the
`/doc-confluence` shortcut and its argument hints.

All adapters are thin: each declares a command in its tool's own format and points at
`docs/generation-procedure.md`, rather than restating the logic.

> **Run these from your config repo**, and note that each command names the framework by
> a relative path. The examples assume the sibling layout, where the framework sits at
> `../confluence-framework`. Adjust that prefix if you chose a different layout — inside
> a submodule it is `./confluence-framework`.

### Claude Code

```bash
cp -r ../confluence-framework/adapters/claude-code/skills/doc-confluence ~/.claude/skills/
cp -r ../confluence-framework/adapters/claude-code/agents/confluence-doc ~/.claude/agents/
```

Installs into your home directory, so it works from any project. Claude Code reads
`CLAUDE.md`, which imports `AGENTS.md` on its first line, so both conventions stay in
sync. See [`../adapters/claude-code/README.md`](../adapters/claude-code/README.md).

### OpenAI Codex

```bash
mkdir -p ~/.codex/prompts
cp ../confluence-framework/adapters/codex/doc-confluence.md ~/.codex/prompts/
```

Also installs into your home directory. `AGENTS.md` is picked up automatically from the
repo you start in.

### opencode

```bash
mkdir -p .opencode/commands
cp ../confluence-framework/adapters/opencode/doc-confluence.md .opencode/commands/
```

Installs into the current repo. For every project instead, use
`~/.config/opencode/commands/`. (opencode also accepts the older singular `command/`,
but `commands/` is the current name.)

### GitHub Copilot

```bash
mkdir -p .github/prompts
cp ../confluence-framework/adapters/copilot/doc-confluence.prompt.md .github/prompts/
cp ../confluence-framework/adapters/copilot/copilot-instructions.md .github/copilot-instructions.md
```

Installs into the current repo — which must be the one you open as your VS Code
workspace, or Copilot will not see the prompt. Then `/doc-confluence` in Copilot Chat,
**in agent mode**: the flow needs to run a command, read files and write one.

Copilot reads `AGENTS.md` too; `.github/copilot-instructions.md` is there for setups that
predate that support.

### Devin

See [`../adapters/devin/README.md`](../adapters/devin/README.md). Put `AGENTS.md` in the
repo root and add the framework's standards to Devin's Knowledge. Mode B does not apply —
see above.

### Anything else

Copy `examples/agents-md-example.md` to your repo root as `AGENTS.md` and fill in the
six variables. Any assistant that reads `AGENTS.md` will follow the procedure without
further setup; it just will not have a dedicated slash command.

---

## Windows

Independent of assistant. The shell block in Step 0 of the procedure is POSIX `sh`
and runs under Git Bash or WSL. Use forward slashes in `project-config.md` paths.
Full detail in `docs/customization-guide.md` -> Windows notes.
