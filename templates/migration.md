# [{PREFIX}-{FRONT}] MIG — {Topic} — AS-IS to TO-BE

> **Default labels**: `type:migration`, `status:draft`, `team:{team}`, `phase:transition`
>
> **Ask the user for**: What is being migrated, AS-IS state, target TO-BE state
> **Look for in the source**: Migration files, current schema, legacy modules being replaced

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @owner |
| **Approver** | @approver |
| **AS-IS Document** | (link to AS-IS page) |
| **TO-BE Document** | (link to TO-BE page) |
| **Migration Status** | NOT STARTED / IN PROGRESS / COMPLETED |
| **Target Date** | YYYY-MM-DD |
| **Version** | 1.0 |

---

## 1. Migration Overview

What is being migrated and why. Business context justifying the change.

## 2. Current State Summary (AS-IS)

Brief summary of the current system/process (3-5 sentences). Link to the complete AS-IS document.

**Complete document**: [link to AS-IS page]

**Key points of the AS-IS**:
- Point 1
- Point 2
- Point 3

## 3. Target State Summary (TO-BE)

Brief summary of the target system/process (3-5 sentences). Link to the complete TO-BE document.

**Complete document**: [link to TO-BE page]

**Key points of the TO-BE**:
- Point 1
- Point 2
- Point 3

## 4. Gap Analysis

| Aspect | AS-IS | TO-BE | Gap | Required Action | Priority |
|--------|-------|-------|-----|-----------------|----------|
| | | | | | High / Medium / Low |

## 5. Migration Plan

Ordered steps for the transition. Include dependencies between steps.

| # | Step | Owner | Dependency | Estimated Date | Status |
|---|------|-------|------------|---------------|--------|
| 1 | | @person | — | YYYY-MM-DD | Pending |
| 2 | | @person | Step 1 | YYYY-MM-DD | Pending |
| 3 | | @person | Step 2 | YYYY-MM-DD | Pending |

## 6. Risks and Mitigations

| Risk | Probability | Impact | Mitigation | Owner |
|------|------------|--------|------------|-------|
| | High / Medium / Low | High / Medium / Low | | @person |

## 7. Rollback Plan

What to do if the migration fails or needs to be reverted.

**Point of no return**: Define the step after which rollback is no longer possible.

**Rollback steps** (if before the point of no return):
1. Step 1
2. Step 2

## 8. Success Criteria

How to verify that the migration is complete and successful.

- [ ] Criterion 1: Description and how to verify
- [ ] Criterion 2: Description and how to verify
- [ ] Criterion 3: End users operate normally on the TO-BE system
- [ ] Criterion 4: The AS-IS system can be decommissioned

## 9. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
