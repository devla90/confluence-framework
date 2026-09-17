# [ACME-BACK] API Specification — Swagger Petstore

> **Labels to apply in Confluence**: `type:api-spec`, `status:draft`, `team:backend`
> **Space / section**: ACMEWEB → Backend
> **Source analyzed**: link — https://petstore3.swagger.io/api/v3/openapi.json (fetched 2026-09-06)

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | {@api-owner} |
| **Service** | Swagger Petstore - OpenAPI 3.0 |
| **OpenAPI Link** | https://petstore3.swagger.io/api/v3/openapi.json |
| **API Version** | 1.0.27 |
| **Last Review** | 2026-09-06 |
| **Next Review** | {YYYY-MM-DD} |

---

## 1. Service Overview

A sample Pet Store server demonstrating the OpenAPI 3.0 specification with a design-first approach. Exposes three resource groups: `pet`, `store` and `user`.

Responsible team: {pending}

| Metric | Target |
|--------|--------|
| Availability | {99.X%} — not declared in the spec |
| Latency p95 | {Xms} — not declared in the spec |
| Throughput | {X req/s} — not declared in the spec |

## 2. API Reference

> **Do not copy the spec here.** The auto-generated spec is the source of truth.

**OpenAPI document**: https://petstore3.swagger.io/api/v3/openapi.json

**Server base URL**: `/api/v3`

**Repository**: {link to the repo with the spec — not available from the fetched document}

### Tags

`pet` · `store` · `user`

## 3. Authentication and Authorization

Two security schemes are declared in `components.securitySchemes`:

| Scheme | Type | Details |
|--------|------|---------|
| `petstore_auth` | OAuth 2.0 | Implicit flow. Scopes: `write:pets`, `read:pets` |
| `api_key` | API Key | Sent as a header |

| Endpoint / Group | Auth Method | Required Roles |
|------------------|-------------|----------------|
| `/pet` write operations (PUT, POST, DELETE) | OAuth 2.0 `petstore_auth` | scope `write:pets` |
| `/pet` read operations (GET) | OAuth 2.0 `petstore_auth` | scope `read:pets` |
| `/store`, `/user` | {confirm against the spec} | {pending} |

> Credentials are never documented here. See AWS Secrets Manager: {path}

### Pet endpoints

| Method | Path | operationId | Summary |
|--------|------|-------------|---------|
| PUT | `/pet` | `updatePet` | Update an existing pet |
| POST | `/pet` | `addPet` | Add a new pet to the store |
| GET | `/pet/findByStatus` | `findPetsByStatus` | Find pets by status |
| GET | `/pet/findByTags` | `findPetsByTags` | Find pets by tags |
| GET | `/pet/{petId}` | `getPetById` | Find pet by ID |
| POST | `/pet/{petId}` | `updatePetWithForm` | Update pet with form data |
| DELETE | `/pet/{petId}` | `deletePet` | Delete a pet |
| POST | `/pet/{petId}/uploadImage` | `uploadFile` | Upload pet image |

## 4. Business Rules and Validation

Rules that **are not captured in the OpenAPI schema** but are critical for consumers.

1. **BR-001**: {pending — not derivable from the spec}
2. **BR-002**: {pending — not derivable from the spec}

## 5. Error Handling Guide

| HTTP Code | Error Code | Meaning | Consumer Action |
|-----------|-----------|---------|-----------------|
| 400 | {VALIDATION_ERROR} | Invalid ID or invalid input | Fix the request |
| 401 | {UNAUTHORIZED} | Missing or expired credentials | Renew credentials |
| 404 | {NOT_FOUND} | Pet not found | Verify the resource |
| 429 | {RATE_LIMITED} | {not declared in the spec} | Apply backoff |
| 500 | {INTERNAL_ERROR} | {not declared in the spec} | Retry with backoff |

> The spec declares per-operation responses; the error-code column above is a project convention to be confirmed with the API owner.

## 6. Usage Examples

### Scenario: retrieve a pet by ID

**Request**:
```
GET /api/v3/pet/{petId}
Accept: application/json
Authorization: Bearer {token}
```

**Successful response**:
```
HTTP 200
{
  "id": {id},
  "name": "{name}",
  "status": "available"
}
```

### Scenario: find pets by status

**Request**:
```
GET /api/v3/pet/findByStatus?status=available
Accept: application/json
```

## 7. Rate Limits and Quotas

| Limit | Value | Window |
|-------|-------|--------|
| Requests per minute | {not declared in the spec} | {window} |
| Maximum payload | {not declared in the spec} | Per request |

## 8. Dependencies

| Service | Purpose | Type | Criticality |
|---------|---------|------|-------------|
| {pending — not derivable from the spec} | | | |

## 9. Change History

| Date | API Version | Changes |
|------|-------------|---------|
| 2026-09-06 | 1.0.27 | Initial creation. Generated from the OpenAPI document at https://petstore3.swagger.io/api/v3/openapi.json |
