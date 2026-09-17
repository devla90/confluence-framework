# [{PREFIX}-{FRONT}] Architecture Overview — {Component}

> **Default labels**: `type:architecture`, `status:draft`, `team:{team}`
>
> **Ask the user for**: Component or application name, frente, what it is for in one sentence, anything intentional that the code cannot reveal
> **Look for in the source**: Top-level directories (the map — do not list every file), dependency manifest, build and bundler config, entry points, routing definitions, existing ADRs

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @tech-lead |
| **Component** | {component or application name} |
| **Repository** | {link to the repo} |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |

---

## 1. What This Is

Two or three sentences: what the component does, who uses it, and where it sits in the
wider system. Someone who has never seen the code should be able to stop here and know
whether the rest of the page concerns them.

## 2. Stack

Read from the dependency manifest and build configuration — not from memory.

| Layer | Technology | Version | Why this one |
|-------|-----------|---------|--------------|
| Language | {} | {} | {or `{placeholder}` if the reason is not recorded anywhere} |
| Framework | {} | {} | |
| Build | {} | {} | |
| Styling | {} | {} | |
| State | {} | {} | |
| Testing | {} | {} | |

Record versions as the manifest states them. If a choice has an ADR, link it rather than
restating the reasoning.

## 3. Structure

The top-level directories and what each is responsible for. This is the map — one line
each, no file inventories.

| Directory | Responsibility |
|-----------|----------------|
| `{dir}` | {what belongs here, and what does not} |

> Insert a draw.io macro here if a picture helps. Do not paste a static image.

### Where a change usually lands

| To do this | Touch |
|------------|-------|
| {add a page or route} | {dirs} |
| {add a shared component} | {dirs} |
| {change a cross-cutting concern} | {dirs} |

New joiners read this before anything else on the page. It is the part that decays
fastest, so keep it short enough to stay true.

## 4. Entry Points and Flow

How execution starts and how a request or interaction travels through the component.

| Entry point | File | What it starts |
|-------------|------|----------------|
| {} | {} | {} |

## 5. Key Decisions

Decisions a reader would otherwise have to reverse-engineer. Link the ADR where one
exists; state it here only when there is none.

| Decision | Consequence | ADR |
|----------|-------------|-----|
| {} | {} | {link or `none recorded`} |

## 6. Dependencies

### Depends on

| System | Purpose | Type | Criticality |
|--------|---------|------|-------------|
| {} | {} | Synchronous / Asynchronous | Critical / Degraded |

### Depended on by

| Consumer | What they use |
|----------|---------------|
| {} | {} |

## 7. Constraints and Known Limitations

Things that are true and inconvenient: performance ceilings, browser or platform support,
deliberate trade-offs, debt that has been accepted rather than fixed. Honesty here saves
the next person a week.

| Constraint | Impact | Deliberate? |
|------------|--------|-------------|
| {} | {} | {yes — reason / no — accepted debt} |

## 8. Non-Functional Characteristics

| Aspect | Target | Current | Measured by |
|--------|--------|---------|-------------|
| Performance | {} | {} | {} |
| Accessibility | {} | {} | {} |
| Security | {} | {} | {} |
| Browser/platform support | {} | {} | {} |

## 9. Open Questions

| Question | Who can answer | Blocking? |
|----------|----------------|-----------|
| {} | {} | {} |

## 10. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
