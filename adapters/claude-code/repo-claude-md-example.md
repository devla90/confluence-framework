# CLAUDE.md for Code Repositories -- Parametrizable Template

> **Instructions**: Copy this file as `CLAUDE.md` to the root of your code repo.
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
> **For other AI assistants**, use `agents-md-example.md` instead -- `AGENTS.md` is the
> cross-tool standard, read by Codex, Copilot, Devin, opencode, Cursor and others.
> Ready-made invocable commands per assistant are in `../adapters/`.
>
> **Don't want to add files to the code repo?** This file is Mode A. There is also
> Mode B: register the repo's local path in the `Code Repositories` table of your
> `project-config.md` and generate from the config repo instead, leaving the code
> repo untouched. See `docs/customization-guide.md` Step 6.

---

# Project: {DESCRIPTION}

## Frente

- **Team**: {FRONT}
- **Confluence naming prefix**: {PREFIX}
- **Confluence space**: {SPACE_KEY}

## Confluence Documentation

This repo generates documentation for Confluence Cloud following the project's standards.

### Where standards and templates live

Standards and templates live in the central framework. They are NOT duplicated in this repo.

- **Project configuration**: `{CONFIG_PATH}`
- **Documentation standards**: `{FRAMEWORK_PATH}/docs/documentation-guide.md`
- **Templates**: `{FRAMEWORK_PATH}/templates/`
- **Decision guide**: `{FRAMEWORK_PATH}/docs/decision-guide.md`

### How to generate documentation

When asked to generate Confluence documentation:

1. Read the project config: `{CONFIG_PATH}` -- get prefix, space key, frentes, language, tech labels
2. Read the standards: `{FRAMEWORK_PATH}/docs/documentation-guide.md` (sections on naming, labels, Page Properties)
3. Read the matching template from `{FRAMEWORK_PATH}/templates/`
4. Analyze the source code in this repo to extract technical information
5. Generate the document in `output/{this-repo-name}/` following the template

Never copy secret values found in this repo into the document -- record variable
names only and reference the secrets manager defined in project-config.md.

### Generation rules

- **Title**: `[{PREFIX}] Type -- Subject`
- **Mandatory labels**: `team:{FRONT}`, `type:{doc-type}`, `status:draft`
- **Page Properties**: Include complete table with Status, Owner, Approver, Last Review, Next Review, Version
- **Language**: As specified in project-config.md
- **Secrets**: NEVER include credentials, API keys, or tokens. Reference the path in the secrets manager defined in project-config.md
- **Diagrams**: Indicate where to insert draw.io macro, do not use static images
- **Placeholders**: Mark with `{placeholder}` anything that cannot be extracted from the code

### Available document types

| Type | Command | Template |
|------|---------|----------|
| Functional Specification | `func-spec` | `templates/func-spec.md` |
| Architecture Overview | `architecture` | `templates/architecture.md` |
| Guide or Standards | `guide` | `templates/guide.md` |
| Release Note | `release-note` | `templates/release-note.md` |
| Deployment Request | `deployment-request` | `templates/deployment-request.md` |
| ADR | `adr` | `templates/adr.md` |
| API Specification | `api-spec` | `templates/api-spec.md` |
| Environment Configuration | `env-config` | `templates/env-config.md` |
| Runbook | `runbook` | `templates/runbook.md` |
| Security Document | `security-doc` | `templates/security-doc.md` |
| Migration | `migration` | `templates/migration.md` |
| Test Plan | `test-plan` | `templates/test-plan.md` |
| Testing Strategy | `test-strategy` | `templates/test-strategy.md` |
| Infrastructure Request | `infra-request` | `templates/infra-request.md` |
| Deployment Role Request | `role-request` | `templates/role-request.md` |

### Output

Generated documents are saved under a folder named after the source they were
generated from, so it is always obvious where a page came from:

```
output/{source}/{type}_{subject}_{YYYY-MM-DD}.md
```

- `{source}` is the name of this repo when the information was read from the code here
- `{source}` is `generic` when the information came from a link, or from you by hand

```
output/
+-- {this-repo-name}/
|   +-- func-spec_contact-form_2026-09-06.md
+-- generic/
    +-- api-spec_stripe-payments_2026-09-06.md
```

Never write straight into `output/` -- there is always a source subfolder.

This folder is in `.gitignore` -- generated docs are not committed to the code repo.

---

## Example: Filled for a Frontend Repo

Below is how this file looks when filled for a hypothetical frontend repo. Use it as reference when replacing your variables.

```
# Project: Public Website -- React SPA

## Frente

- **Team**: frontend
- **Confluence naming prefix**: PROJ-FRONT
- **Confluence space**: PROJSPACE

## Confluence Documentation

This repo generates documentation for Confluence Cloud following the project's standards.

### Where standards and templates live

- **Project configuration**: `../../confluence-config-myproject/project-config.md`
- **Documentation standards**: `../../confluence-framework/docs/documentation-guide.md`
- **Templates**: `../../confluence-framework/templates/`
- **Decision guide**: `../../confluence-framework/docs/decision-guide.md`

### How to generate documentation

1. Read the project config: `../../confluence-config-myproject/project-config.md`
2. Read the standards: `../../confluence-framework/docs/documentation-guide.md`
3. Read the matching template from `../../confluence-framework/templates/`
4. Analyze the source code in this repo to extract technical information
5. Generate the document in `output/{this-repo-name}/` following the template

Never copy secret values found in this repo into the document -- record variable
names only and reference the secrets manager defined in project-config.md.

### Generation rules

- **Title**: `[PROJ-FRONT] Type -- Subject`
- **Mandatory labels**: `team:frontend`, `type:{doc-type}`, `status:draft`
- **Language**: As specified in project-config.md
- **Secrets**: NEVER include credentials. Reference AWS Secrets Manager: {path}
```
