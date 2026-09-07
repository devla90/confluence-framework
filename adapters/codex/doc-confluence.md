Generate a Confluence Cloud document following this project's documentation framework.

Arguments: `$1` = document type, `$2` = subject, `$3` = optional source (local path or URL).

Valid types: func-spec, adr, api-spec, env-config, runbook, security-doc, migration,
test-plan, test-strategy, infra-request, role-request.

## What to do

Locate `docs/generation-procedure.md` inside the `confluence-framework` directory and
**follow it exactly**. It is the single source of truth for this flow:

- Step 0 — run its shell block to resolve `CONFIG_ROOT` and `FRAMEWORK_ROOT`, then use
  those absolute roots for every path
- Step 2 — resolve the source: `$3` if given, otherwise the `Code Repositories` table
  in `project-config.md`, otherwise ask
- Step 5 — analyze the source; the table there says what to look for per document type
- Step 7 — file the result at `{Output path}/{source}/{type}_{subject}_{date}.md`

Do not restate or reinvent that logic — read the file.

## Codex-specific notes

- `AGENTS.md` at the repo root is loaded automatically; this prompt adds the invocable
  command on top of it.
- Reading or writing outside the startup directory depends on your sandbox and
  approval settings. If a path is refused, either start Codex from the parent
  directory containing both the framework and the config repo, or widen the roots in
  `~/.codex/config.toml`. Do not silently skip the analysis.
- Fetching a URL as a source requires web access to be enabled.

## Non-negotiable rules

- Never copy secret **values** out of `.env`, config or CI files — record variable
  names only and reference the project's secrets manager.
- Anything not extracted from the source or supplied by the user stays a
  `{placeholder}`.
