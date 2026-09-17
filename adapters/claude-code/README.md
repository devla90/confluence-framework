# Claude Code

Everything specific to Claude Code lives here, at the same level as every other
assistant. Nothing about this framework sits at the repository root for one tool's
benefit.

```
claude-code/
├── skills/doc-confluence/SKILL.md          <- the /doc-confluence command
├── agents/confluence-doc/confluence-doc.md <- the subagent variant
└── repo-claude-md-example.md               <- CLAUDE.md template for a code repo (Mode A)
```

## Install (optional)

Like every adapter, this only adds the `/doc-confluence` shortcut. Claude Code reads
`CLAUDE.md`, which imports `AGENTS.md`, so it follows the procedure from a
plain-language request with nothing installed.

Run from your config repo. The paths mirror their destinations, so a plain `cp -r` is
enough:

```bash
cp -r ../confluence-framework/adapters/claude-code/skills/doc-confluence ~/.claude/skills/
cp -r ../confluence-framework/adapters/claude-code/agents/confluence-doc ~/.claude/agents/
```

Installs into your home directory, so it works from any project.

```
/doc-confluence <type> <subject> [source-path-or-url]
```

> These files are not read from where they sit. Claude Code only discovers skills and
> agents under `.claude/`, so they do nothing until copied. That is deliberate: the
> framework repo is a library, not a working directory, and the skill would only ever
> have fired in the one place you do not generate documents.

## Why a CLAUDE.md exists at the repo root

Claude Code does not read `AGENTS.md` natively — the most requested open issue on its
tracker. Every other supported assistant picks `AGENTS.md` up on its own, so without a
`CLAUDE.md` importing it, a Claude Code user would get nothing where the others get
everything.

Those nine lines level Claude Code up to the others rather than privileging it. That is
the whole reason the file exists, and it says so in its own comment.

## What is Claude-specific

The generation procedure is tool-neutral by design. These are the only translations it
cannot make:

| Procedure says | Claude Code |
|----------------|-------------|
| "list files matching a pattern" | `Glob` |
| "search file contents" | `Grep` |
| "read a file" | `Read` |
| "fetch a URL" | `WebFetch` |
| "write a file" | `Write` |
| "run a shell command" | `Bash` |
| "grant access to that folder" | `/add-dir <path>`, or `permissions.additionalDirectories` in `settings.json` |

Scope `Glob` and `Grep` to the resolved source path rather than sweeping the filesystem.

Both working modes are supported: Mode A inside the code repo, Mode B from the config
repo pointing at an external path or URL. See
[`../../docs/compatibility.md`](../../docs/compatibility.md).

## Mode A: a CLAUDE.md for a code repo

`repo-claude-md-example.md` is the Claude Code variant of
[`../../examples/agents-md-example.md`](../../examples/agents-md-example.md). Copy it into
a code repo as `CLAUDE.md` and fill in its six variables. If that repo will be worked on
with more than one assistant, use the neutral `AGENTS.md` version instead — Claude Code
reads it through a one-line `CLAUDE.md` shim.
