---
mode: agent
description: Generate Confluence documentation following the project's framework standards, optionally analyzing a local repo or a URL.
---

Generate a Confluence Cloud document following this project's documentation framework.

- **Document type**: ${input:type:func-spec | adr | api-spec | env-config | runbook | security-doc | migration | test-plan | test-strategy | infra-request | role-request}
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

## Non-negotiable rules

- Never copy secret **values** out of `.env`, config or CI files — record variable
  names only and reference the project's secrets manager.
- Anything you cannot extract from the source or get from the user stays a
  `{placeholder}`. Do not fill gaps with plausible-looking content.
