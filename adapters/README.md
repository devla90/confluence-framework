# Assistant Adapters

One thin entry point per AI assistant. Every adapter does the same thing: declare the
command in that tool's own format, then point at `docs/generation-procedure.md`.

**No adapter restates the generation logic.** That lives in one file so it cannot
drift. If you are adding support for a new assistant, copy the shape of an existing
adapter — do not copy the procedure into it.

## Install

| Assistant | Copy | To |
|-----------|------|-----|
| **Claude Code** | `../.claude/skills/doc-confluence`<br>`../.claude/agents/confluence-doc` | `~/.claude/skills/`<br>`~/.claude/agents/` |
| **OpenAI Codex** | `codex/doc-confluence.md` | `~/.codex/prompts/` |
| **opencode** | `opencode/doc-confluence.md` | `.opencode/command/` |
| **GitHub Copilot** | `copilot/doc-confluence.prompt.md`<br>`copilot/copilot-instructions.md` | `.github/prompts/`<br>`.github/copilot-instructions.md` |
| **Devin** | see `devin/README.md` | — |
| **Anything else reading AGENTS.md** | `../examples/agents-md-example.md` | your repo root as `AGENTS.md` |

All of them are invoked as `/doc-confluence <type> <subject> [source]`, except Devin,
which follows `AGENTS.md` from a natural-language request.

Exact commands per assistant, including Windows/PowerShell equivalents, are in
`../docs/compatibility.md`.

## Before you rely on Mode B

Mode B — running from the config repo and pointing at an **external local path** —
needs an assistant that can read outside the repo it started in. Local CLI assistants
can; Copilot needs the folder added to the workspace; Devin cannot at all. The matrix
in `../docs/compatibility.md` is explicit about this.
