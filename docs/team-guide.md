# Team Guide: How We Document in Confluence

This guide is divided into two parts:
- **Part 1**: How to document manually (the team's day-to-day workflow)
- **Part 2**: How to document with AI assistance (progressive automation)

---

# PART 1: Manual Documentation

## 1.1 Before creating a page

### Ask yourself: Does this belong in Confluence?

Use this quick reference:

| If your content is... | It goes in... | NOT in Confluence |
|-----------------------|--------------|-------------------|
| A user story or task | **Issue tracker** (e.g., Jira) | Do not duplicate stories in Confluence |
| A visual design or prototype | **Design tool** (e.g., Figma) | Embed in Confluence with the appropriate macro, do not upload screenshots |
| Source code | **Git** | Do not paste long code blocks |
| A secret or credential | **Secrets manager** (e.g., AWS Secrets Manager, Vault) | **NEVER** in Confluence |
| Functional specification, technical decision, guide, process | **Confluence** | This is its home |

> **Golden rule**: If it already exists in another tool, **link, do not duplicate**.

### Identify the document type

| Type | When to use | Template |
|------|------------|----------|
| Functional Specification | Document a feature (AS-IS or TO-BE) | `func-spec` |
| ADR | Record an important technical decision | `adr` |
| API Specification | Document an API (complement to Swagger/OpenAPI) | `api-spec` |
| Environment Configuration | Document configs for DEV/QA/STG/PROD | `env-config` |
| Runbook | Create a procedure for incidents | `runbook` |
| Security Document | SDLC policies, compliance, audits | `security-doc` |
| Migration Document | Plan AS-IS to TO-BE transition | `migration` |
| Test Plan | Plan a test cycle per feature/sprint | `test-plan` |
| Test Strategy | Define the project's overall QA strategy | `test-strategy` |
| Infrastructure Request | Request a cloud component (compute, storage, networking, etc.) | `infra-request` |
| Deployment Role Request | Request an IAM role, RBAC role, or policy for deployment | `role-request` |

### Identify the correct section

All pages are created within your project's Confluence space (`{SPACE_KEY}`). Navigate to the section for your domain:

| Your domain | Section in {SPACE_KEY} | Prefix in title |
|-------------|----------------------|-----------------|
| Frontend | Frontend | `[{PREFIX}-FRONT]` |
| Backend (services, APIs) | Backend & Services | `[{PREFIX}-BACK]` |
| Design (design system, prototypes) | UI/UX Design | `[{PREFIX}-DESIGN]` |
| Business (rules, processes, features) | Business & Product | `[{PREFIX}-BIZ]` |
| Architecture (cloud, infra, deployments) | Architecture & Cloud | `[{PREFIX}-ARCH]` |
| Security (SDLC, compliance) | Security & Compliance | `[{PREFIX}-SEC]` |
| QA & Testing (plans, strategy, automation) | QA & Testing | `[{PREFIX}-QA]` |
| Cross-cutting (global configs, integrations) | Governance Hub | `[{PREFIX}-HUB]` |

---

## 1.2 Create a page step by step

### Step 1: Create the page from a template

1. Go to your project's Confluence space (`{SPACE_KEY}`) and navigate to the section for your domain
2. Click on **"Create"** (the + button at the top right)
3. Select the **project template** that matches your document type
4. The template comes with the correct structure — you just need to fill it in

### Step 2: Set the correct title

Follow the naming pattern:

```
[{PREFIX}-{SECTION}] {Type} — {Topic}
```

**Examples**:
- `[PROJ-FRONT] Functional Specification — Contact Form`
- `[PROJ-BACK] API Specification — Notification Service`
- `ADR-0015 — Selection of Database Engine for Sessions`
- `ENV-PROD — Web Application`
- `RB — Backend — 502 Error in API Gateway`

### Step 3: Fill in the Page Properties

This is the metadata table at the top of the page. **Always** fill in:

| Field | What to enter |
|-------|--------------|
| Status | DRAFT (always starts this way) |
| Owner | Your name (with @mention) |
| Approver | Your tech lead or PO |
| Last Reviewed | Today's date |
| Next Review | +3 months for normal docs, +1 month for configs |
| Version | 1.0 |

### Step 4: Write the content

- **Follow the template sections** — do not add or remove sections
- **Use tables** for structured data (requirements, configurations, rules)
- **Link to your issue tracker** using the appropriate macro when referencing epics/stories
- **Embed designs** using the design tool macro when referencing visual artifacts
- **Use draw.io** for diagrams (do not upload static images of diagrams)
- **Do not copy API specs** from Swagger — link to the Swagger UI and add only extra context

### Step 5: Add labels

Every page needs **at least 3 labels**:

1. **`team:{your-team}`** — Example: `team:frontend`
2. **`type:{doc-type}`** — Example: `type:func-spec`
3. **`status:draft`** — Always starts as draft

**Additional labels depending on the case**:
- Functional documents: add `phase:as-is` or `phase:to-be`
- Environment documents: add `env:dev`, `env:qa`, `env:stg` or `env:prod`
- Security documents: add `compliance:sdlc-security` or the applicable regulation

### Step 6: Change the Content State

In Confluence Cloud, use the native **Content State**:
1. At the top of the page, click the status badge
2. Select **"DRAFT"**
3. When it is ready for review, change it to **"IN REVIEW"**

### Step 7: Publish and notify

1. Click **"Publish"**
2. Mention the reviewer with **@name** in an inline comment
3. If applicable, add a link to the page in the corresponding issue tracker epic

---

## 1.3 Review process

```
You (author)                  Reviewer                    Approver
    |                            |                            |
    +-- Create DRAFT page        |                            |
    +-- Change to IN-REVIEW ---->|                            |
    |                            +-- Review                   |
    |                            +-- Leave inline comments    |
    |<-- Comments ---------------+                            |
    +-- Resolve comments         |                            |
    +-- Notify ------------------+>                           |
    |                            +-- OK ---------------------->|
    |                            |                            +-- Approve
    |                            |                            +-- Change to APPROVED
    |<------------------------------------------------------------+
    +-- Done                                                  |
```

> For low-risk documents (lessons learned, implementation notes), the peer review can be informal.

---

## 1.4 Keep documents up to date

### When to update

- When you complete a story that affects an existing document
- When an environment configuration changes
- When a decision is made that affects a previous ADR

### How to update

1. Edit the page
2. Update the Page Properties table (new review date, increment version)
3. Add an entry to the Change History at the bottom of the page
4. If the change is major, go through the review flow

### When to archive

- When an AS-IS component is decommissioned: change status to `status:obsolete` and Content State to OBSOLETE
- When replaced by a new version: change to `status:archived`

---

## 1.5 Migrate existing documents (Excel, PDF, Word)

If you have a document in Excel, PDF, or Word that needs to be in Confluence:

1. **Create a new page** using the appropriate template
2. **Copy/adapt the content** to Confluence format (tables, sections, etc.)
3. **Attach the original file** to the page
4. **Add a note** to the attachment: *"Migrated on YYYY-MM-DD. This Confluence page is the source of truth."*
5. **Label the page correctly** with all its labels
6. **Inform the team** that the original file should no longer be edited

> **Do not migrate everything**. Prioritize active TO-BE documents. AS-IS documents that will soon be obsolete can remain as attachments without migrating the content.

---

## 1.6 Common mistakes to avoid

| Mistake | Why it is bad | What to do instead |
|---------|--------------|-------------------|
| Copy the entire Swagger spec | Gets out of sync with the code | Link to Swagger UI, document only extra context |
| Upload a screenshot of a design | Cannot be updated when the design changes | Use the design tool embed macro |
| Insert a diagram as a PNG image | Cannot be edited, becomes obsolete | Use the draw.io macro |
| Create a page without labels | Does not appear in searches or dashboards | Always add at least 3 labels |
| Leave Page Properties blank | Automated dashboards do not work | Fill in all required fields |
| Write a secret in Confluence | Serious security risk | Reference the path in your secrets manager |
| Duplicate content from the issue tracker | Gets out of sync immediately | Use the issue tracker macro with a filter query |
| Not updating the version in Page Properties | Cannot track changes | Always increment the version when editing |

---

# PART 2: Documentation with AI Assistance

## 2.1 Overview

AI does not replace the author — **it accelerates creation and improves maintenance**. The team remains responsible for the accuracy and approval of all content.

### Key principle

> **AI generates drafts. Humans validate and approve.** No AI-generated content is published as APPROVED without human review.

### Adoption phases

| Phase | What AI does | What the team does |
|-------|-------------|-------------------|
| **Phase 1** (current) | Nothing — the team establishes structure | Create pages with templates, apply labels, fill in Page Properties |
| **Phase 2** | Search and answer questions about existing docs | Validate that the answers are correct |
| **Phase 3** | Generate document drafts from issue tracker, Git, or requests | Review drafts, correct, approve |
| **Phase 4** | Detect outdated docs, verify template compliance | Act on alerts, resolve inconsistencies |

---

## 2.2 Using the documentation agent (Claude Code)

### Prerequisites

Have Claude Code installed and be in the project directory:

```bash
cd /path/to/your/confluence-project
claude
```

### Generate a document with the `/doc-confluence` command

Within a Claude Code session:

```
/doc-confluence func-spec Contact Form
```

The agent:
1. Loads the corresponding template (`templates/func-spec.md`)
2. Loads the documentation standards (`documentation-guide.md`)
3. Asks you for the minimum necessary information (domain, phase, issue tracker epic)
4. Generates the complete document with title, labels, Page Properties, and content
5. Saves the file in `output/` ready to copy to Confluence

### Document types it can generate

| Command | What it generates |
|---------|------------------|
| `/doc-confluence func-spec {topic}` | Functional Specification |
| `/doc-confluence adr {decision title}` | Architecture Decision Record |
| `/doc-confluence api-spec {service name}` | API Specification |
| `/doc-confluence env-config {component}` | Environment Configuration |
| `/doc-confluence runbook {scenario}` | Operational Runbook |
| `/doc-confluence security-doc {topic}` | Security Document |
| `/doc-confluence migration {topic}` | Migration Document |
| `/doc-confluence test-plan {feature/sprint}` | Test Plan |
| `/doc-confluence test-strategy {project}` | Test Strategy |
| `/doc-confluence infra-request {resource}` | Infrastructure Request |
| `/doc-confluence role-request {role name}` | Deployment Role Request |

### Full example

```
> /doc-confluence api-spec Notification Service

The agent asks:
- What is the base endpoint? -> /api/v1/notifications
- Authentication type? -> JWT via API Gateway
- Is there a Swagger link? -> https://swagger.example.com/notifications
- SLA target? -> 99.9% availability, p95 < 150ms

The agent generates:
-> output/proj-back-api-spec-notification-service.md

Title: [PROJ-BACK] API Specification — Notification Service
Labels: type:api-spec, status:draft, team:backend
Space: {PREFIX}-BACK
```

---

## 2.3 AI-generated documents: team rules

### Identification

Every AI-generated document must:
1. Carry the label **`ai:auto-generated`**
2. Include a note at the top (use Confluence Info macro):
   > "This draft was generated by AI from [source]. It requires human review before approval."
3. Start in **DRAFT** status — it can never be APPROVED without human review

### Review flow for AI-generated docs

```
AI generates draft
    |
    +-- Label: ai:auto-generated + status:draft
    |
    v
Author reviews and corrects
    |
    +-- Verifies technical data
    +-- Validates business rules
    +-- Completes sections with placeholders
    +-- Adds label: ai:reviewed
    |
    v
Normal review flow
    |
    +-- Peer review
    +-- Approval
    +-- Content State -> APPROVED
    |
    v
Document ready
```

### What AI does well vs. what needs human supervision

| AI does well | Needs human supervision |
|-------------|------------------------|
| Document structure and formatting | Technical data accuracy |
| Applying naming conventions and labels | Specific business rules |
| Generating tables with the correct structure | Actual configuration values |
| Filling in repetitive sections | Architecture decisions |
| Detecting missing sections | Political/organizational context |
| Suggesting cross-references | Security classification |

---

## 2.4 Intelligent search bot (Phase 2 — future)

When implemented, the team will be able to ask in Slack/Teams:

```
@doc-bot What are the business rules for the contact form?
@doc-bot Which API does the frontend consume for notifications?
@doc-bot What is the production config for the CDN?
```

The bot searches the Confluence documentation and responds with the source.

**Requirements for it to work well**:
- Pages must be labeled correctly (mandatory labels)
- Pages must follow the templates (consistent sections)
- Pages must have APPROVED status (the bot prioritizes approved docs)

> The better the manual documentation, the better the bot's answers.

---

## 2.5 Future automations (Phases 3-4)

These automations will be implemented progressively:

| Automation | What it does | When it will be available |
|-----------|-------------|--------------------------|
| **Draft from issue tracker** | When an epic moves to "Ready for Dev", a Functional Specification draft is automatically created | Month 5 |
| **API drift alert** | When an OpenAPI spec changes in Git, it notifies that the doc may be outdated | Month 6 |
| **Automatic release notes** | Generates a release notes draft from commits and issue tracker | Month 7 |
| **AS-IS/TO-BE gap analysis** | Compares AS-IS and TO-BE docs and generates a migration plan draft | Month 8 |
| **Compliance checker** | Weekly verification that pages comply with templates | Month 9 |
| **Stale doc detector** | Cross-references Confluence with Git and the issue tracker to detect potentially obsolete docs | Month 10 |

**The team does not need to do anything special to prepare**, just follow the best practices from Part 1. The structure with templates and labels is what enables these automations.

---

## 2.6 FAQ

**Can I blindly trust an AI-generated document?**
No. Always review technical data, business rules, and configuration values. AI is good with structure and formatting, but it can fabricate details.

**What happens if the AI generates something incorrect?**
You correct it like any draft. That is why it always starts as DRAFT. The label `ai:auto-generated` allows you to track that it was generated by AI.

**Do I need to know how to code to use the agent?**
You only need to have Claude Code installed and know how to run the `/doc-confluence` command. The agent guides you with questions.

**What if I do not have Claude Code?**
Document manually following Part 1. The templates are identical — AI only speeds up the filling, it does not change the structure.

**Does the AI have access to our sensitive data?**
The agent reads only the documentation project files (guides and templates). It does not have access to your cloud provider, Confluence, or production data. Generated documents are created locally.
