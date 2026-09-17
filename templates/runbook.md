# [{PREFIX}-{FRONT}] RB — {System} — {Scenario}

> **Default labels**: `type:runbook`, `status:draft`, `team:{team}`, `priority:{critical|high|normal}`

---

## Page Properties

| Field | Value |
|-------|-------|
| **Status** | DRAFT |
| **Owner** | @oncall-team |
| **Last Test** | YYYY-MM-DD |
| **Severity** | P1 / P2 / P3 |
| **Next Review** | YYYY-MM-DD |

---

## 1. Scenario

What happened or what could happen. When this runbook applies.

> Example: "The React application returns 502 errors when accessed from the main domain. CloudFront cannot connect to the origin."

## 2. Impact

What is affected if not resolved. Impacted users. Degraded services.

| Area | Impact |
|------|--------|
| Affected users | |
| Impacted services | |
| Revenue / SLA at risk | |

## 3. Detection

How this problem is detected.

| Method | Detail |
|--------|--------|
| Automatic alert | Alert name, notification channel |
| Monitoring | Dashboard/metric that shows the problem |
| User report | Channel through which users report |

## 4. Resolution Steps

> **Step-by-step instructions. Be explicit. Assume the reader is under pressure.**

### Step 1: Verify the current state

What to verify first to confirm the problem matches the description.

```
# Specific command or action
```

### Step 2: {Action}

Description of what is done and why.

```
# Specific command or action
```

### Step 3: {Action}

Description of what is done and why.

```
# Specific command or action
```

*(Add as many steps as needed)*

## 5. Verification

How to confirm the problem has been resolved.

- [ ] Verification 1: What to check and what result to expect
- [ ] Verification 2: What to check and what result to expect
- [ ] Verification 3: Users can access normally

## 6. Escalation

If the steps above do not resolve the problem:

| Level | Contact | Channel | When to escalate |
|-------|---------|---------|------------------|
| 1 | @tech-lead | Slack #incidents | After 15 min without resolution |
| 2 | @architect | Direct call | After 30 min without resolution |
| 3 | @cloud-provider | Support ticket | If it is a cloud infrastructure issue |

## 7. Post-Incident

After resolution:

- [ ] Document the incident (date, duration, root cause, resolution)
- [ ] Add an entry to the usage history table of this runbook
- [ ] Evaluate whether a formal post-mortem is needed
- [ ] Create tickets for preventive actions

## 8. Usage History

| Date | Operator | Result | Duration | Notes |
|------|----------|--------|----------|-------|
| YYYY-MM-DD | @person | Resolved / Escalated | Xmin | |
