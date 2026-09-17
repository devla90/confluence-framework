# AI Integration Strategy — Confluence Documentation

This document defines the progressive AI integration strategy for the project's Confluence documentation system. It is designed for a Confluence Cloud environment with a 5-15 person team.

---

## Design Principles

1. **Structure first, automate second**: AI integration depends on consistent templates, metadata, and labeling. Phase 1 establishes this foundation — no automation is possible without it.
2. **Progressive automation**: Start with AI-assisted consumption (search, retrieval), then move to AI-assisted authoring, and finally AI-driven governance.
3. **Human-in-the-loop always**: AI generates drafts and suggestions. Humans review, approve, and own the content. No AI-generated content goes live without explicit human review.
4. **Incremental value**: Each phase delivers standalone value. The team does not need to commit to all 4 phases upfront.

---

## Phase 1: Foundation for AI Readability (Months 1-2)

**Goal**: Make all Confluence content machine-parseable from day one.

### What Makes Content AI-Ready

| Element | How It Helps AI | Implementation |
|---------|----------------|----------------|
| Structured templates with numbered headings | Enables section-level extraction ("give me all Business Rules from all Func Specs") | Standardized templates with consistent H2/H3 structure |
| Page Properties macro | Creates structured key-value metadata that Confluence CQL can query and AI can parse deterministically | Mandatory metadata table at the top of every page |
| Namespaced labels | Creates a filterable, faceted metadata layer for targeted retrieval | `team:`, `type:`, `status:`, `phase:`, `env:`, `tech:`, `compliance:`, `ai:` prefixes |
| Consistent naming conventions | Allows AI systems to infer document purpose from the title alone | `[PROJ-XXX] Type — Subject` pattern |
| Content States | Machine-readable lifecycle status | Confluence Cloud native feature |

### The `ai:` Label Namespace

| Label | Meaning | Who Sets It |
|-------|---------|-------------|
| `ai:template-compliant` | Page follows the structured template format and is ready for AI ingestion | Author (self-assessment) or Documentation Champion (during audit) |
| `ai:needs-structuring` | Page has valuable content but does not follow templates — needs restructuring before AI can reliably parse it | Documentation Champion (during audit) |
| `ai:auto-generated` | Page content was generated or drafted by AI | AI system (automatically applied) |
| `ai:reviewed` | AI-generated content has been reviewed and validated by a human | Human reviewer (after review) |

> **When a page is published through an MCP server**, labels cannot be set — the server
> does not expose them. `ai:auto-generated` is represented instead by a block in the page
> body carrying the token `MCP-DRAFT-PENDING-COMPLETION`, listing the labels somebody must
> apply by hand. Deleting that block, having applied them, is what corresponds to adding
> `ai:reviewed`. A stand-in, not a second vocabulary — it retires when the server supports
> labels. See `confluence-mcp.md`.

### Phase 1 Deliverables

- [ ] All templates created as Confluence Cloud Space Templates
- [ ] Page Properties macro included in all templates
- [ ] Label taxonomy published and team trained
- [ ] First batch of pages created using templates with correct labels
- [ ] `ai:template-compliant` label applied to conforming pages

---

## Phase 2: AI-Assisted Consumption (Months 2-4)

**Goal**: Use AI to help people find and understand existing documentation.

### 2.1 Confluence-to-RAG Pipeline

**Architecture**:

```
Confluence Cloud API v2
        |
        v
  Export Pipeline (scheduled)
  - Filter: label = "ai:template-compliant" AND status = "approved"
  - Extract: page content + Page Properties metadata + labels
  - Transform: split by H2 sections for granular retrieval
        |
        v
  Vector Database (e.g., Pinecone, Weaviate, pgvector)
  - Document = one H2 section of a Confluence page
  - Metadata = structured fields from Page Properties + labels
        |
        v
  RAG Application (e.g., LangChain, LlamaIndex, custom)
  - Filtered retrieval using metadata
  - LLM generates answer with source citations
```

**Key Design Decisions**:

- **Section-level chunking**: Split pages by H2 headings, not by token count. This preserves semantic boundaries. A "Business Rules" section stays intact.
- **Metadata-filtered retrieval**: Don't rely on semantic similarity alone. Use label-based pre-filtering (e.g., `type:api-spec AND team:backend`) before vector search.
- **Incremental sync**: Use `content_hash` to detect changes. Only re-index pages whose content has changed since last sync.

### 2.2 Document Metadata Schema for Vector DB

Every page ingested into the vector database should carry this metadata:

```json
{
  "page_id": "confluence-cloud-page-id",
  "space_key": "{SPACE_KEY}",
  "title": "[PROJ-BACK] API Specification — Customer Profile Service",
  "url": "https://{your-org}.atlassian.net/wiki/spaces/{SPACE_KEY}/pages/12345",
  "labels": {
    "team": "backend",
    "type": "api-spec",
    "status": "approved",
    "tech": ["service-a", "api-gateway"],
    "phase": null,
    "env": null,
    "compliance": null,
    "ai": ["template-compliant"]
  },
  "properties": {
    "status": "APPROVED",
    "owner": "jsmith",
    "approver": "mgarcia",
    "last_reviewed": "2026-05-15",
    "next_review": "2026-08-15",
    "version": "2.1",
    "service": "Customer Profile Service"
  },
  "section_title": "Business Rules & Validation",
  "section_index": 4,
  "content": "... section content ...",
  "last_modified": "2026-05-20T14:30:00Z",
  "content_hash": "sha256:abc123def456..."
}
```

> **Note**: The `team` values in `labels` are defined in your `project-config.md`. Adjust the possible values to match your project structure.

**Why this schema matters**:

- **Filtered retrieval**: "Find API specs for a specific technology" = filter `type:api-spec AND tech:{technology} AND team:backend` before vector search
- **Freshness-aware answers**: Prefer recently reviewed documents over stale ones
- **Section-level retrieval**: Answer questions from specific sections without needing to read the entire page
- **Change detection**: `content_hash` enables incremental re-indexing without full crawls

### 2.3 Smart Search Bot

Deploy an internal bot (Slack/Teams) that:

1. Accepts natural language questions from team members
2. Queries the RAG pipeline with metadata-filtered retrieval
3. Returns an answer with source page links
4. Falls back gracefully when no relevant content is found

**Example interactions**:

```
User: What are the business rules for the contact form?
Bot:  Based on [PROJ-FRONT] Func Spec — Contact Form (section 7):
      1. RN-001: The "query type" field controls visible fields per commercial area rules
      2. RN-002: Forms submitted outside business hours trigger delayed auto-response
      Source: https://{your-org}.atlassian.net/wiki/...

User: What is the SLA for the Customer Profile API?
Bot:  Based on [PROJ-BACK] API Specification — Customer Profile Service:
      - Availability: 99.9%
      - Latency p95: 200ms
      Source: https://{your-org}.atlassian.net/wiki/...
```

### 2.4 Cross-Reference Discovery

An AI agent that periodically:

1. Reads newly created/updated pages
2. Identifies related pages across different sections using semantic similarity
3. Suggests "See Also" links via Confluence comments

This breaks down silos between team sections without manual effort.

### Phase 2 Deliverables

- [ ] Confluence Cloud API export pipeline configured and scheduled
- [ ] Vector database populated with section-level documents and metadata
- [ ] RAG application answering questions with source citations
- [ ] Smart search bot deployed for internal team testing
- [ ] Cross-reference suggestions running on weekly schedule

---

## Phase 3: AI-Assisted Authoring (Months 4-8)

**Goal**: Use AI to help people write and maintain documentation.

### 3.1 Draft Generation from Jira

**Trigger**: Jira epic moves to "Ready for Development" (via Jira webhook or automation rule).

**Process**:
1. AI reads the Jira epic: title, description, acceptance criteria, linked stories
2. AI generates a draft Confluence page using the Functional Specification template
3. Pre-fills: Overview, Business Context, Scope, Functional Requirements table (from stories)
4. Labels automatically: `ai:auto-generated`, `status:draft`, `type:func-spec`, `team:{from-epic}`
5. Assigns the epic owner as page Responsible
6. Posts a comment on the Jira epic linking to the draft page

**Human review**: The author reviews the draft, corrects/enriches it, and removes `ai:auto-generated` or adds `ai:reviewed`.

### 3.2 API Documentation Sync

**Trigger**: OpenAPI spec file updated in Git (via CI/CD webhook).

**Process**:
1. Detect changes in OpenAPI spec files
2. Compare with the current Confluence API Specification page
3. Update or flag sections that may be outdated (new endpoints, changed parameters, removed operations)
4. Post a Confluence comment: "The OpenAPI spec has changed. Sections that may need updating: [list]"

**Note**: This does NOT auto-update the page content. It notifies the author of potential drift.

### 3.3 Release Notes Automation

**Trigger**: Git tag created or release branch merged.

**Process**:
1. AI reads Git commit messages and Jira resolved issues for the release
2. Groups changes by category (features, fixes, improvements)
3. Generates a draft release notes page using the Release Notes naming pattern
4. Labels: `ai:auto-generated`, `status:draft`, `type:release-note`

### 3.4 AS-IS to TO-BE Gap Analysis

**Trigger**: Manual request or when both AS-IS and TO-BE documents exist for a feature.

**Process**:
1. AI reads the AS-IS and TO-BE documents
2. Generates a draft Migration document using the Migration template
3. Pre-fills the Gap Analysis table by comparing the two documents
4. Identifies risks based on the magnitude of changes

### Phase 3 Deliverables

- [ ] Jira-to-Confluence draft generation pipeline deployed
- [ ] API spec drift detection integrated with CI/CD
- [ ] Release notes draft automation running
- [ ] Gap analysis generation available on request
- [ ] Team trained on reviewing AI-generated drafts

---

## Phase 4: AI-Driven Governance (Months 6-12)

**Goal**: AI enforces documentation standards and identifies gaps.

### 4.1 Template Compliance Checker

**Schedule**: Weekly scan of all sections.

**Process**:
1. Scan all pages in space {SPACE_KEY}
2. For each page, check:
   - Does it have the required labels? (`team:`, `type:`, `status:`)
   - Does it have a Page Properties table with mandatory fields?
   - Does the heading structure match the expected template for its `type:` label?
3. Update labels:
   - Compliant -> `ai:template-compliant`
   - Non-compliant -> `ai:needs-structuring`
4. Generate a weekly compliance report in {PREFIX}-HUB

### 4.2 Completeness Auditor

**Schedule**: Monthly.

**Process**:
1. Cross-reference the Service Catalog in {PREFIX}-BACK against deployed services (from cloud provider API/CLI)
2. Cross-reference API documentation pages against OpenAPI specs in Git
3. Cross-reference environment config pages against actual cloud environments
4. Identify undocumented services, APIs, or environments
5. Generate a completeness report with actionable items

### 4.3 Terminology Consistency

**Schedule**: Monthly or on-demand.

**Process**:
1. Read the Glossary page in {PREFIX}-HUB
2. Scan approved documents for inconsistent terminology (e.g., "client" vs. "customer", "user" vs. "end-user")
3. Flag inconsistencies via page comments

### 4.4 Stale Document Detection (Enhanced)

Beyond the basic CQL query (`lastModified < now("-90d")`), AI-enhanced stale detection:

1. Cross-references Confluence pages with Git commit history (if a service was recently changed in code but its docs weren't updated)
2. Cross-references with Jira (if an epic related to a feature was completed but the feature doc still says DRAFT)
3. Generates a prioritized "docs at risk of being stale" report

### Phase 4 Deliverables

- [ ] Template compliance checker running weekly with reports
- [ ] Completeness auditor running monthly
- [ ] Terminology consistency checker deployed
- [ ] Enhanced stale detection cross-referencing Git and Jira
- [ ] Governance dashboard in {PREFIX}-HUB updated automatically

---

## AI-Generated Content Policy

All AI-generated content in Confluence must follow these rules:

1. **Always labeled**: Every AI-generated page or section must carry the `ai:auto-generated` label
2. **Never auto-approved**: AI content starts as `status:draft`. It cannot be moved to `status:approved` without human review
3. **Review tracked**: When a human reviews and validates AI content, they add the `ai:reviewed` label
4. **Transparency**: The page should include a note (using the Info macro) at the top: "This draft was generated by AI from [source]. It requires human review before approval."
5. **Accountability**: The human who reviews and approves AI content becomes the page Responsible/Owner — they own its accuracy

---

## Technical Requirements

### Confluence Cloud API Access

- **API version**: Confluence Cloud REST API v2
- **Authentication**: API token (for scheduled jobs) or OAuth 2.0 (for interactive integrations)
- **Required scopes**: `read:confluence-content.all`, `write:confluence-content`, `read:confluence-space.summary`
- **Rate limits**: Standard Confluence Cloud limits apply — implement backoff and retry

### Infrastructure Needed

| Component | Purpose | Options |
|-----------|---------|---------|
| Vector database | Store embeddings for RAG | Pinecone, Weaviate, pgvector, ChromaDB |
| Embedding model | Generate text embeddings | OpenAI text-embedding-3-small, Cohere embed-v3, or self-hosted |
| LLM for generation | Generate answers and drafts | Claude (Anthropic), GPT-4o (OpenAI), or enterprise-approved model |
| Scheduler | Run periodic jobs (export, audit, compliance) | Cloud-native scheduler (e.g., EventBridge + Lambda), GitHub Actions, or cron |
| Webhook receiver | React to Jira/Git events | API Gateway + serverless function, or dedicated service |

### Data Flow Diagram

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  Confluence   │────>│   Export      │────>│   Vector     │
│  Cloud API    │     │   Pipeline    │     │   Database   │
└──────────────┘     └──────────────┘     └──────┬───────┘
                                                  │
┌──────────────┐     ┌──────────────┐            │
│  Jira         │────>│   Draft       │            │
│  Webhooks     │     │   Generator   │            │
└──────────────┘     └──────┬───────┘            │
                            │                      │
┌──────────────┐            v                      v
│  Git          │     ┌──────────────┐     ┌──────────────┐
│  Webhooks     │────>│  Confluence   │<────│   RAG        │
└──────────────┘     │  Cloud API    │     │   Application│
                      │  (write)      │     └──────┬───────┘
┌──────────────┐     └──────────────┘            │
│  Cloud        │                                  v
│  Provider API │────────────────────────>┌──────────────┐
└──────────────┘                          │  Smart Search │
                                          │  Bot (Slack)  │
                                          └──────────────┘
```

---

## Success Metrics

| Phase | Metric | Target |
|-------|--------|--------|
| 1 | % of pages with all required labels | > 90% by end of month 2 |
| 1 | % of pages using templates (ai:template-compliant) | > 80% by end of month 2 |
| 2 | RAG answer accuracy (human-evaluated sample) | > 80% relevant answers |
| 2 | Avg. time to find documentation (self-reported) | < 2 minutes (baseline TBD) |
| 3 | % of Func Specs started from AI draft vs. blank | > 50% by end of month 6 |
| 3 | Time from Jira epic to first draft in Confluence | < 1 hour (automated) |
| 4 | Template compliance rate (automated check) | > 95% |
| 4 | Undocumented services detected and resolved per quarter | Trending to 0 |
