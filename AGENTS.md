# Confluence Documentation Framework

Universal documentation framework for Confluence Cloud. Guides, 11 page templates,
governance and naming standards for teams building software across multiple domain
fronts.

This repository **is not uploaded to Confluence** — it is the source of truth for the
framework design. It is also project-agnostic: every project-specific value (naming
prefix, space key, frentes, tech stack, repo paths) lives in a separate
`project-config.md`, never here.

## How to generate a document

**Read `docs/generation-procedure.md` and follow it.** That file is the single source
of truth for the whole flow: resolving where the framework and config repo live,
resolving which codebase or link to read from, analyzing it, filling the template,
and filing the result.

It is tool-neutral — it names no vendor's tool or command — so it works whichever
assistant you are.

## Two working modes

- **Mode A** — you are running inside the code repo being documented. Copy
  `examples/agents-md-example.md` to that repo as `AGENTS.md` and fill in its six
  variables.
- **Mode B** — you are running from the config repo and pointing at an external local
  path or a URL. Requires an assistant that can read outside the current repo.

`docs/compatibility.md` says which assistants support which mode, and how each one
grants access to a folder outside the current repo. Check it before relying on Mode B.

## Key conventions

- **Page title**: `[PROJ-XXX] Type -- Subject` (prefix from `project-config.md`)
- **Mandatory labels**: `team:`, `type:`, `status:` on every page
- **Secrets**: NEVER in Confluence. Reference the path in the project's secrets manager
- **Diagrams**: draw.io macro (editable), not static images
- **Output**: `{Output path}/{source}/{type}_{subject}_{date}.md` — one folder per
  source repo, `generic/` for links
- **Guiding principle**: link, don't duplicate. Confluence = durable knowledge

## What to read, per task

Do NOT read every file. Pick only what the task needs.

| Task | Read |
|------|------|
| Understand how the whole thing fits together | `docs/how-it-works.md` |
| Generate or edit a document | `docs/generation-procedure.md` |
| Which assistants support what | `docs/compatibility.md` |
| Standards: naming, labels, lifecycle | `docs/documentation-guide.md` |
| Unsure where content belongs | `docs/decision-guide.md` |
| Create Confluence Space Templates | `docs/confluence-templates-guide.md` |
| Define structure or a new space | `docs/space-structure.md` |
| Roles, cadences, enforcement | `docs/governance.md` |
| Adapt the framework to a new project | `docs/customization-guide.md` + `project-config-template.md` |
| Set this up on a new machine | `docs/customization-guide.md` -> Starting on a new machine |
| Onboard the team | `docs/team-guide.md` |
| AI integration roadmap | `docs/ai-strategy.md`, `docs/implementation-roadmap.md` |

Most guides also have a `.es.md` Spanish translation.

## Per-assistant setup

Nothing needs installing: you are reading `AGENTS.md`, which is all an assistant needs
to follow the procedure from a plain-language request.

`adapters/` holds an optional `/doc-confluence` shortcut for each assistant, plus install
instructions. Each adapter is thin — it points back at `docs/generation-procedure.md`
rather than restating it.
