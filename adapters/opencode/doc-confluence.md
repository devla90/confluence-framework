---
description: Generate Confluence documentation following the project's framework standards
agent: build
---

Generate a Confluence Cloud document following this project's documentation framework.

Arguments: $ARGUMENTS — expected as `<type> <subject> [source-path-or-url]`.

Valid types: func-spec, architecture, adr, api-spec, env-config, runbook, security-doc,
migration, test-plan, test-strategy, infra-request, role-request.

## What to do

Locate `docs/generation-procedure.md` inside the `confluence-framework` directory and
**follow it exactly**. It is the single source of truth for this flow:

- Step 0 — run its shell block to resolve `CONFIG_ROOT` and `FRAMEWORK_ROOT`, then use
  those absolute roots for every path
- Step 2 — resolve the source: the third argument if given, otherwise the
  `Code Repositories` table in `project-config.md`, otherwise ask
- Step 5 — analyze the source; the table there says what to look for per document type
- Step 7 — file the result at `{Output path}/{source}/{type}_{subject}_{date}.md`

Do not restate or reinvent that logic — read the file.

## opencode-specific notes

- `AGENTS.md` at the repo root is loaded automatically; this command adds the
  invocable entry point on top of it.
- opencode runs with your user's filesystem permissions, so Mode B (an external local
  path) works. If a path is unreachable, start opencode from the parent directory
  containing both the framework and the config repo.

## Non-negotiable rules

- Never copy secret **values** out of `.env`, config or CI files — record variable
  names only and reference the project's secrets manager.
- Anything not extracted from the source or supplied by the user stays a
  `{placeholder}`.
