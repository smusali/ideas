# **Prandium**

*AI-Native Menu Intelligence as a Service*

---

## 1. Vision

In a world where restaurant data powers everything from third-party delivery apps to Gen AI chatbots, **structured, enriched, and up-to-date menu information** is still painfully hard to obtain. **Prandium** turns any unstructured menu—PDF, image, Markdown, or plain text—into a rich, multilingual knowledge graph with **zero manual work**, delivered through a developer-first API in milliseconds.

---

## 2. Core Problem & Opportunity

| Challenge                         | Pain Today                                                  | Why It Matters                                           |
| --------------------------------- | ----------------------------------------------------------- | -------------------------------------------------------- |
| **Messy menu data**               | PDFs, photos, or legacy CMSs produce inconsistent records.  | Downstream discovery, search, and personalization break. |
| **Dietary & allergen compliance** | Manual tagging is error-prone and risky.                    | Consumers demand transparency; regulators levy fines.    |
| **Multilingual guests**           | Translating menus requires time, cost, and culinary nuance. | Tourism drives revenue; bad translations hurt brand.     |
| **Static imagery**                | Stock photos fail to match dishes or seasonality.           | Visuals drive >30 % higher conversion on ordering apps.  |

**Prandium** solves all four with a single LLM-powered pipeline.

---

## 3. High-Level Solution

1. **Ingest** any menu artifact via `/imports` (text, image, URL, or file).
2. **Parse & normalize** menu structure using vision+text multimodal LLMs.
3. **Enrich** each item with:

   * nutrition macros & allergens
   * cuisine & dish taxonomy
   * wine/beer pairings
   * SEO-optimized description snippets
4. **Generate** optional hero imagery per item (stable diffusion fine-tuned on culinary styles).
5. **Serve** enriched JSON or GraphQL over low-latency endpoints, plus full-text + vector search.

---

## 4. Key Features

| Category                 | Capabilities                                                                       |
| ------------------------ | ---------------------------------------------------------------------------------- |
| **LLM Parsing**          | Layout detection, OCR correction, section hierarchy, item deduplication.           |
| **Knowledge Graph**      | Dish ↔ ingredient ↔ allergen relationships, cuisine ontologies, embedding vectors. |
| **N-10 Translation**     | Neural translations with culinary term preservation; 50+ locales at launch.        |
| **Nutritional AI**       | Calorie & macro estimation from ingredients + cooking method heuristics.           |
| **Vision Generation**    | Photorealistic or stylized item images; background removal option for POS.         |
| **Conversational Layer** | RAG-backed Chat Completion endpoint for “What’s gluten-free at Café Azul?”         |
| **Webhooks & Streams**   | Delta updates via Kafka topics or HTTPS webhooks for real-time sync.               |
| **Analytics**            | Consumption metrics, allergen compliance score, translation coverage.              |

---

## 5. Primary Use-Cases

1. **Food-delivery marketplaces** auto-clean incoming restaurant feeds.
2. **Voice assistants** answer dietary-specific menu queries.
3. **Digital kiosks** localize menus per airport gate in real-time.
4. **Nutrition apps** fetch macros directly rather than crowdsourcing.
5. **POS & CMS vendors** embed Prandium instead of building AI infra themselves.

---

## 6. API Surface Overview

> All endpoints are **RESTful**, JSON over HTTPS, Bearer-token auth; GraphQL and gRPC facades planned.

| Resource                       | Methods                | Highlights                                                    |
| ------------------------------ | ---------------------- | ------------------------------------------------------------- |
| `/imports`                     | `POST`                 | Upload or URL-ingest menu asset; returns `import_id`.         |
| `/menus/{menu_id}`             | `GET` `PATCH` `DELETE` | Structured tree of sections → items.                          |
| `/items/{item_id}/enrichments` | `GET`                  | Nutrition, allergens, embeddings.                             |
| `/items/{item_id}/image`       | `POST` `GET`           | Asynchronous hero image generation.                           |
| `/search`                      | `GET`                  | Hybrid keyword + vector retrieval across entire tenant scope. |
| `/chat`                        | `POST`                 | Stateful chat endpoint backed by RAG on tenant data.          |
| `/webhooks`                    | `POST` `GET`           | CRUD for event subscriptions.                                 |
| `/usage`                       | `GET`                  | Metered credits, rate-limit status.                           |

---

## 7. Architecture (Mermaid)

```mermaid
graph TD
  A[Client Apps<br/>POS · Delivery · Kiosk] -->|REST/GraphQL| B(API Gateway)
  B -->|auth+rate| C(Edge Cache)
  C --> D[Ingestion Service]
  D -->|async job| E[Worker Pool<br/>(LLM & Vision)]
  E --> F[(Vector DB)]
  E --> G[(PostgreSQL)]
  E --> H[(Object Storage)]
  F --> I[Query Orchestrator]
  G --> I
  I -->|RAG| J[Chat Service]
  I --> B
  J --> B
  E --> K[Webhook Dispatcher]
  K --> L[Partner Systems]
  subgraph Observability
    M[OpenTelemetry] --> N[Grafana Cloud]
  end
  B --> M
  E --> M
```

---

## 8. Technology Stack

| Layer             | Choice                                         | Rationale                               |
| ----------------- | ---------------------------------------------- | --------------------------------------- |
| **API**           | FastAPI + Uvicorn                              | Async Python ecosystem; type-safe docs. |
| **LLM**           | GPT-4o, Claude 3 Sonnet (multi-vendor)         | Accuracy, fallback redundancy.          |
| **Vision**        | Stable Diffusion XL fine-tuned on food images  | On-prem or API swap.                    |
| **Vector Store**  | pgvector inside Postgres                       | Simpler infra, ACID + embeddings.       |
| **Message Bus**   | Kafka                                          | Exactly-once ingestion pipelines.       |
| **Orchestration** | Temporal                                       | Durable, replayable workflows.          |
| **Infra**         | K8s (EKS) + Terraform                          | Multi-tenant isolation & GitOps.        |
| **Obs/Sec**       | OpenTelemetry, Loki, Sentry; OIDC, mTLS, Vault | First-class SRE & compliance.           |

---

## 9. Scalability & Reliability

* **Throughput**: Sharded worker pools scale horizontally; 10 M items/day at P95 < 1 s parse latency.
* **SLA**: 99.9 % uptime; multi-AZ region failover, warm standby cross-region.
* **Backpressure**: Token-bucket rate limiter at gateway; DLQ for poison jobs.
* **Data Consistency**: Strong writes via Postgres; eventual propagation to vector store.

---

## 10. Security & Compliance

* **PII segregation** through tenant-scoped KMS keys.
* **SOC 2 Type II** baseline; optional HIPAA BAAs for health-centric customers.
* **GDPR erase** endpoint (`/items/{id}:redact`) fulfills right-to-be-forgotten.
* **Model privacy**: No raw menu artifacts retained when “Ephemeral Mode” enabled.

---

## 11. Pricing & Packaging (Credit-Based)

| Tier        | Monthly Fee | Included Credits              | Overage       |
| ----------- | ----------- | ----------------------------- | ------------- |
| **Starter** | Free        | 1 K scans · 2 K chat msgs     | \$0.002/scan  |
| **Growth**  | \$249       | 50 K scans · 100 K chat msgs  | \$0.0015/scan |
| **Scale**   | Custom      | Dedicated resources, SSO, SLA | Volume-based  |

> *1 “scan” = parse + enrich of one menu item.*

---

## 12. Go-To-Market Plan

1. **Developer-First Motion**: Public docs, Postman collection, and 2-minute cURL demo.
2. **POS Partnerships**: Embed enrichment as white-label API; rev-share on overages.
3. **Marketplace Extensions**: Shopify, Square, Toast plugins auto-sync menus.
4. **Community Engagement**: Food-tech hackathons, sample notebooks, and Discord.

---

## 13. Competitive Landscape

| Vendor   | Focus             | Gap Filled by Prandium                                 |
| -------- | ----------------- | ------------------------------------------------------ |
| Popmenu  | Full web presence | Closed platform; no API.                               |
| MenuSifu | POS + CMS         | Limited AI enrichment.                                 |
| OpenAI   | Generic LLM       | Requires orchestration, compliance, and domain tuning. |

---

## 14. Roadmap

| Horizon   | Milestone                                                                         |
| --------- | --------------------------------------------------------------------------------- |
| **90 d**  | Automated ingredient photo tagging; Spanish voice synthesis.                      |
| **180 d** | AR “hover-menu” SDK for smart glasses; FDA menu-labeling compliance.              |
| **360 d** | Federated fine-tuning on private datasets; edge inference kit for offline kiosks. |

---

## 15. Success KPIs

* **< 10 min** average time from raw menu upload → production-ready data.
* **> 95 %** accuracy on allergen extraction benchmark.
* **< 100 ms** P95 latency on `/search` for <10 K items.
* **50 % MoM** developer signup growth via self-serve funnel.

---

## 16. Risks & Mitigations

| Risk                | Likelihood | Mitigation                                                  |
| ------------------- | ---------- | ----------------------------------------------------------- |
| LLM hallucination   | Medium     | Rule-based validation, human-in-the-loop correction UI.     |
| Model cost spikes   | Medium     | Batch-process low-priority jobs, fine-tune smaller models.  |
| Regulatory changes  | Low        | Dedicated compliance advisory board; modular policy engine. |
| Data vendor lock-in | Medium     | Multi-cloud, open-source components where feasible.         |

---

## 17. Team Roles (Initial 5-Person Squad)

* **Product/Founder** – market discovery, pricing, GTM.
* **ML Engineer** – prompt/chain optimization, fine-tuning.
* **Backend Engineer** – API gateway, auth, orchestration.
* **DevOps/SRE** – IaC, observability, cost monitoring.
* **Solutions Architect** – POS/marketplace integrations, pilot onboarding.

---

## 18. Implementation Milestones

1. **Week 0-2** – Thin-slice vertical: PDF → JSON enrich → REST deliverable.
2. **Week 3-6** – Add translation & nutrition modules; integrate vector search.
3. **Week 7-10** – Vision generation, webhook system, SLA monitoring.
4. **Week 11-12** – Beta with 3 pilot restaurants; iterate on feedback.

---

### **Prandium: powering the next generation of dynamic, intelligent dining experiences—one API call at a time.**
