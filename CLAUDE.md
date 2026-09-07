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

1. Read the project's `project-config.md` -- prefix, space key, frentes, `Paths`, `Code Repositories`, language, tech labels
2. Read `docs/documentation-guide.md` -- naming, labels, lifecycle, Page Properties
3. Select the matching template from `templates/` for the document type
4. Resolve the code repo to document: an explicit path in the request wins, otherwise the `Code Repositories` row matching the chosen frente. Analyze that codebase for technical details; use `{placeholder}` for anything it does not yield
5. Write the result to `{Output path}/{source}/` -- `{source}` is the basename of the repo the information came from, or `generic` if it came from a link or from the user only. Default base: the config repo's `output/`
6. Consult `docs/decision-guide.md` ONLY if there is doubt about where to document something

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

## Two ways to use this framework

This framework is the single source of standards. Nothing is duplicated -- both modes reference this directory.

### Mode A -- run from inside the code repo (Strategy B, local reference)

The code repo carries a `CLAUDE.md` that points outward at the framework. Use it when the team owns the repo and wants documentation generated where they already work.

1. Copy `examples/repo-claude-md-example.md` to the repo root as `CLAUDE.md`
2. Replace the 6 variables: `{DESCRIPTION}`, `{FRONT}`, `{PREFIX}`, `{FRAMEWORK_PATH}`, `{CONFIG_PATH}`, `{SPACE_KEY}`
3. The AI in that repo reads standards and templates directly from `confluence-framework/`

### Mode B -- run from the config repo, aim at an external path

Nothing is added to the code repo. The config repo holds the paths and the AI reads the external codebase. Use it for repos you cannot or do not want to modify, or to document several repos from one place.

1. Fill the `Paths` and `Code Repositories` sections of your `project-config.md` (see `project-config-template.md`)
2. Install the skill and agent at user level so they are available outside this directory:
   ```bash
   cp -r .claude/skills/doc-confluence ~/.claude/skills/
   cp -r .claude/agents/confluence-doc ~/.claude/agents/
   ```

   On Windows these run in Git Bash. For PowerShell equivalents and path-format rules see `docs/customization-guide.md` -> Windows notes.
3. From the config repo, run `/doc-confluence <type> <subject> [target-path]`

The optional third argument overrides the `Code Repositories` table for a one-off run.

Reading a path outside the working directory requires granting access: `/add-dir /path/to/project` in the session, or `permissions.additionalDirectories` in `settings.json`.

The skill's path resolution is POSIX `sh` and runs unchanged on macOS, Linux, WSL and Git Bash on Windows. Use forward slashes in config paths (`C:/Users/you/work/my-api`) -- see `docs/customization-guide.md` -> Windows notes.

### For Copilot and Devin

Mode A applies. The content is the same, only the destination file changes:
- Copilot: `.github/copilot-instructions.md`
- Devin: `.devin/guidelines.md`

## Agent and Skill available

- **Agent**: `confluence-doc` -- Generates documentation following the framework standards, adapted to the project config
- **Skill**: `/doc-confluence` -- Reusable command to generate professional documents
