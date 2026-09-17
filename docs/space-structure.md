# Single-Space Model with Domain Sections

## Single Space with Domain Sections

The project uses **a single Confluence space** (`{SPACE_KEY}`) organized into **8 root sections**, one for each project domain. Each section has its own page structure and a Section Owner responsible for it.

> **Adapt sections to your project in `project-config.md`.** The domains below (Frontend, Backend, UI/UX, etc.) are a default pattern for web-application projects. Add, remove, or rename sections to match your actual team structure.

### Why a single space with sections

- **Simplicity**: A team of 5-15 people does not need the complexity of 8 separate spaces.
- **Administration**: A single space is easier to configure, maintain, and back up.
- **Search**: All pages live in one space — the space's internal search works without additional filters.
- **Templates**: The 11 Space Templates are configured once in `{SPACE_KEY}`.

### Naming prepared for migration

Page titles use prefixes that identify the domain: `[{PREFIX}-FRONT]`, `[{PREFIX}-BACK]`, etc. These prefixes **are not space keys** — they are naming conventions that enable:
- Identifying the domain of each page in global Confluence searches
- Migrating pages to their own spaces in the future **without renaming anything**

> If in the future you decide to split a domain into its own space (e.g., `{PREFIX}-FRONT`), the titles and labels are already prepared. You just move the pages. See "Migration to Multi-Space" at the end.

---

## Sections of the {SPACE_KEY} Space

| Section | Naming prefix | Description | Suggested Section Owner |
|---------|--------------|-------------|------------------------|
| Governance Hub | `{PREFIX}-HUB` | Standards, cross-cutting documentation, governance, AI initiative | Documentation Champion |
| Frontend | `{PREFIX}-FRONT` | Frontend application, components, configurations | Frontend Tech Lead |
| Backend & Services | `{PREFIX}-BACK` | Services, APIs, data processing | Backend Tech Lead |
| UI/UX Design | `{PREFIX}-DESIGN` | Design system, guidelines, prototypes, research | Design Lead |
| Business & Product | `{PREFIX}-BIZ` | Product vision, business rules, features, processes | Product Owner |
| Architecture & Cloud | `{PREFIX}-ARCH` | Infrastructure, ADRs, deployments, CI/CD | Solution Architect |
| Security & Compliance | `{PREFIX}-SEC` | Security SDLC, compliance, access control, audits | Security Lead |
| QA & Testing | `{PREFIX}-QA` | Testing strategy, test plans, automation, quality metrics | QA Lead |

> **Security**: The "Security & Compliance" section must have **Page Restrictions** configured on its root page. Confluence Cloud inherits restrictions to child pages. Restrict access to: security team + architects + tech leads.

---

## Full Page Tree

```
Home ({SPACE_KEY} — Welcome page with links to all sections)
|
|
+-- [{PREFIX}-HUB] Governance Hub
|   |
|   +-- [{PREFIX}-HUB] Project Overview
|   |   +-- [{PREFIX}-HUB] Project Charter and Objectives
|   |   +-- [{PREFIX}-HUB] Team Directory and Contacts
|   |   +-- [{PREFIX}-HUB] Onboarding Guide
|   |   +-- [{PREFIX}-HUB] Glossary of Terms
|   |
|   +-- [{PREFIX}-HUB] Documentation Standards
|   |   +-- [{PREFIX}-HUB] How to Write Documentation (Style Guide)
|   |   +-- [{PREFIX}-HUB] Naming Conventions
|   |   +-- [{PREFIX}-HUB] Label Taxonomy
|   |   +-- [{PREFIX}-HUB] Template Catalog
|   |   +-- [{PREFIX}-HUB] Decision Guide — What Goes in Confluence
|   |   +-- [{PREFIX}-HUB] Document Lifecycle Policy
|   |
|   +-- [{PREFIX}-HUB] Cross-Cutting Documentation
|   |   +-- [{PREFIX}-HUB] Global Configurations
|   |   |   +-- [{PREFIX}-HUB] Secrets Management Policy
|   |   |   +-- [{PREFIX}-HUB] Shared Environment Variables
|   |   |   +-- [{PREFIX}-HUB] Configuration Map Across Components
|   |   +-- [{PREFIX}-HUB] Environment Matrix
|   |   |   +-- [{PREFIX}-HUB] DEV Environment
|   |   |   +-- [{PREFIX}-HUB] QA Environment
|   |   |   +-- [{PREFIX}-HUB] STG Environment
|   |   |   +-- [{PREFIX}-HUB] PROD Environment
|   |   +-- [{PREFIX}-HUB] Integration Map
|   |   |   +-- [{PREFIX}-HUB] System-to-System Dependencies
|   |   |   +-- [{PREFIX}-HUB] API Contract Registry (index)
|   |   |   +-- [{PREFIX}-HUB] Data Flow Diagrams
|   |   +-- [{PREFIX}-HUB] AS-IS to TO-BE Transition
|   |       +-- [{PREFIX}-HUB] Migration Status Dashboard
|   |       +-- [{PREFIX}-HUB] AS-IS Component Inventory
|   |       +-- [{PREFIX}-HUB] TO-BE Component Mapping
|   |
|   +-- [{PREFIX}-HUB] Releases and Deployments
|   |   +-- [{PREFIX}-HUB] Release Calendar
|   |   +-- [{PREFIX}-HUB] Release Notes Archive
|   |   |   +-- [{PREFIX}-HUB] RN YYYY-MM-DD — vX.Y.Z
|   |   +-- [{PREFIX}-HUB] Deployment Runbooks (index linking to Architecture section)
|   |
|   +-- [{PREFIX}-HUB] Governance and Reviews
|   |   +-- [{PREFIX}-HUB] Documentation Review Calendar
|   |   +-- [{PREFIX}-HUB] Quarterly Audit Log
|   |   +-- [{PREFIX}-HUB] Change Log (structural changes to the docs system)
|   |
|   +-- [{PREFIX}-HUB] AI Documentation Initiative
|       +-- [{PREFIX}-HUB] AI Integration Roadmap
|       +-- [{PREFIX}-HUB] Automation Inventory
|       +-- [{PREFIX}-HUB] AI-Generated Content Policy
|
|
+-- [{PREFIX}-FRONT] Frontend
|   |
|   +-- [{PREFIX}-FRONT] Architecture and Stack
|   |   +-- [{PREFIX}-FRONT] Application Architecture Overview
|   |   +-- [{PREFIX}-FRONT] Module: {Module Name} — Architecture
|   |   +-- [{PREFIX}-FRONT] Technical Decisions (ADRs)
|   |   +-- [{PREFIX}-FRONT] Component Library Reference
|   |
|   +-- [{PREFIX}-FRONT] Environment Configuration
|   |   +-- [{PREFIX}-FRONT] Local Development Setup
|   |   +-- [{PREFIX}-FRONT] DEV Environment Configuration
|   |   +-- [{PREFIX}-FRONT] QA Environment Configuration
|   |   +-- [{PREFIX}-FRONT] STG Environment Configuration
|   |   +-- [{PREFIX}-FRONT] PROD Environment Configuration
|   |
|   +-- [{PREFIX}-FRONT] Functional Documentation
|   |   +-- [{PREFIX}-FRONT] Module: {Module Name}
|   |   |   +-- [{PREFIX}-FRONT] Functional Specification
|   |   |   +-- [{PREFIX}-FRONT] AS-IS Flow
|   |   |   +-- [{PREFIX}-FRONT] TO-BE Flow
|   |   |   +-- [{PREFIX}-FRONT] Implementation Notes
|   |   +-- ... (repeats per module)
|   |
|   +-- [{PREFIX}-FRONT] Technical Guides
|   |   +-- [{PREFIX}-FRONT] Build and Deployment Process
|   |   +-- [{PREFIX}-FRONT] Coding Standards
|   |   +-- [{PREFIX}-FRONT] Testing Strategy
|   |   +-- [{PREFIX}-FRONT] Performance Guidelines
|   |   +-- [{PREFIX}-FRONT] Accessibility Compliance
|   |
|   +-- [{PREFIX}-FRONT] Runbooks
|   |   +-- [{PREFIX}-FRONT] Incident Response — Frontend
|   |   +-- [{PREFIX}-FRONT] Common Troubleshooting
|   |
|   +-- [{PREFIX}-FRONT] Knowledge Base
|       +-- [{PREFIX}-FRONT] Decision Log
|       +-- [{PREFIX}-FRONT] Lessons Learned
|
|
+-- [{PREFIX}-BACK] Backend & Services
|   |
|   +-- [{PREFIX}-BACK] Architecture and Stack
|   |   +-- [{PREFIX}-BACK] Services Overview
|   |   +-- [{PREFIX}-BACK] Service Catalog Summary
|   |   +-- [{PREFIX}-BACK] API Gateway Configuration
|   |   +-- [{PREFIX}-BACK] Technical Decisions (ADRs)
|   |
|   +-- [{PREFIX}-BACK] API Documentation
|   |   +-- [{PREFIX}-BACK] Service: {Service Name} API
|   |   |   +-- [{PREFIX}-BACK] API Specification (or link to Swagger/OpenAPI)
|   |   |   +-- [{PREFIX}-BACK] Request-Response Examples
|   |   |   +-- [{PREFIX}-BACK] Error Codes and Handling
|   |   |   +-- [{PREFIX}-BACK] Rate Limits and SLAs
|   |   +-- ... (repeats per service)
|   |
|   +-- [{PREFIX}-BACK] Service Catalog
|   |   +-- [{PREFIX}-BACK] Service: {Service Name}
|   |   |   +-- [{PREFIX}-BACK] Service Overview
|   |   |   +-- [{PREFIX}-BACK] Data Model
|   |   |   +-- [{PREFIX}-BACK] Dependencies and Integrations
|   |   |   +-- [{PREFIX}-BACK] Environment Configuration
|   |   |   +-- [{PREFIX}-BACK] Deployment Guide
|   |   +-- ... (repeats per service)
|   |
|   +-- [{PREFIX}-BACK] Domain-Specific Services
|   |   +-- [{PREFIX}-BACK] {Domain} Processing Architecture
|   |   +-- [{PREFIX}-BACK] Service: {Service Name} Specification
|   |   +-- [{PREFIX}-BACK] Validation Rules Reference
|   |
|   +-- [{PREFIX}-BACK] Functional Documentation
|   |   +-- [{PREFIX}-BACK] {Functional Area}
|   |   |   +-- [{PREFIX}-BACK] Functional Specification
|   |   |   +-- [{PREFIX}-BACK] AS-IS Flow
|   |   |   +-- [{PREFIX}-BACK] TO-BE Flow
|   |   +-- ...
|   |
|   +-- [{PREFIX}-BACK] Runbooks
|   |   +-- [{PREFIX}-BACK] Incident Response — Backend
|   |   +-- [{PREFIX}-BACK] Common Troubleshooting
|   |
|   +-- [{PREFIX}-BACK] Knowledge Base
|       +-- [{PREFIX}-BACK] Decision Log
|       +-- [{PREFIX}-BACK] Lessons Learned
|
|
+-- [{PREFIX}-DESIGN] UI/UX Design
|   |
|   +-- [{PREFIX}-DESIGN] Design System
|   |   +-- [{PREFIX}-DESIGN] Design Principles
|   |   +-- [{PREFIX}-DESIGN] Brand Guidelines Reference
|   |   +-- [{PREFIX}-DESIGN] Component Pattern Library
|   |   |   +-- [{PREFIX}-DESIGN] Component: {Component Name} — Usage Guide
|   |   |   +-- ...
|   |   +-- [{PREFIX}-DESIGN] Accessibility Standards
|   |
|   +-- [{PREFIX}-DESIGN] Design Deliverables Index
|   |   +-- [{PREFIX}-DESIGN] Feature: {Feature/Page Name}
|   |   |   +-- [{PREFIX}-DESIGN] Design Brief
|   |   |   +-- [{PREFIX}-DESIGN] Prototype Links and Embeds
|   |   |   +-- [{PREFIX}-DESIGN] Interaction Specifications
|   |   |   +-- [{PREFIX}-DESIGN] Design Review Notes
|   |   +-- ...
|   |
|   +-- [{PREFIX}-DESIGN] User Research
|   |   +-- [{PREFIX}-DESIGN] Research Plan
|   |   +-- [{PREFIX}-DESIGN] Persona Definitions
|   |   +-- [{PREFIX}-DESIGN] Usability Testing Results
|   |   +-- [{PREFIX}-DESIGN] User Journey Maps
|   |
|   +-- [{PREFIX}-DESIGN] Knowledge Base
|       +-- [{PREFIX}-DESIGN] Design Decision Log
|       +-- [{PREFIX}-DESIGN] Lessons Learned
|
|
+-- [{PREFIX}-BIZ] Business & Product
|   |
|   +-- [{PREFIX}-BIZ] Product Vision and Strategy
|   |   +-- [{PREFIX}-BIZ] Product Roadmap (high level)
|   |   +-- [{PREFIX}-BIZ] Business Objectives and KPIs
|   |   +-- [{PREFIX}-BIZ] Stakeholder Map
|   |
|   +-- [{PREFIX}-BIZ] Business Definitions
|   |   +-- [{PREFIX}-BIZ] Business Process Catalog
|   |   +-- [{PREFIX}-BIZ] Business Rules Reference
|   |   +-- [{PREFIX}-BIZ] Regulatory Requirements
|   |   +-- [{PREFIX}-BIZ] Data Dictionary (business terms)
|   |
|   +-- [{PREFIX}-BIZ] Feature Documentation
|   |   +-- [{PREFIX}-BIZ] Epic: {Epic/Feature Name}
|   |   |   +-- [{PREFIX}-BIZ] Business Context and Requirements
|   |   |   +-- [{PREFIX}-BIZ] User Story Map (link to issue tracker filter)
|   |   |   +-- [{PREFIX}-BIZ] Acceptance Criteria Summary
|   |   |   +-- [{PREFIX}-BIZ] Business Process AS-IS
|   |   |   +-- [{PREFIX}-BIZ] Business Process TO-BE
|   |   +-- ...
|   |
|   +-- [{PREFIX}-BIZ] Analytics and Metrics
|   |   +-- [{PREFIX}-BIZ] Analytics Implementation Guide
|   |   +-- [{PREFIX}-BIZ] KPI Dashboard Links
|   |
|   +-- [{PREFIX}-BIZ] Knowledge Base
|       +-- [{PREFIX}-BIZ] Business Decision Log
|       +-- [{PREFIX}-BIZ] Lessons Learned
|
|
+-- [{PREFIX}-ARCH] Architecture & Cloud
|   |
|   +-- [{PREFIX}-ARCH] Architecture Overview
|   |   +-- [{PREFIX}-ARCH] Solution Architecture Document (SAD)
|   |   +-- [{PREFIX}-ARCH] High-Level Architecture Diagram
|   |   +-- [{PREFIX}-ARCH] Architecture Decision Records (ADRs)
|   |   |   +-- [{PREFIX}-ARCH] ADR-NNNN — {Decision Title}
|   |   +-- [{PREFIX}-ARCH] Non-Functional Requirements
|   |
|   +-- [{PREFIX}-ARCH] Cloud Infrastructure
|   |   +-- [{PREFIX}-ARCH] Account Structure and Organization
|   |   +-- [{PREFIX}-ARCH] Network Architecture (VPC, subnets)
|   |   +-- [{PREFIX}-ARCH] IAM Roles and Policies
|   |   |   +-- [{PREFIX}-ARCH] Role: {Role Name} — Definition and Justification
|   |   |   +-- [{PREFIX}-ARCH] Deployment Role Requests
|   |   |       +-- [{PREFIX}-ARCH] Role Request — {Description}
|   |   +-- [{PREFIX}-ARCH] Cloud Service Catalog
|   |   |   +-- [{PREFIX}-ARCH] Service: {Cloud Service Name} Configuration
|   |   |   +-- ... (per cloud service used)
|   |   +-- [{PREFIX}-ARCH] Cost Management and Tagging Strategy
|   |
|   +-- [{PREFIX}-ARCH] Infrastructure Requests
|   |   +-- [{PREFIX}-ARCH] Infrastructure Request Process
|   |   +-- [{PREFIX}-ARCH] Request Registry
|   |   |   +-- [{PREFIX}-ARCH] Infra Request — {Description}
|   |   +-- [{PREFIX}-ARCH] Provisioned Resource Inventory
|   |
|   +-- [{PREFIX}-ARCH] Cloud Deployments
|   |   +-- [{PREFIX}-ARCH] CI/CD Pipeline Architecture
|   |   +-- [{PREFIX}-ARCH] Deployment Request Log
|   |   |   +-- [{PREFIX}-ARCH] DR YYYY-MM-DD — {Description}
|   |   +-- [{PREFIX}-ARCH] Infrastructure-as-Code Reference
|   |   +-- [{PREFIX}-ARCH] Environment Provisioning Guides
|   |
|   +-- [{PREFIX}-ARCH] Monitoring and Observability
|   |   +-- [{PREFIX}-ARCH] Monitoring Strategy
|   |   +-- [{PREFIX}-ARCH] Alert Configuration
|   |   +-- [{PREFIX}-ARCH] Logging Architecture
|   |   +-- [{PREFIX}-ARCH] Dashboard Links
|   |
|   +-- [{PREFIX}-ARCH] Knowledge Base
|       +-- [{PREFIX}-ARCH] Architecture Decision Log
|       +-- [{PREFIX}-ARCH] Lessons Learned
|
|
+-- [{PREFIX}-SEC] Security & Compliance
|   |
|   |   > **Page Restrictions**: Apply read restriction on this root page.
|   |   > Confluence Cloud inherits restrictions to child pages.
|   |   > Access: security team + architects + tech leads.
|   |
|   +-- [{PREFIX}-SEC] Security SDLC
|   |   +-- [{PREFIX}-SEC] Secure Development Lifecycle Policy
|   |   +-- [{PREFIX}-SEC] Security Requirements Checklist
|   |   +-- [{PREFIX}-SEC] Code Review Checklist (Security)
|   |   +-- [{PREFIX}-SEC] Dependency Vulnerability Policy
|   |
|   +-- [{PREFIX}-SEC] Cybersecurity Documentation
|   |   +-- [{PREFIX}-SEC] Threat Model
|   |   +-- [{PREFIX}-SEC] Security Architecture
|   |   +-- [{PREFIX}-SEC] Penetration Test Reports
|   |   |   +-- [{PREFIX}-SEC] Pen Test — {Scope}
|   |   +-- [{PREFIX}-SEC] Vulnerability Assessment Log
|   |   +-- [{PREFIX}-SEC] Security Incident Reports
|   |
|   +-- [{PREFIX}-SEC] Compliance and Audit
|   |   +-- [{PREFIX}-SEC] Regulatory Compliance Matrix
|   |   +-- [{PREFIX}-SEC] Audit Trail Documentation
|   |   +-- [{PREFIX}-SEC] Data Privacy (GDPR / Local Regulation)
|   |   +-- [{PREFIX}-SEC] Audit Report Archive
|   |
|   +-- [{PREFIX}-SEC] Access Management
|   |   +-- [{PREFIX}-SEC] Role-Based Access Control (RBAC) Matrix
|   |   +-- [{PREFIX}-SEC] Service Account Inventory
|   |   +-- [{PREFIX}-SEC] Access Review Calendar
|   |
|   +-- [{PREFIX}-SEC] Certificates and Renewals
|       +-- [{PREFIX}-SEC] SSL/TLS Certificate Inventory
|       +-- [{PREFIX}-SEC] Renewal Calendar
|
|
+-- [{PREFIX}-QA] QA & Testing
    |
    +-- QA Strategy
    |   +-- Overall Testing Strategy
    |   +-- Test Types and Tools
    |   +-- Automation Strategy
    |   +-- Quality Criteria and Metrics
    |
    +-- Test Plans
    |   +-- {Feature/Sprint} — Test Plan
    |   +-- ... (repeats per test cycle)
    |
    +-- QA Environments
    |   +-- QA Environment Configuration
    |   +-- Test Data and Management
    |   +-- Compatibility Matrix (browsers, devices)
    |
    +-- Reports and Metrics
    |   +-- Defect Dashboard (link to issue tracker dashboard)
    |   +-- Test Coverage Reports
    |   +-- Quality Retrospectives
    |
    +-- Test Automation
    |   +-- Framework and Tools
    |   +-- Framework Setup Guide
    |   +-- Automation Coverage (metrics)
    |   +-- Automation Technical Decisions (ADRs)
    |
    +-- Guides and Processes
    |   +-- How to Report a Defect (guide for devs)
    |   +-- Regression Process
    |   +-- Pre-Deploy Testing Checklist
    |   +-- Accessibility Testing Guide
    |
    +-- Knowledge Base
        +-- QA Decision Log
        +-- Lessons Learned
```

---

## {SPACE_KEY} Space Configuration

When configuring the space, apply the following:

1. **Home page**: Create with links to the 8 main sections (use the Table of Children macro)
2. **Root sections**: Create the 8 top-level pages as "parent pages" for each domain
3. **Templates**: Configure the 11 templates as Space Templates of the `{SPACE_KEY}` space
4. **Initial labels**: Add `team:{team}` to the root page of each section
5. **Page Restrictions**: Apply read restriction on the "Security & Compliance" root page — Confluence inherits the restriction to all sub-pages
6. **Sidebar**: Organize shortcuts to the 8 main sections

---

## Migration to Multi-Space (future)

If the project grows and you need to split domains into their own spaces:

1. **Create the new space** in Confluence (e.g., `{PREFIX}-FRONT`)
2. **Move the pages** from the "Frontend" section to the new space (native Confluence feature: select page > Move)
3. **The titles already have the correct prefix** (`[{PREFIX}-FRONT] Func Spec — ...`) — no renaming needed
4. **The labels already identify the team** (`team:frontend`) — no re-labeling needed
5. **Replicate the templates** as Space Templates in the new space
6. **Update permissions**: If the new space is Security, configure Space Permissions instead of Page Restrictions
7. **Update this document** to reflect the new model

> This migration is non-destructive and can be done incrementally — one domain at a time, without affecting the rest.
