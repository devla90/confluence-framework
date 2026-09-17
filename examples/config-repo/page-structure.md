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
├── [ACME-HUB] Governance Hub
│   ├── [ACME-HUB] Project Overview
│   │   ├── [ACME-HUB] Project Charter and Objectives
│   │   ├── [ACME-HUB] Team Directory and Contacts
│   │   ├── [ACME-HUB] Onboarding Guide
│   │   └── [ACME-HUB] Glossary
│   ├── [ACME-HUB] Documentation Standards
│   │   ├── [ACME-HUB] How to Write Documentation (Style Guide)
│   │   ├── [ACME-HUB] Naming Conventions
│   │   ├── [ACME-HUB] Label Taxonomy
│   │   ├── [ACME-HUB] Template Catalog
│   │   ├── [ACME-HUB] Decision Guide — What Goes in Confluence
│   │   └── [ACME-HUB] Document Lifecycle Policy
│   ├── [ACME-HUB] Cross-Cutting Documentation
│   │   ├── [ACME-HUB] Global Configurations
│   │   │   ├── [ACME-HUB] Secrets Management Policy
│   │   │   ├── [ACME-HUB] Shared Environment Variables
│   │   │   └── [ACME-HUB] Cross-Component Configuration Map
│   │   ├── [ACME-HUB] Environment Matrix
│   │   │   ├── [ACME-HUB] DEV Environment
│   │   │   ├── [ACME-HUB] QA Environment
│   │   │   ├── [ACME-HUB] STG Environment
│   │   │   └── [ACME-HUB] PROD Environment
│   │   ├── [ACME-HUB] Integration Map
│   │   │   ├── [ACME-HUB] System-to-System Dependencies
│   │   │   ├── [ACME-HUB] API Contracts Registry (index)
│   │   │   └── [ACME-HUB] Data Flow Diagrams
│   │   └── [ACME-HUB] AS-IS to TO-BE Transition
│   │       ├── [ACME-HUB] Migration Status Dashboard
│   │       ├── [ACME-HUB] AS-IS Component Inventory
│   │       └── [ACME-HUB] TO-BE Component Mapping
│   ├── [ACME-HUB] Releases and Deployments
│   │   ├── [ACME-HUB] Release Calendar
│   │   ├── [ACME-HUB] Release Notes Archive
│   │   │   └── [ACME-HUB] Release vX.Y.Z
│   │   └── [ACME-HUB] Deployment Runbooks (index linking to Architecture section)
│   ├── [ACME-HUB] Governance and Reviews
│   │   ├── [ACME-HUB] Documentation Review Calendar
│   │   ├── [ACME-HUB] Quarterly Audit Log
│   │   └── [ACME-HUB] Change Log (structural changes to the doc system)
│   └── [ACME-HUB] AI Documentation Initiative
│       ├── [ACME-HUB] AI Integration Roadmap
│       ├── [ACME-HUB] Automation Inventory
│       └── [ACME-HUB] AI-Generated Content Policy
│
├── [ACME-FRONT] Frontend
│   ├── [ACME-FRONT] Architecture and Stack
│   │   ├── [ACME-FRONT] React Application Architecture
│   │   ├── [ACME-FRONT] WordPress CMS Architecture
│   │   ├── [ACME-FRONT] Technical Decisions (ADRs)
│   │   └── [ACME-FRONT] Component Library Reference
│   ├── [ACME-FRONT] Environment Configuration
│   │   ├── [ACME-FRONT] Local Development Setup
│   │   ├── [ACME-FRONT] DEV Environment Config
│   │   ├── [ACME-FRONT] QA Environment Config
│   │   ├── [ACME-FRONT] STG Environment Config
│   │   └── [ACME-FRONT] PROD Environment Config
│   ├── [ACME-FRONT] Functional Documentation
│   │   ├── [ACME-FRONT] [Module/Feature Name]
│   │   │   ├── [ACME-FRONT] Functional Specification
│   │   │   ├── [ACME-FRONT] AS-IS Flow
│   │   │   ├── [ACME-FRONT] TO-BE Flow
│   │   │   └── [ACME-FRONT] Implementation Notes
│   │   └── ... (repeat per module)
│   ├── [ACME-FRONT] Technical Guides
│   │   ├── [ACME-FRONT] Build and Deployment Process
│   │   ├── [ACME-FRONT] Code Standards
│   │   ├── [ACME-FRONT] Testing Strategy
│   │   ├── [ACME-FRONT] Performance Guidelines
│   │   ├── [ACME-FRONT] Accessibility Compliance
│   │   └── [ACME-FRONT] Analytics Implementation
│   ├── [ACME-FRONT] Runbooks
│   │   ├── [ACME-FRONT] Incident Response — Frontend
│   │   └── [ACME-FRONT] Common Troubleshooting
│   └── [ACME-FRONT] Knowledge Base
│       └── [ACME-FRONT] Lessons Learned
│
├── [ACME-BACK] Backend & Services
│   ├── [ACME-BACK] Architecture and Stack
│   │   ├── [ACME-BACK] Microservices Overview
│   │   ├── [ACME-BACK] Lambda Functions Catalog
│   │   ├── [ACME-BACK] API Gateway Configuration
│   │   └── [ACME-BACK] Technical Decisions (ADRs)
│   ├── [ACME-BACK] API Documentation
│   │   ├── [ACME-BACK] [Service Name] API
│   │   │   ├── [ACME-BACK] API Specification (or link to Swagger/OpenAPI)
│   │   │   ├── [ACME-BACK] Request-Response Examples
│   │   │   ├── [ACME-BACK] Error Codes and Handling
│   │   │   └── [ACME-BACK] Rate Limits and SLAs
│   │   └── ... (repeat per service)
│   ├── [ACME-BACK] Service Catalog
│   │   ├── [ACME-BACK] [Service Name]
│   │   │   ├── [ACME-BACK] Service Overview
│   │   │   ├── [ACME-BACK] Data Model
│   │   │   ├── [ACME-BACK] Dependencies and Integrations
│   │   │   ├── [ACME-BACK] Environment Configuration
│   │   │   └── [ACME-BACK] Deployment Guide
│   │   └── ... (repeat per service)
│   ├── [ACME-BACK] Forms Microservices
│   │   ├── [ACME-BACK] Forms Processing Architecture
│   │   ├── [ACME-BACK] [Form Name] Specification
│   │   └── [ACME-BACK] Validation Rules Reference
│   ├── [ACME-BACK] Functional Documentation
│   │   ├── [ACME-BACK] [Functional Area]
│   │   │   ├── [ACME-BACK] Functional Specification
│   │   │   ├── [ACME-BACK] AS-IS Flow
│   │   │   └── [ACME-BACK] TO-BE Flow
│   │   └── ...
│   ├── [ACME-BACK] Runbooks
│   │   ├── [ACME-BACK] Incident Response — Backend
│   │   └── [ACME-BACK] Common Troubleshooting
│   └── [ACME-BACK] Knowledge Base
│       └── [ACME-BACK] Lessons Learned
│
├── [ACME-DESIGN] UI/UX Design
│   ├── [ACME-DESIGN] Design System
│   │   ├── [ACME-DESIGN] Design Principles
│   │   ├── [ACME-DESIGN] Brand Guidelines Reference
│   │   ├── [ACME-DESIGN] Component Pattern Library
│   │   │   ├── [ACME-DESIGN] [Component Name] — Usage Guide
│   │   │   └── ...
│   │   └── [ACME-DESIGN] Accessibility Standards
│   ├── [ACME-DESIGN] Design Deliverables Index
│   │   ├── [ACME-DESIGN] [Feature/Page Name]
│   │   │   ├── [ACME-DESIGN] Design Brief
│   │   │   ├── [ACME-DESIGN] Figma Links and Embeds
│   │   │   ├── [ACME-DESIGN] Interaction Specifications
│   │   │   └── [ACME-DESIGN] Design Review Notes
│   │   └── ...
│   ├── [ACME-DESIGN] User Research
│   │   ├── [ACME-DESIGN] Research Plan
│   │   ├── [ACME-DESIGN] Persona Definitions
│   │   ├── [ACME-DESIGN] Usability Test Results
│   │   └── [ACME-DESIGN] User Journey Maps
│   └── [ACME-DESIGN] Knowledge Base
│       ├── [ACME-DESIGN] Design Decisions (ADRs)
│       └── [ACME-DESIGN] Lessons Learned
│
├── [ACME-BIZ] Business & Product
│   ├── [ACME-BIZ] Product Vision and Strategy
│   │   ├── [ACME-BIZ] Product Roadmap (high level)
│   │   ├── [ACME-BIZ] Business Objectives and KPIs
│   │   └── [ACME-BIZ] Stakeholder Map
│   ├── [ACME-BIZ] Business Definitions
│   │   ├── [ACME-BIZ] Business Process Catalog
│   │   ├── [ACME-BIZ] Business Rules Reference
│   │   ├── [ACME-BIZ] Regulatory Requirements
│   │   └── [ACME-BIZ] Data Dictionary (business terms)
│   ├── [ACME-BIZ] Feature Documentation
│   │   ├── [ACME-BIZ] [Epic/Feature Name]
│   │   │   ├── [ACME-BIZ] Business Context and Requirements
│   │   │   ├── [ACME-BIZ] User Story Map (link to issue tracker filter)
│   │   │   ├── [ACME-BIZ] Acceptance Criteria Summary
│   │   │   ├── [ACME-BIZ] AS-IS Business Process
│   │   │   └── [ACME-BIZ] TO-BE Business Process
│   │   └── ...
│   ├── [ACME-BIZ] Analytics and Metrics
│   │   ├── [ACME-BIZ] Analytics Implementation Guide (GTM, GA4)
│   │   └── [ACME-BIZ] KPI Dashboard Links
│   └── [ACME-BIZ] Knowledge Base
│       ├── [ACME-BIZ] Business Decisions (ADRs)
│       └── [ACME-BIZ] Lessons Learned
│
├── [ACME-ARCH] Architecture & Cloud
│   ├── [ACME-ARCH] Architecture Overview
│   │   ├── [ACME-ARCH] Solution Architecture Document (SAD)
│   │   ├── [ACME-ARCH] High-Level Architecture Diagram
│   │   ├── [ACME-ARCH] Architecture Decision Records (ADRs)
│   │   │   └── [ACME-ARCH] ADR-NNNN — [Decision Title]
│   │   └── [ACME-ARCH] Non-Functional Requirements
│   ├── [ACME-ARCH] AWS Infrastructure
│   │   ├── [ACME-ARCH] Account Structure and Organization
│   │   ├── [ACME-ARCH] Network Architecture (VPC, subnets)
│   │   ├── [ACME-ARCH] IAM Roles and Policies
│   │   │   ├── [ACME-ARCH] [Role Name] — Definition and Justification
│   │   │   └── [ACME-ARCH] Deployment Role Requests
│   │   │       └── [ACME-ARCH] Role Request — [Description]
│   │   ├── [ACME-ARCH] AWS Service Catalog
│   │   │   ├── [ACME-ARCH] CloudFront Configuration
│   │   │   ├── [ACME-ARCH] S3 Bucket Inventory
│   │   │   ├── [ACME-ARCH] Lambda Deployment Configuration
│   │   │   ├── [ACME-ARCH] API Gateway Setup
│   │   │   ├── [ACME-ARCH] RDS/DynamoDB Configuration
│   │   │   └── ... (per AWS service used)
│   │   └── [ACME-ARCH] Cost Management and Tagging Strategy
│   ├── [ACME-ARCH] Infrastructure Requests
│   │   ├── [ACME-ARCH] Infrastructure Request Process
│   │   ├── [ACME-ARCH] Request Registry
│   │   │   └── [ACME-ARCH] Infra Request — [Description]
│   │   └── [ACME-ARCH] Provisioned Resources Inventory
│   ├── [ACME-ARCH] Cloud Deployments
│   │   ├── [ACME-ARCH] CI/CD Pipeline Architecture
│   │   ├── [ACME-ARCH] Deployment Request Log
│   │   │   └── [ACME-ARCH] Deployment Request — [Description]
│   │   ├── [ACME-ARCH] Infrastructure-as-Code Reference
│   │   └── [ACME-ARCH] Environment Provisioning Guides
│   ├── [ACME-ARCH] Monitoring and Observability
│   │   ├── [ACME-ARCH] Monitoring Strategy
│   │   ├── [ACME-ARCH] Alert Configuration
│   │   ├── [ACME-ARCH] Logging Architecture
│   │   └── [ACME-ARCH] Dashboard Links
│   └── [ACME-ARCH] Knowledge Base
│       └── [ACME-ARCH] Lessons Learned
│
├── [ACME-SEC] Security & Compliance
│   │
│   │   > **Page Restrictions**: Apply read restriction on this root page.
│   │   > Confluence Cloud inherits restrictions to child pages.
│   │   > Access: security team + architects + tech leads.
│   │
│   ├── [ACME-SEC] Security SDLC
│   │   ├── [ACME-SEC] Secure Development Lifecycle Policy
│   │   ├── [ACME-SEC] Security Requirements Checklist
│   │   ├── [ACME-SEC] Code Review Checklist (Security)
│   │   └── [ACME-SEC] Dependency Vulnerability Policy
│   ├── [ACME-SEC] Cybersecurity Documentation
│   │   ├── [ACME-SEC] Threat Model
│   │   ├── [ACME-SEC] Security Architecture
│   │   ├── [ACME-SEC] Penetration Test Reports
│   │   │   └── [ACME-SEC] Pen Test — [Scope]
│   │   ├── [ACME-SEC] Vulnerability Assessment Log
│   │   └── [ACME-SEC] Security Incident Reports
│   ├── [ACME-SEC] Compliance and Audit
│   │   ├── [ACME-SEC] Regulatory Compliance Matrix
│   │   ├── [ACME-SEC] Audit Trail Documentation
│   │   ├── [ACME-SEC] Data Privacy (GDPR / Local Regulation)
│   │   └── [ACME-SEC] Audit Reports Archive
│   ├── [ACME-SEC] Access Management
│   │   ├── [ACME-SEC] Role-Based Access Control (RBAC) Matrix
│   │   ├── [ACME-SEC] Service Account Inventory
│   │   └── [ACME-SEC] Access Review Calendar
│   └── [ACME-SEC] Certificates and Renewals
│       ├── [ACME-SEC] SSL/TLS Certificate Inventory
│       └── [ACME-SEC] Renewal Calendar
│
└── [ACME-QA] QA & Testing
    ├── [ACME-QA] QA Strategy
    │   ├── [ACME-QA] Overall Testing Strategy
    │   ├── [ACME-QA] Test Types and Tools
    │   ├── [ACME-QA] Automation Strategy
    │   └── [ACME-QA] Quality Criteria and Metrics
    ├── [ACME-QA] Test Plans
    │   ├── [ACME-QA] [Feature/Sprint] — Test Plan
    │   └── ... (repeat per test cycle)
    ├── [ACME-QA] QA Environments
    │   ├── [ACME-QA] QA Environment Configuration
    │   ├── [ACME-QA] Test Data and Management
    │   └── [ACME-QA] Compatibility Matrix (browsers, devices)
    ├── [ACME-QA] Reports and Metrics
    │   ├── [ACME-QA] Defect Dashboard (link to issue tracker dashboard)
    │   ├── [ACME-QA] Test Coverage Reports
    │   └── [ACME-QA] Quality Retrospectives
    ├── [ACME-QA] Test Automation
    │   ├── [ACME-QA] Framework and Tools (Selenium/Cypress/Playwright)
    │   ├── [ACME-QA] Framework Setup Guide
    │   ├── [ACME-QA] Automation Coverage (metrics)
    │   └── [ACME-QA] Automation Technical Decisions (ADRs)
    ├── [ACME-QA] Guides and Processes
    │   ├── [ACME-QA] How to Report a Defect (guide for devs)
    │   ├── [ACME-QA] Regression Process
    │   ├── [ACME-QA] Pre-Deploy Test Checklist
    │   └── [ACME-QA] Accessibility Testing Guide
    └── [ACME-QA] Knowledge Base
        ├── [ACME-QA] QA Decisions (ADRs)
        └── [ACME-QA] Lessons Learned
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
