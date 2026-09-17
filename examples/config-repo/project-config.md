# Project Configuration — Acme Corp Web Portal

> Filled example. What each section means: `../../docs/customization-guide.md`.

---

## Identity

| Field | Value |
|-------|-------|
| Project name | Acme Corp Web Portal |
| Organization | Acme Corp |
| Naming prefix | ACME |
| Confluence space key | ACMEWEB |
| Confluence URL | https://acme-corp.atlassian.net/wiki |
| Documentation language | english |
| Team size | 8-12 |

## Paths

| Field | Value |
|-------|-------|
| Framework path | ../confluence-framework |
| Output path | ./output |

## Frentes (Sections)

| Front | Suffix | Technologies | Section Owner | Team Label |
|-------|--------|-------------|---------------|------------|
| Frontend | FRONT | Next.js, Tailwind CSS | Tech Lead Frontend | team:frontend |
| Backend | BACK | Node.js, Express, PostgreSQL | Tech Lead Backend | team:backend |
| Design | DESIGN | Figma, Storybook | Design Lead | team:design |
| Architecture | ARCH | AWS (ECS, RDS, CloudFront, S3) | Solution Architect | team:architecture |
| QA & Testing | QA | Playwright, Jest | QA Lead | team:qa |

## Code Repositories

| Front | Suffix | Local path | Description |
|-------|--------|-----------|-------------|
| Frontend | FRONT | ../acme-web-portal | Next.js storefront |
| Backend | BACK | ../acme-api | Express REST API |
| Design | DESIGN | | No code — Figma only |
| Architecture | ARCH | ../acme-infra | Terraform for AWS |
| QA & Testing | QA | ../acme-e2e | Playwright suite |

## Technology Labels

| Label | Description |
|-------|-------------|
| tech:nextjs | Frontend framework |
| tech:tailwind | CSS framework |
| tech:nodejs | Backend runtime |
| tech:postgresql | Relational database |
| tech:ecs | Container orchestration |
| tech:rds | Managed database |
| tech:cloudfront | CDN |
| tech:s3 | Object storage |

## Secrets Platform

| Field | Value |
|-------|-------|
| Tool | AWS Secrets Manager |
| Reference format in docs | See AWS Secrets Manager: {path} |

## Tools

| Tool | Purpose |
|------|---------|
| Jira | Task management and backlog |
| Figma | UI/UX design |
| GitHub | Source code |
| draw.io | Architecture and flow diagrams |

## Overrides

None.
