# Implementation Roadmap

Step-by-step implementation plan for establishing the Confluence documentation system for the project.

---

## Phase Overview

```
Week 1-2         Week 3-4          Month 2           Month 3-4         Month 5-8        Month 9-12
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Foundation│───>│ Structure │───>│ Active    │───>│ AI Phase │───>│ AI Phase │───>│ AI Phase │
│ and Setup │    │ by Section│    │ Adoption  │    │ 1 and 2  │    │ 3        │    │ 4        │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
```

---

## Week 1-2: Foundation and Setup

**Primary responsible**: Documentation Champion (designated before starting)

### Day 1-3: Configure the {SPACE_KEY} Space and Create Sections

- [ ] Verify access to the `{SPACE_KEY}` space in Confluence Cloud
- [ ] Create the root sections (top-level pages) as defined in your space structure document:
  - Governance Hub, Frontend, Backend & Services, UI/UX Design, Business & Product, Architecture & Cloud, Security & Compliance, QA & Testing
- [ ] Configure Page Restrictions on the "Security & Compliance" root page:
  - Access restricted to security team + architects + tech leads
- [ ] Enable Content States in the space (Draft, In Review, Approved, Archived, Obsolete)

### Day 3-5: Create Templates

- [ ] Create all templates as Space Templates in the corresponding space (see the templates creation guide for step-by-step instructions):
  - Functional Spec -> {PREFIX}-HUB (global, used by multiple sections)
  - ADR -> {PREFIX}-HUB (global)
  - API Spec -> {PREFIX}-BACK
  - Env Config -> {PREFIX}-HUB (global)
  - Runbook -> {PREFIX}-HUB (global)
  - Security Doc -> {PREFIX}-SEC
  - Migration Doc -> {PREFIX}-HUB (global)
  - Test Plan -> {PREFIX}-QA
  - Test Strategy -> {PREFIX}-QA
  - Infra Request -> {PREFIX}-ARCH
  - Role Request -> {PREFIX}-ARCH
- [ ] Configure global templates as "Promoted" so they appear first when creating pages

### Day 5-8: Build the Governance Hub Section

- [ ] Create the complete page tree for the Governance Hub section as defined in your space structure document
- [ ] Write the standards pages:
  - "How to Write Documentation" (based on the documentation guide)
  - "Naming Conventions" (extracted from the documentation guide)
  - "Label Taxonomy" (complete list of labels with descriptions)
  - "Template Catalog" (index page with links to all templates)
  - "Decision Guide — What Goes in Confluence" (based on the decision guide)
  - "Document Lifecycle Policy"
- [ ] Create the Documentation Health Dashboard page with Content Report Table macros

### Day 8-10: Team Onboarding Session

- [ ] Prepare and deliver a 30-45 minute session with the entire team:
  - Show the space structure and sections
  - Demonstrate how to use the templates
  - Explain naming conventions and labels
  - Explain the decision guide (what goes in Confluence vs. other tools)
  - Address questions
- [ ] Share links to reference pages via the team communication channel

### End of Week 2 Checklist

- [ ] Root sections created in {SPACE_KEY}
- [ ] All templates available as Space Templates in {SPACE_KEY}
- [ ] {PREFIX}-HUB with complete standards content
- [ ] Team informed and with access

---

## Week 3-4: Structure by Section

**Primary responsible**: Each Section Owner with support from the Documentation Champion

### Activities by Section Owner

- [ ] **{PREFIX}-FRONT** (Frontend Tech Lead):
  - Create page tree as defined in the space structure document
  - Create skeleton pages for the first modules/features
  - Begin migration of active documents (TO-BE) from Excel/Word to Confluence

- [ ] **{PREFIX}-BACK** (Backend Tech Lead):
  - Create page tree
  - Document existing services using the API Spec template
  - Create the Service Catalog with pages per service

- [ ] **{PREFIX}-DESIGN** (Design Lead):
  - Create page tree
  - Configure Figma embeds for the main designs
  - Document the design system and guidelines

- [ ] **{PREFIX}-BIZ** (Product Owner):
  - Create page tree
  - Document business rules and main processes
  - Create feature pages with links to Jira

- [ ] **{PREFIX}-ARCH** (Solution Architect):
  - Create page tree
  - Document the solution architecture (SAD)
  - Create cloud infrastructure documentation
  - Document IAM roles and justifications

- [ ] **{PREFIX}-SEC** (Security Lead):
  - Create page tree
  - Migrate existing security SDLC documentation
  - Create regulatory compliance matrix

- [ ] **{PREFIX}-QA** (QA Lead):
  - Create page tree
  - Document the overall testing strategy
  - Migrate durable content from testing spreadsheets to Confluence (plans, strategy)
  - Document the automation framework and tools

### Priority Document Migration

- [ ] Each team identifies their 5-10 most important documents currently in Excel/PDF/Word
- [ ] Migrate content to Confluence pages using templates
- [ ] Attach original file with note: "Migrated on YYYY-MM-DD. This page is the source of truth."
- [ ] Apply correct labels to each migrated page

### End of Week 4 Checklist

- [ ] All sections have their page tree created
- [ ] At least 5 documents migrated per team
- [ ] Labels correctly applied to all pages

---

## Month 2: Active Adoption

**Responsible**: Entire team with coordination from the Documentation Champion

### Ongoing Activities

- [ ] Teams actively documenting as part of sprint work
- [ ] Definition of Done in Jira updated to include documentation
- [ ] Section Owners do biweekly spot-checks of their section

### Refinement

- [ ] Documentation Champion collects feedback from the team on:
  - Templates: Missing fields? Unnecessary fields? Clear enough?
  - Naming: Do the conventions work in practice?
  - Labels: Is the taxonomy sufficient? Are new labels needed?
- [ ] Adjust templates and guides based on feedback

### Dashboards

- [ ] Set up and validate CQL dashboards:
  - Stale docs (>90 days without update)
  - Stuck drafts (>30 days as DRAFT)
  - Pages without mandatory labels
- [ ] First monthly health check (15 min) by the Documentation Champion

### End of Month 2 Checklist

- [ ] > 80% of new pages use templates
- [ ] > 90% of pages have mandatory labels (`team:`, `type:`, `status:`)
- [ ] CQL dashboards operational
- [ ] Templates refined based on feedback

---

## Month 3-4: AI Phase 1 and 2

**Responsible**: Documentation Champion + assigned technical resource

### AI Phase 1: Foundation (should have been completed in Months 1-2, validate)

- [ ] Verify that > 80% of approved pages have the `ai:template-compliant` label
- [ ] Check that Page Properties are consistent across all pages
- [ ] Publish the AI-Generated Content Policy in {PREFIX}-HUB

### AI Phase 2: Consumption Pipeline

- [ ] Set up access to Confluence Cloud API v2 (API token + permissions)
- [ ] Develop export pipeline:
  - Filter: `ai:template-compliant AND status:approved`
  - Chunking by H2 sections
  - Metadata extraction from Page Properties and labels
- [ ] Set up vector database (select provider)
- [ ] Load first version of the index
- [ ] Configure incremental sync (detect changes via `content_hash`)
- [ ] Build RAG application with metadata-filtered retrieval
- [ ] Deploy smart search bot for internal testing
- [ ] Collect team feedback on answer accuracy

### End of Month 4 Checklist

- [ ] Confluence -> Vector DB pipeline operational with incremental sync
- [ ] Search bot available for the team (even in beta)
- [ ] > 80% accuracy in answers (human evaluation of sample)

---

## Month 5-8: AI Phase 3 — Assisted Authoring

**Responsible**: Technical resource + Documentation Champion

- [ ] **Month 5**: Implement draft generation from Jira
  - Configure Jira webhook (epic -> Ready for Development)
  - Develop draft generator using the Func Spec template
  - Apply automatic labels (`ai:auto-generated`, `status:draft`)
  - Testing with 5-10 real epics

- [ ] **Month 6**: Implement API docs drift detection
  - Integrate with CI/CD to detect changes in OpenAPI specs
  - Generate Confluence comments when drift is detected
  - Testing with 3-5 real APIs

- [ ] **Month 7**: Implement release notes automation
  - Integrate with Git tags and Jira resolved issues
  - Generate release notes drafts automatically

- [ ] **Month 8**: Implement AS-IS/TO-BE gap analysis
  - Develop AS-IS vs. TO-BE document comparator
  - Generate draft migration documents

### End of Month 8 Checklist

- [ ] > 50% of Func Specs started from AI draft
- [ ] API docs drift detected automatically
- [ ] Release notes generated automatically for each release
- [ ] Gap analysis available on-demand

---

## Month 9-12: AI Phase 4 — Automated Governance

**Responsible**: Documentation Champion + technical resource

- [ ] **Month 9**: Deploy template compliance checker
  - Weekly scan of all sections
  - Automatic label updates `ai:template-compliant` / `ai:needs-structuring`
  - Weekly report in {PREFIX}-HUB

- [ ] **Month 10**: Deploy completeness auditor
  - Cross-reference: Deployed services vs. documented in Confluence
  - Cross-reference: APIs in Git vs. documented in Confluence
  - Monthly gap report

- [ ] **Month 11**: Deploy terminology consistency checker
  - Compare documents against the Glossary
  - Flag inconsistencies via comments

- [ ] **Month 12**: Annual review of the complete framework
  - Include evaluation of test management tools for test case management (migrate test cases from Confluence/Jira to the new tool if adopted)
  - Evaluate success metrics (see ai-strategy.md)
  - Adjust processes, templates, and automations
  - Plan improvements for the next year
  - First quarterly audit with full AI support

### End of Month 12 Checklist

- [ ] Template compliance > 95%
- [ ] 0 undocumented services (automatic detection)
- [ ] Annual review completed with plan for next year

---

## Resources Needed

| Role | Dedication | When |
|------|-----------|------|
| Documentation Champion | 2-4 hours/week | Entire period |
| Section Owners (7 people) | 2-3 hours/week in weeks 1-4, then 1 hour/week | Entire period |
| Technical resource (AI/DevOps) | Part-time months 3-4, more dedicated months 5-12 | Months 3-12 |
| Entire team | Documentation integrated into sprint work | Starting from week 3 |

---

## Roadmap Risks

| Risk | Impact | Mitigation |
|------|--------|------------|
| The team does not have time to document | Adoption fails in month 2 | Integrate into Definition of Done. Start with the minimum viable. |
| No technical resource available for AI in month 3 | AI phases are delayed | Phases 1-2 of the roadmap (pure Confluence) are valuable on their own. AI is an accelerator, not a requirement. |
| Templates turn out to be inadequate | Low adoption, inconsistent content | Iterate in month 2 based on real feedback. Do not wait for them to be perfect. |
| Confluence Cloud has unforeseen limitations | Some features do not work as expected | Validate critical macros (Page Properties Report, Content Report Table, Figma Embed) in week 1. |
