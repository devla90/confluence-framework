# Document Generation Procedure

> **This file is the single source of truth for how a document gets generated.**
>
> It is deliberately tool-neutral: it names no vendor's tool, command or config
> format. Every assistant adapter (`adapters/`, `.claude/`) is a thin wrapper that
> points here. If you change how generation works, change it here and nowhere else.
>
> Which assistants can do what — and how each one grants access to a folder outside
> the current repo — is in `docs/compatibility.md`.

---

## Capabilities you need

The procedure assumes an assistant that can do these five things. Every assistant
names them differently; use whatever yours calls them.

| Capability | Used for |
|-----------|----------|
| Run a shell command | Resolving roots (Step 0), checking a path exists, creating directories |
| Read a file | Config, standards, templates, source code |
| List files matching a pattern | Finding specs, tests, IaC in the source repo |
| Search file contents | Narrowing down to the relevant code |
| Write a file | The generated document |
| Fetch a URL *(optional)* | Only when the source is a link instead of a local path |

If your assistant cannot run shell commands, resolve the roots by hand and tell the
assistant the two absolute paths before starting.

---

## Step 0: Resolve the roots

Two locations must be known before anything else, and neither can be assumed from
the current directory:

- **`CONFIG_ROOT`** — the directory holding `project-config.md`
- **`FRAMEWORK_ROOT`** — the framework directory holding `templates/` and `docs/`

Run this. It is POSIX `sh` and works unchanged on macOS, Linux, WSL and Git Bash on
Windows. Replace `func-spec` with the document type being generated.

```sh
T=func-spec

unset CDPATH
A() { (cd "$1" 2>/dev/null && { pwd -W 2>/dev/null || pwd; }); }

CFG=""
for d in . .. ./confluence-config-* ../confluence-config-*; do
  [ -f "$d/project-config.md" ] && CFG=$(A "$d") && break
done

FW=""
if [ -n "$CFG" ]; then
  P=$(grep -m1 '^| *Framework path *|' "$CFG/project-config.md" | tr -d '\r' \
      | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')
  case "$P" in ""|\{*) P="" ;; esac
  [ -n "$P" ] && [ -f "$CFG/$P/templates/func-spec.md" ] && FW=$(A "$CFG/$P")
fi
if [ -z "$FW" ]; then
  for d in . .. ./confluence-framework ../confluence-framework "$CFG/../confluence-framework"; do
    [ -f "$d/templates/func-spec.md" ] && FW=$(A "$d") && break
  done
fi

echo "CONFIG_ROOT=${CFG:-NOT_FOUND}"
echo "FRAMEWORK_ROOT=${FW:-NOT_FOUND}"
echo "--- project-config.md ---"
{ [ -n "$CFG" ] && cat "$CFG/project-config.md"; } \
  || echo "NOT_FOUND: no project-config.md in . .. or a sibling confluence-config-*."
echo "--- documentation-guide.md (head) ---"
{ [ -n "$FW" ] && head -60 "$FW/docs/documentation-guide.md"; } \
  || echo "NOT_FOUND: framework root not resolved."
echo "--- template: $T ---"
{ [ -n "$FW" ] && cat "$FW/templates/$T.md" 2>/dev/null; } \
  || echo "TEMPLATE NOT FOUND. Valid types: func-spec adr api-spec env-config runbook security-doc migration test-plan test-strategy infra-request role-request"
```

**Why each guard is there** — do not simplify them away:

- `pwd -W` yields a native `C:/Users/...` root on Git Bash instead of the MSYS
  `/c/Users/...` form, which file-reading tools cannot open. It fails harmlessly on
  POSIX and falls back to `pwd`.
- `tr -d '\r'` stops a CRLF checkout from gluing a carriage return onto the parsed
  path, producing a directory that does not exist.
- The `case "$P" in \{*)` guard rejects an unfilled `{placeholder}` in the config.

Use the two absolute roots it prints for **every** path from here on. Never use bare
relative paths like `templates/x.md` or `docs/x.md` — they only resolve from one
specific directory.

If either root printed `NOT_FOUND`, stop and ask the user for the missing path
instead of guessing. If more than one `confluence-config-*` sibling exists the first
match wins — confirm with the user that it is the right project.

## Step 1: Read the project configuration

From `$CONFIG_ROOT/project-config.md` obtain:

- **Naming prefix** (e.g. `PROJ`) and **Confluence space key** (e.g. `PROJSPACE`)
- **Frentes table** with suffixes and team labels
- **Code Repositories table** with the local path of each frente's repo
- **Paths** section: `Framework path` and `Output path`
- **Documentation language**, **Technology labels**, **Secrets platform**
- **Overrides** of any framework defaults

## Step 2: Resolve the source

The source is where technical information will be extracted from — normally a local
codebase, but it can also be a link. Resolve it in this order, first match wins:

1. **An explicit path or URL** given in the request. This always overrides the config.
2. **The `Code Repositories` table** in `project-config.md` — the row whose `Front` or
   `Suffix` matches the frente chosen in Step 4. Read it under the
   `## Code Repositories` heading **only**: the `## Frentes (Sections)` table has the
   same `Front`/`Suffix` columns but its third column is a technology list, not a
   path. A row with an empty path means that frente has no code — generate from
   placeholders.
3. **Ask the user** for the path, or offer to generate from placeholders only, with
   no source analysis.

**Relative paths resolve against `CONFIG_ROOT`**, never against the current directory.
A `Code Repositories` row saying `../my-api` means `$CONFIG_ROOT/../my-api`, whatever
directory the session was started from. This is what keeps a shared, committed config
working on every machine — resolve it the same way from anywhere, and expand it to an
absolute path before using it. An explicit path given in the request is taken as-is.

**If the source is a local path**, validate it with `test -d <path> && ls <path>`. If
it does not exist or is not readable, say so and tell the user to grant the assistant
access to that folder — see `docs/compatibility.md` for how each one does it. Do not
silently skip the analysis and do not invent content.

**Windows paths**: accept `C:\Users\you\work\my-api` from the user, but convert `\`
to `/` before using it in any shell command — inside `sh` a backslash is an escape
character and `test -d "C:\Users\..."` will not match. `C:/Users/you/work/my-api`
works everywhere. Under WSL use `/mnt/c/Users/you/work/my-api`.

**If the source is a URL**, fetch it. Record that the source was a link — it changes
where the document is filed (Step 7).

Two working modes both end here:

- **Mode A** — you are running inside the code repo. The source is the current directory.
- **Mode B** — you are running from the config repo and the source is an external path
  or URL. Mode B needs an assistant that can read outside the current repo; check
  `docs/compatibility.md` before relying on it.

## Step 3: Validate the document type

It must be one of: `func-spec`, `adr`, `api-spec`, `env-config`, `runbook`,
`security-doc`, `migration`, `test-plan`, `test-strategy`, `infra-request`,
`role-request`. If invalid, show the list and ask the user to choose. Full
descriptions and default labels are in `$FRAMEWORK_ROOT/docs/documentation-guide.md`
Section 8.

## Step 4: Gather information

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

The frente chosen here is what selects the row in the `Code Repositories` table, so
ask for it before Step 5 when the type requires one.

## Step 5: Analyze the source

Only if a source was resolved in Step 2.

**Local path** — list files by pattern and search their contents, **scoped to the
source path**. Read what the document type needs, not the whole repo:

| Type | What to look for in the source |
|------|-------------------------------|
| `api-spec` | OpenAPI/Swagger files, route definitions, auth middleware, request/response models |
| `env-config` | `.env.example`, config files, IaC (Terraform/CDK/docker-compose), deployment manifests |
| `func-spec` | Components/modules for the feature, routes, data models, business rules |
| `adr` | Dependency manifests, architecture visible in the directory structure, existing ADRs |
| `runbook` | Deploy scripts, health checks, logging/monitoring config, CI pipelines |
| `migration` | Migration files, current schema, legacy modules being replaced |
| `test-plan` / `test-strategy` | Test setup, runners, coverage config, existing test directories |
| `infra-request` / `role-request` | IaC, IAM policies, deployment manifests, required permissions |

Start with the repo's README and dependency manifest to orient yourself, then narrow
by searching contents.

**Link** — fetch it and extract the same kind of information. Cite the URL in the
document so every fact is traceable.

**Secrets rule** — never copy values out of `.env`, config files, or CI variables.
Record only variable/parameter **names** and reference the secrets platform defined
in `project-config.md`. If you encounter a real credential, do not reproduce it
anywhere in the document.

**Invention rule** — everything you could not extract from the source or get from the
user stays a `{placeholder}`. Do not fill gaps with plausible-looking content.

## Step 6: Generate the document

1. Read the full template from `$FRAMEWORK_ROOT/templates/{type}.md`
2. Read the naming conventions from `$FRAMEWORK_ROOT/docs/documentation-guide.md`
3. Use the prefix, space and language from `$CONFIG_ROOT/project-config.md`
4. Apply:
   - **Title**: `[{PREFIX}-{SUFFIX}] {Type} -- {Subject}` (prefix and suffix from project-config.md)
   - **Labels**: list all labels to be applied in Confluence
   - **Page Properties**: complete table with mandatory fields
   - **Content**: fill sections from the user's input and the source analysis
   - **Placeholders**: mark with `{placeholder}` what the user must complete
   - **Language**: as specified in project-config.md

## Step 7: Resolve the output path

Every document is filed inside a subfolder named after the source it came from, so it
is always obvious where a page originated and documents from different repos never mix.

**1. Base directory** — the `Output path` row from the `Paths` section of
`project-config.md`, resolved relative to `CONFIG_ROOT` if it is not absolute. If the
row is missing, empty, or still a `{placeholder}`, use `$CONFIG_ROOT/output/`.

**2. Source folder**:

| Source resolved in Step 2 | Folder |
|---------------------------|--------|
| A local repo | The basename of the source path, lowercased and slugified. Normalize `\` to `/` and drop trailing separators first, so Windows paths work too: `/Users/you/work/my-api`, `C:/Users/you/work/my-api` and `C:\Users\you\work\my-api` all give `my-api` |
| A link | `generic` |
| No source — information came only from the user | `generic` |

**3. Final path** — `{base}/{source-folder}/{type}_{subject-slug}_{YYYY-MM-DD}.md`

Create the directories with `mkdir -p` before writing. **Never write straight into the
base folder** — there is always a source subfolder. Use forward slashes in the path
you write to, on every platform.

```
output/
+-- my-web-app/
|   +-- func-spec_contact-form_2026-09-07.md
+-- my-api/
|   +-- api-spec_authentication_2026-09-07.md
+-- generic/
    +-- api-spec_stripe-payments_2026-09-07.md
```

## Step 8: Delivery summary

When finished, report:

- Path of the generated file
- Page title for Confluence
- Labels to apply
- Sections requiring user attention (pending placeholders)
- Section within the Confluence space where the page should be created
- **Resolved roots**: `CONFIG_ROOT`, `FRAMEWORK_ROOT`, the source analyzed (a local
  path, a URL, or a note that neither was used), and the source folder the document
  was filed under

## Quality rules

Full standards are in `$FRAMEWORK_ROOT/docs/documentation-guide.md` Section 9. The
ones that matter most:

- Write in the language configured in `project-config.md`
- Never invent data — extract it from the source or ask the user
- Never include secrets — reference the secrets platform instead
- Mark placeholders with `{placeholder}`
- Follow the template structure exactly
- Include a changelog entry
