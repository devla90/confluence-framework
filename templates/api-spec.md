# [{PREFIX}-{SUFFIX}] API Specification — {Service Name}

> **Default labels**: `type:api-spec`, `status:draft`, `team:backend`
>
> **Not a REST service?** This template covers any service contract — event consumers,
> queue workers, gRPC services, GraphQL, scheduled jobs. Set **Interface style** below and
> fill sections 2, 5 and 6 in the terms of that style. Everything else applies unchanged.
>
> **Ask the user for**: Service name, interface style (REST/GraphQL/gRPC/events/queue/job), main operations, authentication
> **Look for in the source**: The service's contract in whatever form it takes — OpenAPI/Swagger, GraphQL schema, `.proto`, message schemas — plus route or handler definitions, auth middleware, and for event or queue consumers the topics subscribed and published and the retry and dead-letter configuration

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @api-owner |
| **Service** | {service name} |
| **Interface style** | {REST / GraphQL / gRPC / events / queue / scheduled job} |
| **Contract Link** | {URL to the OpenAPI, GraphQL schema, .proto, or message schema registry} |
| **Version** | v1.0 |
| **Last Review** | YYYY-MM-DD |
| **Next Review** | YYYY-MM-DD |

---

## 1. Service Overview

Purpose of the service in 2-3 sentences. Responsible team. SLA targets.

| Metric | Target |
|--------|--------|
| Availability | 99.X% |
| Latency p95 | Xms |
| Throughput | X req/s — or messages/s, jobs/hour, whichever unit fits |

## 2. Contract Reference

> **Do not copy the spec here.** The generated contract is the source of truth; this page
> carries what the contract cannot express.

**Contract**: {link to Swagger UI, GraphQL playground, .proto file, or schema registry}

**Repository**: {link to the repo holding it}

Fill the block matching your interface style and delete the others.

**REST / GraphQL / gRPC**

| Operation | Path or method | Purpose |
|-----------|----------------|---------|
| | | |

**Events or queues**

| Direction | Topic / queue | Message schema | Purpose |
|-----------|---------------|----------------|---------|
| consumes | | | |
| produces | | | |

| Property | Value |
|----------|-------|
| Delivery guarantee | {at-least-once / at-most-once / exactly-once} |
| Ordering | {none / per key / global} |
| Idempotency | {how repeated delivery is handled} |
| Dead letter | {where failed messages go, and who watches it} |

**Scheduled job**

| Property | Value |
|----------|-------|
| Schedule | {cron expression, and in which timezone} |
| Trigger | {timer / upstream event / manual} |
| Inputs | {where it reads from} |
| Outputs | {where it writes to} |
| Overlap | {what happens if the previous run is still going} |

## 3. Authentication and Authorization

How consumers authenticate. Required roles and scopes.

| Operation / Topic / Job | Auth Method | Required Roles |
|-------------------------|-------------|----------------|
| | {API Key / JWT / OAuth / mTLS / IAM role / queue ACL} | |

## 4. Business Rules and Validation

Rules that **are not captured in the contract** but are critical for consumers.

1. **BR-001**: Description
2. **BR-002**: Description

## 5. Error Handling Guide

**Request/response interfaces** (REST, GraphQL, gRPC)

| HTTP Code | Error Code | Meaning | Consumer Action |
|-----------|-----------|---------|-----------------|
| 400 | VALIDATION_ERROR | | Fix the request |
| 401 | UNAUTHORIZED | | Renew credentials |
| 404 | NOT_FOUND | | Verify the resource |
| 429 | RATE_LIMITED | | Apply backoff |
| 500 | INTERNAL_ERROR | | Retry with backoff |

**Asynchronous interfaces** (events, queues, jobs) — there is no caller waiting for a
status code, so say where failures surface and who is expected to act.

| Failure | Where it surfaces | Retry policy | Who acts |
|---------|-------------------|--------------|----------|
| Malformed message | {DLQ / log / alert} | {none — inspect manually} | {team} |
| Downstream unavailable | | {N attempts, exponential backoff} | |
| Partial batch failure | | {whole batch / per record} | |

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

### Scenario: {an asynchronous flow}

For events, queues and jobs, show the message rather than a request:

```
Topic: {topic name}
Key:   {partition key, if any}

{
  "eventId": "abc-123",
  "type": "{event.type}",
  "occurredAt": "2026-01-01T00:00:00Z",
  "payload": { }
}
```

State what the consumer is expected to do, and what happens if it sees the same message
twice.

*(Add examples for the most common flows)*

## 7. Rate Limits and Quotas

| Limit | Value | Window |
|-------|-------|--------|
| Requests or messages per minute | X | 1 min sliding window |
| Maximum payload or message size | X MB | Per request / per message |
| Concurrency | X | Simultaneous consumers or workers |

## 8. Dependencies

Downstream services this API consumes.

| Service | Purpose | Type | Criticality |
|---------|---------|------|-------------|
| | | Synchronous / Asynchronous | Critical / Degraded |

## 9. Change History

| Date | API Version | Changes |
|------|-------------|---------|
| YYYY-MM-DD | v1.0 | Initial release |
