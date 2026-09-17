---
mode: agent
description: Generate Confluence documentation following the project's framework standards, optionally analyzing a local repo or a URL.
---

Generate a Confluence Cloud document following this project's documentation framework.

- **Document type**: ${input:type:func-spec | architecture | adr | api-spec | env-config | runbook | guide | reference | security-doc | migration | release-note | deployment-request | test-plan | test-strategy | infra-request | role-request}
- **Subject**: ${input:subject:What the document is about}
- **Source (optional)**: ${input:source:Local path or URL to read technical details from. Leave empty to use the Code Repositories table in project-config.md}

## What to do

Find `docs/generation-procedure.md` in the `confluence-framework` directory and
**follow it exactly**. It is the single source of truth for this flow and covers:

- Step 0 — resolving `CONFIG_ROOT` and `FRAMEWORK_ROOT` (a shell block you should run)
- Step 2 — resolving which codebase or link to read from
- Step 5 — what to look for in the source, per document type
- Step 7 — where to file the result: `{Output path}/{source}/{type}_{subject}_{date}.md`

Do not restate or reinvent that logic here — read the file.

## Copilot-specific notes

- Run the Step 0 shell block in the integrated terminal; use the two absolute roots it
  prints for every subsequent file read.
- Reading a repo outside this workspace requires **File > Add Folder to Workspace**
  first. If the source path is not reachable, say so — do not invent the content.
- Agent mode is required (this prompt declares `mode: agent`): the flow needs to run
  commands, read files and write a new one.

## Reading Confluence (optional)

If Atlassian's MCP server is connected, the procedure can check a title is free before
writing and read the real page tree. **It does not do so unless you ask in the request**,
or the project config opts in — read and search scopes only. See
`docs/confluence-mcp.md`. Without any of that, everything works as before.

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
- Anything you cannot extract from the source or get from the user stays a
  `{placeholder}`. Do not fill gaps with plausible-looking content.
