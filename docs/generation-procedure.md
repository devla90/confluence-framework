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

Two locations must be known before anything else, and neither can be assumed from the
current directory:

- **`CONFIG_ROOT`** — the directory holding `project-config.md`
- **`FRAMEWORK_ROOT`** — the framework directory holding `templates/` and `docs/`

**If they were already resolved for you** — you will see `CONFIG_ROOT=` and
`FRAMEWORK_ROOT=` lines above, together with the project config, the standards and the
template — Step 0 is done. Go to Step 1.

**Otherwise**, run the block in [`resolve-roots.md`](resolve-roots.md), then come back.
It is POSIX `sh`, works on macOS, Linux, WSL and Git Bash, and prints the two absolute
roots plus the three files the rest of this procedure needs.

Use those two absolute roots for **every** path from here on. Never use bare relative
paths like `templates/x.md` — they only resolve from one specific directory.

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
`role-request`. If invalid, show the list and ask the user to choose. Full descriptions
and default labels are in Section 8 of the standards, already loaded in Step 0.

## Step 4: Gather information

The template loaded in Step 0 opens with a **Ask the user for** line naming exactly what
this document type needs. Ask for those, and nothing more — anything else you can read
from the source or leave as a `{placeholder}`.

The frente chosen here selects the row in the `Code Repositories` table, so ask for it
before Step 5 when the type requires one.

## Step 5: Analyze the source

Only if a source was resolved in Step 2.

**Local path** — list files by pattern and search their contents, **scoped to the
source path**. The template's **Look for in the source** line says what this document
type needs; read that, not the whole repo.

**Stay inside an exploration budget.** Listing every file in a real repository costs more
than everything else in this procedure combined — a mid-sized frontend returns well over a
thousand paths, and that listing alone can outweigh the config, the standards, the template
and these instructions together. It also tells you very little: what a directory is called
says more about the architecture than the names of the files inside it.

So, in order:

1. **Read the README and the dependency manifest first.** They orient you at a known,
   small cost and usually name the parts that matter.
2. **List directories before files**, and shallowly — one or two levels. A repo's top-level
   directories are the map; expand only the branch the document actually concerns.
3. **Search contents rather than listing paths** once you know what you are looking for.
   A targeted search returns matches; a broad listing returns everything.
4. **If a pattern would return more than roughly 200 results, do not read it** — narrow it
   by directory or extension and try again. Something that broad is a sign you have not yet
   decided what you need.
5. **Stop when you can fill the template.** Extra files do not improve a document whose
   gaps are `{placeholder}` by design.

**Link** — fetch it and extract the same kind of information. Cite the URL in the
document so every fact is traceable.

**Secrets rule** — never copy values out of `.env`, config files, or CI variables.
Record only variable/parameter **names** and reference the secrets platform defined
in `project-config.md`. If you encounter a real credential, do not reproduce it
anywhere in the document.

**Invention rule** — everything you could not extract from the source or get from the
user stays a `{placeholder}`. Do not fill gaps with plausible-looking content.

## Step 6: Generate the document

1. The template's leading blockquote — default labels, **Ask the user for**, **Look for
   in the source** — is guidance for you, not content. Do not copy it into the document.
   Use the template and the naming conventions you already have — Step 0 loaded the
   template plus sections 1, 8 and 9 of the standards. Do not open that file again
   unless you need a section outside those three
2. Use the prefix, space and language from the project config, also already loaded
4. Apply:
   - **Title**: `[{PREFIX}-{SUFFIX}] {Type} -- {Subject}` (prefix and suffix from
     project-config.md). This applies to **every** title without exception, including
     patterns that look self-qualifying: `[APP-ARCH] ADR-0012 — ...`,
     `[APP-FRONT] RB — ...`, `[APP-ARCH] ENV-PROD — ...`. Confluence requires titles to
     be unique per space, and several projects may share one
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

Section 9 of the standards, loaded in Step 0, has the full list. The ones that matter
most:

- Write in the language configured in `project-config.md`
- Never invent data — extract it from the source or ask the user
- Never include secrets — reference the secrets platform instead
- Mark placeholders with `{placeholder}`
- Follow the template structure exactly
- Include a changelog entry
