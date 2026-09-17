# [{PREFIX}-{SUFFIX}] ENV-{ENVIRONMENT} — {Technology/Component}

> **Default labels**: `type:env-config`, `status:draft`, `team:{team}`, `env:{dev|qa|stg|prod}`
>
> **Ask the user for**: Environment (DEV/QA/STG/PROD), technology/component, main parameters
> **Look for in the source**: `.env.example`, config files, IaC (Terraform/CDK/docker-compose), deployment manifests

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Environment** | DEV / QA / STG / PROD |
| **Owner** | @owner |
| **Last Verification** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |

---

## 1. Environment Overview

**Purpose**: What this environment is used for (development, testing, staging, production).

**URLs / Endpoints**:

| Service | URL | Notes |
|---------|-----|-------|
| Web Application | | |
| API | | |
| CMS | | |
| Monitoring | | |

**How to obtain access**: Description of the process to request access to this environment.

## 2. Configuration Parameters

> **IMPORTANT**: Never include secret values in this table. For sensitive parameters, indicate the path in {secrets_platform}.

| Parameter | Value | Description | Secret? |
|-----------|-------|-------------|---------|
| NODE_ENV | production | Execution mode | No |
| API_URL | https://api.example.com | API base URL | No |
| DB_HOST | — | Database host | Yes → {secrets_platform}: `/{project}/{env}/db/host` |
| DB_PASSWORD | — | Database password | Yes → {secrets_platform}: `/{project}/{env}/db/password` |
| API_KEY_EXTERNAL | — | External service key | Yes → {secrets_platform}: `/{project}/{env}/external/api-key` |

> The path format is: `/{project}/{environment}/{service}/{parameter}`

## 3. Infrastructure Resources

| Resource | Type | Identifier | Region | Notes |
|----------|------|------------|--------|-------|
| | EC2 / Lambda / S3 / RDS / CloudFront / API GW | ARN or ID | | |

## 4. Access and Permissions

| Role | Who has access | Access type | How to request |
|------|---------------|-------------|----------------|
| Developer | Development team | Read + Deploy | Request from Tech Lead |
| DevOps | Infrastructure team | Full | — |
| QA | Testing team | Read | Request from Tech Lead |

## 5. Known Differences vs Production

> *Complete only for environments that are NOT PROD. List intentional differences.*

| Aspect | This Environment | Production | Reason for difference |
|--------|-----------------|------------|----------------------|
| Instances | 1 | 3 | Cost savings in dev |
| CDN | Disabled | CloudFront | Not needed for testing |
| Data | Synthetic data | Real data | Data regulation |

## 6. Troubleshooting

Common problems specific to this environment and how to resolve them.

| Problem | Probable Cause | Solution |
|---------|---------------|----------|
| | | |
