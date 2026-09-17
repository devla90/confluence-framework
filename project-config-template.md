# Project Configuration

> Tables only — this file is reloaded on every generation. What each section means:
> `docs/customization-guide.md` -> What each section means.

---

## Identity

| Field | Value |
|-------|-------|
| Project name | {Your Project Name} |
| Organization | {Your Organization} |
| Naming prefix | {PREFIX} |
| Confluence space key | {SPACEKEY} |
| Space shared with other projects | {yes / no} |
| Check Confluence before generating | {no} |
| Confirm before publishing | {yes} |

> **No credentials in this file.** It is committed and shared. An MCP token goes in the
> assistant's own configuration, outside the repository — or use OAuth and there is
> nothing to store. See `docs/confluence-mcp.md`.
| Confluence URL | {https://your-org.atlassian.net/wiki} |
| Documentation language | {english / spanish / portuguese} |
| Team size | {e.g. 5-15} |

## Paths

| Field | Value |
|-------|-------|
| Framework path | ../confluence-framework |
| Output path | ./output |

## Frentes (Sections)

| Front | Suffix | Technologies | Section Owner | Team Label |
|-------|--------|-------------|---------------|------------|
| Frontend | FRONT | {tech, tech} | {role} | team:frontend |
| Backend | BACK | {tech, tech} | {role} | team:backend |
| UI/UX | DESIGN | {tech, tech} | {role} | team:design |
| Business | BIZ | {tech, tech} | {role} | team:business |
| Architecture | ARCH | {tech, tech} | {role} | team:architecture |
| Security | SEC | {tech, tech} | {role} | team:security |
| QA & Testing | QA | {tech, tech} | {role} | team:qa |

## Code Repositories

| Front | Suffix | Local path | Description |
|-------|--------|-----------|-------------|
| Frontend | FRONT | {../my-frontend-repo} | {short description} |
| Backend | BACK | {../my-backend-repo} | {short description} |
| UI/UX | DESIGN | | No code — Figma only |
| Business | BIZ | | No code — Jira only |
| Architecture | ARCH | {../my-infra-repo} | {short description} |
| Security | SEC | | |
| QA & Testing | QA | {../my-e2e-repo} | {short description} |

## Technology Labels

| Label | Description |
|-------|-------------|
| tech:{name} | {what it is} |
| tech:{name} | {what it is} |

## Secrets Platform

| Field | Value |
|-------|-------|
| Tool | {AWS Secrets Manager / Azure Key Vault / HashiCorp Vault / GCP Secret Manager} |
| Reference format in docs | {e.g. "See AWS Secrets Manager: {path}"} |

## Tools

| Tool | Purpose |
|------|---------|
| {Jira / Azure DevOps / Linear} | Task management and backlog |
| {Figma / Sketch} | UI/UX design |
| {GitHub / GitLab / Bitbucket} | Source code |
| {draw.io} | Architecture and flow diagrams |

## Overrides

None.
