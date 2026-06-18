# Documentation Standards Guide

This guide defines how documentation is written, named, labeled, and maintained in Confluence for the project.

---

## 1. Naming Conventions

### Page Titles

Titles must be **globally unique** (not just within the space) to facilitate search and linking.

| Document type | Pattern | Example |
|---------------|---------|---------|
| General documentation | `[PROJ-XXX] Type — Subject` | `[PROJ-FRONT] Functional Specification — Contact Form` |
| ADR | `ADR-NNNN — Decision Title` | `ADR-0012 — Selection of Framework X over Framework Y` |
| Runbook | `RB — System — Scenario` | `RB — Frontend — CDN Cache Invalidation` |
| Release Notes | `RN YYYY-MM-DD — vX.Y.Z` | `RN 2026-06-15 — v2.1.0` |
| Deployment Request | `DR YYYY-MM-DD — Description` | `DR 2026-06-10 — Deploy Service Forms` |
| Environment Config | `ENV-{ENVIRONMENT} — Technology/Component` | `ENV-PROD — Web Application` |
| Migration Document | `MIG — Subject — AS-IS to TO-BE` | `MIG — Contact Module — AS-IS to TO-BE` |
| Infrastructure Request | `[PROJ-ARCH] Infra Request — Description` | `[PROJ-ARCH] Infra Request — S3 Bucket Production Assets` |
| Deployment Role Request | `[PROJ-ARCH] Role Request — Role Name` | `[PROJ-ARCH] Role Request — Lambda Deploy Role` |

### Attachments

For documents migrated from Excel, PDF, or Word:

```
{PROJ-XXX}_{DocType}_{Subject}_{YYYY-MM-DD}_v{N}.{ext}
```

Example: `PROJ-BACK_FuncSpec_FormService_2026-06-01_v2.pdf`

### Note on Prefixes and Single-Space Setup

Prefixes like `PROJ-FRONT`, `PROJ-BACK`, etc. identify the domain section in the page title. In a single-space setup, all pages live in the space `{SPACE_KEY}`. If sections are later separated into their own spaces, the titles require no changes — they are prepared for migration.

### Why It Matters for AI

Predictable, self-contained titles allow a RAG system to identify the document's purpose from the title alone, improving retrieval precision without needing to read the full content.

---

## 2. Label Taxonomy

Labels in Confluence Cloud are flat (no hierarchy). We use **namespaced prefixes** to create structure.

### Label Categories

| Prefix | Purpose | Values |
|--------|---------|--------|
| `team:` | Responsible team | Define project-specific `team:` labels in your `project-config.md`. Pattern: `team:{team-label}` (e.g., `team:frontend`, `team:backend`, `team:design`, `team:business`, `team:architecture`, `team:security`, `team:qa`) |
| `type:` | Document type | `type:func-spec`, `type:adr`, `type:runbook`, `type:api-spec`, `type:env-config`, `type:release-note`, `type:deployment-request`, `type:guide`, `type:policy`, `type:migration`, `type:test-plan`, `type:test-strategy`, `type:infra-request`, `type:role-request` |
| `status:` | Lifecycle state | `status:draft`, `status:in-review`, `status:approved`, `status:archived`, `status:obsolete` |
| `phase:` | System phase | `phase:as-is`, `phase:to-be`, `phase:transition` |
| `env:` | Environment | `env:dev`, `env:qa`, `env:stg`, `env:prod`, `env:all` |
| `tech:` | Technology | Define project-specific `tech:` labels in your `project-config.md`. Pattern: `tech:{technology}` (e.g., `tech:framework-x`, `tech:database-y`, `tech:service-z`) |
| `compliance:` | Regulatory/audit | `compliance:sdlc-security`, `compliance:gdpr`, `compliance:audit-required`, `compliance:pci` |
| `ai:` | AI processing metadata | `ai:template-compliant`, `ai:needs-structuring`, `ai:auto-generated`, `ai:reviewed` |

### Mandatory Labeling Rules

**Every page must have at minimum:**
1. One `team:` label
2. One `type:` label
3. One `status:` label

**Additional mandatory labels by context:**
- Functional and flow documents: add `phase:` (as-is, to-be, or transition)
- Environment documents: add `env:`
- Security/compliance documents: add `compliance:`
- Pages that follow the structured template: add `ai:template-compliant`

### Closed Label List

Maintain a closed list on the page **{PREFIX}-HUB / Documentation Standards / Label Taxonomy**. Authors must use only labels from this list. If they need a new one, they should request it from the Documentation Champion to maintain consistency.

---

## 3. Document Lifecycle

### States

```
DRAFT ──> IN-REVIEW ──> APPROVED ──> ARCHIVED
  ^           |              |            |
  |           |              |            v
  └───────────┘              |        OBSOLETE
     (revisions)             |
                             v
                        (new version)
```

### Using Content States in Confluence Cloud

Confluence Cloud has native **Content States**. Configure the following custom states in the space settings:

| Content State | Suggested Color | Meaning |
|---------------|----------------|---------|
| DRAFT | Gray | Document in progress, not yet reliable |
| IN-REVIEW | Yellow | Submitted for review, do not modify without coordination |
| APPROVED | Green | Reviewed and approved, source of truth |
| ARCHIVED | Blue | No longer current but preserved as historical reference |
| OBSOLETE | Red | Replaced by another version, do not use |

### Transitions

| From | To | Who | When |
|------|----|-----|------|
| DRAFT | IN-REVIEW | Author | When they consider the document complete |
| IN-REVIEW | DRAFT | Reviewer | If significant changes are required |
| IN-REVIEW | APPROVED | Approver | After satisfactory review |
| APPROVED | DRAFT | Author | When a major update is needed (creates new version) |
| APPROVED | ARCHIVED | Space Owner | When replaced by a newer version |
| APPROVED | OBSOLETE | Space Owner | When the topic no longer applies (e.g., decommissioned AS-IS component) |

---

## 4. Page Properties (Structured Metadata)

Every page must include a **Page Properties** table at the top using the Confluence macro. This table is the machine-readable metadata of the document.

### Standard Fields

| Field | Required | Description |
|-------|----------|-------------|
| Status | Yes | DRAFT / IN-REVIEW / APPROVED / ARCHIVED / OBSOLETE |
| Owner | Yes | Document owner (mention @user) |
| Approver | Yes | Who approves the document |
| Last Reviewed | Yes | Date of last review (YYYY-MM-DD) |
| Next Review | Yes | Scheduled date for next review |
| Version | Yes | Content version number (1.0, 1.1, 2.0...) |
| Phase | Conditional | AS-IS / TO-BE / Transition (only for functional docs) |
| Related Jira Epic | Optional | Link via Jira macro to the associated epic |
| Environment | Conditional | DEV / QA / STG / PROD (only for config docs) |

### Page Properties Example

```
┌─────────────────────────────────────────────────┐
│ Page Properties (Confluence macro)               │
│                                                  │
│ Status:            APPROVED                      │
│ Owner:             @maria.garcia                 │
│ Approver:          @carlos.lopez                 │
│ Last Reviewed:     2026-06-01                    │
│ Next Review:       2026-09-01                    │
│ Version:           2.0                           │
│ Phase:             TO-BE                         │
│ Jira Epic:         PROJ-1234                     │
└─────────────────────────────────────────────────┘
```

### Page Properties Report

On index pages (such as "Service Catalog" or "Functional Documentation"), use the **Page Properties Report** macro to generate automatic tables that aggregate metadata from child pages. This creates live dashboards.

---

## 5. Writing Rules

### Principles

1. **Concise and scannable**: Use lists, tables, and numbered sections. Avoid long paragraphs.
2. **Numbered and consistent sections**: Follow the corresponding template for the document type.
3. **Link, don't duplicate**: If the information exists in Jira, Figma, Swagger, or Git, link to it. Do not copy content that will fall out of sync.
4. **Editable diagrams**: Use the draw.io macro for diagrams (not static images). If an image is imported, it should be temporary and replaced by an editable diagram.
5. **No secrets or credentials**: Never include passwords, API keys, tokens, or sensitive data. Reference the path in your secrets manager (e.g., AWS Secrets Manager, HashiCorp Vault).
6. **Tables for structured data**: Requirements, business rules, configuration parameters — always in a table with clear columns.

### Formatting

- **Headings**: H1 is only for the page title (automatic). Use H2 for main sections, H3 for subsections.
- **Useful macros**: Page Properties, Table of Children, Jira Issues, Status macro (for visual badges), Expand (for optional content), Info/Warning/Note panels.
- **Design embeds**: Use the native Figma Embed macro to display designs. Do not upload screenshots from design tools.

---

## 6. Useful CQL Queries

Confluence Query Language (CQL) enables powerful searches. These queries can be saved as favorites or used in Content Report macros.

### Operational Searches

```sql
-- All drafts from the backend team (within the space)
space = "{SPACE_KEY}" AND label = "team:backend" AND label = "status:draft"

-- Functional specifications TO-BE in review
label = "type:func-spec" AND label = "phase:to-be" AND label = "status:in-review"

-- Compliance docs that are still drafts (risk)
label = "compliance:audit-required" AND label = "status:draft"

-- Production configurations
label = "type:env-config" AND label = "env:prod"

-- All deployment requests
label = "type:deployment-request" ORDER BY created DESC

-- AS-IS documents marked as obsolete
label = "phase:as-is" AND label = "status:obsolete"

-- Pending infrastructure requests
label = "type:infra-request" AND label = "status:draft" ORDER BY created DESC

-- Deployment role requests
label = "type:role-request" ORDER BY created DESC
```

### Maintenance Searches

```sql
-- Approved documents not updated in 90+ days (potentially stale)
label = "status:approved" AND lastModified < now("-90d")

-- Pages without team label (incomplete)
space = "{SPACE_KEY}" AND label NOT IN ("team:frontend")

-- AI-generated documents pending human review
label = "ai:auto-generated" AND label NOT IN ("ai:reviewed")
```

### AI Pipeline Searches

```sql
-- Documents ready for RAG ingestion
label = "ai:template-compliant" AND label = "status:approved"

-- Documents that need restructuring for AI
label = "ai:needs-structuring"
```

---

## 7. Migration of Existing Documents (Excel, PDF, Word)

### Migration Process

1. **Evaluate**: Determine if the document is AS-IS (will become obsolete) or TO-BE (active).
2. **Decide**: If it is AS-IS and will be decommissioned soon, it can remain as an attachment without migrating the content. If it is active or TO-BE, migrate it.
3. **Migrate content**: Create a Confluence page using the appropriate template. Copy/adapt the content to Confluence format.
4. **Attach original**: Upload the original file as a page attachment with a note: "Original file migrated on YYYY-MM-DD. The content of this Confluence page is the source of truth."
5. **Label**: Apply all corresponding labels, including `phase:` as applicable.
6. **Notify**: Inform the team that the document has been migrated and the original file should no longer be edited.

### Migration Priority

| Priority | Criterion |
|----------|-----------|
| High | TO-BE documents actively in use or under construction |
| Medium | Cross-cutting documents (configs, integrations) |
| Low | AS-IS documents that will be obsolete in < 3 months |
| Do not migrate | Purely historical documents with no current operational value |

---

## 8. Document Types Reference

Single source of truth for document types, templates, and default labels. Used by the `confluence-doc` agent and `/doc-confluence` skill.

| Type Key | Document Type | Template | Default Labels |
|----------|--------------|----------|---------------|
| `func-spec` | Functional Specification | `templates/func-spec.md` | `type:func-spec`, `status:draft`, `team:{team}`, `phase:{phase}` |
| `adr` | Architecture Decision Record | `templates/adr.md` | `type:adr`, `status:draft`, `team:{team}` |
| `api-spec` | API Specification | `templates/api-spec.md` | `type:api-spec`, `status:draft`, `team:backend` |
| `env-config` | Environment Configuration | `templates/env-config.md` | `type:env-config`, `status:draft`, `team:{team}`, `env:{environment}` |
| `runbook` | Operational Runbook | `templates/runbook.md` | `type:runbook`, `status:draft`, `team:{team}` |
| `security-doc` | Security/Compliance Document | `templates/security-doc.md` | `type:policy`, `status:draft`, `team:security`, `compliance:{regulation}` |
| `migration` | Migration Document | `templates/migration.md` | `type:migration`, `status:draft`, `team:{team}`, `phase:transition` |
| `test-plan` | Test Plan | `templates/test-plan.md` | `type:test-plan`, `status:draft`, `team:qa` |
| `test-strategy` | Testing Strategy | `templates/test-strategy.md` | `type:test-strategy`, `status:draft`, `team:qa` |
| `infra-request` | Infrastructure Request | `templates/infra-request.md` | `type:infra-request`, `status:draft`, `team:architecture`, `env:{environment}` |
| `role-request` | Deployment Role Request | `templates/role-request.md` | `type:role-request`, `status:draft`, `team:architecture`, `env:{environment}` |

Replace `{team}`, `{phase}`, `{environment}`, and `{regulation}` with actual values from your project context.

---

## 9. Document Quality Standards

Rules for AI-generated and manually authored Confluence documents. Referenced by the agent and skill to avoid duplication.

1. **Language**: Write in the language specified in `project-config.md`. Default to English if not specified.
2. **No invention**: Never invent technical details, business rules, or requirements. Ask the author or user for missing information.
3. **No secrets**: Never include passwords, API keys, tokens, or credentials. Reference the secrets platform path defined in `project-config.md` (e.g., "See AWS Secrets Manager: /prod/api/keys").
4. **Template fidelity**: Follow the template structure exactly — do not add or remove sections.
5. **Numbered sections**: Use numbered sections matching the template structure.
6. **Structured data**: Use tables for requirements, configurations, rules, and parameters.
7. **Placeholders**: Mark unfilled fields with `{placeholder}` syntax so the author knows what to complete.
8. **Page Properties**: Include the Page Properties table with all mandatory fields (Status, Owner, Approver, Last Review, Next Review, Version).
9. **Changelog**: Include an entry in the Changelog table with the creation or modification date.
10. **Diagrams**: Indicate where to insert draw.io macros — do not use static images.
11. **External references**: For issue trackers, use the appropriate macro (e.g., Jira Issues). For design tools, use the embed macro (e.g., Figma Embed). Link, don't duplicate.
