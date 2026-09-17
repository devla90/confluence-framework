# Page Structure — Acme Corp Web Portal

Space: `ACMEWEB`
Prefix: `ACME`

---

## Sections

| Section | Naming Prefix | Description | Section Owner |
|---------|--------------|-------------|---------------|
| Governance Hub | `ACME-HUB` | Standards, cross-cutting docs, governance, AI initiative | Documentation Champion |
| Frontend | `ACME-FRONT` | React, WordPress CMS, components, frontend configs | Tech Lead Frontend |
| Backend & Services | `ACME-BACK` | Microservices, Lambdas, APIs, forms | Tech Lead Backend |
| UI/UX Design | `ACME-DESIGN` | Design system, guidelines, Figma, research | Design Lead |
| Business & Product | `ACME-BIZ` | Product vision, business rules, features, processes | Product Owner |
| Architecture & Cloud | `ACME-ARCH` | AWS, infrastructure, ADRs, deployments, CI/CD | Solution Architect |
| Security & Compliance | `ACME-SEC` | Security SDLC, compliance, access, audits | Security Lead |
| QA & Testing | `ACME-QA` | Testing strategy, test plans, automation, quality metrics | QA Lead |

> **Security**: The "Security & Compliance" root page must have **Page Restrictions** applied. Confluence Cloud inherits restrictions to child pages. Restrict to: security team + architects + tech leads.

---

## Full Page Tree

```
Home (ACMEWEB — Welcome page with links to all sections)
│
├── Governance Hub
│   ├── Project Overview
│   │   ├── Project Charter and Objectives
│   │   ├── Team Directory and Contacts
│   │   ├── Onboarding Guide
│   │   └── Glossary
│   ├── Documentation Standards
│   │   ├── How to Write Documentation (Style Guide)
│   │   ├── Naming Conventions
│   │   ├── Label Taxonomy
│   │   ├── Template Catalog
│   │   ├── Decision Guide — What Goes in Confluence
│   │   └── Document Lifecycle Policy
│   ├── Cross-Cutting Documentation
│   │   ├── Global Configurations
│   │   │   ├── Secrets Management Policy
│   │   │   ├── Shared Environment Variables
│   │   │   └── Cross-Component Configuration Map
│   │   ├── Environment Matrix
│   │   │   ├── DEV Environment
│   │   │   ├── QA Environment
│   │   │   ├── STG Environment
│   │   │   └── PROD Environment
│   │   ├── Integration Map
│   │   │   ├── System-to-System Dependencies
│   │   │   ├── API Contracts Registry (index)
│   │   │   └── Data Flow Diagrams
│   │   └── AS-IS to TO-BE Transition
│   │       ├── Migration Status Dashboard
│   │       ├── AS-IS Component Inventory
│   │       └── TO-BE Component Mapping
│   ├── Releases and Deployments
│   │   ├── Release Calendar
│   │   ├── Release Notes Archive
│   │   │   └── [YYYY-MM] Release vX.Y.Z
│   │   └── Deployment Runbooks (index linking to Architecture section)
│   ├── Governance and Reviews
│   │   ├── Documentation Review Calendar
│   │   ├── Quarterly Audit Log
│   │   └── Change Log (structural changes to the doc system)
│   └── AI Documentation Initiative
│       ├── AI Integration Roadmap
│       ├── Automation Inventory
│       └── AI-Generated Content Policy
│
├── Frontend
│   ├── Architecture and Stack
│   │   ├── React Application Architecture
│   │   ├── WordPress CMS Architecture
│   │   ├── Technical Decisions (ADRs)
│   │   └── Component Library Reference
│   ├── Environment Configuration
│   │   ├── Local Development Setup
│   │   ├── DEV Environment Config
│   │   ├── QA Environment Config
│   │   ├── STG Environment Config
│   │   └── PROD Environment Config
│   ├── Functional Documentation
│   │   ├── [Module/Feature Name]
│   │   │   ├── Functional Specification
│   │   │   ├── AS-IS Flow
│   │   │   ├── TO-BE Flow
│   │   │   └── Implementation Notes
│   │   └── ... (repeat per module)
│   ├── Technical Guides
│   │   ├── Build and Deployment Process
│   │   ├── Code Standards
│   │   ├── Testing Strategy
│   │   ├── Performance Guidelines
│   │   ├── Accessibility Compliance
│   │   └── Analytics Implementation
│   ├── Runbooks
│   │   ├── Incident Response — Frontend
│   │   └── Common Troubleshooting
│   └── Knowledge Base
│       ├── Decision Log
│       └── Lessons Learned
│
├── Backend & Services
│   ├── Architecture and Stack
│   │   ├── Microservices Overview
│   │   ├── Lambda Functions Catalog
│   │   ├── API Gateway Configuration
│   │   └── Technical Decisions (ADRs)
│   ├── API Documentation
│   │   ├── [Service Name] API
│   │   │   ├── API Specification (or link to Swagger/OpenAPI)
│   │   │   ├── Request-Response Examples
│   │   │   ├── Error Codes and Handling
│   │   │   └── Rate Limits and SLAs
│   │   └── ... (repeat per service)
│   ├── Service Catalog
│   │   ├── [Service Name]
│   │   │   ├── Service Overview
│   │   │   ├── Data Model
│   │   │   ├── Dependencies and Integrations
│   │   │   ├── Environment Configuration
│   │   │   └── Deployment Guide
│   │   └── ... (repeat per service)
│   ├── Forms Microservices
│   │   ├── Forms Processing Architecture
│   │   ├── [Form Name] Specification
│   │   └── Validation Rules Reference
│   ├── Functional Documentation
│   │   ├── [Functional Area]
│   │   │   ├── Functional Specification
│   │   │   ├── AS-IS Flow
│   │   │   └── TO-BE Flow
│   │   └── ...
│   ├── Runbooks
│   │   ├── Incident Response — Backend
│   │   └── Common Troubleshooting
│   └── Knowledge Base
│       ├── Decision Log
│       └── Lessons Learned
│
├── UI/UX Design
│   ├── Design System
│   │   ├── Design Principles
│   │   ├── Brand Guidelines Reference
│   │   ├── Component Pattern Library
│   │   │   ├── [Component Name] — Usage Guide
│   │   │   └── ...
│   │   └── Accessibility Standards
│   ├── Design Deliverables Index
│   │   ├── [Feature/Page Name]
│   │   │   ├── Design Brief
│   │   │   ├── Figma Links and Embeds
│   │   │   ├── Interaction Specifications
│   │   │   └── Design Review Notes
│   │   └── ...
│   ├── User Research
│   │   ├── Research Plan
│   │   ├── Persona Definitions
│   │   ├── Usability Test Results
│   │   └── User Journey Maps
│   └── Knowledge Base
│       ├── Design Decision Log
│       └── Lessons Learned
│
├── Business & Product
│   ├── Product Vision and Strategy
│   │   ├── Product Roadmap (high level)
│   │   ├── Business Objectives and KPIs
│   │   └── Stakeholder Map
│   ├── Business Definitions
│   │   ├── Business Process Catalog
│   │   ├── Business Rules Reference
│   │   ├── Regulatory Requirements
│   │   └── Data Dictionary (business terms)
│   ├── Feature Documentation
│   │   ├── [Epic/Feature Name]
│   │   │   ├── Business Context and Requirements
│   │   │   ├── User Story Map (link to issue tracker filter)
│   │   │   ├── Acceptance Criteria Summary
│   │   │   ├── AS-IS Business Process
│   │   │   └── TO-BE Business Process
│   │   └── ...
│   ├── Analytics and Metrics
│   │   ├── Analytics Implementation Guide (GTM, GA4)
│   │   └── KPI Dashboard Links
│   └── Knowledge Base
│       ├── Business Decision Log
│       └── Lessons Learned
│
├── Architecture & Cloud
│   ├── Architecture Overview
│   │   ├── Solution Architecture Document (SAD)
│   │   ├── High-Level Architecture Diagram
│   │   ├── Architecture Decision Records (ADRs)
│   │   │   └── ADR-NNNN — [Decision Title]
│   │   └── Non-Functional Requirements
│   ├── AWS Infrastructure
│   │   ├── Account Structure and Organization
│   │   ├── Network Architecture (VPC, subnets)
│   │   ├── IAM Roles and Policies
│   │   │   ├── [Role Name] — Definition and Justification
│   │   │   └── Deployment Role Requests
│   │   │       └── [YYYY-MM-DD] Role Request — [Description]
│   │   ├── AWS Service Catalog
│   │   │   ├── CloudFront Configuration
│   │   │   ├── S3 Bucket Inventory
│   │   │   ├── Lambda Deployment Configuration
│   │   │   ├── API Gateway Setup
│   │   │   ├── RDS/DynamoDB Configuration
│   │   │   └── ... (per AWS service used)
│   │   └── Cost Management and Tagging Strategy
│   ├── Infrastructure Requests
│   │   ├── Infrastructure Request Process
│   │   ├── Request Registry
│   │   │   └── [YYYY-MM-DD] Infra Request — [Description]
│   │   └── Provisioned Resources Inventory
│   ├── Cloud Deployments
│   │   ├── CI/CD Pipeline Architecture
│   │   ├── Deployment Request Log
│   │   │   └── [YYYY-MM-DD] Deployment Request — [Description]
│   │   ├── Infrastructure-as-Code Reference
│   │   └── Environment Provisioning Guides
│   ├── Monitoring and Observability
│   │   ├── Monitoring Strategy
│   │   ├── Alert Configuration
│   │   ├── Logging Architecture
│   │   └── Dashboard Links
│   └── Knowledge Base
│       ├── Architecture Decision Log
│       └── Lessons Learned
│
├── Security & Compliance
│   │
│   │   > **Page Restrictions**: Apply read restriction on this root page.
│   │   > Confluence Cloud inherits restrictions to child pages.
│   │   > Access: security team + architects + tech leads.
│   │
│   ├── Security SDLC
│   │   ├── Secure Development Lifecycle Policy
│   │   ├── Security Requirements Checklist
│   │   ├── Code Review Checklist (Security)
│   │   └── Dependency Vulnerability Policy
│   ├── Cybersecurity Documentation
│   │   ├── Threat Model
│   │   ├── Security Architecture
│   │   ├── Penetration Test Reports
│   │   │   └── [YYYY-QN] Pen Test — [Scope]
│   │   ├── Vulnerability Assessment Log
│   │   └── Security Incident Reports
│   ├── Compliance and Audit
│   │   ├── Regulatory Compliance Matrix
│   │   ├── Audit Trail Documentation
│   │   ├── Data Privacy (GDPR / Local Regulation)
│   │   └── Audit Reports Archive
│   ├── Access Management
│   │   ├── Role-Based Access Control (RBAC) Matrix
│   │   ├── Service Account Inventory
│   │   └── Access Review Calendar
│   └── Certificates and Renewals
│       ├── SSL/TLS Certificate Inventory
│       └── Renewal Calendar
│
└── QA & Testing
    ├── QA Strategy
    │   ├── Overall Testing Strategy
    │   ├── Test Types and Tools
    │   ├── Automation Strategy
    │   └── Quality Criteria and Metrics
    ├── Test Plans
    │   ├── [Feature/Sprint] — Test Plan
    │   └── ... (repeat per test cycle)
    ├── QA Environments
    │   ├── QA Environment Configuration
    │   ├── Test Data and Management
    │   └── Compatibility Matrix (browsers, devices)
    ├── Reports and Metrics
    │   ├── Defect Dashboard (link to issue tracker dashboard)
    │   ├── Test Coverage Reports
    │   └── Quality Retrospectives
    ├── Test Automation
    │   ├── Framework and Tools (Selenium/Cypress/Playwright)
    │   ├── Framework Setup Guide
    │   ├── Automation Coverage (metrics)
    │   └── Automation Technical Decisions (ADRs)
    ├── Guides and Processes
    │   ├── How to Report a Defect (guide for devs)
    │   ├── Regression Process
    │   ├── Pre-Deploy Test Checklist
    │   └── Accessibility Testing Guide
    └── Knowledge Base
        ├── QA Decision Log
        └── Lessons Learned
```

---

## Space Configuration

1. **Home page**: Create with links to all 8 main sections (use Table of Children macro)
2. **Root sections**: Create the 8 first-level pages as parent pages for each frente
3. **Templates**: Configure all 11 templates as Space Templates in ACMEWEB
4. **Initial labels**: Add `team:{team}` to each section's root page
5. **Page Restrictions**: Apply read restriction on the "Security & Compliance" root page — Confluence inherits the restriction to all child pages
6. **Sidebar**: Organize shortcuts to the 8 main sections

---

## Migration to Multi-Space (future)

If the project grows and frentes need to be separated into their own spaces:

1. Create the new space in Confluence (e.g., `ACME-FRONT`)
2. Move the pages from the "Frontend" section to the new space (native Confluence: select page > Move)
3. Titles already have the correct prefix (`[ACME-FRONT] Func Spec — ...`) — no renaming needed
4. Labels already identify the team (`team:frontend`) — no re-labeling needed
5. Replicate templates as Space Templates in the new space
6. Update permissions: configure Space Permissions instead of Page Restrictions
