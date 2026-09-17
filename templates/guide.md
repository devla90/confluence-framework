# [{PREFIX}-{FRONT}] {Guide Title}

> **Default labels**: `type:guide`, `status:draft`, `team:{team}`
>
> **Ask the user for**: What the guide covers, who it is for, whether it describes a procedure to follow or standards to comply with
> **Look for in the source**: Existing scripts and tooling config that already encode the rules (linter, formatter, CI, git hooks), README sections covering the same ground, and any conventions visible in the code itself

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @owner |
| **Audience** | {who this is written for} |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |

---

## 1. What This Covers

One paragraph: what the reader will be able to do or comply with after reading, and
what is deliberately out of scope. If someone is in the wrong place, they should find out
here rather than three sections down.

**Who this is for**: {role or team}

**Assumed knowledge**: {what the reader is expected to already know}

## 2. Before You Start

Only for guides that describe a procedure. Delete this section for standards and
principles.

| Requirement | How to get it |
|-------------|---------------|
| {access, tool, permission} | {where to request it, how to install it} |

## 3. {The Body}

Pick the shape that fits and delete the other.

### If this is a procedure

Numbered steps, each one an action the reader takes. Show the command or the click, not a
description of it. Say what a successful step looks like, so the reader can tell whether
it worked before moving on.

1. **{Step}** — {what to do}
   ```
   {command}
   ```
   {what you should see}

2. **{Step}** — {what to do}

### If these are standards or principles

One rule per row. State the rule, why it exists, and how compliance is checked. A rule
nobody enforces will be broken within a quarter, so be honest about which are enforced by
tooling and which rely on review.

| Rule | Why | Enforced by |
|------|-----|-------------|
| {rule} | {reason} | {linter / CI / code review / nothing yet} |

Where a rule is already encoded in tooling — a linter rule, a CI check, a git hook — link
the configuration instead of restating it. The config is the source of truth; this page
explains the intent.

## 4. Common Problems

The failures people actually hit, not the ones that are theoretically possible.

| Symptom | Cause | Fix |
|---------|-------|-----|
| {what the reader sees} | {why it happens} | {what to do} |

## 5. Exceptions

When the rules in this page do not apply, and who decides. A guide with no stated
exceptions invites people to invent their own silently.

| Situation | What applies instead | Who approves |
|-----------|---------------------|--------------|
| {} | {} | {} |

## 6. Related

| Page | Why you might need it |
|------|----------------------|
| {link} | {} |

**Questions about this guide**: {person or channel}

## 7. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
