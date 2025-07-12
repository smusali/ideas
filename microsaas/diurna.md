# **Diurna™ – The Intelligent Time & Attendance API**

*“LLM-powered precision for every second that counts.”*

---

## 1. Executive Summary

Diurna is an API-only MicroSaaS that transforms raw clock-in/out events into compliant, insight-rich timesheets in real time. Leveraging a domain-tuned large-language model (LLM), Diurna automatically **validates**, **cleans**, and **contextualizes** time-tracking data for education, healthcare, retail, and any industry with multi-shift hourly staff.
The service eliminates manual auditing, flags anomalies (e.g., missed punches, policy violations), and generates human-readable summaries and labor-law–ready exports—without exposing a user interface. Customers simply integrate a REST/GraphQL endpoint and receive pristine, insight-laden timesheet objects minutes later.

---

## 2. Problem Statement

| Challenge                                                                                     | Consequence                                                       |
| --------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Frequent in-day punches (breaks, split shifts) create fragmented data.                        | Payroll admins must reconcile errors manually, delaying pay runs. |
| Staff forget to clock in/out or duplicate entries.                                            | Compliance risk; inaccurate wage payouts.                         |
| Labor regulations (break length, overtime limits, split-shift premiums) vary by jurisdiction. | Constant rule updates burden engineering teams.                   |
| Existing point solutions are monolithic apps, not composable APIs.                            | Hard to embed in modern, product-led stacks.                      |

---

## 3. Target Users & Personas

1. **EdTech & Childcare Platforms** – Integrate Diurna to power teacher timesheets (mirroring the HiMama scenario).
2. **Workforce Management Startups** – Replace in-house rule engines.
3. **HRIS/Payroll Providers** – Offload compliance calculations.
4. **Enterprise Internal Tools Teams** – Modernize legacy punch systems without a full rewrite.

---

## 4. Core Value Proposition

| Pillar                         | Description                                                                                                    |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| **LLM-Driven Data Sanitation** | Fills gaps, merges duplicates, and infers intent (“classroom handoff break”) from metadata or free-text notes. |
| **Dynamic Compliance Engine**  | Declarative policy language auto-translated by the LLM into rule graphs—instantly adapts to new labor codes.   |
| **Explainable Summaries**      | Natural-language rationales for each adjustment; auditors see “why,” not just numbers.                         |
| **Embeddable in Minutes**      | Single endpoint to submit events; webhook or poll to retrieve enriched timesheets.                             |
| **API-First, UI-Free**         | Customers own the frontend; Diurna focuses on intelligence and data integrity.                                 |

---

## 5. Key API Surfaces

| Endpoint                             | Purpose                                                      | Sample Actions (non-exhaustive)                 |
| ------------------------------------ | ------------------------------------------------------------ | ----------------------------------------------- |
| `POST /v1/events`                    | Stream clock-in/out events, edits, or deletions.             | Bulk or single submission with idempotency key. |
| `GET /v1/timesheets/{user}/{period}` | Retrieve reconciled, compliance-checked timesheet.           | Query by day, week, custom range.               |
| `POST /v1/policies`                  | Upload or update local labor rules in declarative JSON/YAML. | Versioned with rollback.                        |
| `GET /v1/anomalies`                  | List unresolved validation errors or policy breaches.        | Filter by severity, location, user.             |
| `POST /v1/explain`                   | Ask “why was entry X modified?”                              | Returns step-by-step LLM rationale.             |

---

## 6. Conceptual Data Model

```
Event
 ├─ id, user_id, timestamp, type(in/out/edit/delete)
 ├─ location_id, device_id
 └─ metadata  (string→string map)

Timesheet
 ├─ user_id, period_start, period_end
 ├─ entries[] → {start, end, break_tags[], source_event_ids[]}
 ├─ totals    → {regular, overtime, paid_breaks, unpaid_breaks}
 ├─ compliance_flags[] → {code, severity, message}
 └─ explanations[]     → {entry_id, narrative}
```

*(This schema is internal; clients receive JSON responses.)*

---

## 7. LLM Capabilities

| Capability                        | Example                                                                              |
| --------------------------------- | ------------------------------------------------------------------------------------ |
| **Temporal Reasoning**            | Detects overlapping shifts; resolves “11:59 PM” typo → “11:59 AM” using context.     |
| **Policy Translation**            | Converts “Staff must break 30 min after 5 hrs continuous work” into evaluable graph. |
| **Anomaly Clustering**            | Groups related issues to reduce noise (“three missed outs likely a single shift”).   |
| **Natural-Language Explanations** | Generates plain English why an overtime premium was applied.                         |
| **Continual Fine-Tuning**         | Automatic reinforcement learning from human payroll corrections (opt-in).            |

---

## 8. Architecture Overview

1. **Stateless API Gateways** – Multi-region, autoscaling.
2. **Event Stream Ingestion** – Append-only log ensures ordering and idempotency.
3. **LLM Orchestration Layer** – Routes validation, policy translation, and summarization prompts.
4. **Rule Engine & Temporal Database** – Calculates durations, premiums, accruals.
5. **Vector Store** – Stores embeddings of policies and historical corrections for rapid retrieval-augmented generation.
6. **Observability Mesh** – Structured audit logs, metrics, traces.
7. **Security Perimeter** – mTLS, fine-grained OAuth scopes, customer-managed keys (CMK) option.

*No specific languages or frameworks are referenced to maintain neutrality.*

---

## 9. Security & Compliance

* **SOC 2 Type II** baseline with continuous control monitoring.
* **GDPR & 🇨🇦 PIPEDA Ready** – Regional data residency and automated subject-access exports.
* **HIPAA-Enabled Tier** (for healthcare): encryption, BAAs.
* **Audit Trail API** – Immutable, tamper-evident ledger of all transformations.

---

## 10. Pricing Model (Usage-Based with Grace Tier)

| Tier           | Monthly Platform Fee | Included Events | Overage (per 1k events) | Premium Features       |
| -------------- | -------------------- | --------------- | ----------------------- | ---------------------- |
| **Starter**    | \$0                  | 50 k            | \$4.00                  | Basic validation       |
| **Growth**     | \$249                | 1 M             | \$2.50                  | Compliance engine      |
| **Scale**      | \$999                | 5 M             | \$1.20                  | Dedicated cluster, CMK |
| **Enterprise** | Custom               | Unlimited       | Custom                  | HIPAA, on-prem edge    |

Webhook deliveries are free; explanations beyond 500 calls/mo incur marginal cost.

---

## 11. Competitive Landscape

| Competitor           | Focus             | Gaps Addressed by Diurna                   |
| -------------------- | ----------------- | ------------------------------------------ |
| Monolithic HR suites | End-to-end UI     | Closed platform, hard to embed             |
| Point calculators    | Payroll math only | No anomaly reasoning or summaries          |
| In-house rule code   | Custom            | High maintenance, lacks LLM explainability |

---

## 12. Go-to-Market Strategy

1. **DevRel & SDKs** – Publish Postman collection, OpenAPI spec, and quick-start guides.
2. **Niche Beachhead** – Partner with childcare SaaS to mirror the HiMama workflow.
3. **Compliance Thought Leadership** – White-papers on emerging labor laws, webinars with attorneys.
4. **Marketplace Listings** – Payroll/HR app stores for instant distribution.
5. **Usage-Metered Free Tier** – Remove adoption friction; virality via webhook notifications.

---

## 13. MVP Scope (First 90 Days)

* **Core Endpoints:** `/events`, `/timesheets`, `/anomalies`.
* **Basic Validations:** overlapping shifts, missing outs, negative durations.
* **Single-Region Deployment** with per-tenant data isolation.
* **LLM Prompts:** anomaly classification and summary generation.
* **Unit & Contract Tests:** >90 % coverage on event pipeline.
* **CI/CD & Canary Releases** to safeguard payroll integrity.

---

## 14. 12-Month Product Roadmap

| Quarter | Milestones                                                                         |
| ------- | ---------------------------------------------------------------------------------- |
| **Q1**  | Multi-region failover, self-serve dashboard (usage & billing), policy DSL beta.    |
| **Q2**  | Real-time overtime budgeting API, localized language packs (ES, FR).               |
| **Q3**  | HIPAA tier, on-device punch SDK, AI-generated monthly labor-cost insights.         |
| **Q4**  | Marketplace for community policy templates, partner revenue share, ISO 27001 cert. |

---

## 15. Key Metrics & KPIs

* **Time-to-Timesheet (T3)** – Avg. seconds from event ingestion to finalized timesheet (<5 s target).
* **Anomaly Resolution Rate** – % anomalies auto-resolved by LLM without human input.
* **Policy Update Lag** – Hours between new regulation release and supported enforcement.
* **Churn %** – Monitored monthly, goal < 3 %.
* **Gross Margin** – Target 85 % via efficient LLM batching and caching.

---

## 16. Risk Assessment & Mitigations

| Risk                                            | Impact                   | Mitigation                                                    |
| ----------------------------------------------- | ------------------------ | ------------------------------------------------------------- |
| LLM hallucination generates incorrect summaries | Incorrect payroll audits | Ensemble validation + deterministic rule engine before output |
| Rapidly changing labor laws                     | Compliance gaps          | Policy-as-code with legal partner SLAs                        |
| Customer distrust of AI decisions               | Adoption friction        | Transparent explanations, opt-out to deterministic only       |
| Regulatory breach                               | Fines                    | Continuous penetration testing, industry certifications       |

---

## 17. Testing & Validation Strategy

1. **Synthetic Event Fuzzing** – Randomized shift patterns to stress validation.
2. **Golden Policy Suites** – Jurisdictional test bundles executed nightly.
3. **Shadow Mode** – Replay customer traffic against Diurna and legacy system, compare deltas.
4. **Red Team Prompts** – Attempt to coerce LLM into invalid adjustments; harden prompt guardrails.
5. **Customer UAT Playbooks** – Sandbox environment with sample day-care datasets.

---

## 18. Future Enhancements

* **Predictive Scheduling** – Suggest optimal breaks to avoid overtime before it happens.
* **Voice & Chatbot Integration** – Allow managers to query “Who is on overtime today?” via messaging apps.
* **Cross-System Reconciliation** – Match biometric punches or NFC scans to events for fraud detection.
* **Earned Wage Access API** – Real-time gross pay calculations feeding fintech providers.

---

## 19. Why Now?

* Workforce compliance complexity is rising (e.g., split-shift mandates, predictive scheduling laws).
* LLMs have matured to deliver explainable reasoning suitable for payroll audit trails.
* Developers demand modular services; the API economy favors specialized MicroSaaS.
* Edge devices and ubiquitous connectivity enable real-time event capture.

---

## 20. Call to Action

* **Early Access Program**: Limited seats for design partners—free usage for feedback.
* **Feedback Loop**: Dedicated Slack community and shared roadmap visibility.
* **Integration Sprint**: Typical customers go live in under a day; Diurna handles the heavy lifting.

---

> **Diurna™ turns noisy punch data into crystal-clear, audit-ready timesheets—so your team can focus on people, not paperwork.**
