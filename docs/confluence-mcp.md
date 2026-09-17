# Reading Confluence While You Generate

Optional. The framework works without it, exactly as it does today.

If your assistant can reach your Confluence space, it can check things that are
otherwise guesswork: whether a title is already taken, where a page belongs in the real
tree, whether the page you are about to write already exists. This file explains how to
set that up, what it buys, and what it deliberately does not do.

> **Read-only by design.** Publishing pages is not part of this. See
> [Why writing is not included](#why-writing-is-not-included) at the end — the reason is
> specific to this framework and worth understanding before you go looking for it.
>
> **Off unless you ask.** Connecting the server does not make the lookups happen. They run
> only when you request them, or when the project opts in — see
> [When the lookups run](#when-the-lookups-run).
>
> **One rule that does not bend:** no credential ever enters this repository — see
> [Keeping the credential out of the repository](#keeping-the-credential-out-of-the-repository).
> Publishing asks for confirmation by default, and that one *is* configurable — see
> [Publishing asks first](#publishing-asks-first-unless-you-say-otherwise).

---

## What it buys

| Without it | With it |
|------------|---------|
| You discover a title collision when you paste the page into Confluence and it is rejected | The assistant tells you before writing the document |
| The parent page is deduced from `page-structure.md`, which may have drifted from reality | It reads the actual tree |
| A second run creates a second document for a page that already exists | It notices and tells you |
| Related pages — the ADRs an architecture document should link — are whatever you remember | It can look them up |

The first row is the one that matters. The naming rule in
[`documentation-guide.md`](documentation-guide.md) exists because Confluence rejects
duplicate titles within a space; this turns that rule from something you comply with
blindly into something that gets checked.

## When the lookups run

Having the capability is not permission to use it. Your Confluence space is usually shared
with a team, and an assistant that reaches into it on every generation is doing something
you did not ask for. So the default is **off**, even with the server connected.

They run in exactly two situations:

**You ask, in that request.**

```
/doc-confluence api-spec Payments Service — and check the title in Confluence first
```

Anything that plainly means it works: "verify against the space", "look it up in
Confluence", "check the title exists". No flag to memorise.

**Or the project opts in.** Set `Check Confluence before generating` to `yes` in
`project-config.md`. That row is a standing instruction from whoever owns the project and
is `no` by default. Use it when a team wants every generation checked without saying so
each time.

Any other case: the assistant does not contact Confluence, and says so in its delivery
summary rather than leaving you to assume the title was verified.

## Setup

**1. Connect the server.** Atlassian publishes an official remote MCP server at
`mcp.atlassian.com`. Configuration differs per assistant; see
[`compatibility.md`](compatibility.md).

**2. Choose how it authenticates.** Both work; they suit different situations.

| | OAuth 2.1 | API token |
|---|-----------|-----------|
| How it feels | A browser opens, you approve once | A token in the client config, no prompt |
| Always available? | Yes | **Only if your Atlassian admin has enabled it** |
| Suited to | A person generating documents interactively | Non-interactive use — CI, bots, automation |
| Revoking | Withdraw the consent | Delete the token |

On a company instance the admin may have API token authentication turned off, in which
case OAuth is the only route and the client will tell you so. On an instance you own, you
decide.

For the interactive case this framework is built around — you, asking for a document —
OAuth is the better fit: nothing to store, nothing to leak, and it expires. A token is
worth it when something has to run without a person present.

See [Keeping the credential out of the repository](#keeping-the-credential-out-of-the-repository)
below before choosing the token route.

**3. Grant read and search scopes only.** The server groups its tools into read, write and
search. Leaving write unauthorised is not merely cautious: it makes it *impossible* for an
assistant to publish or modify a page by accident, which matters when the space is shared
with a team.

**4. Nothing else.** The `Confluence space key` already in your `project-config.md` is
what the queries need. There is no new configuration to fill in.

### Smoke test

Ask your assistant, in plain language:

> list the Confluence spaces I have access to

You should get your spaces back, by key and name. If you do, this is working. If it
answers from memory, or says it has no such tool, the server is not connected — check the
configuration before going further.

## Capability mapping

The generation procedure describes capabilities, never tool names, so that a different
Confluence MCP server can be swapped in by changing this table alone.

| The procedure says | Atlassian's official server |
|--------------------|----------------------------|
| "identify the Confluence site" | `getAccessibleAtlassianResources` — returns the `cloudId` every other call needs |
| "check whether a page with this title exists" | `searchConfluenceUsingCql` with `title = "..." AND space = "..."` |
| "read the space's page tree" | `getPagesInConfluenceSpace`, `getConfluencePageDescendants` |
| "read an existing page" | `getConfluencePage` |
| "list the spaces I can reach" | `getConfluenceSpaces` |

Third-party Confluence MCP servers expose different names. If you use one, change this
table; the procedure does not need touching.

## Keeping the credential out of the repository

**A token never goes into this repository.** Not in `project-config.md`, not in an MCP
client configuration committed alongside it, not in a comment, not temporarily.

Git does not forget. A token committed and then removed is still in the history, still in
every clone anyone made, still on the remote. Revoking it is the only real repair, and
that depends on somebody noticing.

Where it does go:

| Assistant | MCP configuration | In the repo? |
|-----------|-------------------|--------------|
| Claude Code | `.mcp.json`, or user-level config | `.mcp.json` **is** — and is gitignored for this reason |
| GitHub Copilot | `.vscode/mcp.json` | **is** — gitignored |
| opencode | `opencode.json` | **is** — gitignored |
| OpenAI Codex | `~/.codex/config.toml` | no, it lives in your home directory |

Both repositories ignore those three files by default. If you have a configuration that
genuinely contains no secret — OAuth, for instance — you can force-add it, but check twice
first.

The surest answer is to use OAuth, where there is no long-lived secret to misplace.

## Publishing asks first, unless you say otherwise

Writing is not part of this phase, so in normal use the question does not arise. It is
here because scopes can be granted later, by you or by someone else on the team.

The default is to confirm before every create and every update: title, space, parent, and
whether the call creates a page or overwrites one. `project-config.md` can change that:

| `Confirm before publishing` | Behaviour |
|-----------------------------|-----------|
| `yes` *(default, and what applies when the row is absent)* | Asks every time |
| `updates-only` | Creates without asking, always confirms an overwrite |
| `no` | Never asks |

`updates-only` exists because the two are not the same risk. A wrongly created page leaves
something to delete. A wrongly overwritten page replaces work somebody else did, and the
previous version survives only in page history, if anyone thinks to look.

Whatever the setting, every page created or updated is **reported in the delivery
summary** with its title and whether it was new or an overwrite. Turning off the question
turns off the question, not the record.

The full rule, including what to state when confirming, is in
[`generation-procedure.md`](generation-procedure.md).

## When it is not available

Every step that uses this is optional, and the procedure says so. If the tools are absent,
unauthorised, or the call fails, **continue generating** — do not stop, and do not invent
what the lookup would have returned.

Say once, in the delivery summary, that the check did not run and what that means: the
title has not been verified as free, and the parent page is the one `page-structure.md`
predicts rather than one that was confirmed. A reader who knows the check was skipped can
decide whether to care. A reader told nothing will assume it passed.

## Why writing is not included

Atlassian's `createConfluencePage` accepts markdown or ADF, not Confluence storage format.
Macros — `ac:structured-macro` — are dropped in the conversion.

That is fatal for this framework specifically, because it does not use macros decoratively:

- **Page Properties** is required on every page by
  [`documentation-guide.md`](documentation-guide.md) section 4, and all sixteen templates
  carry it. It is what the **Page Properties Report** macro aggregates into the live
  dashboards on index pages, and what several of the CQL queries in section 6 rely on.
- **draw.io** is mandated for diagrams — the standard forbids static images.
- **Jira Issues** links epics without duplicating them, which is what `decision-guide.md`
  requires.

Publish through MCP and the body arrives intact while the Page Properties table becomes a
plain table. It looks almost identical. The report macro no longer sees it, the index
dashboards quietly return nothing, and nobody notices for months — a silent failure, which
is worse than an obvious one.

Until storage format is supported, publishing is a manual paste, or a direct REST API call
that bypasses the MCP's authorisation layer. Neither belongs in this procedure yet.
