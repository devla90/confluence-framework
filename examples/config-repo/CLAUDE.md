@AGENTS.md

<!-- EXAMPLE FILE — part of the example config repo. Not a live config. -->

# Claude Code specifics

Everything about this project is in `AGENTS.md`, imported on the first line above. This
file holds only what is specific to Claude Code — which is why it is this short.

## Generating a document

```
/doc-confluence <type> <subject> [target-path-or-url]
```

The third argument overrides the `Code Repositories` table for one run and accepts a URL
as well as a path:

```
/doc-confluence api-spec Payments ../acme-api
/doc-confluence api-spec Stripe https://docs.stripe.com/api
```

## Installing the skill

```bash
cp -r ../confluence-framework/.claude/skills/doc-confluence ~/.claude/skills/
cp -r ../confluence-framework/.claude/agents/confluence-doc ~/.claude/agents/
```

## Reading an external repo

Mode B needs access to a folder outside this repo: `/add-dir ../acme-api`, or
`permissions.additionalDirectories` in `settings.json`.
