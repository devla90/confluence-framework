# Devin

Devin comes in two forms, and they differ in the one thing that matters here — whether
it can see your disk:

| | Runs | Reads your local repos | Mode B | Adapter |
|---|------|------------------------|--------|---------|
| **Devin Local** (Devin Desktop, formerly Windsurf) and **Devin CLI** | On your machine | Yes, within the workspace and the paths you grant | yes | `skills/doc-confluence/SKILL.md` |
| **Devin cloud** | In a VM built from a Git repository | No | **no** | Knowledge entry or a repo skill — see below |

Both read `AGENTS.md`, so a plain-language request works with nothing installed.

```
devin/
└── skills/doc-confluence/SKILL.md   <- the /doc-confluence skill, Devin Local and CLI
```

## Devin Local and Devin CLI

### Install (optional)

From your config repo:

```bash
../confluence-framework/scripts/install-adapter.sh devin
```

That copies the skill to `~/.config/devin/skills/doc-confluence/` — or
`%APPDATA%\devin\skills\doc-confluence\` on Windows — so it works from any project. Then:

```
/doc-confluence <type> <subject> [source-path-or-url]
```

Arguments arrive as `$ARGUMENTS`, so the skill parses type, subject and source from one
string. Unlike the Claude Code skill there is no preload: Devin runs Step 0 of the
procedure itself, which costs one extra command and changes nothing else.

**Only one skill is active at a time** in Devin. Invoking another replaces this one, so
finish the document before switching.

### Mode B

The agent reads and edits inside the workspace by default. To document a repo outside
it, grant that path in Devin's permissions, or start Devin from a directory that
contains both the config repo and the code repo — the same rule that works for every
local assistant.

### Reading Confluence

Devin Local speaks MCP. Configure Atlassian's server in `~/.config/devin/config.json`
(user) or `.devin/config.local.json` (gitignored) — **not** the committed
`.devin/config.json` if the entry carries a token. OAuth needs no secret at all.
Everything else is in `docs/confluence-mcp.md`, including the guided setup.

## Devin cloud

### Setup

**1. Put an `AGENTS.md` in the repo Devin will work on.** Copy the template and fill
in its six variables:

```bash
cp ../../examples/agents-md-example.md /path/to/your/repo/AGENTS.md
```

Variables: `{DESCRIPTION}`, `{FRONT}`, `{PREFIX}`, `{FRAMEWORK_PATH}`, `{CONFIG_PATH}`,
`{SPACE_KEY}`.

**2. Give Devin the framework.** It cannot reach the framework repo unless it is part
of the workspace it clones. Either:

- Vendor the framework as a git submodule or subtree in the repo, so
  `{FRAMEWORK_PATH}` resolves inside Devin's VM, or
- Paste the contents of `docs/generation-procedure.md` and
  `docs/documentation-guide.md` into a Knowledge entry scoped to that repo.

The first option is better — it keeps a single source of truth and updates with a
pull.

**3. Optionally commit the skill** to `.agents/skills/doc-confluence/SKILL.md` in that
repo — Devin scans it on every session. Invoke it with `@skills:doc-confluence`.

### Mode B does not work on Devin cloud

The VM has **no path to your local disk**, so it cannot read a repo at
`/Users/you/work/my-api` or `C:/Users/you/...`. No adapter can change this — it is
architectural. Use Devin Local for that, or one of these:

| Instead of Mode B | Do this |
|-------------------|---------|
| Document a repo Devin already has | **Mode A** — put `AGENTS.md` in that repo. The source is the working directory |
| Document something with a public spec | Pass the **URL** as the source. Devin can fetch it, and the result is filed under `output/generic/` |
| Document several repos at once | Run Devin once per repo in Mode A, or use a local assistant for Mode B |

### Reading Confluence

The cloud VM has no local MCP configuration, so the optional Confluence lookups in
`docs/confluence-mcp.md` do not apply. Titles go unverified until you paste the page.

## What still applies

Everything in `docs/generation-procedure.md`. On Devin cloud, everything except Step 2's
external-path branch.

See `docs/compatibility.md` for the full matrix.
