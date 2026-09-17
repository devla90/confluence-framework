# [{PREFIX}-{FRONT}] Testing Strategy — {Project/Component}

> **Default labels**: `type:test-strategy`, `status:draft`, `team:qa`
>
> **Ask the user for**: Scope (project/component), test types, automation tools, target metrics
> **Look for in the source**: Test setup, runners, coverage config, existing test directories

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @qa-lead |
| **Approver** | @tech-lead / @architect |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |
| **Version** | 1.0 |
| **Scope** | {entire project / specific component} |

---

## 1. QA Vision and Objectives

What the testing strategy aims to achieve. Measurable quality objectives.

| Objective | Metric | Target |
|-----------|--------|--------|
| Detect defects before production | % defects found in QA vs production | > {X}% |
| Automated test coverage | % of critical flows automated | > {X}% |
| Test cycle time | Days from deploy to QA until sign-off | < {X} days |
| Production defects | P1/P2 defects reported in production per sprint | < {X} |

## 2. Testing Scope

### Components Under Test

| Component | Type | Technology | Test Level |
|-----------|------|-----------|------------|
| Institutional website | Frontend | React | Functional, E2E, Accessibility, Compatibility |
| CMS | Frontend | WordPress | Functional, Integration |
| Form APIs | Backend | Microservices | Functional, Integration, Performance |
| Lambda functions | Backend | AWS Lambda | Unit, Integration |
| Infrastructure | Cloud | AWS | Smoke tests post-deploy |

### Out of QA Scope

- Items that are not the QA team's responsibility (e.g., unit tests are the responsibility of development)

## 3. Test Types

| Type | Description | Owner | Tool | Manual / Automated |
|------|------------|-------|------|-------------------|
| **Unit** | Tests of isolated functions/components | Development | Jest / JUnit | Automated |
| **Integration** | Tests between components/services | QA + Development | {tool} | Mixed |
| **Functional** | Validation of functional requirements | QA | Jira + {tool} | Manual (automate progressively) |
| **Regression** | Verify that changes do not break existing functionality | QA | {Cypress/Selenium/Playwright} | Automated |
| **E2E (End-to-End)** | Complete user flows | QA | {Cypress/Playwright} | Automated |
| **Performance** | Load, stress, capacity | QA + DevOps | {JMeter/k6/Artillery} | Automated |
| **Security** | OWASP vulnerabilities, injections, auth | Security + QA | {OWASP ZAP/Burp Suite} | Mixed |
| **Accessibility** | WCAG compliance | QA + Design | Axe / Lighthouse | Mixed |
| **Compatibility** | Browsers, devices, resolutions | QA | BrowserStack / Manual | Mixed |
| **Smoke** | Basic post-deploy verification | QA | {tool} | Automated |

## 4. Test Environments

| Environment | QA Purpose | Test Types | Data |
|-------------|-----------|------------|------|
| DEV | Early exploratory testing | Basic functional | Development data |
| QA | Formal test cycle | Functional, Regression, Integration | Controlled synthetic data |
| STG | Pre-production validation | E2E, Performance, Smoke | Production-like data (anonymized) |
| PROD | Post-deploy verification | Smoke | Real data (read-only) |

### Test Data Management

- Where test data is stored
- How it is generated/refreshed
- Sensitive data policy (anonymization, GDPR)
- Link to the test data guide in Confluence

## 5. Automation Strategy

### Framework and Tools

| Component | Tool | Language | Repository |
|-----------|------|----------|------------|
| E2E Frontend | {Cypress/Playwright} | {JavaScript/TypeScript} | {link to repo} |
| API Testing | {Postman/RestAssured/Supertest} | {language} | {link to repo} |
| Performance | {JMeter/k6/Artillery} | {language/config} | {link to repo} |

### Automation Criteria

What to automate and what to leave manual:

| Automate | Do not automate (manual) |
|----------|--------------------------|
| Critical business flows (happy path) | Exploratory testing |
| Regression of stable features | Features under active development |
| Repetitive validations | UX/usability testing |
| Smoke tests post-deploy | One-off edge cases |
| Integrations between services | Visual design validation |

### Automation Coverage Plan

| Quarter | Coverage Target | Focus |
|---------|----------------|-------|
| Q1 | {X}% | Smoke tests + critical flows |
| Q2 | {X}% | Full regression of main flows |
| Q3 | {X}% | Integrations and API testing |
| Q4 | {X}% | Performance and basic security |

### CI/CD Integration

- At which pipeline stage automated tests are executed
- Blocking criteria (what failure prevents deploy)
- Automated results reports

## 6. Defect Management Process

### Defect Lifecycle

```
Found → Reported in Jira → Triaged → Assigned → Fixed → Verified → Closed
```

### Severity Classification

| Severity | Description | Resolution SLA | Example |
|----------|------------|---------------|---------|
| P1 — Critical | Core functionality blocked, no workaround | {X} hours | Login does not work, form does not submit |
| P2 — Major | Important functionality affected, with workaround | {X} days | Incorrect field validation, visual error in main flow |
| P3 — Minor | Secondary functionality affected, low impact | Next sprint | Typo, minor visual alignment |
| P4 — Trivial | Cosmetic, does not affect functionality | Backlog | Suggested UX improvement |

### How to Report a Defect (Team Guide)

> *Link to the detailed page in {PREFIX}-{FRONT}: "How to Report a Defect"*

Minimum required information:
1. Descriptive title
2. Steps to reproduce
3. Expected result vs actual result
4. Severity (P1-P4)
5. Environment where it was found
6. Evidence (screenshot or video)

## 7. Metrics and Reports

| Metric | Formula | Frequency | Dashboard |
|--------|---------|-----------|-----------|
| Defect Detection Rate | Defects in QA / (Defects in QA + Defects in PROD) | Monthly | {link} |
| Test Coverage | Cases executed / Total cases planned | Per cycle | {link} |
| Automation Rate | Automated cases / Total cases | Quarterly | {link} |
| Defect Density | Defects / Feature points | Per sprint | {link} |
| Mean Time to Detect | Average hours from introduction to detection | Monthly | {link} |
| Defect Reopen Rate | Defects reopened / Defects closed | Per sprint | {link} |

## 8. QA Roles and Responsibilities

| Role | Responsibilities |
|------|-----------------|
| QA Lead | Strategy, plans, metrics, coordination with teams |
| QA Analyst | Design and execution of manual tests, defect reporting |
| QA Automation | Development and maintenance of automation framework |
| Development | Unit tests, defect fixes, code review of tests |

## 9. Tools

| Purpose | Tool | Notes |
|---------|------|-------|
| Test management | Jira native (future: Xray/Zephyr) | Tool evaluation in ~12 months |
| E2E automation | {Cypress/Playwright} | |
| API automation | {Postman/RestAssured} | |
| Performance | {JMeter/k6} | |
| Bug tracking | Jira | |
| CI/CD | {Jenkins/GitHub Actions/CodePipeline} | |
| Monitoring | {Grafana/CloudWatch} | |

## 10. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
