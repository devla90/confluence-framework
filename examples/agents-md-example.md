# AGENTS.md for Code and Config Repositories -- Parametrizable Template

> **Instructions**: Copy this file as `AGENTS.md` to the root of your repo.
> Replace the 6 variables marked with `{...}` below.
> Remove this instruction block after copying.
>
> **Variables to replace**:
> - `{DESCRIPTION}`: Short description of what this repo does (e.g. "Public Website -- React SPA")
> - `{FRONT}`: Frente name in lowercase (e.g. `frontend`, `backend`, `security`)
> - `{PREFIX}`: Full naming prefix including suffix (e.g. `PROJ-FRONT`, `PROJ-BACK`)
> - `{FRAMEWORK_PATH}`: Relative path to `confluence-framework/` from this repo (e.g. `../../confluence-framework`)
> - `{CONFIG_PATH}`: Relative path to the config repo's `project-config.md` (e.g. `../../confluence-config-myproject/project-config.md`)
> - `{SPACE_KEY}`: Confluence space key from project-config.md (e.g. `PROJSPACE`)
>
> `AGENTS.md` is read automatically by OpenAI Codex, GitHub Copilot, Devin, opencode,
> Cursor, Windsurf, Zed, Aider, Gemini CLI and others. For Claude Code, add
> `@AGENTS.md` as the first line of a `CLAUDE.md` next to it, or use
> `repo-claude-md-example.md` instead.

---

# Project: {DESCRIPTION}

## Frente

- **Team**: {FRONT}
- **Confluence naming prefix**: {PREFIX}
- **Confluence space**: {SPACE_KEY}

## Confluence Documentation

This repo generates documentation for Confluence Cloud following the project's
standards. Standards and templates are NOT duplicated here — they live in the central
framework.

- **Generation procedure (follow this)**: `{FRAMEWORK_PATH}/docs/generation-procedure.md`
- **Project configuration**: `{CONFIG_PATH}`
- **Documentation standards**: `{FRAMEWORK_PATH}/docs/documentation-guide.md`
- **Templates**: `{FRAMEWORK_PATH}/templates/`
- **Assistant compatibility**: `{FRAMEWORK_PATH}/docs/compatibility.md`

### How to generate documentation

When asked to generate Confluence documentation, **read
`{FRAMEWORK_PATH}/docs/generation-procedure.md` and follow it**. It is the single
source of truth and covers root resolution, source resolution, per-type source
analysis, template filling and where the output goes.

In this repo the default source is **this repository** — the code here is what gets
analyzed for technical details. To document something else, pass an explicit path or
a URL, or fill the `Code Repositories` table in the project config.

### Generation rules

- **Title**: `[{PREFIX}] Type -- Subject`
- **Mandatory labels**: `team:{FRONT}`, `type:{doc-type}`, `status:draft`
- **Page Properties**: include the complete table with Status, Owner, Approver, Last Review, Next Review, Version
- **Language**: as specified in project-config.md
- **Secrets**: NEVER include credentials, API keys or tokens. Record variable names only and reference the path in the secrets manager defined in project-config.md
- **Diagrams**: indicate where to insert a draw.io macro, do not use static images
- **Placeholders**: mark with `{placeholder}` anything that cannot be extracted from the source

### Available document types

`func-spec` · `adr` · `api-spec` · `env-config` · `runbook` · `security-doc` ·
`migration` · `test-plan` · `test-strategy` · `infra-request` · `role-request`

Templates: `{FRAMEWORK_PATH}/templates/{type}.md`

### Output

Generated documents are filed under a folder named after the source they came from:

```
output/{source}/{type}_{subject}_{YYYY-MM-DD}.md
```

- `{source}` is the name of this repo when the information was read from the code here
- `{source}` is `generic` when it came from a link, or from the user by hand

Never write straight into `output/` — there is always a source subfolder. This folder
is in `.gitignore`; generated docs are not committed to the code repo.
