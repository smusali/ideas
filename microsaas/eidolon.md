# **Eidolon**

*A singular, self-contained API service for taming conversational context in LLM-powered products.*

---

## 1 Vision

Modern applications that embed large-language models (LLMs) must juggle user privacy, context windows, token limits, and conversation recall. **Eidolon** aspires to be *the* drop-in “memory spine” for every conversational AI stack—storing, compressing, retrieving, and analysing dialogue so builders can stay laser-focused on product logic rather than context plumbing.

---

## 2 Problem Statement

| Challenge                          | Symptoms in Today’s Apps                         | Consequences                                         |
| ---------------------------------- | ------------------------------------------------ | ---------------------------------------------------- |
| **Context bloat**                  | Long chats explode token counts                  | Escalating latency & cost, silent context truncation |
| **Fragmented storage**             | Each team reinvents chat persistence             | Inconsistent schemas, fragile migrations             |
| **Poor recall & search**           | Hard to surface “what was said 30 messages ago?” | Repetition, low-quality answers, user frustration    |
| **Limited conversation analytics** | No unified signal pipeline                       | Missed insights, compliance blind spots              |
| **Security & compliance friction** | Ad-hoc encryption & access control               | Audit headaches, data-leak risk                      |

---

## 3 Solution Overview

Eidolon presents a **purely API-driven** layer that:

1. **Persists dialogue threads** with hierarchical metadata (workspace → user → thread → message).
2. **Continuously summarises** expanding threads into token-budget-friendly “snapshots”.
3. **Embeds** each message & summary for *semantic* search and retrieval.
4. **Emits insights**—sentiment, intent, topic shifts—via webhooks or pull APIs.
5. **Enforces tenant isolation** and end-to-end encryption for every byte at rest.

The result: *one* service that handles memory, search, compression, and observability across every channel where your assistants live.

---

## 4 Key Capabilities at a Glance

| Domain                    | What Eidolon Delivers                                                             | Notes                                        |
| ------------------------- | --------------------------------------------------------------------------------- | -------------------------------------------- |
| **Thread Lifecycle**      | Create, update title, soft-delete/restore, final archive                          | Flexible retention policies                  |
| **Message Ingestion**     | Atomic append of user / assistant / system turns                                  | Optimistic concurrency                       |
| **Summarisation**         | Auto-generates abstractive snapshots once configurable token threshold is crossed | Maintains “summary tree” for time-travel     |
| **Vector Search**         | k-NN and hybrid keyword-semantic queries scoped to tenant / user / thread         | Supports relevance filters & sort by recency |
| **Analytics Hooks**       | Real-time events: `NEW_MESSAGE`, `SUMMARY_CREATED`, `INSIGHT_READY`               | Delivered via webhook or SSE                 |
| **Security & Compliance** | Row-level tenancy, envelope encryption, full audit trail                          | Designed for SOC 2 & GDPR                    |
| **Scalability**           | Stateless API tier, horizontally scalable workers, sharded vector store           | 99.99 % uptime SLO target                    |
| **Extensibility**         | Custom summarisation templates, pluggable insight extractors, BYO-embedding-model | Version-ed schemas, zero-downtime rollout    |

---

## 5 Core Entities & Relationships

```
Workspace 1─∞ User 1─∞ Thread 1─∞ Message
                       └─∞ Summary
```

| Entity        | Essential Fields (non-exhaustive)                                                  | Purpose                  |
| ------------- | ---------------------------------------------------------------------------------- | ------------------------ |
| **Workspace** | `workspace_id`, `name`, `plan`, `billing_info`                                     | Billing & isolation root |
| **User**      | `user_id`, `workspace_id`, `external_ref`, `preferences`                           | Maps to your app’s user  |
| **Thread**    | `thread_id`, `user_id`, `title`, `status`, `created_at`                            | Conversational session   |
| **Message**   | `msg_id`, `thread_id`, `role`, `content`, `tokens`, `created_at`                   | Atomic dialogue turn     |
| **Summary**   | `summary_id`, `thread_id`, `range_start`, `range_end`, `summary_text`, `embedding` | Rolling compression      |

---

## 6 API Design (High Level)

*(All routes are versioned; example “v1” shown.)*

| Method   | Route                                      | Description                   | Typical Payload / Query Params |
| -------- | ------------------------------------------ | ----------------------------- | ------------------------------ |
| `POST`   | `/v1/threads`                              | Create new thread             | `{ user_id, title? }`          |
| `GET`    | `/v1/threads/{thread_id}`                  | Fetch thread metadata + stats | `?include=messages,summaries`  |
| `PATCH`  | `/v1/threads/{thread_id}`                  | Rename or update status       | `{ title?, status? }`          |
| `DELETE` | `/v1/threads/{thread_id}`                  | Soft-delete thread            | —                              |
| `POST`   | `/v1/threads/{thread_id}/messages`         | Append dialogue turn          | `{ role, content }`            |
| `GET`    | `/v1/threads/{thread_id}/search`           | Semantic / keyword search     | `q=...&k=20`                   |
| `GET`    | `/v1/threads/{thread_id}/summaries/latest` | Retrieve most recent summary  | —                              |
| `POST`   | `/v1/hooks`                                | Register webhook endpoint     | `{ url, events[] }`            |
| `GET`    | `/v1/insights/recent`                      | Pull conversation analytics   | `?since=timestamp`             |

All endpoints require a tenant-scoped API key in the `Authorization` header. Requests & responses are strictly JSON; timestamps are ISO-8601 with millisecond precision.

---

## 7 Security & Privacy Blueprint

1. **Zero-trust defaults** — every request carries bearer token; missing or wrong scope → 401.
2. **Field-level encryption** — sensitive message bodies encrypted with per-workspace KEKs.
3. **Audit ledger** — immutable append-only log capturing CRUD & read events.
4. **Configurable redaction** — pattern-based scrubbing (PII, PHI) before persistence.
5. **Bring-your-own-region** — choose data jurisdiction per workspace (EU, US, APAC).

---

## 8 Scalability & Performance Highlights

| Layer               | Horizontal Scaling Mechanism                  | Notes                            |
| ------------------- | --------------------------------------------- | -------------------------------- |
| API Gateways        | Stateless; replicated under load balancer     | Autoscale on p95 latency         |
| Queue Workers       | Processes summarisation, embeddings, insights | Separate pools per task type     |
| Vector Store        | Sharded partitioning by workspace             | Elastic re-sharding              |
| Object Storage      | Stores raw & redacted blobs                   | Lifecycle rules for cold storage |
| Operational Metrics | High-cardinality event tracing                | 1 s resolution                   |

Benchmarks (baseline production target):

* **Message ingest** ≤ 50 ms p95 (single message, cold cache)
* **Search top-k (k=20)** ≤ 150 ms p95 up to 1 M messages/thread
* **Daily active threads** 100 K on single shard group before scale-out

---

## 9 Extensibility Options

| Extension Point         | How It Works                                                           | Example Use                                |
| ----------------------- | ---------------------------------------------------------------------- | ------------------------------------------ |
| **Custom Summariser**   | Supply template & LLM provider details via `/v1/extensions/summariser` | Domain-specific jargon handling            |
| **Insight Plugins**     | WebAssembly snippets or remote functions triggered on new message      | Toxicity detection, action item extraction |
| **Storage Connectors**  | Stream summaries to external data lakes                                | Real-time BI dashboards                    |
| **Embedding Providers** | Swap distance metric & model family                                    | Proprietary embedding for private corpora  |

---

## 10 Operational Excellence

* **Red / Green deploys** with schema shadowing—zero downtime migrations.
* **SLO-driven alerts**: latency, error rate, summary backlog.
* **Customer-visible status page**: Incident transparency & uptime log.
* **Fine-grained rate limits** with burst credits, visible in response headers.

---

## 11 Pricing & Packaging (Indicative)

| Tier           | Monthly Base | Included Messages | Add-on Cost      | Intended Users                      |
| -------------- | ------------ | ----------------- | ---------------- | ----------------------------------- |
| **Spark**      | Free         | 5 K               | \$0.50 / 1 K msg | Hobby & prototype                   |
| **Flux**       | \$49         | 100 K             | \$0.25 / 1 K msg | Indie products, seed startups       |
| **Pulse**      | \$299        | 1 M               | \$0.10 / 1 K msg | Growth-stage SaaS, internal tooling |
| **Enterprise** | Custom       | Unlimited         | Volume discounts | Regulated or high-scale orgs        |

All tiers include encryption, search, and basic summarisation. *Insights & advanced compliance* are Pro add-ons or Enterprise inclusions.

---

## 12 Go-to-Market & Competitive Differentiation

1. **First-class “memory” focus**: Unlike generic vector DBs, Eidolon natively understands conversational structure & lifecycles.
2. **Drop-in SDKs**: Auto-handles token windows, chunking, and back-pressure.
3. **Transparent costs**: Pay for *messages*, not opaque compute units.
4. **Privacy posture**: Field-level encryption and region pinning out-of-the-box.

Early adopter targets: AI customer-support platforms, in-product copilots, agent orchestration frameworks, and analytics vendors that demand long-lived conversational context.

---

## 13 12-Month Product Roadmap

| Quarter | Milestone     | Outcome                                                              |
| ------- | ------------- | -------------------------------------------------------------------- |
| **Q1**  | Private Alpha | Core CRUD + summarisation + search, single-region                    |
| **Q2**  | Public Beta   | Multi-tenant isolation, webhook events, Spark & Flux tiers           |
| **Q3**  | GA Launch     | SLA-backed Pulse tier, EU data residency, Terraform provider         |
| **Q4**  | Enterprise GA | Bring-Your-Own-Key encryption, SOC 2 certification, query federation |

---

## 14 Potential Integration Recipes

1. **Chat Support Bot** → Push user & agent turns to Eidolon → Retrieve latest summary before each model call → Guarantee context ≤ 4 K tokens.
2. **Voice Assistant** → Transcribe speech, stream chunks as messages → Leverage real-time insight webhooks for sentiment-based escalation.
3. **Meeting Summaries** → Ingest transcript segments → Use `/summaries/latest` for dynamic “running minutes” display.

---

## 15 Glossary

| Term                 | Meaning within Eidolon                                                                      |
| -------------------- | ------------------------------------------------------------------------------------------- |
| **Thread**           | A contiguous conversation session; may span hours, days, or weeks.                          |
| **Snapshot Summary** | Abstractive compression of an earlier segment so the full thread fits future model windows. |
| **Insight**          | Model-generated signal such as sentiment, action item, or PII detection.                    |
| **Token Budget**     | The caller’s maximum tokens for a model prompt; Eidolon helps respect this limit.           |

---

## 16 Closing Thoughts

By abstracting the heavy lifting of **conversation memory**, **semantic retrieval**, and **insight extraction** into one secure, pay-as-you-grow service, **Eidolon** allows every AI team—from solo hacker to enterprise lab—to launch richer, longer, and safer conversations faster than ever before.
