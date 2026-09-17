# Reading Confluence While You Generate

Optional. The framework works without it, exactly as it does today.

If your assistant can reach your Confluence space, it can check things that are
otherwise guesswork: whether a title is already taken, where a page belongs in the real
tree, whether the page you are about to write already exists. This file explains how to
set that up, what it buys, and what it deliberately does not do.

> **Reading is what this is for.** Publishing is possible but lossy — macros and labels do
> not survive — so a published page carries a block saying what is missing. See
> [Publishing, and what it cannot carry](#publishing-and-what-it-cannot-carry).
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

## Guided setup

You can ask your assistant to do this rather than working through the section below:

> connect the Confluence MCP

What follows is the procedure it should run. It is written out because one step in it is a
refusal, and a refusal that is not written down gets optimised away by the next person
trying to be helpful.

**1. Ask which authentication.** OAuth or API token, with the trade-off from the table
below. If the user has no preference, recommend OAuth: nothing is stored, nothing can
leak, and it is always available whereas token authentication depends on their Atlassian
admin having enabled it.

**2a. OAuth — run it.** There is nothing to ask for; the endpoint is fixed and no
credential is involved. For Claude Code:

```bash
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp/authv2
```

Then tell the user to run `/mcp` and authorise in the browser, granting **read and search
scopes only**.

**2b. API token — do not ask for the token.** Print the two commands and have the user run
them. Never request the token, the email, or the encoded value in conversation, and if a
user offers one anyway, say why you are not taking it.

```sh
printf '%s' 'you@example.com:YOUR_TOKEN' | base64 | tr -d '\n'
```

```bash
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp \
  -H "Authorization: Basic <paste the output of the previous command>"
```

The reason is not squeamishness. A token pasted into a conversation is in the transcript,
and a transcript is a file that gets kept, synced and occasionally shared. Revoking is then
the only repair. Asking costs the user one extra command; not asking costs them a
credential rotation when they notice — and most do not notice.

**3. Say that a restart is needed.** `claude mcp add` writes to the client's
configuration, but the running session does not pick up a server added mid-conversation.
The tools appear after a restart. *(Expected behaviour, not verified here.)*

**4. Verify after the restart.** Run the [smoke test](#smoke-test). If it fails with an
authentication error on the token route, the likely cause is that the user's Atlassian
admin has not enabled API token authentication — suggest OAuth rather than debugging the
header.

---

## Setup

**1. Connect the server.** Atlassian publishes an official remote MCP server at
`mcp.atlassian.com`. Configuration differs per assistant; see
[`compatibility.md`](compatibility.md).

**2. Choose how it authenticates.** Both work; they suit different situations.

| | OAuth 2.1 | API token |
|---|-----------|-----------|
| **Endpoint** | `https://mcp.atlassian.com/v1/mcp/authv2` | `https://mcp.atlassian.com/v1/mcp` |
| How it feels | A browser opens, you approve once | A header in the client config, no prompt |
| Always available? | Yes | **Only if your Atlassian admin has enabled it** |
| Suited to | A person generating documents interactively | Non-interactive use — CI, bots, automation |
| Revoking | Withdraw the consent | Delete the token |

**The endpoints differ**, and that is the detail that wastes an afternoon: point a token
configuration at the OAuth URL and it will not connect, with nothing in the error to
suggest why. Atlassian accepts `Basic base64(email:api_token)` for a personal token, or
`Bearer <key>` for a service account key.

On a company instance the admin may have API token authentication turned off, in which
case OAuth is the only route and the client will tell you so. On an instance you own, you
decide.

For the interactive case this framework is built around — you, asking for a document —
OAuth is the better fit: nothing to store, nothing to leak, and it expires. A token is
worth it when something has to run without a person present: a pipeline regenerating
documentation on release cannot wait for a browser consent screen.

If you do go the token route, build the encoded value in your own terminal and paste it
nowhere:

```sh
printf '%s' 'you@example.com:YOUR_TOKEN' | base64 | tr -d '\n'
```

The `tr -d '\n'` is not decoration. GNU's `base64` wraps its output at 76 characters, so
on Git Bash and Linux the value arrives split across several lines; pasted into a header
that way it simply does not work, and nothing in the failure says why. On macOS the pipe
is a no-op. PowerShell has its own form — see `customization-guide.md` -> Windows notes.

What comes out is your email and token, trivially decoded. Treat it as the credential it
is — which is what the next section is about.

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
[`generation-procedure.md`](generation-procedure.md). What a published page loses, and how
it says so, is in [Publishing, and what it cannot carry](#publishing-and-what-it-cannot-carry).

## When it is not available

Every step that uses this is optional, and the procedure says so. If the tools are absent,
unauthorised, or the call fails, **continue generating** — do not stop, and do not invent
what the lookup would have returned.

Say once, in the delivery summary, that the check did not run and what that means: the
title has not been verified as free, and the parent page is the one `page-structure.md`
predicts rather than one that was confirmed. A reader who knows the check was skipped can
decide whether to care. A reader told nothing will assume it passed.

## Publishing, and what it cannot carry

Writing is possible, and it is lossy. Which is why the framework marks what it lost rather
than pretending otherwise.

`createConfluencePage` takes markdown or ADF, not Confluence storage format, so macros are
dropped. And the server exposes no label management at all — there is an open feature
request for it. So a published page arrives with:

| | |
|---|---|
| The body | intact |
| Page Properties macro | a plain table — the Page Properties Report stops seeing it |
| draw.io, Jira macros | gone |
| **Labels** | **none** |

Labels are what every query in the standards searches on. Without them the page is
readable and **unfindable** — and nothing about it looks wrong. That silence is the real
danger: not that the page is incomplete, but that nobody can tell.

### So the page says what is missing

Every page published this way carries a block at the top with the token
`MCP-DRAFT-PENDING-COMPLETION`, the exact labels somebody must apply, the macros to
insert, and — if it supersedes an earlier page — which one and that the earlier one stays
authoritative until they are merged. A one-line mark sits wherever each macro belongs.

Find them all with:

```sql
space = "{SPACE_KEY}" AND text ~ "MCP-DRAFT-PENDING-COMPLETION"
```

The token is a fixed literal. Do not reword it; the query matches on it.

### The state cycle, which the framework already had

`ai-strategy.md` defines `ai:auto-generated` for AI-drafted content and `ai:reviewed` for
content a human has validated. The token is a stand-in for the first, used only because
labels cannot be set through this route. It retires when they can.

| Page state | What it means | What may be done |
|------------|---------------|------------------|
| Token present | Published, nobody has completed it | Updating it is safe |
| Token gone | Somebody applied the labels and macros and deleted the block | **Do not update it** |

Completing a page is manual, and deliberately so: deleting the block **is** the act that
changes the state. Nothing infers it, so what a reader sees is the real state.

### Updating: read before you write

If the token is still there, update freely and reproduce the block.

If it is gone, **refuse**. An update replaces the body with markdown and would destroy the
macros and labels somebody added, leaving page history as the only recovery — if anyone
thinks to look. Offer instead: edit it in Confluence, where macros survive, or publish a
new page with the version appended to the subject — `… — {Subject} (v2)`.

A refusal rather than a confirmation is deliberate. Routine confirmations get accepted
without reading, and what is at stake here is somebody else's work.

The full rule is in [`generation-procedure.md`](generation-procedure.md).

### The alternative, if this is not enough

The REST API accepts storage format and has a label endpoint, so it can produce a complete
page with no manual step. The price is that you handle the credential yourself, without
the MCP's authorisation layer. It is a different design from the one documented here, not
an extension of it.
