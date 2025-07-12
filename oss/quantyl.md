# **Quantyl**

> *“Illuminating systems through language-aware log intelligence.”*

---

## **1. Executive Summary**

Quantyl is an open-source, language-driven observability platform that turns raw operational logs into actionable knowledge. By fusing large-language-model (LLM) reasoning with a modular log-collection pipeline, Quantyl empowers engineers, SREs, and security teams to **search, summarize, and diagnose** complex distributed systems in conversational natural language—without sacrificing speed, scale, or data privacy.

---

## **2. Problem Statement**

* Modern applications generate **terabytes of heterogeneous logs** that are hard to normalize, query, and interpret in real time.
* Traditional log stacks demand expert-level query languages, static dashboards, and manual correlation that do not keep pace with dynamic microservice topologies.
* “Alert fatigue” from noisy rules obscures true anomalies, while post-incident root-cause analysis remains tedious and error-prone.

---

## **3. Vision**

Quantyl envisions a world where **anyone**—from a junior developer to a senior incident commander—can simply ask:

> “Why did checkout latency spike at 14:37 UTC?”

…and receive a **context-rich narrative** citing the exact log lines, causal chains, and remediation hints in seconds.

---

## **4. Core Design Principles**

| Principle              | Description                                                                                         |
| ---------------------- | --------------------------------------------------------------------------------------------------- |
| **LLM-First**          | Treat language models as first-class citizens for parsing, clustering, and explaining logs.         |
| **Modular Ingestion**  | Support pluggable collectors (systemd, syslog, cloud streams, audit trails) via lightweight agents. |
| **Schema-On-Demand**   | Infer structure lazily—store raw text, extract fields only when needed.                             |
| **Privacy-Preserving** | Run all inference locally or inside air-gapped environments; no external data egress by default.    |
| **Extensible**         | Offer a plugin framework for custom analyzers, enrichment layers, and domain-specific prompts.      |

---

## **5. Architectural Overview**

```
┌────────────┐     ┌─────────────┐     ┌──────────────┐
│  Sources    │ →  │  Collectors  │ →  │  Buffer &     │
│ (servers,   │     │ (agents,    │     │  Ingest Bus   │
│  containers)│     │  tail-f,    │     └──────────────┘
└────────────┘     │  polling)    │            │
                   └─────────────┘            ▼
                                            ┌──────────────┐
                                            │  Storage &   │
                                            │  Indexing    │
                                            └──────────────┘
                                                     │
                                                     ▼
                                            ┌────────────────┐
                                            │  LLM Engine     │
                                            │  (semantic      │
                                            │  clustering,    │
                                            │  RAG, CoT)      │
                                            └────────────────┘
                                                     │
                              ┌──────────────────────┴──────────────────────┐
                              │                API Layer                    │
                              └──────────────────────┬──────────────────────┘
                                                     │
                      ┌───────────────┬──────────────┴──────────────┬─────────────┐
                      │ CLI / TUI     │  Web Console (Chat-UX)      │  Integrations│
                      └───────────────┴─────────────────────────────┴─────────────┘
```

* **Collectors** – lightweight binaries that stream log lines, metadata, and back-pressure signals.
* **Buffer & Ingest Bus** – fault-tolerant queue absorbing burst traffic.
* **Storage & Indexing** – columnar store plus inverted index for hybrid search (keyword + vector).
* **LLM Engine** – local or remote models providing semantic embeddings, summaries, and causal reasoning.
* **API Layer** – uniform REST & event streams exposing search, conversation, and alert hooks.

---

## **6. Key Features**

### 6.1 Semantic Log Search

* Accept free-form questions (e.g., “show auth failures from Europe last night”).
* Hybrid retrieval blends keyword filters with vector similarity, ranked by relevance.

### 6.2 Conversational Root-Cause Analysis

* Chain-of-thought prompting builds a timeline of correlated events across services.
* Generates “storyboards” that cite supporting log IDs for easy auditing.

### 6.3 Summarization & Trend Reporting

* Daily digests that narrate anomalies, configuration drifts, and usage trends in plain language.
* Automatically groups repetitive incidents into themes (e.g., flaky DB connections).

### 6.4 Anomaly Detection & Smart Alerts

* Unsupervised pattern learning spots deviations without hard-coded thresholds.
* Alert payloads include a human-readable explanation and suggested mitigations.

### 6.5 Prompt Studio

* Web workspace for crafting, testing, and versioning prompts specific to your domain.
* Side-by-side diff to benchmark generations against ground-truth incidents.

---

## **7. API Blueprint**

| Method   | Path            | Purpose                                                                           |
| -------- | --------------- | --------------------------------------------------------------------------------- |
| `GET`    | `/sources`      | Enumerate registered log sources & health metrics.                                |
| `POST`   | `/query`        | Submit natural-language or structured search; returns log set + semantic summary. |
| `GET`    | `/events/:id`   | Fetch full context (preceding & following lines) for a single log entry.          |
| `POST`   | `/alerts`       | Create rule tying LLM-based patterns to notifications.                            |
| `STREAM` | `/conversation` | Bidirectional channel for interactive incident chats.                             |

(All endpoints emit **hyperlinks to cited logs** and **explainability metadata** for trust & reproducibility.)

---

## **8. Privacy, Security & Compliance**

* **On-Prem Friendly:** All components can run within private networks; model weights may be self-hosted.
* **PII Redaction:** Built-in detectors mask sensitive tokens before indexing or model inference.
* **Audit-Ready:** Deterministic hash of every prompt/response pair stored for evidentiary trails.
* **RBAC & Multi-Tenant:** Fine-grained permissions isolate projects and restrict prompt visibility.

---

## **9. Extensibility**

| Extension Point        | Example                                                                  |
| ---------------------- | ------------------------------------------------------------------------ |
| **Collector SDK**      | Add a plugin for IoT syslog over UDP.                                    |
| **Prompt Packs**       | Domain-specific templates (security, fintech, gaming).                   |
| **Vectorizer Modules** | Swap embedding models for custom vocabulary.                             |
| **Action Hooks**       | Trigger rollbacks, ticket creation, or chat-ops reactions post-analysis. |

---

## **10. Use-Case Illustrations**

1. **DevOps Hotfix**
   *Ask:* “Why did pod restart counts spike after the latest deployment?”
   *Quantyl replies with:* Summarized exception stack traces, timeline of crash loops, and links to the exact commit introducing a misconfigured environment variable.

2. **Security Forensics**
   *Ask:* “Did we see any suspicious sudo attempts during the weekend?”
   *Quantyl replies with:* Clustered set of failed login logs, geolocation map, and recommended remediation steps.

3. **Capacity Planning**
   *Ask:* “Summarize memory growth trends for our cache tier over the past 90 days.”
   *Quantyl replies with:* A natural-language report, embedded chart, and projected saturation date.

---

## **11. Roadmap**

| Milestone                       | Description                                         | ETA     |
| ------------------------------- | --------------------------------------------------- | ------- |
| **v0.1 (Incubation)**           | Core ingestion, storage, keyword search, basic CLI  | Q4 2025 |
| **v0.2**                        | Vector search, LLM summarization, web UI prototype  | Q1 2026 |
| **v0.3**                        | Conversational RCA, alerting, plugin SDK            | Q2 2026 |
| **v1.0 (General Availability)** | Stable APIs, governance model, production hardening | Q4 2026 |

---

## **12. Governance & Community**

* **Steering Committee** – Guides technical direction & release cadence.
* **Champion Model** – Domain experts maintain feature areas (ingestion, LLM, UX).
* **Community Calls** – Monthly road-show of demos, RFC discussions, and contributor spotlights.
* **Open RFC Process** – Proposals evaluated in public, ensuring transparency and meritocracy.

---

## **13. Contribution Guidelines (abridged)**

1. **Fork → Branch → Pull Request** with descriptive commit messages.
2. All new features require **unit tests** & **documentation updates**.
3. Proposals for architectural changes should begin as an **RFC** discussed in a dedicated issue.
4. Maintain **inclusive language** and adhere to the project’s **Code of Conduct**.

Full details live in `CONTRIBUTING.md`.

---

## **14. Licensing**

Quantyl is released under the **Apache 2.0 license**, balancing permissive usage with robust patent protection. Commercial derivatives are welcome, provided modifications are disclosed as required.

---

## **15. Getting Started in Three Steps**

1. **Deploy the collector agent** wherever logs reside (servers, containers, edge devices).
2. **Spin up the Quantyl core** in your preferred environment (single node or cluster).
3. **Start asking questions**—from ad-hoc searches to multi-step investigations—directly in chat or via API.

---

## **16. Call to Action**

Whether you’re hunting elusive race conditions, leading security blue teams, or simply tired of yak-shaving log queries, **Quantyl** invites you to rethink observability through the lens of language.

Join the discussion, star the repository, and help craft the next generation of log intelligence—**built by the community, for the community.**

---

*Together, let’s transform raw noise into narrative insight.*
