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

Run these **from your config repo**. Sources are written for the sibling layout, where
the framework sits at `../confluence-framework`; adjust that prefix for another layout.

| Assistant | Copy from the framework | To | Scope |
|-----------|------------------------|-----|-------|
| **Claude Code** | `adapters/claude-code/skills/doc-confluence`<br>`adapters/claude-code/agents/confluence-doc` | `~/.claude/skills/`<br>`~/.claude/agents/` | all projects |
| **OpenAI Codex** | `adapters/codex/doc-confluence.md` | `~/.codex/prompts/` | all projects |
| **opencode** | `adapters/opencode/doc-confluence.md` | `.opencode/commands/` | this repo |
| **GitHub Copilot** | `adapters/copilot/doc-confluence.prompt.md`<br>`adapters/copilot/copilot-instructions.md` | `.github/prompts/`<br>`.github/copilot-instructions.md` | this repo |
| **Devin** | see `devin/README.md` | — | — |

Copy-paste commands per assistant: [`../docs/compatibility.md`](../docs/compatibility.md).

All of them are invoked as `/doc-confluence <type> <subject> [source]`, except Devin,
which follows `AGENTS.md` from a natural-language request.

Exact commands per assistant, including Windows/PowerShell equivalents, are in
`../docs/compatibility.md`.

## Where the framework lives

These install commands assume the framework and your config repo are **siblings** — the
default layout. If you put the framework inside your config repo as a submodule, adjust
the source paths accordingly. Both layouts are described in
[`../docs/customization-guide.md`](../docs/customization-guide.md) -> Choosing a layout.

## Before you rely on Mode B

Mode B — running from the config repo and pointing at an **external local path** —
needs an assistant that can read outside the repo it started in. Local CLI assistants
can; Copilot needs the folder added to the workspace; Devin cannot at all. The matrix
in `../docs/compatibility.md` is explicit about this.
