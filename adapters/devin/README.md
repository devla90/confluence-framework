# Devin

Devin reads `AGENTS.md` from the repository root before it starts working.

## Setup

**1. Put an `AGENTS.md` in the repo Devin will work on.** Copy the template and fill
in its six variables:

```bash
cp ../../examples/agents-md-example.md /path/to/your/repo/AGENTS.md
```

Variables: `{DESCRIPTION}`, `{FRONT}`, `{PREFIX}`, `{FRAMEWORK_PATH}`, `{CONFIG_PATH}`,
`{SPACE_KEY}`.

**2. Add the standards to Devin's Knowledge.** Devin cannot reach the framework repo
unless it is part of the workspace it clones. Either:

- Vendor the framework as a git submodule or subtree in the repo, so
  `{FRAMEWORK_PATH}` resolves inside Devin's VM, or
- Paste the contents of `docs/generation-procedure.md` and
  `docs/documentation-guide.md` into a Knowledge entry scoped to that repo.

The first option is better — it keeps a single source of truth and updates with a
pull.

**3. Optionally add a Skill** so the flow is invocable by name, pointing at
`docs/generation-procedure.md` rather than restating it.

## Mode B does not work on Devin

Devin runs in a cloud VM built from a Git repository. It has **no path to your local
disk**, so it cannot read a repo at `/Users/you/work/my-api` or `C:/Users/you/...`.
No adapter can change this — it is architectural.

Use one of these instead:

| Instead of Mode B | Do this |
|-------------------|---------|
| Document a repo Devin already has | **Mode A** — put `AGENTS.md` in that repo. The source is the working directory |
| Document something with a public spec | Pass the **URL** as the source. Devin can fetch it, and the result is filed under `output/generic/` |
| Document several repos at once | Run Devin once per repo in Mode A, or use a local assistant (Claude Code, Codex, opencode) for Mode B |

See `docs/compatibility.md` for the full matrix.

## Reading Confluence

Devin has no local MCP configuration, so the optional Confluence lookups described in
`docs/confluence-mcp.md` do not apply. Everything else in the procedure works unchanged;
titles simply go unverified until you paste the page.

## What still applies

Everything in `docs/generation-procedure.md` except Step 2's external-path branch:
type validation, per-type source analysis, template filling, the
`{Output path}/{source}/` layout, the secrets rule and the invention rule.
