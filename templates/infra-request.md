# [{PREFIX}-{SUFFIX}] Infrastructure Request — {Resource Description}

> **Default labels**: `type:infra-request`, `status:draft`, `team:architecture`, `env:{environment}`
>
> **Ask the user for**: Cloud resource type, proposed name, environment, region, justification (the feature or service requiring it), technical specifications, security requirements, target team
> **Look for in the source**: IaC, existing resource definitions, deployment manifests

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | REQUESTED / IN REVIEW / APPROVED / PROVISIONED / REJECTED |
| **Requester** | @requester |
| **Approver** | @architect / @tech-lead |
| **Target Team** | Internal / External (Infra Support {company}) |
| **Request Date** | YYYY-MM-DD |
| **Estimated Delivery Date** | YYYY-MM-DD |
| **Environment** | DEV / QA / STG / PROD |
| **Priority** | High / Medium / Low |
| **Version** | 1.0 |

---

## 1. What is Requested

| Field | Detail |
|-------|--------|
| AWS resource type | {EKS / S3 / Lambda / RDS / DynamoDB / CloudFront / API Gateway / SQS / SNS / other} |
| Proposed name | {resource name following project naming conventions} |
| Environment | {DEV / QA / STG / PROD} |
| Region | {us-east-1 / sa-east-1 / other} |
| Purpose | {brief description of what it will be used for} |

## 2. Justification

Why this resource is needed. What feature, service, or requirement justifies it.

| Field | Detail |
|-------|--------|
| Feature/Service that requires it | {name} |
| Related Jira Epic | {PREFIX}-XXXX (link via Jira macro) |
| What happens if not provisioned | {project impact} |
| Alternatives considered | {were other options evaluated? why were they discarded?} |

## 3. Technical Specifications

> *Complete according to the resource type. Remove rows that do not apply.*

| Parameter | Requested Value | Notes |
|-----------|----------------|-------|
| **General** | | |
| Resource name | | Follow naming conventions |
| Required tags | | Project, Environment, Team, CostCenter |
| | | |
| **Compute (EKS/EC2/Lambda)** | | |
| Instance type/size | | e.g.: t3.medium, m5.large |
| Number of nodes/replicas | | |
| Memory / CPU | | |
| Auto-scaling (min/max) | | |
| Runtime (Lambda) | | e.g.: Node.js 18, Python 3.11 |
| Timeout (Lambda) | | |
| | | |
| **Storage (S3/EBS/EFS)** | | |
| Estimated capacity | | |
| Storage class | | e.g.: S3 Standard, S3-IA, gp3 |
| Retention policy | | |
| Versioning | | Yes / No |
| | | |
| **Database (RDS/DynamoDB)** | | |
| Engine and version | | e.g.: PostgreSQL 15, MySQL 8 |
| Instance type | | e.g.: db.t3.medium |
| Initial storage | | |
| Multi-AZ | | Yes / No |
| Backups (retention) | | e.g.: 7 days |
| | | |
| **Networking (VPC/ALB/CloudFront)** | | |
| VPC / Subnet | | |
| Required Security Groups | | |
| Exposed port(s) | | |
| Domain / CNAME | | |

## 4. Security Requirements

| Requirement | Detail |
|-------------|--------|
| Encryption at-rest | Yes / No — type: {AES-256, KMS key, default} |
| Encryption in-transit | Yes / No — type: {TLS 1.2+, SSL} |
| Public access | Yes / No |
| IP/VPC restriction | {details} |
| Specific compliance | {PCI-DSS, GDPR, local regulation — if applicable} |
| Logging/Auditing | {CloudTrail, Access Logs, etc.} |

## 5. Dependencies

| Resource | Relationship | Status |
|----------|-------------|--------|
| {resource name} | This resource depends on / Is a dependency of | Existing / Pending |

## 6. Information Checklist for Infra

> *Verify that all necessary information is complete before sending to the support team.*

- [ ] Resource type and technical specifications defined
- [ ] Required tags specified (Project, Environment, Team, CostCenter)
- [ ] Security requirements defined
- [ ] Environment and region specified
- [ ] VPC/Subnet identified (if applicable)
- [ ] Justification and Jira epic linked
- [ ] Solution Architect approval obtained
- [ ] Cost estimate reviewed (if applicable)

## 7. Tracking

| Date | Action | Who | Result |
|------|--------|-----|--------|
| YYYY-MM-DD | Request created | @requester | Sent to {target team} |
| YYYY-MM-DD | Technical review | @architect | Approved / Requires changes |
| YYYY-MM-DD | Sent to infra support | @requester | Ticket/email #{reference} |
| YYYY-MM-DD | Provisioning completed | @infra-support | Resource created |

## 8. Post-Provisioning

> *Complete once the resource has been created.*

| Field | Value |
|-------|-------|
| ARN / Resource ID | {arn:aws:...} |
| Endpoint / URL | {if applicable} |
| Creation date | YYYY-MM-DD |
| Credentials / Secrets | See {secrets_platform}: `/{project}/{env}/{service}/{parameter}` |
| Configuration page in Confluence | [link to corresponding ENV-{ENVIRONMENT} page] |

> **IMPORTANT**: Do not include credentials, passwords, or API keys on this page. Only reference the path in {secrets_platform}.

## 9. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
