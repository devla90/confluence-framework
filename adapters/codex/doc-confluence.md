Generate a Confluence Cloud document following this project's documentation framework.

Arguments: `$1` = document type, `$2` = subject, `$3` = optional source (local path or URL).

Valid types: func-spec, architecture, adr, api-spec, env-config, runbook, guide, reference,
security-doc, migration, release-note, deployment-request, test-plan, test-strategy,
infra-request, role-request.

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

## Reading Confluence (optional)

If Atlassian's MCP server is connected, the procedure can check a title is free before
writing and read the real page tree. **It does not do so unless you ask in the request**,
or the project config opts in — read and search scopes only. See
`docs/confluence-mcp.md`. Without any of that, everything works as before.

## Non-negotiable rules

- **Never put a credential in the repository.** An MCP token goes in the assistant's own
  configuration, outside the repo, or use OAuth. Git keeps deleted secrets in history.
- **Confirm before creating or updating a Confluence page** — title, space, parent, and
  whether it creates or overwrites. Approval for one page is not approval for the next.
  `Confirm before publishing` in `project-config.md` can relax this to `updates-only` or
  `no`; with either, still report every page touched.
- Never copy secret **values** out of `.env`, config or CI files — record variable
  names only and reference the project's secrets manager.
- Anything not extracted from the source or supplied by the user stays a
  `{placeholder}`.
