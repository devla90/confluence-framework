---
name: doc-confluence
description: Generates professional Confluence documentation following the framework standards. Reads project-config.md for project-specific values and can analyze an external local code repository to extract technical information. Supports all document types (func-spec, adr, api-spec, env-config, runbook, security-doc, migration, test-plan, test-strategy, infra-request, role-request).
when_to_use: When the user needs to create Confluence documentation, generate a new page from a template, or document a feature, API, environment, decision, runbook, security policy, or migration plan -- either for the current repo or for a project at another local path.
argument-hint: <type> <subject> [target-path] -- types: func-spec | adr | api-spec | env-config | runbook | security-doc | migration | test-plan | test-strategy | infra-request | role-request
arguments: [tipo, tema, target]
allowed-tools: Read, Bash, Write, Edit, Glob, Grep, WebFetch
model: sonnet
effort: high
user-invocable: true
---

## Objective

Generate a professional document for Confluence Cloud following the framework standards, adapted to the current project's configuration.

**Document type**: `$tipo`
**Subject**: `$tema`
**Target repo path (optional)**: `$target`

## Bootstrap: resolve roots and preload context

This block resolves the framework and config repo locations no matter which directory you were invoked from, then preloads the three files needed. Use the absolute `CONFIG_ROOT` and `FRAMEWORK_ROOT` it prints for every subsequent path -- never use bare relative paths like `templates/x.md` or `docs/x.md`.

!`unset CDPATH; A(){ (cd "$1" 2>/dev/null && { pwd -W 2>/dev/null || pwd; }); }; T="$tipo"; CFG=""; for d in . .. ./confluence-config-* ../confluence-config-*; do [ -f "$d/project-config.md" ] && CFG=$(A "$d") && break; done; FW=""; if [ -n "$CFG" ]; then P=$(grep -m1 '^| *Framework path *|' "$CFG/project-config.md" | tr -d '\r' | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}'); case "$P" in ""|\{*) P="" ;; esac; [ -n "$P" ] && [ -f "$CFG/$P/templates/func-spec.md" ] && FW=$(A "$CFG/$P"); fi; if [ -z "$FW" ]; then for d in . .. ./confluence-framework ../confluence-framework "$CFG/../confluence-framework"; do [ -f "$d/templates/func-spec.md" ] && FW=$(A "$d") && break; done; fi; echo "CONFIG_ROOT=${CFG:-NOT_FOUND}"; echo "FRAMEWORK_ROOT=${FW:-NOT_FOUND}"; echo "SHELL_UNAME=$(uname -s 2>/dev/null || echo unknown)"; echo "--- project-config.md ---"; { [ -n "$CFG" ] && cat "$CFG/project-config.md"; } || echo "NOT_FOUND: no project-config.md in . .. or a sibling confluence-config-*. Ask the user for the config repo path."; echo "--- documentation-guide.md (head) ---"; { [ -n "$FW" ] && head -60 "$FW/docs/documentation-guide.md"; } || echo "NOT_FOUND: framework root not resolved. Ask the user for the confluence-framework path."; echo "--- template: $T ---"; { [ -n "$FW" ] && cat "$FW/templates/$T.md" 2>/dev/null; } || echo "TEMPLATE NOT FOUND. Valid types: func-spec adr api-spec env-config runbook security-doc migration test-plan test-strategy infra-request role-request"`

The block is POSIX `sh` and runs unchanged on macOS, Linux, WSL and Git Bash on Windows. On Git Bash `pwd -W` yields a native `C:/Users/...` root rather than the MSYS `/c/Users/...` form, which the file tools cannot open; `tr -d '\r'` keeps CRLF-checked-out configs from producing paths with a trailing carriage return.

If either root printed `NOT_FOUND`, stop and ask the user for the missing path instead of guessing. If more than one `confluence-config-*` sibling exists the first match wins -- confirm with the user that it is the right project before continuing.

## Execution instructions

### Step 0: Read project configuration

From the preloaded `project-config.md` obtain:
- **Naming prefix** (e.g. `PROJ`) and **Confluence space key** (e.g. `PROJSPACE`)
- **Frentes table** with suffixes and team labels
- **Code Repositories table** with the local path of each frente's repo
- **Paths** section: `Framework path` and `Output path`
- **Documentation language**, **Technology labels**, **Secrets platform**
- **Overrides** of any framework defaults

### Step 0.5: Resolve the target repo path

The target is the source the information will be extracted from -- normally a local codebase, but it can also be a link. Resolve it in this order, first match wins:

1. **The `$target` argument**, if the user passed one. This always overrides the config. It may be a local path **or a URL** (an OpenAPI spec, a public documentation page, a repository page).
2. **The `Code Repositories` table** in `project-config.md` -- the row whose `Front` or `Suffix` matches the frente chosen in Step 2. Read it under the `## Code Repositories` heading only: the `## Frentes (Sections)` table has the same `Front`/`Suffix` columns and its third column is a technology list, not a path. A row with an empty path means that frente has no code -- generate from placeholders.
3. **Ask the user** for the path, or offer to generate the document from placeholders only, with no code analysis.

If the resolved target is a local path, validate it with `test -d <path> && ls <path>`. If it does not exist or is not readable, say so and tell the user to run `/add-dir <path>` (or add it to `permissions.additionalDirectories` in `settings.json`) -- do not silently skip the analysis and do not invent content.

**Windows paths**: accept `C:\Users\you\work\my-api` from the user, but convert `\` to `/` before using it in any shell command -- inside `sh` a backslash is an escape character and `test -d "C:\Users\..."` will not match. `C:/Users/you/work/my-api` works everywhere.

If the resolved target is a URL, fetch it with `WebFetch` instead. Record that the source was a link -- it changes where the document is filed (Step 3.5).

Two working modes are supported and both end up here:
- **Mode A**: you are running inside the code repo. The target is the current directory.
- **Mode B**: you are running from the config repo and the target is an external path or URL resolved above.

### Step 1: Validate the document type

Verify that `$tipo` is one of: `func-spec`, `adr`, `api-spec`, `env-config`, `runbook`, `security-doc`, `migration`, `test-plan`, `test-strategy`, `infra-request`, `role-request`. If invalid, show available types and ask the user to choose. For full descriptions and default labels, read `$FRAMEWORK_ROOT/docs/documentation-guide.md` Section 8.

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

The frente chosen here is what selects the row in the `Code Repositories` table, so ask for it before Step 2.5 when the type requires one.

### Step 2.5: Analyze the target codebase

Only if a target was resolved in Step 0.5.

**Local path**: use `Glob`, `Grep` and `Read` **scoped to the target path** to extract real technical information. Read what the document type needs, not the whole repo:

| Type | What to look for in the target |
|------|-------------------------------|
| `api-spec` | OpenAPI/Swagger files, route definitions, auth middleware, request/response models |
| `env-config` | `.env.example`, config files, IaC (Terraform/CDK/docker-compose), deployment manifests |
| `func-spec` | Components/modules for the feature, routes, data models, business rules |
| `adr` | Dependency manifests, architecture visible in the directory structure, existing ADRs |
| `runbook` | Deploy scripts, health checks, logging/monitoring config, CI pipelines |
| `migration` | Migration files, current schema, legacy modules being replaced |
| `test-plan` / `test-strategy` | Test setup, runners, coverage config, existing test directories |
| `infra-request` / `role-request` | IaC, IAM policies, deployment manifests, required permissions |

Start with the repo's README and dependency manifest to orient yourself, then narrow with `Grep`.

**Link**: fetch it with `WebFetch` and extract the same kind of information. Cite the URL in the document so the source of every fact is traceable.

**Secrets rule while reading the target**: never copy values out of `.env`, config files, or CI variables. Record only variable/parameter **names** and reference the secrets platform defined in `project-config.md`. If you encounter a real credential, do not reproduce it anywhere in the document.

**Invention rule**: everything you could not extract from the code or get from the user stays a `{placeholder}`. Do not fill gaps with plausible-looking content.

### Step 3: Generate the document

1. Read the full corresponding template from `$FRAMEWORK_ROOT/templates/$tipo.md`
2. Read the naming conventions section from `$FRAMEWORK_ROOT/docs/documentation-guide.md`
3. Use the prefix, space, and language from `$CONFIG_ROOT/project-config.md`
4. Generate the document applying:
   - **Title**: Following pattern `[{PREFIX}-{SUFFIX}] {Type} -- {Subject}` (prefix and suffix from project-config.md)
   - **Labels**: List all labels to be applied in Confluence
   - **Page Properties**: Complete table with mandatory fields
   - **Content**: Fill sections with information from the user and from the codebase analysis
   - **Placeholders**: Mark with `{placeholder}` what the user must complete
   - **Language**: Write in the language specified in project-config.md

### Step 3.5: Resolve the output path

Every document is filed inside a subfolder named after the source it was generated from, so it is always obvious where a page came from and documents from different repos never mix.

**1. Base directory** -- the `Output path` row from the `Paths` section of `project-config.md`, resolved relative to `CONFIG_ROOT` if it is not absolute. If the row is missing, empty, or still a `{placeholder}`, use `$CONFIG_ROOT/output/`.

**2. Source folder** -- named after where the information came from:

| Source resolved in Step 0.5 | Folder |
|-----------------------------|--------|
| A local repo | The basename of the target path, lowercased and slugified. Normalize `\` to `/` and drop trailing separators first, so Windows paths work too: `/Users/you/work/my-api`, `C:/Users/you/work/my-api` and `C:\Users\you\work\my-api` all give `my-api` |
| A link (URL fetched with WebFetch) | `generic` |
| No source -- information came only from the user | `generic` |

**3. Final path** -- `{base}/{source-folder}/{tipo}_{subject-slug}_{YYYY-MM-DD}.md`

Create the directories with `mkdir -p` before writing. **Never write straight into the base folder** -- there is always a source subfolder.

Use forward slashes in the path you pass to `Write`, on every platform.

```
output/
+-- scb-web-public-react-spa/
|   +-- test-strategy_react-spa_2026-09-06.md
|   +-- api-spec_contact-form_2026-09-06.md
+-- my-api/
|   +-- api-spec_authentication_2026-09-06.md
+-- generic/
    +-- api-spec_stripe-payments_2026-09-06.md
```

### Step 4: Delivery summary

When finished, show:
- Path of the generated file
- Page title for Confluence
- Labels to apply
- Sections requiring user attention (pending placeholders)
- Section within the Confluence space where the page should be created
- **Resolved roots**: `CONFIG_ROOT`, `FRAMEWORK_ROOT`, and the source that was analyzed -- a local path, a URL, or a note that neither was used -- plus the source folder the document was filed under

## Quality rules

Follow quality standards in `$FRAMEWORK_ROOT/docs/documentation-guide.md` Section 9. Key rules: write in the configured language, never invent data, never include secrets, mark placeholders with `{placeholder}`, follow template structure exactly, include changelog entry.
