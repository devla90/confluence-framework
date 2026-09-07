@AGENTS.md

# Claude Code specifics

Everything about this framework -- what it is, the conventions, the two working modes,
which file to read per task -- is in `AGENTS.md`, imported above. This file only holds
what is specific to Claude Code.

## Generating a document

Use the `/doc-confluence` skill, or the `confluence-doc` agent. Both are thin adapters:
they run Step 0 of `docs/generation-procedure.md` and then follow it. The procedure is
the single source of truth -- do not restate or improvise around it.

```
/doc-confluence <type> <subject> [target-path-or-url]
```

## Installing them outside this directory

The skill and agent live in `.claude/`, which scopes them to this repo. To use them
from a config repo, install at user level:

```bash
cp -r .claude/skills/doc-confluence ~/.claude/skills/
cp -r .claude/agents/confluence-doc ~/.claude/agents/
```

On Windows these run in Git Bash. PowerShell equivalents and path-format rules are in
`docs/customization-guide.md` -> Windows notes.

The root resolution in Step 0 is what lets them work from any directory once installed.

## Capability mapping

The procedure is tool-neutral. In Claude Code:

| Procedure says | Use |
|----------------|-----|
| "list files matching a pattern" | `Glob` |
| "search file contents" | `Grep` |
| "read a file" | `Read` |
| "fetch a URL" | `WebFetch` |
| "write a file" | `Write` |
| "run a shell command" | `Bash` |
| "grant the assistant access to that folder" | `/add-dir <path>`, or `permissions.additionalDirectories` in `settings.json` |

## Other assistants

This framework also runs on Codex, Copilot, opencode, Devin, Cursor and anything else
that reads `AGENTS.md`. Ready-made adapters are in `adapters/`; the capability matrix
-- including which assistants can and cannot do Mode B -- is in `docs/compatibility.md`.
