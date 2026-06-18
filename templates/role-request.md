# [{PREFIX}-{FRONT}] Deployment Role Request — {Role Name}

> **Default labels**: `type:role-request`, `status:draft`, `team:architecture`, `env:{environment}`

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | REQUESTED / IN REVIEW / APPROVED / CREATED / REJECTED |
| **Requester** | @requester |
| **Approver** | @architect / @security-lead |
| **Target Team** | Internal / External (Infra Support {company}) |
| **Request Date** | YYYY-MM-DD |
| **Environment** | DEV / QA / STG / PROD / All |
| **Version** | 1.0 |

---

## 1. What Role is Requested

| Field | Detail |
|-------|--------|
| Role name | {proposed name following conventions} |
| Role type | IAM Role / IAM Policy / EKS RBAC / S3 Bucket Policy / other |
| Environments | {DEV / QA / STG / PROD — indicate if it is a per-environment role or cross-environment} |
| Existing role to modify | {if modifying an existing role, indicate ARN} |

## 2. Justification

| Field | Detail |
|-------|--------|
| What service/pipeline needs it | {service name, Lambda function, CI/CD pipeline} |
| Why it is needed | {technical and business context} |
| Related Jira Epic | {PREFIX}-XXXX (link via Jira macro) |
| Least privilege principle | {explain why exactly these permissions are requested and no more} |

## 3. Requested Permissions

> *List the specific permissions required. Apply the principle of least privilege: only the necessary permissions, on the necessary resources.*

| AWS Service | Actions | Resources | Conditions |
|-------------|---------|-----------|------------|
| S3 | `s3:GetObject`, `s3:PutObject` | `arn:aws:s3:::{project}-{env}-*/*` | Only from project VPC |
| EKS | `eks:DescribeCluster`, `eks:ListClusters` | `arn:aws:eks:{region}:{account}:cluster/{project}-*` | — |
| Lambda | `lambda:InvokeFunction` | `arn:aws:lambda:{region}:{account}:function:{project}-*` | — |
| {service} | {actions} | {resource ARN} | {conditions} |

> **Note**: The examples above are illustrative. Replace with the actual permissions needed.

## 4. Who / What Will Use the Role

| Field | Detail |
|-------|--------|
| Entity type | Person / Service Account / CI/CD Pipeline / Lambda Function |
| Name/Identifier | {user name, service account, or pipeline name} |
| Service assuming the role | {e.g.: EC2, Lambda, EKS pod, CodePipeline} |
| Required Trust Policy | {what entity can assume this role — if applicable} |

## 5. Scope by Environment

| Environment | Applies | Differences | Specific Resources |
|-------------|---------|-------------|-------------------|
| DEV | Yes / No | | |
| QA | Yes / No | | |
| STG | Yes / No | | |
| PROD | Yes / No | {additional restrictions for prod} | |

> If it is an identical role for all environments, indicate "Same role, replicated per environment" and complete only one row.

## 6. Duration and Review

| Field | Detail |
|-------|--------|
| Type | Permanent / Temporary |
| Expiration date | {YYYY-MM-DD if temporary, N/A if permanent} |
| Next review date | {YYYY-MM-DD — recommended every 6 months for permanent roles} |
| Revocation condition | {when this role should be removed} |

## 7. Tracking

| Date | Action | Who | Result |
|------|--------|-----|--------|
| YYYY-MM-DD | Request created | @requester | — |
| YYYY-MM-DD | Security review | @security-lead | Approved / Requires changes |
| YYYY-MM-DD | Architecture review | @architect | Approved / Requires changes |
| YYYY-MM-DD | Sent to infra support | @requester | Ticket/email #{reference} |
| YYYY-MM-DD | Role created | @infra-support | Completed |

## 8. Post-Creation

> *Complete once the role has been created.*

| Field | Value |
|-------|-------|
| Role ARN | {arn:aws:iam::...} |
| Attached Policy ARN(s) | {list policy ARNs} |
| Policy document | See in AWS Console: [link] (do not copy the full JSON here) |
| Reference page in Confluence | [link to page in "IAM Roles and Policies"] |
| Functionality verification | {confirm that the service/pipeline works with the role} |

> **IMPORTANT**: Do not include access keys, secret keys, or temporary credentials on this page.

## 9. Change History

| Date | Author | Version | Changes |
|------|--------|---------|---------|
| YYYY-MM-DD | @author | 1.0 | Initial creation |
