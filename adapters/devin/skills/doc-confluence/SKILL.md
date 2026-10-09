---
name: doc-confluence
description: Generate Confluence documentation following the project's framework standards, optionally analyzing a local repo or a URL. Use when the user asks to document a feature, API, environment, decision, runbook, security policy or migration plan for Confluence.
argument-hint: "<type> <subject> [source-path-or-url]"
allowed-tools:
  - read
  - grep
  - glob
---

Generate a Confluence Cloud document following this project's documentation framework.

Arguments: $ARGUMENTS — expected as `<type> <subject> [source-path-or-url]`.

Valid types: func-spec, architecture, adr, api-spec, env-config, runbook, guide, reference,
security-doc, migration, release-note, deployment-request, test-plan, test-strategy,
infra-request, role-request.

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

## Devin-specific notes

- This skill is for **Devin Local** (Devin Desktop) and **Devin CLI**, which run on your
  machine. Devin in the cloud runs in a VM with no path to your disk — see
  `adapters/devin/README.md`.
- `AGENTS.md` at the repo root is loaded automatically; this skill adds the invocable
  `/doc-confluence` command on top of it.
- Devin Local reads and edits inside the workspace by default. Reading an external path
  (Mode B) needs that path granted in its permissions. If a path is refused, say so —
  do not silently skip the analysis.
- Only one skill is active at a time in Devin. Invoking another one replaces this one,
  so finish the document before switching.

## Reading Confluence (optional)

If Atlassian's MCP server is connected (`~/.config/devin/config.json`, or
`.devin/config.local.json` — never the committed `.devin/config.json` if it holds a
token), the procedure can check a title is free before writing and read the real page
tree. **It does not do so unless you ask in the request**, or the project config opts
in — read and search scopes, plus
write only if the project publishes. See `docs/confluence-mcp.md`. Without any of that,
everything works as before.

Asked to connect it? `docs/confluence-mcp.md` has a guided setup. Follow it as written —
including the step where you print the command instead of asking for the token.

## Non-negotiable rules

- **Never put a credential in the repository.** An MCP token goes in the assistant's own
  configuration, outside the repo, or use OAuth. Git keeps deleted secrets in history.
- **Do not update a Confluence page whose `MCP-DRAFT-PENDING-COMPLETION` block is gone** —
  somebody completed it, and an update would destroy the macros and labels they added.
  Offer editing in Confluence, or a new page with `(v2)` appended to the subject.
- **Confirm before creating or updating a Confluence page** — title, space, parent, and
  whether it creates or overwrites. Approval for one page is not approval for the next.
  `Confirm before publishing` in `project-config.md` can relax this to `updates-only` or
  `no`; with either, still report every page touched.
- Never copy secret **values** out of `.env`, config or CI files — record variable
  names only and reference the project's secrets manager.
- Anything not extracted from the source or supplied by the user stays a
  `{placeholder}`.
