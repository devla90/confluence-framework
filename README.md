# Confluence Documentation Framework

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

A universal, reusable framework for organizing, standardizing, and maintaining project documentation in Confluence Cloud. Designed for teams of 5-15 people working on multi-domain projects, this framework provides battle-tested conventions, templates, governance, and an AI integration strategy that any team can adopt and customize for their specific needs.

---

## Feature Highlights

- **Naming conventions**: Consistent page titles with domain prefixes (`[{PREFIX}-FRONT]`, `[{PREFIX}-BACK]`, etc.) that enable fast search and future multi-space migration
- **Label taxonomy**: Structured `team:`, `type:`, `status:`, `phase:`, `env:` labels for automated dashboards and CQL-powered reporting
- **11 page templates**: Functional Specification, ADR, API Specification, Environment Configuration, Runbook, Security Document, Migration Document, Test Plan, Test Strategy, Infrastructure Request, Deployment Role Request
- **Document lifecycle**: DRAFT -> IN-REVIEW -> APPROVED -> ARCHIVED -> OBSOLETE with Content States, Page Properties, and scheduled reviews
- **Governance model**: Lightweight roles (Documentation Champion, Section Owners), quarterly reviews, and enforcement rules scaled for small-to-medium teams
- **AI integration strategy**: 4-phase roadmap from manual documentation to intelligent search, auto-generated drafts, and compliance checking
- **Implementation roadmap**: Week-by-week plan with checklists for rolling out the framework

---

## Quick Start

### 1. Clone this framework

```bash
git clone <framework-repo-url>
cd confluence-framework
```

### 2. Create your project configuration

Copy the configuration template and fill in your project-specific values:

```bash
cp project-config-template.md my-project-config.md
```

Edit `my-project-config.md` to set your space key, domain prefixes, team names, and technology stack. All `{SPACE_KEY}`, `{PREFIX}`, and other placeholders in the framework docs reference values you define here.

### 3. Start generating documentation

Use the guides in `docs/` to set up your Confluence space, create templates, and begin documenting:

1. Follow `docs/space-structure.md` to create your space and page tree
2. Follow `docs/confluence-templates-guide.md` to set up Space Templates
3. Follow `docs/team-guide.md` to onboard your team

Works on macOS, Linux, WSL and Windows (Git Bash) -- see `docs/customization-guide.md` -> Windows notes.

## Which AI assistants

The generation logic lives in one tool-neutral file, `docs/generation-procedure.md`,
reachable from `AGENTS.md` -- the cross-tool standard read by OpenAI Codex, GitHub
Copilot, Devin, opencode, Cursor, Windsurf, Zed, Aider and others. Claude Code reads it
through a `@AGENTS.md` import in `CLAUDE.md`.

Ready-made invocable commands per assistant are in `adapters/`. What each one can and
cannot do -- notably whether it can read a repo outside the current one -- is in
`docs/compatibility.md`.

For AI-assisted documentation, install the adapter for your assistant and use the
`/doc-confluence` command:

```bash
claude
> /doc-confluence func-spec Contact Form
```

To document a project living at another local path, register it in the
`Code Repositories` table of your `project-config.md` or pass the path directly:

```bash
> /doc-confluence api-spec Payments Service /Users/you/work/payments-api
```

See `docs/customization-guide.md` Step 6 for both working modes.

---

## Folder Structure

```
confluence-framework/
|
+-- README.md                              <- This file: index and entry point
|
|   GUIDES AND REFERENCES
|
+-- docs/
|   +-- team-guide.md                      <- How to document: manual + AI workflow
|   +-- documentation-guide.md             <- Standards: naming, labels, lifecycle
|   +-- confluence-templates-guide.md      <- How to create custom templates in Confluence Cloud
|   +-- space-structure.md                 <- Single-space model with domain sections + page tree
|   +-- governance.md                      <- Roles, reviews, enforcement
|   +-- decision-guide.md                  <- What goes in Confluence vs other tools
|   +-- customization-guide.md             <- How to adapt the framework to your project
|   +-- generation-procedure.md            <- THE generation flow (tool-neutral, single source of truth)
|   +-- compatibility.md                   <- What each AI assistant can and cannot do
|   +-- ai-strategy.md                     <- AI integration strategy in 4 phases
|   +-- implementation-roadmap.md          <- Week-by-week plan with checklists
|   (each guide also has a .es.md Spanish translation)
|
|   PAGE TEMPLATES
|   (copy to Confluence as Space Templates -- see confluence-templates-guide.md)
|
+-- templates/
|   +-- func-spec.md                       <- Functional Specification (features AS-IS/TO-BE)
|   +-- adr.md                             <- Architecture Decision Record
|   +-- api-spec.md                        <- API Specification (complement to Swagger/OpenAPI)
|   +-- env-config.md                      <- Environment Configuration (DEV/QA/STG/PROD)
|   +-- runbook.md                         <- Operational Runbook (incident response)
|   +-- security-doc.md                    <- Security/Compliance Document
|   +-- migration.md                       <- Migration AS-IS to TO-BE
|   +-- test-plan.md                       <- Test Plan
|   +-- test-strategy.md                   <- Test Strategy
|   +-- infra-request.md                   <- Infrastructure Request
|   +-- role-request.md                    <- Deployment Role Request
|
|   EXAMPLES
|
+-- examples/
|   +-- project-config-example.md          <- Filled project configuration
|   +-- repo-claude-md-example.md          <- CLAUDE.md to drop into a code repo (Mode A)
|
|   PROJECT CONFIGURATION
|
+-- project-config-template.md             <- Template for project-specific values
|                                             (identity, paths, frentes, code repos)
|
|   AI ASSISTANT CONFIGURATION
|
+-- AGENTS.md                              <- Cross-tool entry point (Codex, Copilot, Devin, opencode, ...)
+-- CLAUDE.md                              <- Claude Code layer; imports AGENTS.md
+-- adapters/                              <- One thin invocable command per assistant
|   +-- copilot/  codex/  opencode/  devin/
+-- .claude/
    +-- agents/confluence-doc/             <- Claude Code documentation agent
    +-- skills/doc-confluence/             <- /doc-confluence skill (reusable command)
```

---

## Domain Sections

The framework organizes documentation into domain-based sections. The default pattern covers common web-application domains:

| Section | Naming Prefix | Description |
|---------|--------------|-------------|
| Governance Hub | `{PREFIX}-HUB` | Standards, cross-cutting docs, governance, AI initiative |
| Frontend | `{PREFIX}-FRONT` | Frontend application, components, configurations |
| Backend & Services | `{PREFIX}-BACK` | Services, APIs, data processing |
| UI/UX Design | `{PREFIX}-DESIGN` | Design system, guidelines, prototypes, research |
| Business & Product | `{PREFIX}-BIZ` | Product vision, business rules, features, processes |
| Architecture & Cloud | `{PREFIX}-ARCH` | Infrastructure, ADRs, deployments, CI/CD |
| Security & Compliance | `{PREFIX}-SEC` | Security SDLC, compliance, access control, audits |
| QA & Testing | `{PREFIX}-QA` | Testing strategy, test plans, automation, quality metrics |

> These are the default sections. Add, remove, or rename them to match your project's actual domains. See `docs/customization-guide.md` for instructions.

---

## Documentation Language

The framework guides and templates are written in English. However, the actual documentation your team produces in Confluence can be in any language. The naming conventions, label taxonomy, and template structure are language-agnostic — only the `{PREFIX}` and label keys need to stay in English for consistency in CQL queries and automation.

To adapt the framework for a different language:
1. Translate the template section headings in `templates/`
2. Keep label keys (`team:`, `type:`, `status:`) in English
3. Keep page title prefixes (`[{PREFIX}-FRONT]`) in English
4. Write content in your team's preferred language

---

## Key Files

| File | Purpose |
|------|---------|
| [`docs/customization-guide.md`](docs/customization-guide.md) | How to adapt the framework to your project |
| [`project-config-template.md`](project-config-template.md) | Template for your project-specific configuration |
| [`docs/documentation-guide.md`](docs/documentation-guide.md) | Naming, labels, lifecycle, and CQL query standards |
| [`docs/space-structure.md`](docs/space-structure.md) | Full page tree and space architecture |
| [`docs/confluence-templates-guide.md`](docs/confluence-templates-guide.md) | Step-by-step guide to creating Confluence templates |
| [`docs/team-guide.md`](docs/team-guide.md) | Team onboarding: manual and AI-assisted workflows |
| [`docs/governance.md`](docs/governance.md) | Roles, review cadences, enforcement |
| [`ai-strategy.md`](ai-strategy.md) | 4-phase AI integration roadmap |

---

## Relationship Between This Repository and Confluence

This repository **is not uploaded to Confluence**. It is the source of truth for the **framework design**:

| This repository contains | In Confluence it becomes |
|--------------------------|-------------------------|
| `docs/space-structure.md` | The root sections created in your space |
| `templates/*.md` | Space Templates (created via `docs/confluence-templates-guide.md`) |
| `docs/documentation-guide.md` | Standards pages in the Governance Hub section |
| `docs/decision-guide.md` | "Decision Guide" page in the Governance Hub section |
| `docs/governance.md` | Governance pages in the Governance Hub section |
| `docs/team-guide.md` | Onboarding page in the Governance Hub section |
| `output/*.md` | Individual pages in the corresponding section |

---

## License

This project is licensed under the [Apache License 2.0](LICENSE).
