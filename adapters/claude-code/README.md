# Claude Code

> **Where the files are.** Unlike the other adapters, Claude Code's live in
> [`../../.claude/`](../../.claude/) rather than here. That directory is not storage —
> Claude Code reads `.claude/skills/` and `.claude/agents/` automatically, so the skill
> is live while you work on the framework itself. Moving it under `adapters/` would turn
> it into an inert file that has to be installed before it does anything.
>
> - Skill: `.claude/skills/doc-confluence/SKILL.md`
> - Agent: `.claude/agents/confluence-doc/confluence-doc.md`

## Install (optional)

Like every adapter, this only adds the `/doc-confluence` shortcut. Claude Code reads
`CLAUDE.md`, which imports `AGENTS.md`, so it follows the procedure from a plain-language
request with nothing installed.

Run from your config repo:

```bash
cp -r ../confluence-framework/.claude/skills/doc-confluence ~/.claude/skills/
cp -r ../confluence-framework/.claude/agents/confluence-doc ~/.claude/agents/
```

Installs into your home directory, so it works from any project.

```
/doc-confluence <type> <subject> [source-path-or-url]
```

## Why CLAUDE.md exists at all

Claude Code does not yet read `AGENTS.md` natively, so a `CLAUDE.md` whose first line is
`@AGENTS.md` bridges the two conventions. That is the entire reason the file exists —
it is a compatibility shim, not a privileged position for this assistant. Anything
genuinely Claude-specific belongs in this directory instead.

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
