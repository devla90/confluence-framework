# Decision Guide: What Goes in Confluence

This guide establishes the criteria for determining where each type of content lives in the project. The goal is to avoid duplication, maintain a single source of truth, and ensure each tool is used for what it does best.

---

## Guiding Principle

> **Confluence is for durable knowledge. Transient work lives in specialized tools. Link, don't duplicate.**

### What Is "Durable Knowledge"

Information that:
- Has value beyond a single sprint or iteration
- Needs to be found by people who did not participate in its creation
- Requires review, approval, or auditing
- Explains the **why** behind technical or business decisions
- Needs narrative context that does not fit in a ticket or a commit

### What Is "Transient Work"

Information that:
- Has a short lifecycle (one sprint, one iteration)
- Is better managed with specialized workflows (kanban, code review)
- Is generated or updated automatically from code
- Is granular at the individual task level

---

## Decision Matrix

### Project Tools and Their Domains

| Tool | Is the source of truth for | Is NOT the place for |
|------|---------------------------|----------------------|
| **Jira** | User stories, tasks, bugs, sprints, backlog | Narrative documentation, long specifications, guides |
| **Figma** | Visual designs, prototypes, visual design system | Design rationale, written interaction specs |
| **Git** | Source code, IaC, auto-generated OpenAPI specs | Business context, narrative architectural decisions |
| **Swagger/OpenAPI** | Technical API reference (auto-generated from code) | Usage examples, business rules, SLAs |
| **Cloud Console/IaC** | Actual state of the infrastructure | Documentation of why it was configured that way |
| **Secrets Manager** | Actual values of secrets and credentials | — |
| **Confluence** | Everything else: durable knowledge, context, decisions | Secrets, code, visual designs, granular tasks |
| **Jira (testing)** | Bugs, individual test cases, test executions | Strategy, plans, testing guides (those go in Confluence) |
| **Test Management Tool (future)** | Advanced test case and test run management (evaluate adoption timeline) | Until implemented, plans live in Confluence |

---

### Decision by Content Type

| Content | Where it lives (source of truth) | What Confluence does | How it connects |
|---------|----------------------------------|----------------------|-----------------|
| **User Stories** | Jira | DO NOT duplicate. The Feature page in Confluence links to the Jira epic/filter | Jira Issues macro with JQL filter |
| **Tasks and bugs** | Jira | Do not document individual tasks in Confluence | — |
| **Sprint boards / Kanban** | Jira | Do not replicate | — |
| **UI/UX designs (visual)** | Figma | Embed Figma frames. Write rationale, interaction specs, and review notes | Figma Embed macro (native in Cloud) |
| **Source code** | Git | DO NOT paste large code blocks. Document context, setup, decisions | Link to repo/file |
| **API Reference (auto-generated)** | Swagger/OpenAPI in Git | Link to Swagger UI. Add content NOT in the spec: usage examples, business rules, SLAs, error guide | Direct link to Swagger URL |
| **Architecture diagrams** | Confluence | **Source of truth.** Create with draw.io macro (editable, not images) | — |
| **Functional specifications** | Confluence | **Source of truth.** Use Func Spec template | Labels + Page Properties |
| **Business rules** | Confluence | **Source of truth.** Dedicated sections in functional specs or standalone pages | — |
| **ADRs (technical decisions)** | Confluence | **Source of truth.** Use ADR template | Labels `type:adr` |
| **Environment configurations** | Confluence (reference) | Document **what** exists and **where**, not the secret values. Secrets reference the path in your secrets manager | Column "Secret? -> See Secrets Manager: /path" |
| **Secrets and credentials** | Secrets Manager | **NEVER in Confluence.** Only reference the path | — |
| **Secrets management policy** | Confluence | **Source of truth.** Policy and process, not values | — |
| **Security SDLC** | Confluence (Security section) | **Source of truth.** Checklists, policies, reports | Section with Page Restrictions |
| **Functional docs (complete)** | Confluence | **Source of truth.** Func Spec template with status APPROVED | `status:approved` |
| **Functional docs (planned)** | Confluence | Create page with status DRAFT and minimal content (scope, owner) | `status:draft` |
| **Deployment requests** | Confluence (if no ServiceNow or similar) | **Source of truth.** Log with date, description, approver | Template Deployment Request |
| **IAM role creation** | Confluence (Architecture section) | Document definition and justification of each role | Subpage under "Roles and IAM Policies" |
| **Infrastructure component request** | Confluence (Architecture section) | **Source of truth.** infra-request template with traceability. Email is only the submission channel; Confluence records the request and its status | Labels `type:infra-request` |
| **Deployment role request** | Confluence (Architecture section) | **Source of truth.** role-request template with traceability and least-privilege justification. Email is only the submission channel | Labels `type:role-request` |
| **Provisioned resource inventory** | Confluence (Architecture section) | **Source of truth.** Registry of all provisioned cloud resources with identifiers, status, and reference page | Subpage under "Infrastructure Requests" |
| **AS-IS flows** | Confluence | **Source of truth.** Tag with `phase:as-is`. When decommissioned, change to `status:obsolete` | Label `phase:as-is` |
| **TO-BE flows** | Confluence | **Source of truth.** Tag with `phase:to-be` | Label `phase:to-be` |
| **Existing Excel documents** | Migrate to Confluence | Migrate active content to native pages. Attach original as backup | See migration section in Documentation Guide |
| **Existing PDF/Word documents** | Migrate to Confluence | Migrate active content to native pages. Attach original as backup | Attachment with migration note |
| **Diagram images** | Migrate to draw.io in Confluence | Replace with editable diagrams when feasible | draw.io macro |
| **Operational runbooks** | Confluence | **Source of truth.** Runbook template | Labels `type:runbook` |
| **Release notes** | Confluence | **Source of truth.** Release Notes template | Labels `type:release-note` |
| **Onboarding** | Confluence | **Source of truth.** Narrative guide with links to other tools | Page in {PREFIX}-HUB |
| **Glossary of terms** | Confluence | **Source of truth.** Single page in HUB | — |
| **Meeting notes with decisions** | Confluence | Only if decisions are made that affect the project. Do not document routine meetings without decisions | Native Meeting Notes template |
| **Testing strategy** | Confluence (QA section) | **Source of truth.** Test Strategy template | Labels `type:test-strategy` |
| **Test plans** | Confluence (QA section) | **Source of truth.** Test Plan template | Labels `type:test-plan` |
| **Individual bugs** | Jira | Do not duplicate in Confluence | — |
| **Detailed test cases** | Jira (today) / Test management tool (future) | Do not duplicate. Link from the test plan if context is needed | Jira Issues macro |
| **Test executions (runs)** | Jira (today) / Test management tool (future) | Do not duplicate | — |
| **Existing testing Excel** | Migrate to Confluence (temporary) | Migrate durable content (plans, strategy) to {PREFIX}-QA. When a test management tool is adopted, cases migrate there | Attach original + migrate |
| **Test data (guide)** | Confluence (QA section) | **Source of truth.** How to generate and manage test data | — |
| **Pre-deploy checklist** | Confluence (QA section) | **Source of truth.** Reusable checklist per cycle | — |
| **Quality metrics** | Confluence (link to dashboard) | Link to Jira dashboard or Grafana. Do not duplicate data | Smart Links |
| **Automation framework (config)** | Git (code) + Confluence (context) | Do not paste code. Document setup, technical decisions, tools | Link to repo |

---

## Quick Decision Tree

Use this flow when you are not sure where to document something:

```
Is it a task, bug, or user story?
  -> YES: Jira. Not Confluence.

Is it a visual design or prototype?
  -> YES: Figma. Embed in Confluence if it needs written context.

Is it code or an auto-generated API reference?
  -> YES: Git/Swagger. Link from Confluence.

Is it a secret, password, or credential?
  -> YES: Secrets Manager. NEVER in Confluence.

Is it knowledge someone will need in 3+ months?
  -> YES: Confluence. Use the appropriate template.
  -> NO: Is it ephemeral? Evaluate whether it truly needs to be documented.

Does it already exist in another tool as the source of truth?
  -> YES: Do not duplicate. Link from Confluence if context is needed.
  -> NO: Confluence is the place.
```

---

## Connection Rule: "Link, Don't Duplicate"

When Confluence references content from another tool:

1. **Include brief context** (1-2 sentences) about what exists and why it matters
2. **Direct link** using Confluence Cloud macros:
   - Jira Issues macro for stories/epics
   - Figma Embed macro for designs
   - Smart Links for Swagger URLs, Git, dashboards
3. **Add unique value**: Write in Confluence only what does NOT exist in the source tool — rationale, business context, constraints, decisions

### Correct Example

> **Form Service — Contact API**
>
> This service processes the contact forms on the institutional website. The validation rules align with regulation XYZ.
>
> **Technical reference**: [Link to Swagger UI]
>
> **Business rules not covered by the spec**:
> 1. The "query type" field controls visible fields according to the commercial area rules table
> 2. Forms submitted outside business hours trigger a delayed automatic response

### Incorrect Example

> **Form Service — Contact API**
>
> POST /api/v1/contact
> Request body: { name: string, email: string, type: string, message: string }
> Response: { id: string, status: string }
> [... full copy of the Swagger spec ...]

This falls out of sync with the code as soon as there is a change.
