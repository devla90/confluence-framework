# [{PREFIX}-{FRONT}] Test Plan — {Feature/Sprint}

> **Default labels**: `type:test-plan`, `status:draft`, `team:qa`

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @qa-analyst |
| **Approver** | @qa-lead |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |
| **Version** | 1.0 |
| **Feature/Sprint** | {feature or sprint name} |
| **Jira Epic** | {PREFIX}-XXXX (link via Jira macro) |
| **Test Start Date** | YYYY-MM-DD |
| **Estimated End Date** | YYYY-MM-DD |

---

## 1. Plan Objective

What will be tested and why. Scope of the test cycle.

## 2. Scope

### In Scope

| Module/Feature | Test Type | Priority |
|---------------|-----------|----------|
| | Functional / Regression / Integration / E2E | High / Medium / Low |

### Out of Scope

- Items explicitly excluded from this test cycle and why.

## 3. Testing Strategy for this Plan

> *Reference: The overall project strategy is on the [{PREFIX}-{FRONT}] General Testing Strategy page. This section describes adjustments specific to this plan.*

| Test Type | Applies | Tool | Owner |
|-----------|---------|------|-------|
| Functional (manual) | Yes / No | Jira | @person |
| Regression (manual) | Yes / No | Jira | @person |
| Regression (automated) | Yes / No | {Cypress/Selenium/Playwright} | @person |
| Integration | Yes / No | {tool} | @person |
| Performance | Yes / No | {JMeter/k6/Artillery} | @person |
| Security | Yes / No | {tool} | @person |
| Accessibility | Yes / No | {Axe/Lighthouse} | @person |
| Compatibility (browsers/devices) | Yes / No | Manual / BrowserStack | @person |

## 4. Test Environment

| Aspect | Detail |
|--------|--------|
| Environment | QA / STG |
| URL | {environment URL} |
| Test data | {description or link to test data guide} |
| Preconditions | {what must be deployed or configured before starting} |

## 5. Entry Criteria

Conditions that must be met **before** starting tests:

- [ ] Code is deployed to the test environment
- [ ] Test data is prepared
- [ ] Dependencies (APIs, services) are available
- [ ] Functional documentation is up to date
- [ ] {other specific preconditions}

## 6. Exit Criteria

Conditions that must be met to consider testing **complete**:

- [ ] All High-priority test cases executed
- [ ] 0 critical defects (P1) open
- [ ] P2 defects documented with workaround or resolution plan
- [ ] Automated regression coverage >= {X}%
- [ ] Results report completed
- [ ] {other specific criteria}

## 7. Test Cases (Reference)

> *Detailed test cases are managed in Jira. This section links to the relevant filters.*

**Jira Filter — Test cases for this plan**: [link via Jira Issues macro with JQL filter]

| Case Group | Count | Priority | Jira Link |
|------------|-------|----------|-----------|
| Functional — Main flow | | High | |
| Functional — Alternative flows | | Medium | |
| Regression | | High | |
| Edge cases | | Low | |

## 8. Test Cycle Risks

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|------------|
| Unstable environment | | | |
| Insufficient test data | | | |
| Unavailable dependencies | | | |
| Last-minute scope changes | | | |

## 9. Schedule

| Activity | Start Date | End Date | Owner | Status |
|----------|-----------|----------|-------|--------|
| Data preparation | | | | Pending |
| Functional testing | | | | Pending |
| Regression testing | | | | Pending |
| Integration testing | | | | Pending |
| Results report | | | | Pending |

## 10. Results

> *Complete at the end of the test cycle.*

| Metric | Result |
|--------|--------|
| Total cases executed | |
| Cases passed | |
| Cases failed | |
| Cases blocked | |
| Defects found (total) | |
| P1 defects (critical) | |
| P2 defects (major) | |
| P3 defects (minor) | |
| Automation coverage | |

## 11. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
