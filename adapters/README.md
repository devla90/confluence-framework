# Assistant Adapters

One thin entry point per AI assistant. Every adapter does the same thing: declare the
command in that tool's own format, then point at `docs/generation-procedure.md`.

**No adapter restates the generation logic.** That lives in one file so it cannot
drift. If you are adding support for a new assistant, copy the shape of an existing
adapter — do not copy the procedure into it.

Why the adapters are this thin, and what that buys:
[`../docs/how-it-works.md`](../docs/how-it-works.md).

## Install

Run these **from your config repo**. Sources are written for the sibling layout, where
the framework sits at `../confluence-framework`; adjust that prefix for another layout.

| Assistant | Copy from the framework | To | Scope |
|-----------|------------------------|-----|-------|
| **Claude Code** | `.claude/skills/doc-confluence`<br>`.claude/agents/confluence-doc` | `~/.claude/skills/`<br>`~/.claude/agents/` | all projects |
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
