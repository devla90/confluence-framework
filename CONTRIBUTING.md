# Contributing

Thanks for considering a contribution. This project ships **conventions, not code** —
it is entirely Markdown, with no build, no dependencies and no test suite to run. That
shapes what a good contribution looks like.

## The one rule that matters

**All generation logic lives in `docs/generation-procedure.md`. Nowhere else.**

Every assistant adapter — `adapters/codex/`, `adapters/copilot/`, `adapters/opencode/`,
`.claude/skills/`, `.claude/agents/` — is deliberately thin. Each one declares a command
in its tool's own format and then points at the procedure. The four invocable adapters
total fewer lines than the procedure itself, and that ratio is the design.

So when you add or change behaviour:

- **Do** edit `docs/generation-procedure.md`
- **Don't** edit the adapters, unless the change is genuinely about that tool's command
  syntax or its own constraints

An adapter that restates the logic will drift from the others within two releases. If a
change seems to require touching every adapter, it almost certainly belongs in the
procedure instead.

## Keeping the procedure tool-neutral

`docs/generation-procedure.md`, `AGENTS.md` and `examples/agents-md-example.md` must
never name a specific vendor's tool. Write capabilities, not product names: "list files
matching a pattern" rather than a particular search tool, "fetch a URL" rather than a
particular fetcher.

You can check this before opening a PR:

```sh
grep -rnE 'allowed-tools|argument-hint|user-invocable|additionalDirectories' \
  AGENTS.md docs/generation-procedure.md examples/agents-md-example.md
```

Empty output means you are fine. Tool-specific names belong in the adapter for that
tool, or in `docs/compatibility.md`, which exists precisely to hold them.

## Adding a page template

1. Add `templates/{type}.md`, following the shape of an existing one: title line,
   default labels, Page Properties table, numbered sections, changelog table
2. Register it in `docs/documentation-guide.md` Section 8 — description and default labels
3. Add it to the type list in `docs/generation-procedure.md` Step 3, and to the
   per-type analysis table in Step 5 (what an assistant should look for in the source)
4. Add it to the type lists in each adapter's argument hint

Use `{placeholder}` syntax for anything the user must fill in. Never invent example
values that look real — a template that ships with plausible-looking content invites
someone to publish it unchanged.

## Adding support for a new assistant

1. Create `adapters/{assistant}/` with that tool's command format
2. Point it at `docs/generation-procedure.md` — do not copy the procedure into it
3. Add a row to the matrix in `docs/compatibility.md`, including honestly whether that
   assistant can read a folder outside the repo it started in (this decides whether
   Mode B works) and how it grants that access
4. Add the install command to `adapters/README.md`

Copy the shape of `adapters/codex/doc-confluence.md` — it is the smallest one.

## Before opening a pull request

- Markdown code fences balanced, files LF (a `.gitattributes` enforces this)
- Any path you mention in a document actually exists
- The neutrality check above passes
- If you changed generation behaviour, add a `## [Unreleased]` entry to `CHANGELOG.md`

## Reporting a problem

Say which **version** you were on — a tag like `v1.0.0`, or the commit — and which
assistant you were using. Without those two facts a report is usually not actionable,
since behaviour depends on both.
