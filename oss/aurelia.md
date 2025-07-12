# **Aurelia**

*The universal conversational memory engine for open-source LLM applications*

---

## 1 Vision

Modern chat-based products keep reinventing the same wheel: how to **preserve conversational context, enrich it with knowledge, and serve it back to large-language models in a reliable, privacy-respecting way**. Aurelia is an open-source micro-service that isolates those concerns behind a clean, language-agnostic HTTP interface, letting product teams focus on user value instead of boiler-plate infrastructure.

---

## 2 Why Aurelia Is Needed

| Challenge                 | Pain Today                                                   | Aurelia’s Approach                                                 |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------------ |
| **Context length limits** | Loss of earlier messages or expensive prompt stuffing        | Automatic windowing, summarisation, and vector-based retrieval     |
| **Fragmented storage**    | Each team invents its own schema                             | Canonical, forward-compatible schema with pluggable back-ends      |
| **Provider churn**        | Switching LLM vendors breaks logic                           | Provider-agnostic request envelope; adapters live outside the core |
| **Observability gaps**    | Little visibility into prompts, costs, latency               | Built-in telemetry feeds and cost accounting hooks                 |
| **Security & compliance** | Personally identifiable information often leaks into prompts | Field-level redaction, audit trails, policy guards                 |

---

## 3 Guiding Principles

1. **Stateless at the edge, stateful at the core** – All transient computation happens in side-effect-free workers; only durable artefacts enter the memory layer.
2. **“Bring-your-own” everything** – Storage engine, message broker, vector database, secret vault: pick what you already run.
3. **Explicit contracts, implicit scalability** – The public API is frozen per major version, while internal components can scale horizontally without code changes.
4. **Privacy first** – Data minimisation, encryption-in-transit & at-rest, and compliance check-points are non-negotiable default behaviours.

---

## 4 High-Level Architecture

```
(Client Apps) ⇄ REST / WebSocket API Gateway
                     │
                     ▼
          ┌─────────────────────┐
          │  Session Orchestrator│
          └─────────────────────┘
                     │
     ┌───────────────┼────────────────┬────────────────┐
     │               │                │                │
     ▼               ▼                ▼                ▼
Context Window   Vector Retriever   Memory Store   Policy Engine
Composer         (optional)         (durable)      (PII, quotas)
```

*Text diagram only – no implementation details provided.*

### Component Roles

| Component                   | Responsibility                                                                                           |
| --------------------------- | -------------------------------------------------------------------------------------------------------- |
| **Session Orchestrator**    | Accepts user queries, fetches relevant history, invokes external LLM, persists results, emits analytics. |
| **Context Window Composer** | Builds the final prompt using sliding windows, hierarchical summaries, or retrieval-augmented snippets.  |
| **Memory Store**            | Holds chats, messages, and metadata; supports point-in-time recovery and multi-tenant isolation.         |
| **Vector Retriever**        | Optional plug-in enabling semantic lookup of past utterances or external documents.                      |
| **Policy Engine**           | Enforces redaction, rate-limits, cost ceilings, and jurisdictional storage rules.                        |

---

## 5 Public API (v1)

| Method | Path                               | Description                                             |
| ------ | ---------------------------------- | ------------------------------------------------------- |
| POST   | /chats/search                      | Submit a question, receive streamed or blocking answer. |
| GET    | /users/{user\_id}/chats            | List all chat sessions for the user.                    |
| GET    | /users/{user\_id}/chats/{chat\_id} | Retrieve an entire conversation.                        |
| PATCH  | /users/{user\_id}/chats/{chat\_id} | Update mutable attributes (e.g., title).                |
| DELETE | /users/{user\_id}/chats/{chat\_id} | Hard-delete or soft-archive a conversation.             |

*All endpoints accept and return pure JSON; transport is HTTPS. Authentication is opaque-token based.*

---

## 6 Canonical Data Model

| Entity      | Key Fields                                                                                                                  | Notes                                                                        |
| ----------- | --------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| **Chat**    | chat\_id (UUID), user\_id, title, created\_at, updated\_at, metadata (JSON)                                                 | Title can be user-supplied or auto-generated.                                |
| **Message** | msg\_id (UUID), chat\_id, role (USER / ASSISTANT / SYSTEM), content (text), vector\_ref (optional), cost\_units, timestamps | Role classification enables fine-grained redaction and retrieval strategies. |

Both entities are **immutable by default**; updates create new versions for auditability.

---

## 7 Non-Functional Objectives

| Dimension         | Target                                                                  |
| ----------------- | ----------------------------------------------------------------------- |
| **Latency**       | <300 ms p95 for history fetch & prompt assembly (excluding LLM latency) |
| **Throughput**    | 1 k concurrent sessions per service replica with linear scale-out       |
| **Durability**    | Chat and message data recoverable within 15 min RPO, 4 h RTO            |
| **Multi-tenancy** | Hard isolation via namespace-scoped encryption keys                     |
| **Extensibility** | New plug-ins (retrievers, telemetry sinks) installable without downtime |
| **Observability** | Trace IDs propagate from incoming request to LLM call and back          |

---

## 8 Security & Compliance Posture

* **Zero-trust defaults** –Every request must carry a signed bearer token; internal services mutually authenticate.
* **Field-level encryption** – Sensitive attributes (emails, names, etc.) remain encrypted even inside the data store.
* **Audit events** – All create/update/delete operations emit immutable logs to an append-only channel.
* **Data locality** – Deployment profiles allow pinning data to specific regions to satisfy residency laws.
* **Regulatory mappings** – Pre-packaged controls map to GDPR Articles 5, 12, 17; CCPA §1798.105; HIPAA §164.312.

---

## 9 Pluggable Interfaces

| Extension Point           | Example Adaptors                             | Contract                                              |
| ------------------------- | -------------------------------------------- | ----------------------------------------------------- |
| **LLM Provider**          | OpenAI, Anthropic, Cohere, open-source local | Uniform request/response schema; cost accounting hook |
| **Vector Store**          | FAISS, Qdrant, Milvus                        | Up-sert & top-K similarity search                     |
| **Relational / KV Store** | PostgreSQL, CockroachDB, Dynamo-style        | ACID operations on Chat & Message tables              |
| **Metrics Sink**          | Prometheus, OpenTelemetry collector          | Structured spans, counters, histograms                |
| **Event Bus**             | Kafka, NATS, Pulsar                          | At-least-once delivery of audit and analytics events  |

---

## 10 Operational Playbook

1. **Deploy** Aurelia core and chosen plug-ins with your preferred orchestration platform.
2. **Point** client applications to the exposed HTTPS gateway and exchange OAuth or service tokens.
3. **Configure** retention periods, quota tiers, and redaction policies via the Admin API.
4. **Monitor** usage, latency, and spend through included Grafana dashboards.
5. **Iterate** by adding custom context builders or LLM adapters without touching the core.

---

## 11 Project Roadmap (selected milestones)

| Quarter     | Deliverable                                                                     |
| ----------- | ------------------------------------------------------------------------------- |
| **Q3 2025** | Public beta, reference deployments, multi-node clustering guide                 |
| **Q4 2025** | Vector-powered long-term memory module, Bring-Your-Own-RAG blueprint            |
| **Q1 2026** | Real-time streaming over WebSockets, fine-grained billing hooks                 |
| **Q2 2026** | Differential privacy mode for analytics, FIPS-140-3 crypto module certification |

---

## 12 Community & Governance

* **Stewardship** – Project led by a lightweight Technical Steering Committee elected annually.
* **Contribution workflow** – Fork → feature branch → signed Contributor License Agreement → pull request.
* **Communication channels** – Public chat, weekly stand-ups, monthly roadmap calls, and RFC process for breaking changes.
* **License** – Permissive OSI-approved license fostering commercial and academic adoption while protecting trademarks.

---

## 13 Getting Involved

1. **Star** the repository and subscribe to release notifications.
2. **File** issues for bugs, feature ideas, or ecosystem plug-ins you intend to build.
3. **Join** the newcomer session (first Wednesday of each month) to pair with maintainers.
4. **Follow** the style guide and commit-message conventions; small, focused pull requests are encouraged.
5. **Spread** the word – blog, stream, or give a talk about how Aurelia simplifies conversational AI infrastructure.

---

### *Aurelia aims to become the shared memory layer that every LLM application can rely on – transparent, secure, and extensible. Join us in shaping the future of context-aware AI.*
