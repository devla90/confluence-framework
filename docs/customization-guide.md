# Customization Guide

How to adapt this framework for a new project.

---

## Prerequisites

- Access to a Confluence Cloud space for your project
- This framework repository cloned locally
- An AI coding assistant (Claude Code, Copilot, Devin, or similar)

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

## Step 3: Fill In Your Configuration

Edit `project-config.md` and replace all `{placeholder}` values:

1. **Identity**: Project name, organization, naming prefix, Confluence space key, URL
2. **Paths**: `Framework path` (relative path to `confluence-framework/`) and `Output path` (where generated docs are written)
3. **Frentes**: Your team structure. You can use the 7 defaults (Frontend, Backend, UI/UX, Business, Architecture, Security, QA) or define your own
4. **Code repositories**: The local path of the repo implementing each frente. Required for Mode B (Step 6). Leave empty for frentes with no code
5. **Technology labels**: The `tech:` labels specific to your stack
6. **Secrets platform**: Where your team stores secrets (AWS Secrets Manager, Azure Key Vault, etc.)
7. **Tools**: Your team's toolchain

See `examples/project-config-example.md` in the framework repo for a filled example.

## Step 4: Create Your Config Repo CLAUDE.md

Create a `CLAUDE.md` in your config repo:

```markdown
# Project: {Your Project Name}

## Confluence Documentation

- **Framework**: ../confluence-framework/
- **Config**: ./project-config.md
- **Page structure**: ./page-structure.md

### To generate documentation

1. Read config: `./project-config.md` -- prefix, space key, frentes, `Paths`, `Code Repositories`
2. Read standards: `../confluence-framework/docs/documentation-guide.md`
3. Read template: `../confluence-framework/templates/{type}.md`
4. Resolve the source: the path or URL given in the request, else the `Code Repositories`
   row matching the frente. Analyze that codebase (or fetch that link) for technical details
5. Generate in `{Output path}/{source}/` (default base `./output/`), where `{source}` is the
   repo name or `generic` for links, following the template

### Available document types

func-spec | adr | api-spec | env-config | runbook | security-doc | migration | test-plan | test-strategy | infra-request | role-request
```

## Step 5: Create Your Page Structure

Create `page-structure.md` in your config repo with the actual Confluence page tree for your project. Use the pattern from `docs/space-structure.md` in the framework, adapted to your frentes.

## Step 6: Connect Your Code Repos

There are two modes. They are not exclusive -- pick per repo.

### Mode A: put a CLAUDE.md inside the code repo

Use this when the team owns the repo and wants to generate documentation from where they already work.

```bash
cp ../confluence-framework/examples/repo-claude-md-example.md ./CLAUDE.md
```

Fill in the 6 variables:
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

**2. Install the skill and agent at user level.** The skill ships inside `confluence-framework/.claude/skills/`, which scopes it to that directory -- it will not activate from your config repo until you install it globally:

```bash
cp -r ../confluence-framework/.claude/skills/doc-confluence ~/.claude/skills/
cp -r ../confluence-framework/.claude/agents/confluence-doc ~/.claude/agents/
```

The skill resolves the framework and config roots itself at runtime, so it works from any directory once installed.

**3. Grant access to the target path.** Claude Code only reads inside its working directory by default. Either run this in the session:

```
/add-dir /Users/you/work/my-api
```

or add the path permanently to `settings.json`:

```json
{ "permissions": { "additionalDirectories": ["/Users/you/work/my-api"] } }
```

Without this you will get a permission prompt on every file read.

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
