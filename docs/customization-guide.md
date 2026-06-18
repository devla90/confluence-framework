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
2. **Frentes**: Your team structure. You can use the 7 defaults (Frontend, Backend, UI/UX, Business, Architecture, Security, QA) or define your own
3. **Technology labels**: The `tech:` labels specific to your stack
4. **Secrets platform**: Where your team stores secrets (AWS Secrets Manager, Azure Key Vault, etc.)
5. **Tools**: Your team's toolchain

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

1. Read config: `./project-config.md`
2. Read standards: `../confluence-framework/docs/documentation-guide.md`
3. Read template: `../confluence-framework/templates/{type}.md`
4. Generate in `output/` following the template

### Available document types

func-spec | adr | api-spec | env-config | runbook | security-doc | migration | test-plan | test-strategy | infra-request | role-request
```

## Step 5: Create Your Page Structure

Create `page-structure.md` in your config repo with the actual Confluence page tree for your project. Use the pattern from `docs/space-structure.md` in the framework, adapted to your frentes.

## Step 6: Connect Your Code Repos

For each code repository, copy the CLAUDE.md example:

```bash
cp ../confluence-framework/examples/repo-claude-md-example.md ./CLAUDE.md
```

Fill in the 5 variables:
- `{FRONT}`: Your frente name (e.g., `frontend`)
- `{PREFIX}`: Your naming prefix + suffix (e.g., `PROJ-FRONT`)
- `{FRAMEWORK_PATH}`: Relative path to `confluence-framework/`
- `{CONFIG_PATH}`: Relative path to your config repo
- `{DESCRIPTION}`: Short project description

## Step 7: Verify

Open your config repo in Claude Code and ask it to generate a test document:

```
Generate a func-spec for a sample login feature
```

The AI should:
- Read your `project-config.md` for prefix, space key, and team
- Read the template from the framework
- Generate a document with your project's naming convention and labels

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
