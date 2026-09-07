# Project Configuration

> Copy this file and fill in your project's values.
> See `examples/project-config-example.md` for a filled example.
> See `docs/customization-guide.md` for step-by-step instructions.

---

## Identity

| Field | Value |
|-------|-------|
| Project name | {your project name} |
| Organization | {your organization} |
| Naming prefix | {PREFIX} |
| Confluence space key | {SPACEKEY} |
| Confluence URL | {https://your-org.atlassian.net/wiki} |
| Documentation language | {english / spanish / portuguese / etc.} |
| Team size | {number range, e.g. 5-15} |

## Paths

Where the framework lives and where generated documents are written. Both are
resolved relative to this config repo unless you give an absolute path.

| Field | Value |
|-------|-------|
| Framework path | {relative path to confluence-framework, e.g. ../confluence-framework} |
| Output path | {./output — base folder for generated docs; relative to this config repo, or absolute} |

Generated documents are filed under `{Output path}/{source}/`, where `{source}` is the
name of the repo the information was read from, or `generic/` when it came from a link
or from the user only:

```
output/
+-- my-web-app/
|   +-- func-spec_contact-form_2026-09-06.md
+-- my-api/
|   +-- api-spec_authentication_2026-09-06.md
+-- generic/
    +-- api-spec_stripe-payments_2026-09-06.md
```

## Frentes (Sections)

Define the domain sections for your project. Each frente gets a suffix appended to your naming prefix: `[{PREFIX}-{SUFFIX}]`.

| Front | Suffix | Technologies | Section Owner | Team Label |
|-------|--------|-------------|---------------|------------|
| {name} | {SUFFIX} | {tech1, tech2} | {role} | team:{label} |
| {name} | {SUFFIX} | {tech1, tech2} | {role} | team:{label} |

**Default frentes** (common for web projects — adapt as needed):

| Front | Suffix | Team Label |
|-------|--------|------------|
| Frontend | FRONT | team:frontend |
| Backend | BACK | team:backend |
| UI/UX | DESIGN | team:design |
| Business | BIZ | team:business |
| Architecture | ARCH | team:architecture |
| Security | SEC | team:security |
| QA & Testing | QA | team:qa |

## Code Repositories

Local paths of the repos that implement each frente. The AI reads code from these
paths to extract technical information (endpoints, env vars, migrations, test setup).
Leave the path empty for frentes with no code (Business, UI/UX). Absolute paths
recommended — relative paths are resolved from this config repo.

This table powers **Mode B** (see `docs/customization-guide.md` Step 6): you work
from this config repo and the AI reads an external project, instead of you having
to open that project and put a `CLAUDE.md` inside it.

| Front | Suffix | Local path | Description |
|-------|--------|-----------|-------------|
| {Frontend} | {FRONT} | {/absolute/path/to/repo} | {short description} |
| {Backend} | {BACK} | {/absolute/path/to/repo} | {short description} |

> A path passed as the third argument to `/doc-confluence <type> <subject> [target-path]`
> overrides whatever is in this table.

## Technology Labels

Define `tech:` labels specific to your project's stack.

| Label | Description |
|-------|-------------|
| tech:{name} | {description} |
| tech:{name} | {description} |

## Secrets Platform

| Field | Value |
|-------|-------|
| Tool | {AWS Secrets Manager / Azure Key Vault / HashiCorp Vault / GCP Secret Manager / other} |
| Reference format in docs | {e.g. "See AWS Secrets Manager: {path}"} |

## Tools

| Tool | Purpose |
|------|---------|
| {Jira / Azure DevOps / Linear} | Task management and backlog |
| {Figma / Sketch / Adobe XD} | UI/UX design |
| {GitHub / GitLab / Bitbucket} | Source code |
| {tool} | {purpose} |

## Overrides

Document any deviations from the framework defaults. The AI reads this section to respect project-specific exceptions.

| Guide | Override | Reason |
|-------|----------|--------|
| {none by default} | | |
