# [{PREFIX}-{SUFFIX}] DR {YYYY-MM-DD} — {Description}

> **Default labels**: `type:deployment-request`, `status:draft`, `team:{team}`, `env:{environment}`
>
> **Ask the user for**: What is being deployed, target environment, requested window, who approves, what changes in production
> **Look for in the source**: Version to be deployed, deployment manifests and IaC, migration files included, CI pipeline definition, feature flags involved

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT / SUBMITTED / APPROVED / DEPLOYED / REJECTED |
| **Requested By** | @person |
| **Approver** | @person |
| **Target Environment** | {DEV / QA / STG / PROD} |
| **Requested Window** | YYYY-MM-DD HH:MM {timezone} |
| **Version** | v{X.Y.Z} |

---

## 1. What Is Being Deployed

| Component | From version | To version | Repository |
|-----------|-------------|-----------|------------|
| {} | {} | {} | {link} |

**Why now**: {the reason this needs to go out — a fix, a committed date, a dependency}

## 2. Changes Included

Link the release note if one exists rather than restating it.

- {change} ({issue link})

## 3. Risk

An honest assessment. An approver reading "low risk" with nothing behind it learns
nothing.

| Field | Value |
|-------|-------|
| **Risk level** | {low / medium / high} |
| **Why** | {what could go wrong, and how likely} |
| **Blast radius** | {who is affected if it goes wrong} |
| **Reversible?** | {yes, in N minutes / no, because ...} |

### Irreversible steps

Anything that cannot be undone by rolling back the code — schema changes that drop data,
messages published to other systems, third-party state.

| Step | Why it cannot be reversed | Mitigation |
|------|--------------------------|------------|
| {} | {} | {} |

## 4. Pre-Deployment Checklist

| Check | Done | Evidence |
|-------|------|----------|
| Tested in {previous environment} | {} | {link} |
| Migrations tested against production-like data | {} | {link} |
| Rollback procedure verified | {} | {link} |
| Dependent teams notified | {} | {} |
| Monitoring and alerts in place | {} | {} |

## 5. Deployment Plan

| Step | Action | Owner | Estimated |
|------|--------|-------|-----------|
| 1 | {} | {} | {} |

**Downtime expected**: {none / duration and what is unavailable}

## 6. Rollback Plan

| Field | Value |
|-------|-------|
| **Trigger** | {what makes us roll back — a metric, an error rate, a report} |
| **Procedure** | {link to the runbook, or the steps} |
| **Time to roll back** | {} |
| **Decision maker** | {who calls it} |

## 7. Post-Deployment Verification

| Check | Expected | Owner |
|-------|----------|-------|
| {} | {} | {} |

**Monitoring period**: {how long someone watches before considering it done}

## 8. Approval

| Role | Person | Date | Decision |
|------|--------|------|----------|
| {Tech Lead} | | | |
| {Ops / Platform} | | | |

## 9. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
