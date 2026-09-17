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

Nothing to install. This framework is plain Markdown — no build, no dependencies, no
runtime.

### Just want the standards?

```bash
git clone https://github.com/devla90/confluence-framework
```

Read `docs/documentation-guide.md` for the naming and label conventions, browse
`templates/` for the 11 page templates, and copy the ones you want into Confluence by
hand following `docs/confluence-templates-guide.md`. That is a complete, valid way to
use this project — no AI assistant required.

### Want an AI assistant to generate the documents?

Then you also need a **config repo**: a small repository holding your project's values
(naming prefix, Confluence space key, frentes, code repository paths). Start it from the
template:

1. Open [confluence-config-template](https://github.com/devla90/confluence-config-template)
   and press **Use this template**
2. Clone both repos side by side:
   ```bash
   git clone https://github.com/devla90/confluence-framework
   git clone <your-new-config-repo>
   ```
3. Fill in `project-config.md` in your config repo
4. Open your assistant **in the config repo** and ask, in plain language:
   *"generate a func-spec for the login feature"*

That is the whole setup — there is nothing to install. Your assistant reads `AGENTS.md`,
which points it at the generation procedure, and the procedure asks you for whatever it
cannot read from your code.

**Optionally**, install a `/doc-confluence` shortcut for your assistant — one command,
listed in [`adapters/README.md`](adapters/README.md). It saves typing; it does not
unlock anything.

Full walkthrough: [`docs/customization-guide.md`](docs/customization-guide.md).
How the whole thing fits together: [`docs/how-it-works.md`](docs/how-it-works.md).

### Which AI assistants

The generation logic lives in one tool-neutral file,
[`docs/generation-procedure.md`](docs/generation-procedure.md), reachable from
`AGENTS.md` — the cross-tool standard read by OpenAI Codex, GitHub Copilot, Devin,
opencode, Cursor, Windsurf, Zed, Aider and others. Claude Code reads it through an
`@AGENTS.md` import in `CLAUDE.md`.

No assistant is privileged and none is required. Optional `/doc-confluence` shortcuts
per assistant are in [`adapters/`](adapters/). What each one can and cannot do — notably
whether it can read a repo outside the current one — is in
[`docs/compatibility.md`](docs/compatibility.md).

Works on macOS, Linux, WSL and Windows (Git Bash) — see
[`docs/customization-guide.md`](docs/customization-guide.md) -> Windows notes.

---

## Versioning

Releases are tagged. To pin your team to a specific version:

```bash
git clone --branch v1.0.0 https://github.com/devla90/confluence-framework
```

and to move deliberately when you are ready:

```bash
git fetch --tags && git checkout v1.1.0
```

Pinning matters because this framework ships **conventions**, not code: a change to the
naming pattern or the label taxonomy affects pages your team has already published. You
decide when to absorb that.

Version numbers are not plain semver, because there is nothing to compile:

| Bump | Means | Example |
|------|-------|---------|
| **Major** | A convention changed. Existing pages may need revisiting | Naming pattern or label taxonomy changes; a template's required sections change |
| **Minor** | Something was added, nothing broke | A new page template, a new assistant adapter, a new guide |
| **Patch** | Corrections only | Typos, clarified wording, fixed links |

Every change is recorded in [`CHANGELOG.md`](CHANGELOG.md). When reporting a problem,
say which version you were on — behaviour depends on it.

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
|   +-- how-it-works.md                    <- The design explained end to end, for people
|   +-- generation-procedure.md            <- THE generation flow (tool-neutral, single source of truth)
|   +-- compatibility.md                   <- What each AI assistant can and cannot do
|   +-- ai-strategy.md                     <- AI integration strategy in 4 phases
|   +-- implementation-roadmap.md          <- Week-by-week plan with checklists
|   (most guides also have a .es.md Spanish translation)
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
|   +-- config-repo/                       <- A complete filled config repo, for reading
|   +-- agents-md-example.md               <- AGENTS.md to drop into a code repo (Mode A)
|   +-- repo-claude-md-example.md          <- Claude Code variant of the same
|
|   PROJECT CONFIGURATION
|
+-- project-config-template.md             <- Template for project-specific values
|                                             (identity, paths, frentes, code repos)
|
|   PROJECT META
|
+-- CHANGELOG.md                           <- What changed in each release
+-- CONTRIBUTING.md                        <- How to contribute; the single-source-of-truth rule
|
|   AI ASSISTANT CONFIGURATION
|
+-- AGENTS.md                              <- Cross-tool entry point (Codex, Copilot, Devin, opencode, ...)
+-- CLAUDE.md                              <- Claude Code layer; imports AGENTS.md
+-- adapters/                              <- One thin invocable command per assistant
|   +-- claude-code/  copilot/  codex/  opencode/  devin/
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
| [`docs/how-it-works.md`](docs/how-it-works.md) | The design explained end to end — start here |
| [`docs/customization-guide.md`](docs/customization-guide.md) | How to adapt the framework to your project |
| [`project-config-template.md`](project-config-template.md) | Template for your project-specific configuration |
| [`examples/config-repo/`](examples/config-repo/) | A complete filled config repo, for reading |
| [`docs/documentation-guide.md`](docs/documentation-guide.md) | Naming, labels, lifecycle, and CQL query standards |
| [`docs/generation-procedure.md`](docs/generation-procedure.md) | The generation flow every assistant follows |
| [`docs/compatibility.md`](docs/compatibility.md) | What each AI assistant can and cannot do |
| [`docs/space-structure.md`](docs/space-structure.md) | Full page tree and space architecture |
| [`docs/confluence-templates-guide.md`](docs/confluence-templates-guide.md) | Step-by-step guide to creating Confluence templates |
| [`docs/team-guide.md`](docs/team-guide.md) | Team onboarding: manual and AI-assisted workflows |
| [`docs/governance.md`](docs/governance.md) | Roles, review cadences, enforcement |
| [`docs/ai-strategy.md`](docs/ai-strategy.md) | 4-phase AI integration roadmap |
| [`CHANGELOG.md`](CHANGELOG.md) | What changed in each release |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | How to contribute |

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
