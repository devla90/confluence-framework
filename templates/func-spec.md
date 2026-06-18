# [{PREFIX}-{FRONT}] Functional Specification — {Feature Name}

> **Default labels**: `type:func-spec`, `status:draft`, `team:{team}`, `phase:{as-is|to-be}`

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @author |
| **Approver** | @approver |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |
| **Version** | 1.0 |
| **Phase** | AS-IS / TO-BE |
| **Jira Epic** | {PREFIX}-XXXX (link via Jira macro) |

---

## 1. General Description

Brief description of the feature or capability (2-3 sentences). What it does and for whom.

## 2. Business Context

Why this feature exists. What business objective it serves. What happens if it is not implemented.

## 3. Scope

### In Scope

- Item 1
- Item 2

### Out of Scope

- Item 1
- Item 2

## 4. Current State (AS-IS)

> *Complete only if applicable. If this is a new feature with no prior state, indicate "Not applicable — new feature."*

Description of the current flow. Include a diagram using the draw.io macro.

**AS-IS Diagram**: *(insert draw.io diagram here)*

If there is a separate AS-IS document, link it: See [link to AS-IS page]

## 5. Target State (TO-BE)

Description of the target flow. Include a diagram using the draw.io macro.

**TO-BE Diagram**: *(insert draw.io diagram here)*

## 6. Functional Requirements

| ID | Requirement | Priority | Acceptance Criteria | Jira Link |
|----|------------|----------|---------------------|-----------|
| FR-001 | | High / Medium / Low | | {PREFIX}-XXXX |
| FR-002 | | | | |

## 7. Business Rules

1. **BR-001**: Description of the rule
2. **BR-002**: Description of the rule

## 8. Data Requirements

Input data, output data, validation rules, data sources.

| Field | Type | Required | Validation | Source |
|-------|------|----------|-----------|--------|
| | | Yes / No | | |

## 9. Integration Points

Systems this feature integrates with, APIs consumed/exposed.

| System/Service | Integration Type | API/Endpoint | Direction |
|----------------|-----------------|-------------|-----------|
| | REST / Event / Batch | | Consumes / Exposes |

## 10. Non-Functional Requirements

- **Performance**: Expected response time, throughput
- **Security**: Authentication, authorization, sensitive data
- **Accessibility**: Required WCAG level
- **Availability**: Expected SLA

## 11. Open Questions

| # | Question | Owner | Status | Resolution |
|---|----------|-------|--------|------------|
| 1 | | @person | Open / Resolved | |

## 12. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
