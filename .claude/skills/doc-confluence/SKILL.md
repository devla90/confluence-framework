---
name: doc-confluence
description: Generates professional Confluence documentation following the framework standards. Reads project-config.md for project-specific values. Supports all document types (func-spec, adr, api-spec, env-config, runbook, security, migration, test-plan, test-strategy, infra-request, role-request).
when_to_use: When the user needs to create Confluence documentation, generate a new page from a template, or document a feature, API, environment, decision, runbook, security policy, or migration plan.
argument-hint: <type> <subject> -- types: func-spec | adr | api-spec | env-config | runbook | security | migration | test-plan | test-strategy | infra-request | role-request
arguments: [tipo, tema]
allowed-tools: Read, Bash, Write, Edit
model: sonnet
effort: high
user-invocable: true
---

## Objective

Generate a professional document for Confluence Cloud following the framework standards, adapted to the current project's configuration.

**Document type**: `$tipo`
**Subject**: `$tema`

## Project configuration (load first)

!`cat project-config.md 2>/dev/null | head -25 || echo "WARNING: project-config.md not found in current directory. Check parent directory or config repo path in CLAUDE.md."`

## Project standards (minimal load)

!`cat docs/documentation-guide.md | head -60`

## Template to use

!`cat templates/$tipo.md 2>/dev/null || echo "TEMPLATE NOT FOUND. Available types: func-spec, adr, api-spec, env-config, runbook, security-doc, migration, test-plan, test-strategy, infra-request, role-request"`

## Execution instructions

### Step 0: Read project configuration

Read `project-config.md` to obtain:
- **Naming prefix** (e.g. `PROJ`)
- **Confluence space key** (e.g. `PROJSPACE`)
- **Frentes table** with suffixes and team labels
- **Documentation language** (e.g. english, spanish)
- **Technology labels** specific to the project
- **Secrets platform** for credential references
- **Overrides** of any framework defaults

If `project-config.md` is not in the current directory, check the path referenced in the repo's CLAUDE.md.

### Step 1: Validate the document type

Verify that `$tipo` is one of: `func-spec`, `adr`, `api-spec`, `env-config`, `runbook`, `security-doc`, `migration`, `test-plan`, `test-strategy`, `infra-request`, `role-request`. If invalid, show available types and ask the user to choose. For full descriptions and default labels, read `docs/documentation-guide.md` Section 8.

### Step 2: Gather information

Ask the user for the minimum necessary information per type:

**func-spec**: Feature name, frente (frontend/backend/etc), phase (AS-IS/TO-BE), related epic in issue tracker
**adr**: Decision title, context, options considered
**api-spec**: Service name, main endpoints, authentication
**env-config**: Environment (DEV/QA/STG/PROD), technology/component, main parameters
**runbook**: Affected system, scenario, severity
**security-doc**: Type (policy/checklist/report), applicable regulation
**migration**: What is being migrated, AS-IS state, target TO-BE state
**test-plan**: Feature/sprint under test, test types, environment, entry/exit criteria
**test-strategy**: Scope (project/component), test types, automation tools, target metrics
**infra-request**: Cloud resource type, proposed name, environment, region, justification (feature/service requiring it), technical specifications, security requirements, target team (internal/external)
**role-request**: Role name, type (IAM Role/Policy/RBAC), environment, which service/pipeline needs it, requested permissions (service/actions/resources), least-privilege justification, duration (permanent/temporary), target team

### Step 3: Generate the document

1. Read the full corresponding template from `templates/`
2. Read the naming conventions section from `docs/documentation-guide.md`
3. Read the project-config.md for prefix, space, and language
4. Generate the document applying:
   - **Title**: Following pattern `[{PREFIX}-{SUFFIX}] {Type} -- {Subject}` (prefix and suffix from project-config.md)
   - **Labels**: List all labels to be applied in Confluence
   - **Page Properties**: Complete table with mandatory fields
   - **Content**: Fill sections with provided information
   - **Placeholders**: Mark with `{placeholder}` what the user must complete
   - **Language**: Write in the language specified in project-config.md

5. Write the generated file in `output/` with a descriptive name

### Step 4: Delivery summary

When finished, show:
- Path of the generated file
- Page title for Confluence
- Labels to apply
- Sections requiring user attention (pending placeholders)
- Section within the Confluence space where the page should be created

## Quality rules

Follow quality standards in `docs/documentation-guide.md` Section 9. Key rules: write in the configured language, never invent data, never include secrets, mark placeholders with `{placeholder}`, follow template structure exactly, include changelog entry.
