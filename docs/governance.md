# Documentation Governance Model

Lightweight model for a team of 5-15 people. No excessive bureaucracy — just enough to maintain quality and consistency.

---

## 1. Roles

### Documentation Champion (1 person, rotates quarterly)

**This is not a full-time role.** It is an additional responsibility that rotates among the tech leads or senior members of the team.

**Responsibilities:**
- Maintain the {PREFIX}-HUB section (standards, taxonomy, templates)
- Execute the monthly health check (15 minutes)
- Coordinate the lightweight quarterly audit
- Resolve structure or naming conflicts between teams
- Drive the AI integration initiative
- Onboard new team members on documentation standards

### Section Owner (1 per section within the {SPACE_KEY} space)

| Section | Prefix | Natural Section Owner |
|---------|--------|-----------------------|
| Governance Hub | {PREFIX}-HUB | Documentation Champion |
| Frontend | {PREFIX}-FRONT | Frontend Tech Lead |
| Backend & Services | {PREFIX}-BACK | Backend Tech Lead |
| UI/UX Design | {PREFIX}-DESIGN | Design Lead |
| Business & Product | {PREFIX}-BIZ | Product Owner |
| Architecture & Cloud | {PREFIX}-ARCH | Solution Architect |
| Security & Compliance | {PREFIX}-SEC | Security Lead |
| QA & Testing | {PREFIX}-QA | QA Lead |

**Responsibilities:**
- Maintain the page tree structure of their section
- Ensure their team uses the correct templates and labels
- Review and approve documents in their domain
- Participate in the quarterly audit of their section
- Manage Page Restrictions if applicable (e.g., Security section)

### Authors (all team members)

**Responsibilities:**
- Write and update pages using the available templates
- Apply correct labels (minimum: `team:`, `type:`, `status:`)
- Keep the Page Properties table up to date
- Use Content States to indicate the document status
- Respond to review feedback

---

## 2. Who Writes, Who Reviews, Who Approves

| Document type | Typical author | Reviewer | Approver |
|---------------|---------------|----------|----------|
| Functional Specification | Developer or Analyst | Team peer | Tech Lead or PO of the section |
| ADR | Architect or Tech Lead | Technical team (async) | Solution Architect |
| API Specification | Backend Developer | Backend peer | Backend Tech Lead |
| Environment Configuration | DevOps or Developer | Section Tech Lead | Solution Architect |
| Runbook | Developer or DevOps | Team peer | Section Tech Lead |
| Security Document | Security Lead | Architect | Security Lead + Compliance |
| Migration Document | Analyst or Developer | Section Tech Lead | PO + Tech Lead |
| Test Plan | QA Lead or QA Analyst | Tech Lead of the section under test | QA Lead |
| Testing Strategy | QA Lead | Architect + Tech Leads | QA Lead |
| Infrastructure Request | Developer or Tech Lead | Solution Architect | Solution Architect |
| Deployment Role Request | Developer or DevOps | Security Lead + Architect | Solution Architect |
| Business Rules | Product Owner or Analyst | Business stakeholder | Product Owner |
| Release Notes | Any team member | Tech Lead | Tech Lead |

### Simplified Review Process

1. The author creates the page with status **DRAFT** and Content State "DRAFT"
2. When ready, they change it to **IN-REVIEW** and mention (@) the reviewer in an inline comment
3. The reviewer leaves inline comments on the page (using Confluence comments, not editing directly)
4. The author resolves the comments and notifies the approver
5. The approver changes the status to **APPROVED**

> For low-risk documents (implementation notes, lessons learned), peer review can be informal — a "I took a look" from the tech lead is sufficient.

---

## 3. Review Cadence

### Recurring Activities

| Frequency | Activity | Responsible | Estimated duration |
|-----------|----------|-------------|-------------------|
| **Per sprint** | Review docs affected by completed stories | Authors | Integrated into sprint work |
| **Monthly** | Health check: review dashboard of stale docs, stuck drafts, missing labels | Documentation Champion | 15 minutes |
| **Quarterly** | Lightweight audit: each Section Owner reviews their section (completeness, accuracy, structure) | Section Owners + Champion | 1 hour per Section Owner |
| **Quarterly** | Review of security/compliance documents | Security Lead | 2 hours |
| **Semi-annually** | Review of label taxonomy and templates (are they still working?) | Documentation Champion + all Section Owners | 1 meeting of 30 min |

### Inclusion in Definition of Done (Jira)

Add to the team's Definition of Done in Jira:

> **Documentation**: If the story affects architecture, APIs, configurations, or business flows, the corresponding documentation in Confluence is created or updated with the correct status.

This does not mean documenting everything — only what falls within the decision guide.

---

## 4. Documentation Health Dashboard

Create a page in **{PREFIX}-HUB / Governance and Reviews** with the following CQL queries using the Content Report Table macro:

### Potentially Stale Documents

```sql
label = "status:approved" AND lastModified < now("-90d")
```

Shows approved documents that have not been touched in 90 days. It does not mean they are wrong — but it is worth verifying.

### Stuck Drafts

```sql
label = "status:draft" AND created < now("-30d")
```

Drafts created more than 30 days ago that are still in draft status. Possibly abandoned.

### Pages Without Mandatory Labels

Requires manual review or a script. Search for pages in each section that do not have at least `team:`, `type:`, and `status:`.

### AI-Generated Documents Pending Review

```sql
label = "ai:auto-generated" AND label NOT IN ("ai:reviewed")
```

### Compliance Documents at Risk

```sql
label = "compliance:audit-required" AND label = "status:draft"
```

---

## 5. Enforcement Mechanisms

### What Confluence Cloud Offers Natively

| Mechanism | How to use it |
|-----------|---------------|
| **Space Templates** | Configure the templates as default templates for the {SPACE_KEY} space. When someone creates a new page, the project templates appear first |
| **Content States** | Enable in the space. Visual states (Draft, In Review, Approved) are visible in the page listing |
| **Page Restrictions** | Apply read restriction on the "Security & Compliance" root page so only security, architects, and tech leads can access it |
| **Page Restrictions** | For individual sensitive pages, use page-level restrictions |
| **Watch Pages** | Section Owners should "Watch" their entire section to receive change notifications |

### What We Do as a Team

| Practice | Frequency |
|----------|-----------|
| Review the health dashboard in the monthly team meeting (5 min) | Monthly |
| Section Owner does a spot-check of 3-5 new pages in their section | Every 2 weeks |
| Documentation Champion sends a mini-report via Slack/Teams after the quarterly audit | Quarterly |

### What We Do NOT Do

- We do not create approval processes that block work
- We do not require documentation for minor tasks and bugs
- We do not force anyone to fill in fields that do not apply
- We do not penalize mistakes — we correct and move on

---

## 6. Handling Legacy Documents (Excel, PDF, Word)

### Migration Responsibility

| Document type | Responsible for migration |
|---------------|--------------------------|
| Technical docs (configs, APIs, architecture) | Tech Lead of the corresponding section (delegates to team) |
| Functional/business docs | Product Owner or Business Analyst |
| Security docs | Security Lead |
| Cross-cutting docs | Documentation Champion coordinates, team executes |

### Prioritization Criteria

Only actively migrate documents that:
1. Are TO-BE (the new system being built)
2. Are cross-cutting and frequently consulted
3. Are required for compliance/audit

AS-IS documents that will be obsolete in less than 3 months: **attach as a file without migrating content.** Create a minimal page with title, one-line description, and the attached file. Label with `phase:as-is` and `status:archived`.

---

## 7. Onboarding New Members

When a new member joins the team:

1. Add them to the corresponding Confluence spaces (permissions)
2. Share a link to the **Onboarding Guide** in {PREFIX}-HUB
3. The Section Owner of their domain shows them the section structure (5 min)
4. The new member reads:
   - How to Write Documentation (Style Guide)
   - Template Catalog
   - Decision Guide — What Goes in Confluence
5. Their first document is created using a template, and they request feedback from a peer
