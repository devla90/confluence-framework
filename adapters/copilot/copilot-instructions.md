# Confluence documentation

This project documents to Confluence Cloud using a shared framework.

When asked to create, generate or update Confluence documentation — a functional
spec, ADR, API spec, environment config, runbook, security document, migration, test
plan, test strategy, infrastructure request or deployment role request — find
`docs/generation-procedure.md` in the `confluence-framework` directory and follow it.

That file is the single source of truth: root resolution, source resolution, per-type
source analysis, template filling, and where the output goes. Do not improvise an
alternative flow.

Project-specific values — naming prefix, Confluence space key, frentes, technology
labels, secrets platform, repo paths and output path — come from `project-config.md`
in the project's config repo. Never hardcode them.

## Rules that apply to every generated document

- Title: `[{PREFIX}-{SUFFIX}] Type -- Subject`, prefix and suffix from `project-config.md`
- Mandatory labels: `team:`, `type:`, `status:`
- Include the full Page Properties table
- Write in the language configured in `project-config.md`
- **Never** include credentials, API keys or tokens. Reference the path in the
  project's secrets manager instead
- Diagrams: indicate where to insert a draw.io macro, never a static image
- Mark anything you could not extract with `{placeholder}` — never invent business
  rules, technical specs or requirements

## Reading a repo outside this workspace

Copilot is scoped to the open workspace. To document a repo that is not in it, use
**File > Add Folder to Workspace** first. If it is not reachable, say so rather than
guessing at the contents.
