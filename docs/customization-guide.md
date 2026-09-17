# Customization Guide

How to adapt this framework for a new project.

---

## Prerequisites

- Access to a Confluence Cloud space for your project
- This framework repository cloned locally
- An AI coding assistant. Claude Code, OpenAI Codex, GitHub Copilot, opencode, Devin, Cursor and others are supported -- see `compatibility.md` for what each one can do
- On Windows: Git Bash (ships with Git for Windows) or WSL — see [Windows notes](#windows-notes)

---

## Choosing a layout

The framework and your project's values live in separate repositories. Three
arrangements work, and the root resolution in Step 0 of the procedure finds the
framework in all three without any configuration — it searches `.`, `..`,
`./confluence-framework` and `../confluence-framework`.

### A — Siblings (default)

Two plain clones, side by side. No flags, nothing to remember.

```
my-workspace/
├── confluence-framework/       <- git clone, public
└── config-my-project/          <- from the template, yours
    ├── project-config.md       <- Framework path: ../confluence-framework
    ├── AGENTS.md
    └── output/
```

Choose this unless you have a reason not to. It is the least surprising, and both
`AGENTS.md` files arrive with their clones.

### B — The code repo is the config repo

For a project that lives in a single repository, you do not need a separate config repo
at all. Put `project-config.md` at the root of the code repo:

```
my-app/
├── project-config.md           <- Framework path: ./confluence-framework
├── confluence-framework/       <- clone or submodule
├── output/
└── src/
```

Simpler for one-repo projects. Less suitable once several repos share one Confluence
space, since each would carry its own copy of the project's values.

### C — Framework as a submodule

Pins the framework to an exact commit inside your config repo's own history. See
[Advanced: pinning with a submodule](#advanced-pinning-with-a-submodule) below —
including the cost, which is real.

> **Not supported:** putting `project-config.md` *inside* `confluence-framework/`. The
> framework is deliberately project-agnostic — that property is what lets several teams
> share one copy and what makes it publishable. Your values belong in your repo.

---

## Starting on a new machine

If the project is already set up and you just need it running somewhere new — a new
laptop, a new teammate — this is the whole sequence. Nothing is installed beyond your
assistant's adapter; the framework is plain Markdown.

**1. Clone both repos as siblings:**

```bash
mkdir my-workspace && cd my-workspace
git clone https://github.com/devla90/confluence-framework
git clone <your-config-repo-url> config-my-project
```

To pin the framework to a release instead of tracking the latest:
`git clone --branch v1.0.0 https://github.com/devla90/confluence-framework`.

**2. Check the `Framework path` row** in your config repo's `project-config.md`. For the
sibling layout it is `../confluence-framework`. Root resolution reads this row first.

**3. Optionally, install a `/doc-confluence` shortcut.** Skip this and everything still
works — your assistant reads `AGENTS.md` and follows the procedure from a plain-language
request. The shortcut only saves typing. One command per machine, from your config repo;
see [`../adapters/README.md`](../adapters/README.md) for all of them. For example:

```bash
# OpenAI Codex
mkdir -p ~/.codex/prompts && cp ../confluence-framework/adapters/codex/doc-confluence.md ~/.codex/prompts/
```

**4. Start the session from your config repo.** Its `AGENTS.md` is versioned, so it
arrives with the clone and orients whichever assistant you use. Step 0 finds the
framework from there.

**5. Smoke test.** Run the shell block from Step 0 of
[`generation-procedure.md`](generation-procedure.md). It must print two **absolute**
roots and no `NOT_FOUND`:

```
CONFIG_ROOT=/Users/you/my-workspace/config-my-project
FRAMEWORK_ROOT=/Users/you/my-workspace/confluence-framework
```

If either says `NOT_FOUND`, the layout or the `Framework path` row is wrong — fix that
before generating anything.

**6. Check the `Code Repositories` paths.** Relative paths (`../my-api`) resolve from the
config repo and carry over to a new machine unchanged. Any absolute path in that table
came from someone else's machine and needs updating — or pass the path as the third
argument for a one-off run.

On Windows, read the [Windows notes](#windows-notes) first: use Git Bash or WSL, and
forward slashes in config paths.

---

## Advanced: pinning with a submodule

Skip this unless you specifically want the framework version recorded inside your config
repo's history. The sibling layout plus a tagged clone
(`git clone --branch v1.0.0 ...`) gives you most of the same benefit with none of the
friction below.

### What a submodule actually is

Git does **not** store a copy of the framework's files in your repo. It stores two
things: an entry in `.gitmodules` with the URL and path, and a pointer in the tree to
one exact **commit SHA**. That is why a normal `git clone` leaves you with an *empty*
`confluence-framework/` directory — the pointer came through, the files did not.

### Setting it up

```bash
cd config-my-project
git submodule add https://github.com/devla90/confluence-framework confluence-framework
git commit -m "Pin framework"
```

Then set `Framework path` to `./confluence-framework`.

### Cloning it afterwards

```bash
git clone --recurse-submodules <your-config-repo>
```

**The flag is needed only on the first clone — and it cannot be automated.** Setting
`git config --global submodule.recurse true` covers your day-to-day commands, but clone
is the documented exception:

> `submodule.recurse` applies to *checkout, fetch, grep, pull, push, read-tree, reset,
> restore* — *"clone and ls-files are not supported."*
> — `git config --help`

If you forget, nothing is lost. From inside the repo:

```bash
git submodule update --init --recursive
```

### Updating the framework on purpose

```bash
git submodule update --remote
git commit -am "Update framework"
```

The update is a commit in your repo, so you can see when it happened and revert it.

> **The framework itself has no submodules.** Anyone who just wants the standards clones
> it normally and it works immediately. Submodules only ever appear in *your* config
> repo, and only if you choose this layout.

---

## Step 1: Clone the Framework

```bash
git clone <framework-repo-url> confluence-framework
```

This repo is shared — do not modify it for your project. Your project-specific values go in a separate config repo.

## Step 2: Create Your Config Repo

Create a new repository for your project configuration:

```bash
mkdir confluence-config-{your-project}
cd confluence-config-{your-project}
```

Copy the config template from the framework:

```bash
cp ../confluence-framework/project-config-template.md ./project-config.md
```

Then add an `AGENTS.md` one level up, in the directory holding both repos. This is what
an assistant started from the workspace level reads, and starting there is what lets a
sandboxed assistant reach both repos. Keep it short — name the two directories and point
at `confluence-framework/docs/generation-procedure.md`. The `AGENTS.md` at the root of
this workspace is a working example.

```
my-workspace/
├── AGENTS.md                          <- orients any assistant started here
├── confluence-framework/
└── confluence-config-{your-project}/
```

## Step 3: Fill In Your Configuration

Edit `project-config.md` and replace all `{placeholder}` values:

1. **Identity**: Project name, organization, naming prefix, Confluence space key, URL
2. **Paths**: `Framework path` (relative path to `confluence-framework/`) and `Output path` (where generated docs are written)
3. **Frentes**: Your team structure. You can use the 7 defaults (Frontend, Backend, UI/UX, Business, Architecture, Security, QA) or define your own
4. **Code repositories**: The local path of the repo implementing each frente. Required for Mode B (Step 6). Leave empty for frentes with no code
5. **Technology labels**: The `tech:` labels specific to your stack
6. **Secrets platform**: Where your team stores secrets (AWS Secrets Manager, Azure Key Vault, etc.)
7. **Tools**: Your team's toolchain

See `examples/config-repo/` in the framework repo for a complete filled example — config, page structure and entry files together.

## Step 4: Create Your Config Repo AGENTS.md

`AGENTS.md` is the cross-tool standard -- read automatically by Codex, Copilot, Devin,
opencode, Cursor and others. Create one in your config repo covering:

- **Directory structure requirement** -- this config repo must be a sibling of `confluence-framework/`
- **How to generate documentation** -- one line: read `../confluence-framework/docs/generation-procedure.md` and follow it. That file is the single source of truth for root resolution, source resolution, per-type analysis, template filling and output location
- **Where things live** -- `./project-config.md`, `./page-structure.md`, `../confluence-framework/docs/documentation-guide.md`, `../confluence-framework/templates/{type}.md`, `../confluence-framework/docs/compatibility.md`
- **Available document types** -- the eleven type keys
- **Output layout** -- `output/{source-repo-name}/{type}_{subject}_{YYYY-MM-DD}.md`, or `output/generic/` for links. Never write straight into `output/`
- **Key rules** -- naming pattern, mandatory labels, secrets policy, placeholder policy

`examples/config-repo/AGENTS.md` is a filled example you can copy and adapt.

**For Claude Code**, add a `CLAUDE.md` next to it whose first line is `@AGENTS.md`,
then put only Claude-specific notes below. That keeps one source of truth and works
with both conventions.

## Step 5: Create Your Page Structure

Create `page-structure.md` in your config repo with the actual Confluence page tree for your project. Use the pattern from `docs/space-structure.md` in the framework, adapted to your frentes.

## Step 6: Connect Your Code Repos

There are two modes. They are not exclusive -- pick per repo.

### Mode A: put an instruction file inside the code repo

Use this when the team owns the repo and wants to generate documentation from where they already work.

```bash
# Any assistant reading AGENTS.md (Codex, Copilot, Devin, opencode, Cursor, ...)
cp ../confluence-framework/examples/agents-md-example.md ./AGENTS.md

# Claude Code
cp ../confluence-framework/adapters/claude-code/repo-claude-md-example.md ./CLAUDE.md
```

Both templates take the same 6 variables:
- `{DESCRIPTION}`: Short repo description
- `{FRONT}`: Your frente name (e.g., `frontend`)
- `{PREFIX}`: Your naming prefix + suffix (e.g., `PROJ-FRONT`)
- `{FRAMEWORK_PATH}`: Relative path to `confluence-framework/`
- `{CONFIG_PATH}`: Relative path to your config repo's `project-config.md`
- `{SPACE_KEY}`: Confluence space key

### Mode B: aim at an external path from the config repo

Use this when you cannot or do not want to add files to the code repo, or when you want to document several repos from one place. Nothing is written into the target repo.

**1. Register the repos.** In your config repo's `project-config.md`, fill the `Code Repositories` table:

```markdown
| Front | Suffix | Local path | Description |
|-------|--------|-----------|-------------|
| Frontend | FRONT | /Users/you/work/my-web-app | React SPA |
| Backend | BACK | /Users/you/work/my-api | Express REST API |
```

Also fill the `Paths` section so the framework and the output destination are explicit:

```markdown
| Field | Value |
|-------|-------|
| Framework path | ../confluence-framework |
| Output path | ./output |
```

**2. Optionally, install a `/doc-confluence` shortcut.** Mode B works without it — your assistant reads `AGENTS.md` and follows the procedure from a plain-language request. Each shortcut is a thin command pointing at `docs/generation-procedure.md`; none duplicates the logic. Pick yours, running from your config repo:

```bash
# Claude Code -- ships in .claude/, scoped to the framework repo, so install globally
cp -r ../confluence-framework/adapters/claude-code/skills/doc-confluence ~/.claude/skills/
cp -r ../confluence-framework/adapters/claude-code/agents/confluence-doc ~/.claude/agents/

# OpenAI Codex
mkdir -p ~/.codex/prompts && cp ../confluence-framework/adapters/codex/doc-confluence.md ~/.codex/prompts/

# opencode
mkdir -p .opencode/commands && cp ../confluence-framework/adapters/opencode/doc-confluence.md .opencode/commands/

# GitHub Copilot
mkdir -p .github/prompts && cp ../confluence-framework/adapters/copilot/doc-confluence.prompt.md .github/prompts/
cp ../confluence-framework/adapters/copilot/copilot-instructions.md .github/copilot-instructions.md

# Devin -- see ../confluence-framework/adapters/devin/README.md
```

All of them are then invoked as `/doc-confluence <type> <subject> [source]`. The root resolution in Step 0 of the procedure is what lets them work from any directory once installed.

Full install matrix: `../confluence-framework/adapters/README.md`.

**3. Grant access to the target path.** Assistants only read inside their working directory by default, and each grants access differently -- the table in `compatibility.md` lists them all. For Claude Code:

```
/add-dir /Users/you/work/my-api
```

or permanently in `settings.json`:

```json
{ "permissions": { "additionalDirectories": ["/Users/you/work/my-api"] } }
```

Start the session from **your config repo**. Step 0 searches `.`, `..` and siblings, so it finds the framework from there whichever layout you chose, and the config repo's own `AGENTS.md` orients the assistant automatically.

> **Mode B is not available on every assistant.** It needs to read outside the repo it started in. Local CLI assistants can; Copilot needs the folder added to the workspace; Devin runs in a cloud VM and cannot at all. Check `compatibility.md` before relying on it.

**4. Generate.** From your config repo:

```
/doc-confluence api-spec Authentication Service
```

The AI resolves the target from the `Code Repositories` table using the frente you pick, reads that codebase, and writes the document to your configured `Output path`, inside a subfolder named after the source repo.

### Where documents land

Each document goes under a folder named after where its information came from, so pages from different repos never mix:

```
output/
+-- my-web-app/                                  <- basename of the target repo
|   +-- func-spec_contact-form_2026-09-06.md
+-- my-api/
|   +-- api-spec_authentication_2026-09-06.md
+-- generic/                                     <- source was a link, or user input only
    +-- api-spec_stripe-payments_2026-09-06.md
```

You can also point at a **link** instead of a path -- an OpenAPI URL, a public documentation page. The AI fetches it and files the result under `generic/`:

```
/doc-confluence api-spec Stripe Payments https://docs.stripe.com/api
```

To point at a repo that is not in the table, pass the path as a third argument -- it overrides the config:

```
/doc-confluence api-spec Payments Service /Users/you/work/payments-api
```

## Step 7: Verify

**Mode A**: open a connected code repo in Claude Code and ask for a test document.

**Mode B**: open your config repo in Claude Code and run:

```
/doc-confluence func-spec Sample Login Feature
```

The AI should:
- Print the resolved `CONFIG_ROOT` and `FRAMEWORK_ROOT` (both absolute, neither `NOT_FOUND`)
- Read your `project-config.md` for prefix, space key, and team
- Resolve the target repo path from the `Code Repositories` table and analyze that codebase
- Read the template from the framework
- Write the document to `{Output path}/{source-repo-name}/` with your project's naming convention and labels
- Report which source it analyzed and which folder it filed the document under

If it reports `NOT_FOUND` for either root, check that your config repo is a sibling of `confluence-framework/` or that the `Framework path` row is correct.

---

## Windows notes

The framework is plain markdown, so nothing is platform-specific by itself. Four things need attention.

### 1. Shell

The `/doc-confluence` skill runs a POSIX `sh` block to locate the framework and config repos. On Windows that block runs under **Git Bash** (bundled with Git for Windows, which Claude Code already requires) or under **WSL**. Both work unchanged — no PowerShell-only setup.

The block takes absolute paths with `pwd -W` where available, so on Git Bash the roots come back as `C:/Users/you/...` rather than the MSYS `/c/Users/you/...` form, which the file-reading tools cannot open. On WSL, paths are `/mnt/c/...` as usual.

### 2. Path format in `project-config.md`

Use **forward slashes** in the `Paths` and `Code Repositories` tables:

```markdown
| Front | Suffix | Local path | Description |
|-------|--------|-----------|-------------|
| Frontend | FRONT | C:/Users/you/work/my-web-app | React SPA |
```

`C:/Users/you/work/my-web-app` works on every platform. `C:\Users\you\work\my-web-app` does not survive a shell command, because `sh` reads a backslash as an escape character — `test -d` will not match it and the repo name will not slugify correctly. The skill converts backslashes when it sees them, but forward slashes avoid the round trip.

Under WSL, use the WSL path instead: `/mnt/c/Users/you/work/my-web-app`.

### 3. Line endings

The skill parses paths out of markdown tables. If the repos are checked out with `core.autocrlf=true`, every value carries a trailing carriage return and the resulting paths do not exist.

Both repos ship a `.gitattributes` pinning text files to `eol=lf`, which prevents this. If you cloned before that file existed, renormalize once:

```bash
git add --renormalize .
git status
```

The skill also strips `\r` defensively, so a stray CRLF file will not break it.

### 4. Installing the skill globally

The Mode B install step in Step 6 uses `cp`. In Git Bash it works as written. In PowerShell:

```powershell
Copy-Item -Recurse -Force ..\confluence-framework\.claude\skills\doc-confluence $env:USERPROFILE\.claude\skills\
Copy-Item -Recurse -Force ..\confluence-framework\.claude\agents\confluence-doc $env:USERPROFILE\.claude\agents\
```

`~/.claude/` and `%USERPROFILE%\.claude\` are the same directory.

### Granting access to an external repo

Identical on all platforms:

```
/add-dir C:/Users/you/work/my-api
```

or in `settings.json`, with forward slashes or escaped backslashes:

```json
{ "permissions": { "additionalDirectories": ["C:/Users/you/work/my-api"] } }
```

## Adapting Frentes

The framework defaults to 7 frentes. To use fewer or different ones:

1. Edit the **Frentes** table in your `project-config.md`
2. Update your `page-structure.md` to match
3. Adjust the `CLAUDE.md` in your code repos to use the correct suffix

The framework guides use `PROJ-FRONT`, `PROJ-BACK`, etc. as generic examples. Your config maps these to your actual structure.

## Adding Custom Document Types

To add a template not included in the framework:

1. Create the template in your config repo (not in the framework)
2. Reference it in your `CLAUDE.md`
3. If the template is useful for other projects, contribute it upstream to the framework

## Overrides

If a framework guideline does not apply to your project, document it in the **Overrides** section of your `project-config.md`. The AI reads this section and respects exceptions.
