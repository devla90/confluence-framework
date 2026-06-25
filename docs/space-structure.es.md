<!-- Versión fuente: 2026-06-25 -->
# Modelo de espacio único con secciones por dominio

## Espacio único con secciones por dominio

El proyecto utiliza **un único espacio de Confluence** (`{SPACE_KEY}`) organizado en **8 secciones raíz**, una por cada dominio del proyecto. Cada sección tiene su propia estructura de páginas y un Section Owner responsable de ella.

> **Adapta las secciones a tu proyecto en `project-config.md`.** Los dominios que se muestran a continuación (Frontend, Backend, UI/UX, etc.) son un patrón por defecto para proyectos de aplicaciones web. Agrega, elimina o renombra secciones para que coincidan con la estructura real de tu equipo.

### Por qué un único espacio con secciones

- **Simplicidad**: Un equipo de 5 a 15 personas no necesita la complejidad de 8 espacios separados.
- **Administración**: Un único espacio es más fácil de configurar, mantener y respaldar.
- **Búsqueda**: Todas las páginas viven en un mismo espacio — la búsqueda interna del espacio funciona sin filtros adicionales.
- **Plantillas**: Las 11 Space Templates se configuran una sola vez en `{SPACE_KEY}`.

### Nomenclatura preparada para la migración

Los títulos de las páginas usan prefijos que identifican el dominio: `[{PREFIX}-FRONT]`, `[{PREFIX}-BACK]`, etc. Estos prefijos **no son claves de espacio (space keys)** — son convenciones de nomenclatura que permiten:
- Identificar el dominio de cada página en las búsquedas globales de Confluence
- Migrar páginas a sus propios espacios en el futuro **sin tener que renombrar nada**

> Si en el futuro decides separar un dominio en su propio espacio (por ejemplo, `{PREFIX}-FRONT`), los títulos y las labels ya están preparados. Solo tienes que mover las páginas. Consulta "Migración a Multi-Espacio" al final.

---

## Secciones del espacio {SPACE_KEY}

| Sección | Prefijo de nomenclatura | Descripción | Section Owner sugerido |
|---------|--------------|-------------|------------------------|
| Governance Hub | `{PREFIX}-HUB` | Estándares, documentación transversal, gobernanza, iniciativa de IA | Documentation Champion |
| Frontend | `{PREFIX}-FRONT` | Aplicación frontend, componentes, configuraciones | Frontend Tech Lead |
| Backend & Services | `{PREFIX}-BACK` | Servicios, APIs, procesamiento de datos | Backend Tech Lead |
| UI/UX Design | `{PREFIX}-DESIGN` | Design system, lineamientos, prototipos, research | Design Lead |
| Business & Product | `{PREFIX}-BIZ` | Visión de producto, reglas de negocio, features, procesos | Product Owner |
| Architecture & Cloud | `{PREFIX}-ARCH` | Infraestructura, ADRs, despliegues, CI/CD | Solution Architect |
| Security & Compliance | `{PREFIX}-SEC` | Security SDLC, compliance, control de acceso, auditorías | Security Lead |
| QA & Testing | `{PREFIX}-QA` | Estrategia de testing, planes de prueba, automatización, métricas de calidad | QA Lead |

> **Seguridad**: La sección "Security & Compliance" debe tener **Page Restrictions** configuradas en su página raíz. Confluence Cloud hereda las restricciones a las páginas hijas. Restringe el acceso a: equipo de seguridad + arquitectos + tech leads.

---

## Árbol completo de páginas

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

## Configuración del espacio {SPACE_KEY}

Al configurar el espacio, aplica lo siguiente:

1. **Home page**: Créala con enlaces a las 8 secciones principales (usa la macro Table of Children)
2. **Secciones raíz**: Crea las 8 páginas de nivel superior como "páginas padre" para cada dominio
3. **Plantillas**: Configura las 11 plantillas como Space Templates del espacio `{SPACE_KEY}`
4. **Labels iniciales**: Agrega `team:{team}` a la página raíz de cada sección
5. **Page Restrictions**: Aplica restricción de lectura en la página raíz de "Security & Compliance" — Confluence hereda la restricción a todas las sub-páginas
6. **Sidebar**: Organiza accesos directos a las 8 secciones principales

---

## Migración a Multi-Espacio (futuro)

Si el proyecto crece y necesitas separar dominios en sus propios espacios:

1. **Crea el nuevo espacio** en Confluence (por ejemplo, `{PREFIX}-FRONT`)
2. **Mueve las páginas** de la sección "Frontend" al nuevo espacio (función nativa de Confluence: selecciona la página > Move)
3. **Los títulos ya tienen el prefijo correcto** (`[{PREFIX}-FRONT] Func Spec — ...`) — no es necesario renombrar
4. **Las labels ya identifican al equipo** (`team:frontend`) — no es necesario reetiquetar
5. **Replica las plantillas** como Space Templates en el nuevo espacio
6. **Actualiza los permisos**: Si el nuevo espacio es Security, configura Space Permissions en lugar de Page Restrictions
7. **Actualiza este documento** para reflejar el nuevo modelo

> Esta migración no es destructiva y puede realizarse de forma incremental — un dominio a la vez, sin afectar al resto.
