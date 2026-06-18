# [{PREFIX}-{FRONT}] API Specification — {Service Name}

> **Default labels**: `type:api-spec`, `status:draft`, `team:backend`

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @api-owner |
| **Service** | {service name} |
| **OpenAPI Link** | (URL to Swagger UI) |
| **API Version** | v1.0 |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |

---

## 1. Service Overview

Purpose of the service in 2-3 sentences. Responsible team. SLA targets.

| Metric | Target |
|--------|--------|
| Availability | 99.X% |
| Latency p95 | Xms |
| Throughput | X req/s |

## 2. API Reference

> **Do not copy the spec here.** The auto-generated spec is the source of truth.

**Swagger UI**: [direct link to Swagger/OpenAPI]

**Repository**: [link to the repo with the spec]

## 3. Authentication and Authorization

How consumers authenticate. Required roles and scopes.

| Endpoint / Group | Auth Method | Required Roles |
|------------------|-------------|----------------|
| | API Key / JWT / OAuth | |

## 4. Business Rules and Validation

Rules that **are not captured in the OpenAPI schema** but are critical for consumers.

1. **BR-001**: Description
2. **BR-002**: Description

## 5. Error Handling Guide

| HTTP Code | Error Code | Meaning | Consumer Action |
|-----------|-----------|---------|-----------------|
| 400 | VALIDATION_ERROR | | Fix the request |
| 401 | UNAUTHORIZED | | Renew credentials |
| 404 | NOT_FOUND | | Verify the resource |
| 429 | RATE_LIMITED | | Apply backoff |
| 500 | INTERNAL_ERROR | | Retry with backoff |

## 6. Usage Examples

### Scenario: {scenario name}

**Request**:
```
POST /api/v1/resource
Content-Type: application/json
Authorization: Bearer {token}

{
  "field": "value"
}
```

**Successful response**:
```
HTTP 200
{
  "id": "abc-123",
  "status": "created"
}
```

### Scenario: {another scenario}

*(Add examples for the most common flows)*

## 7. Rate Limits and Quotas

| Limit | Value | Window |
|-------|-------|--------|
| Requests per minute | X | 1 min sliding window |
| Maximum payload | X MB | Per request |

## 8. Dependencies

Downstream services this API consumes.

| Service | Purpose | Type | Criticality |
|---------|---------|------|-------------|
| | | Synchronous / Asynchronous | Critical / Degraded |

## 9. Change History

| Date | API Version | Changes |
|------|-------------|---------|
| YYYY-MM-DD | v1.0 | Initial release |
