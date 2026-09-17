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

It must be one of: `func-spec`, `architecture`, `adr`, `api-spec`, `env-config`,
`runbook`, `guide`, `reference`, `security-doc`, `migration`, `release-note`,
`deployment-request`, `test-plan`, `test-strategy`, `infra-request`, `role-request`. If invalid, show the list and ask the user to choose. Full descriptions
and default labels are in Section 8 of the standards, already loaded in Step 0.

## Step 4: Gather information

The template loaded in Step 0 opens with a **Ask the user for** line naming exactly what
this document type needs. Ask for those, and nothing more — anything else you can read
from the source or leave as a `{placeholder}`.

The frente chosen here selects the row in the `Code Repositories` table, so ask for it
before Step 5 when the type requires one.

### Check the title is free — only when asked

**Do not contact Confluence unless the user asked you to in this request.** Having the
capability is not permission to use it: the space is usually shared with a team, and an
assistant that reaches into it on every generation is doing something the user did not
ask for.

Run this check when, and only when, one of these is true:

- The user asked in this request — "check the title first", "look it up in Confluence",
  "verify it against the space", or anything that plainly means it.
- `project-config.md` has `Check Confluence before generating` set to `yes`. That row is
  a standing instruction from whoever owns the project, and is absent by default.

Otherwise skip it and carry on. Skipping is the default, not a failure.

When it does run, run it here rather than later: Step 5 is the expensive part, and there
is no sense analyzing a repository for a page that cannot be created.

- **Free** — continue.
- **Taken** — stop and tell the user, with a link to the existing page. Ask whether they
  meant to update it or want a different subject. Confluence rejects a duplicate title
  within a space, so generating anyway only moves the failure to the paste.
- **Cannot check** — no such capability, not authorised, or the call failed. Continue
  generating, and say so in Step 8.

Setup and the tool names behind this: [`confluence-mcp.md`](confluence-mcp.md).

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

**Where it goes in Confluence.** The document is a file; someone still has to place it in
the space. Quote the parent that `page-structure.md` predicts, and label it as a
prediction — that file is a plan, the space is the fact, and the two drift.

Confirm it against the real tree **only under the same conditions as the title check
above**: the user asked, or the config says to. Do not reach into Confluence on your own
initiative.

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
- **What was checked against Confluence, and what was not.** If a check ran and the title
  is free, say so. If nothing was checked — the usual case, since these run only on
  request — say that plainly: the title is unverified and the parent page is predicted
  rather than confirmed. Silence reads as success, so never omit this

## Rules that are never bent

### Credentials never enter this repository

An API token, an OAuth secret, a password: none of them belong in any file under the
framework or the config repo. Not in `project-config.md`, not in an MCP client
configuration, not in a comment, not "temporarily".

The reason is that git does not forget. A token committed and then deleted is still in the
history, still in every clone, still on the remote. Revoking it is the only repair, and
that only works once somebody notices.

If a user asks you to store one, or offers one in a message so you can "put it in the
config", decline and say why: it goes in the assistant's own MCP configuration, outside
the repository, or it uses OAuth and there is nothing to store at all.

The same holds when helping someone connect a service. **Never ask for a token, a
password, or an encoded credential in conversation, even when the user has asked you to
set the thing up.** Print the command with a placeholder and let them run it. A credential
pasted into a chat is in the transcript, which is a file that gets kept and sometimes
shared, and revoking it is then the only repair.

This one has no setting. There is no situation in which committing a credential is the
right call.

---

## Confirming before you publish

Generating a document writes a file: private and reversible. Creating or updating a
Confluence page is neither — the space is usually shared, people who watch it get
notified, and an overwritten page is awkward to restore.

So the default is to ask. The project can change that.

### The setting

`project-config.md`, row `Confirm before publishing`:

| Value | Behaviour |
|-------|-----------|
| `yes` *(default, and what applies when the row is missing)* | Confirm every create and every update |
| `updates-only` | Create new pages without asking; always confirm before overwriting one that exists |
| `no` | Never ask |

`updates-only` is worth knowing about. Creating a page that turns out to be wrong leaves
a page to delete; overwriting one replaces work somebody else may have done, and the
previous content is only recoverable through page history if anyone thinks to look. Those
are different risks and the setting lets you treat them differently.

### When you do confirm

State, before the call:

- the full page title, as it will appear
- the space and the parent page it will be created under
- whether this **creates** a new page or **overwrites** an existing one, and if it
  overwrites, what is there now

Then wait for a clear yes. Not an assumption from earlier in the conversation, not an
inference from the original request, not "the user obviously wants this published". Ask
again for each page: approval to publish one is not approval to publish the next.

### When you do not

Even with confirmation switched off, **report every page you created or updated** in the
delivery summary, with its title and whether it was new or an overwrite. The user chose to
skip the question, not to skip knowing.

And a setting is not a licence to guess. If you are unsure which page a request refers to,
ask — `no` removes the routine confirmation, not your judgement.

If write scopes were never granted, none of this can arise, which is why
[`confluence-mcp.md`](confluence-mcp.md) recommends withholding them.

---

## What a published page cannot carry

Publishing drops things this framework treats as mandatory. The body arrives; the metadata
does not.

| Lost | Consequence |
|------|-------------|
| Page Properties macro | Becomes a plain table. The Page Properties Report on index pages stops seeing it |
| draw.io, Jira macros | Dropped entirely |
| **Every label** | The page is absent from all twelve CQL queries in the standards — readable, but unfindable |

None of that is visible on the published page, which looks almost right. So a published
page **says what is missing from it**, in three places.

### 1. A block at the top

First thing on the page, before any content. It carries:

- The tracking token, verbatim: `MCP-DRAFT-PENDING-COMPLETION`
- **The labels to apply**, one per line, copyable — taken from the template's
  `Default labels` line and the frente, not invented
- **The macros to insert** and where
- If this page supersedes another, which one — and that **the earlier page remains the
  authoritative one until somebody merges them**
- A last item: *delete this block and add `ai:reviewed` when done*

Deleting the block is what changes the page's state. Do not automate that: what a reader
sees should be the real state, not a guess at it.

### 2. A mark where each macro belongs

Wherever the template says to insert a draw.io macro, and immediately above every Page
Properties table, leave a one-line mark saying which macro goes there. The block at the
top says *what* is missing; these say *where*, which is what the person fixing it needs.

### 3. The token, so the page can be found

Labels are what the standards search on, and they are exactly what cannot be set. The
token stands in: it makes incomplete pages findable by text search until label support
arrives. The query lives in
[`documentation-guide.md`](documentation-guide.md) section 6.

The token is a **fixed literal**. Do not translate it, reword it or decorate it — the
query matches on it.

### This is the framework's existing state, borrowed

`ai-strategy.md` already defines `ai:auto-generated` for AI-drafted content and
`ai:reviewed` for content a human has validated, and `governance.md` already queries the
gap between them. The token is a stand-in for `ai:auto-generated` for as long as labels
cannot be set through this route — not a new concept, and it retires when they can.

## Updating a page that already exists

Read it before writing. What you find decides what you may do.

**The token is still there.** Nobody has completed the page, so nothing manual is at risk.
Update it, and reproduce the block — the page is still incomplete.

**The token is gone.** Somebody completed this page: applied the labels, inserted the
macros, deleted the block. An update would replace the body with markdown and destroy all
of it, leaving only page history as a recovery route — if anyone thinks to look.

**Refuse.** Not a confirmation prompt, a refusal. Say the page has been completed, name
what would be lost, and offer the two ways forward:

- edit it in Confluence directly, where macros survive
- publish as a new page, with the version appended to the subject:
  `[{PREFIX}-{SUFFIX}] {Type} — {Subject} (v2)`, rising to `(v3)` and so on

Create the new page only on explicit confirmation, and its block must name the page it
supersedes along with the warning that the earlier one stays authoritative until merged.

A routine confirmation gets accepted without reading. A refusal does not, and what is at
stake here is somebody else's work.

## Quality rules

Section 9 of the standards, loaded in Step 0, has the full list. The ones that matter
most:

- Write in the language configured in `project-config.md`
- Never invent data — extract it from the source or ask the user
- Never include secrets — reference the secrets platform instead
- Mark placeholders with `{placeholder}`
- Follow the template structure exactly
- Include a changelog entry
