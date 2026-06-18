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
