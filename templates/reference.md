# [{PREFIX}-{SUFFIX}] {Reference Title}

> **Default labels**: `type:reference`, `status:draft`, `team:{team}`
>
> **Ask the user for**: What this lists, who consults it, and where the authoritative version lives if it is not this page
> **Look for in the source**: The definitive list wherever it already exists — enum or constant definitions, error code maps, IaC resource declarations, schema files, dependency manifests, route tables. Prefer generating rows from these over transcribing them by hand

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @owner |
| **Source of truth** | {this page / or where the authoritative version lives} |
| **Last Verified** | YYYY-MM-DD |
| **Verification cadence** | {monthly / quarterly / on change} |

---

## 1. Scope

What this page lists, in one sentence. Then, just as important, **what it does not** —
a reference that does not state its boundaries gets used for questions it cannot answer.

**Covers**: {}

**Does not cover**: {what a reader might expect here but will not find, and where it is instead}

**Who consults this**: {role or team, and typically to answer what question}

## 2. Where the truth lives

> Fill this in honestly. It is the section that decides whether this page is still useful
> in a year.

| Field | Value |
|-------|-------|
| **Authoritative source** | {this page / a file in a repo / a cloud console / another system} |
| **If elsewhere, why duplicate it here** | {the reason people cannot just read the source} |
| **How this page is refreshed** | {manually by the owner / generated from the source / not refreshed} |
| **How to tell it is stale** | {the signal a reader can check} |

A reference copied from somewhere else goes out of date quietly, and quiet staleness is
worse than an obvious gap — the reader trusts it and is wrong. If the source is a file or
a system, link it and keep this page as an index rather than a copy.

## 3. {The List}

One row per entry. Keep the columns to what someone looking something up actually needs;
a reference nobody can scan is not a reference.

| {Item} | {What it is} | {Owner or origin} | {Notes} |
|--------|-------------|-------------------|---------|
| {} | {} | {} | {} |

### Conventions used here

| Convention | Meaning |
|------------|---------|
| {notation, abbreviation or status marker used in the table} | {} |

## 4. How to Add or Change an Entry

Without this, entries accumulate in whatever shape each person felt like, and the
reference stops being comparable.

1. {where to make the change — this page, or the authoritative source}
2. {what must be filled in for a new entry}
3. {who reviews or approves}

## 5. Related

| Page | Why you might need it |
|------|----------------------|
| {link} | {} |

## 6. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
