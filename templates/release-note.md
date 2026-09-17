# [{PREFIX}-{SUFFIX}] RN {YYYY-MM-DD} — v{X.Y.Z}

> **Default labels**: `type:release-note`, `status:draft`, `team:{team}`, `env:prod`
>
> **Ask the user for**: Version number, release date, environment, what shipped, anything that needs action from consumers
> **Look for in the source**: CHANGELOG, git log or merged pull requests since the previous tag, version in the dependency manifest, migration files included in the release

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT / RELEASED / ROLLED BACK |
| **Version** | v{X.Y.Z} |
| **Release Date** | YYYY-MM-DD |
| **Environment** | {PROD / STG} |
| **Released By** | @person |
| **Previous Version** | {link to the previous release note} |

---

## 1. Summary

Two or three sentences a non-engineer can read: what changed for users, and whether
anything is required of them.

## 2. What Changed

Group by what the reader cares about, not by commit.

### Added

- {feature} — {one line on what it does} ({issue link})

### Changed

- {change} — {what is different now} ({issue link})

### Fixed

- {bug} — {what was wrong} ({issue link})

### Removed

- {what is gone, and what replaces it}

## 3. Breaking Changes

Delete this section if there are none — do not leave it saying "none", which reads like
nobody checked.

| What broke | Who is affected | What they must do | By when |
|------------|-----------------|-------------------|---------|
| {} | {} | {} | {} |

## 4. Migration and Actions Required

Steps consumers must take, if any: schema migrations, configuration changes, dependency
bumps, cache invalidation.

1. {action}

## 5. Deployment

| Field | Value |
|-------|-------|
| **Components deployed** | {} |
| **Deployment window** | {} |
| **Downtime** | {none / duration} |
| **Rollback plan** | {link to the runbook, or the procedure} |
| **Feature flags** | {flags toggled, and their state} |

## 6. Verification

How the release was confirmed good, and by whom.

| Check | Result | Verified by |
|-------|--------|-------------|
| Smoke tests | {} | {} |
| Key user flows | {} | {} |
| Monitoring for {X} minutes after deploy | {} | {} |

## 7. Known Issues

Shipped with known problems, if any — better here than discovered in a support ticket.

| Issue | Impact | Workaround | Tracked as |
|-------|--------|-----------|------------|
| {} | {} | {} | {issue link} |

## 8. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
