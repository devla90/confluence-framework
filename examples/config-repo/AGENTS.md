<!-- EXAMPLE FILE — fictional values, for reading. Not a live config.
     To start a real project use the template repo; see ../../docs/customization-guide.md -->

# Project: Acme Corp Web Portal

Configuration repo for the Acme Corp Web Portal Confluence space. Holds this project's
values; the shared standards live in the framework repo next door.

## Directory structure requirement

This config repo must be a sibling of the framework repo:

```
../confluence-framework/          <- framework (shared, open source)
../confluence-config-acme/       <- this repo (project-specific)
```

## How to generate documentation

**Read `../confluence-framework/docs/generation-procedure.md` and follow it.** That is
the single source of truth: resolving roots, resolving which codebase or link to read
from, analyzing it per document type, filling the template, and where the result goes.
It is tool-neutral, so it works whichever assistant you are.

Project values come from `./project-config.md` — prefix `ACME`, space key `ACMEWEB`,
frentes, `Paths`, `Code Repositories`, technology labels, documentation language.

- **Page structure**: `./page-structure.md`
- **Standards**: `../confluence-framework/docs/documentation-guide.md`
- **Templates**: `../confluence-framework/templates/{type}.md`
- **Assistant compatibility**: `../confluence-framework/docs/compatibility.md`

## Available document types

`func-spec` · `adr` · `api-spec` · `env-config` · `runbook` · `security-doc` ·
`migration` · `test-plan` · `test-strategy` · `infra-request` · `role-request`

## Output layout

```
output/
+-- {source-repo-name}/   <- one folder per repo documented
|   +-- {type}_{subject}_{YYYY-MM-DD}.md
+-- generic/              <- sources that are links, or user input only
    +-- {type}_{subject}_{YYYY-MM-DD}.md
```

Never write straight into `output/` — there is always a source subfolder.

## Connecting code repos

Two modes, pick per repo.

**Mode A** — put an `AGENTS.md` in the code repo:

```bash
cp ../confluence-framework/examples/agents-md-example.md /path/to/your/repo/AGENTS.md
```

Fill in the variables with this project's values: `{DESCRIPTION}`, `{FRONT}` (e.g.
`frontend`), `{PREFIX}` (`ACME-FRONT` or the matching suffix), `{FRAMEWORK_PATH}`
(`../confluence-framework`), `{CONFIG_PATH}` (`../confluence-config-acme/project-config.md`),
`{SPACE_KEY}` (`ACMEWEB`).

**Mode B** — nothing is written into the code repo. Fill the `Code Repositories` table
in `./project-config.md` with each repo's local path and generate from here. Requires
an assistant that can read outside this repo — check
`../confluence-framework/docs/compatibility.md` first.

## Key rules

- **Language**: English (as defined in project-config.md)
- **Naming**: `[ACME-{SUFFIX}] Type — Subject`
- **Labels**: always include `team:`, `type:`, `status:`
- **Secrets**: NEVER in Confluence. Record variable names only and reference AWS Secrets Manager
- **Diagrams**: draw.io macro (editable), not static images
- **Placeholders**: mark with `{placeholder}` anything not extracted from the source
