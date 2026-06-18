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
+-- Governance Hub
|   |
|   +-- Project Overview
|   |   +-- Project Charter and Objectives
|   |   +-- Team Directory and Contacts
|   |   +-- Onboarding Guide
|   |   +-- Glossary of Terms
|   |
|   +-- Documentation Standards
|   |   +-- How to Write Documentation (Style Guide)
|   |   +-- Naming Conventions
|   |   +-- Label Taxonomy
|   |   +-- Template Catalog
|   |   +-- Decision Guide — What Goes in Confluence
|   |   +-- Document Lifecycle Policy
|   |
|   +-- Cross-Cutting Documentation
|   |   +-- Global Configurations
|   |   |   +-- Secrets Management Policy
|   |   |   +-- Shared Environment Variables
|   |   |   +-- Configuration Map Across Components
|   |   +-- Environment Matrix
|   |   |   +-- DEV Environment
|   |   |   +-- QA Environment
|   |   |   +-- STG Environment
|   |   |   +-- PROD Environment
|   |   +-- Integration Map
|   |   |   +-- System-to-System Dependencies
|   |   |   +-- API Contract Registry (index)
|   |   |   +-- Data Flow Diagrams
|   |   +-- AS-IS to TO-BE Transition
|   |       +-- Migration Status Dashboard
|   |       +-- AS-IS Component Inventory
|   |       +-- TO-BE Component Mapping
|   |
|   +-- Releases and Deployments
|   |   +-- Release Calendar
|   |   +-- Release Notes Archive
|   |   |   +-- [YYYY-MM] Release vX.Y.Z
|   |   +-- Deployment Runbooks (index linking to Architecture section)
|   |
|   +-- Governance and Reviews
|   |   +-- Documentation Review Calendar
|   |   +-- Quarterly Audit Log
|   |   +-- Change Log (structural changes to the docs system)
|   |
|   +-- AI Documentation Initiative
|       +-- AI Integration Roadmap
|       +-- Automation Inventory
|       +-- AI-Generated Content Policy
|
|
+-- Frontend
|   |
|   +-- Architecture and Stack
|   |   +-- Application Architecture Overview
|   |   +-- Module: {Module Name} — Architecture
|   |   +-- Technical Decisions (ADRs)
|   |   +-- Component Library Reference
|   |
|   +-- Environment Configuration
|   |   +-- Local Development Setup
|   |   +-- DEV Environment Configuration
|   |   +-- QA Environment Configuration
|   |   +-- STG Environment Configuration
|   |   +-- PROD Environment Configuration
|   |
|   +-- Functional Documentation
|   |   +-- Module: {Module Name}
|   |   |   +-- Functional Specification
|   |   |   +-- AS-IS Flow
|   |   |   +-- TO-BE Flow
|   |   |   +-- Implementation Notes
|   |   +-- ... (repeats per module)
|   |
|   +-- Technical Guides
|   |   +-- Build and Deployment Process
|   |   +-- Coding Standards
|   |   +-- Testing Strategy
|   |   +-- Performance Guidelines
|   |   +-- Accessibility Compliance
|   |
|   +-- Runbooks
|   |   +-- Incident Response — Frontend
|   |   +-- Common Troubleshooting
|   |
|   +-- Knowledge Base
|       +-- Decision Log
|       +-- Lessons Learned
|
|
+-- Backend & Services
|   |
|   +-- Architecture and Stack
|   |   +-- Services Overview
|   |   +-- Service Catalog Summary
|   |   +-- API Gateway Configuration
|   |   +-- Technical Decisions (ADRs)
|   |
|   +-- API Documentation
|   |   +-- Service: {Service Name} API
|   |   |   +-- API Specification (or link to Swagger/OpenAPI)
|   |   |   +-- Request-Response Examples
|   |   |   +-- Error Codes and Handling
|   |   |   +-- Rate Limits and SLAs
|   |   +-- ... (repeats per service)
|   |
|   +-- Service Catalog
|   |   +-- Service: {Service Name}
|   |   |   +-- Service Overview
|   |   |   +-- Data Model
|   |   |   +-- Dependencies and Integrations
|   |   |   +-- Environment Configuration
|   |   |   +-- Deployment Guide
|   |   +-- ... (repeats per service)
|   |
|   +-- Domain-Specific Services
|   |   +-- {Domain} Processing Architecture
|   |   +-- Service: {Service Name} Specification
|   |   +-- Validation Rules Reference
|   |
|   +-- Functional Documentation
|   |   +-- {Functional Area}
|   |   |   +-- Functional Specification
|   |   |   +-- AS-IS Flow
|   |   |   +-- TO-BE Flow
|   |   +-- ...
|   |
|   +-- Runbooks
|   |   +-- Incident Response — Backend
|   |   +-- Common Troubleshooting
|   |
|   +-- Knowledge Base
|       +-- Decision Log
|       +-- Lessons Learned
|
|
+-- UI/UX Design
|   |
|   +-- Design System
|   |   +-- Design Principles
|   |   +-- Brand Guidelines Reference
|   |   +-- Component Pattern Library
|   |   |   +-- Component: {Component Name} — Usage Guide
|   |   |   +-- ...
|   |   +-- Accessibility Standards
|   |
|   +-- Design Deliverables Index
|   |   +-- Feature: {Feature/Page Name}
|   |   |   +-- Design Brief
|   |   |   +-- Prototype Links and Embeds
|   |   |   +-- Interaction Specifications
|   |   |   +-- Design Review Notes
|   |   +-- ...
|   |
|   +-- User Research
|   |   +-- Research Plan
|   |   +-- Persona Definitions
|   |   +-- Usability Testing Results
|   |   +-- User Journey Maps
|   |
|   +-- Knowledge Base
|       +-- Design Decision Log
|       +-- Lessons Learned
|
|
+-- Business & Product
|   |
|   +-- Product Vision and Strategy
|   |   +-- Product Roadmap (high level)
|   |   +-- Business Objectives and KPIs
|   |   +-- Stakeholder Map
|   |
|   +-- Business Definitions
|   |   +-- Business Process Catalog
|   |   +-- Business Rules Reference
|   |   +-- Regulatory Requirements
|   |   +-- Data Dictionary (business terms)
|   |
|   +-- Feature Documentation
|   |   +-- Epic: {Epic/Feature Name}
|   |   |   +-- Business Context and Requirements
|   |   |   +-- User Story Map (link to issue tracker filter)
|   |   |   +-- Acceptance Criteria Summary
|   |   |   +-- Business Process AS-IS
|   |   |   +-- Business Process TO-BE
|   |   +-- ...
|   |
|   +-- Analytics and Metrics
|   |   +-- Analytics Implementation Guide
|   |   +-- KPI Dashboard Links
|   |
|   +-- Knowledge Base
|       +-- Business Decision Log
|       +-- Lessons Learned
|
|
+-- Architecture & Cloud
|   |
|   +-- Architecture Overview
|   |   +-- Solution Architecture Document (SAD)
|   |   +-- High-Level Architecture Diagram
|   |   +-- Architecture Decision Records (ADRs)
|   |   |   +-- ADR-NNNN — {Decision Title}
|   |   +-- Non-Functional Requirements
|   |
|   +-- Cloud Infrastructure
|   |   +-- Account Structure and Organization
|   |   +-- Network Architecture (VPC, subnets)
|   |   +-- IAM Roles and Policies
|   |   |   +-- Role: {Role Name} — Definition and Justification
|   |   |   +-- Deployment Role Requests
|   |   |       +-- [YYYY-MM-DD] Role Request — {Description}
|   |   +-- Cloud Service Catalog
|   |   |   +-- Service: {Cloud Service Name} Configuration
|   |   |   +-- ... (per cloud service used)
|   |   +-- Cost Management and Tagging Strategy
|   |
|   +-- Infrastructure Requests
|   |   +-- Infrastructure Request Process
|   |   +-- Request Registry
|   |   |   +-- [YYYY-MM-DD] Infra Request — {Description}
|   |   +-- Provisioned Resource Inventory
|   |
|   +-- Cloud Deployments
|   |   +-- CI/CD Pipeline Architecture
|   |   +-- Deployment Request Log
|   |   |   +-- [YYYY-MM-DD] Deployment Request — {Description}
|   |   +-- Infrastructure-as-Code Reference
|   |   +-- Environment Provisioning Guides
|   |
|   +-- Monitoring and Observability
|   |   +-- Monitoring Strategy
|   |   +-- Alert Configuration
|   |   +-- Logging Architecture
|   |   +-- Dashboard Links
|   |
|   +-- Knowledge Base
|       +-- Architecture Decision Log
|       +-- Lessons Learned
|
|
+-- Security & Compliance
|   |
|   |   > **Page Restrictions**: Apply read restriction on this root page.
|   |   > Confluence Cloud inherits restrictions to child pages.
|   |   > Access: security team + architects + tech leads.
|   |
|   +-- Security SDLC
|   |   +-- Secure Development Lifecycle Policy
|   |   +-- Security Requirements Checklist
|   |   +-- Code Review Checklist (Security)
|   |   +-- Dependency Vulnerability Policy
|   |
|   +-- Cybersecurity Documentation
|   |   +-- Threat Model
|   |   +-- Security Architecture
|   |   +-- Penetration Test Reports
|   |   |   +-- [YYYY-QN] Pen Test — {Scope}
|   |   +-- Vulnerability Assessment Log
|   |   +-- Security Incident Reports
|   |
|   +-- Compliance and Audit
|   |   +-- Regulatory Compliance Matrix
|   |   +-- Audit Trail Documentation
|   |   +-- Data Privacy (GDPR / Local Regulation)
|   |   +-- Audit Report Archive
|   |
|   +-- Access Management
|   |   +-- Role-Based Access Control (RBAC) Matrix
|   |   +-- Service Account Inventory
|   |   +-- Access Review Calendar
|   |
|   +-- Certificates and Renewals
|       +-- SSL/TLS Certificate Inventory
|       +-- Renewal Calendar
|
|
+-- QA & Testing
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
