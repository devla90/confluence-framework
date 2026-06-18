# Confluence Documentation Framework

## What is this project

IMPORTANT: Read `project-config.md` first (if it exists in the working directory) or the config from the project's config repo to get project-specific values (prefix, space key, frentes, tech stack).

Universal documentation framework for Confluence Cloud. Contains guides, templates, governance, and AI strategy for teams of any size building software across multiple domain fronts. This framework is project-agnostic -- all project-specific values (naming prefix, space key, frentes, technology stack) are defined externally in each project's `project-config.md`.

## Project context

- **Platform**: Confluence Cloud (Content States, REST API v2, Figma embed, Smart Links)
- **Team size**: Any (governance scales from lightweight to formal)
- **Language**: Documentation language is defined per project in `project-config.md`
- **Frentes**: Project frentes, prefix, and space key are defined in the project's `project-config.md`. See `project-config-template.md` for the structure and `examples/project-config-example.md` for a real example.

## File map -- what to read per task

> **Instruction for agents**: Do NOT read all files. Select ONLY the ones needed for the current task.

### To create/edit Confluence documentation

1. Read the project's `project-config.md` -- prefix, space key, frentes, language, tech labels
2. Read `docs/documentation-guide.md` -- naming, labels, lifecycle, Page Properties
3. Select the matching template from `templates/` for the document type
4. Consult `docs/decision-guide.md` ONLY if there is doubt about where to document something

### To create Confluence Cloud templates

1. Read `docs/confluence-templates-guide.md` -- step-by-step for creating Space Templates from the markdown files

### To define structure or create new spaces

1. Read `docs/space-structure.md` -- generic page tree for a multi-front Confluence space

### For governance or team process topics

1. Read `docs/governance.md` -- roles, cadences, enforcement

### For AI integration or automation pipelines

1. Read `docs/ai-strategy.md` -- phases, JSON schema, RAG architecture, metrics

### To plan implementation

1. Read `docs/implementation-roadmap.md` -- week-by-week plan with checklists

### To onboard the team

1. Read `docs/team-guide.md` -- step-by-step guide for manual and AI-assisted workflows

### To adapt this framework for a new project

1. Read `docs/customization-guide.md` -- how to create a config repo and connect code repos
2. Read `project-config-template.md` -- template to fill with project values
3. Read `examples/project-config-example.md` -- real-world filled example

## Key conventions (quick reference)

- **Page title**: `[PROJ-XXX] Type -- Subject` (replace `PROJ` with the prefix from `project-config.md`)
- **Mandatory labels**: `team:`, `type:`, `status:` on every page
- **Secrets**: NEVER in Confluence. Reference the path in your secrets manager (defined in `project-config.md`)
- **Diagrams**: draw.io macro (editable), not static images
- **Guiding principle**: Link, don't duplicate. Confluence = durable knowledge

## Usage from code repos (Strategy B -- local reference)

This framework is the single source of standards. Code repos do NOT duplicate files -- they reference this directory.

### How to connect a new code repo

1. Copy `examples/repo-claude-md-example.md` to the repo root as `CLAUDE.md`
2. Replace the 6 variables: `{DESCRIPTION}`, `{FRONT}`, `{PREFIX}`, `{FRAMEWORK_PATH}`, `{CONFIG_PATH}`, `{SPACE_KEY}`
3. The AI in that repo will read standards and templates directly from `confluence-framework/`

### For Copilot and Devin

The content is the same, only the destination file changes:
- Copilot: `.github/copilot-instructions.md`
- Devin: `.devin/guidelines.md`

## Agent and Skill available

- **Agent**: `confluence-doc` -- Generates documentation following the framework standards, adapted to the project config
- **Skill**: `/doc-confluence` -- Reusable command to generate professional documents
