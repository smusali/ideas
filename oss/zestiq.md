# **Zestiq – The Intelligent Menu Intelligence Platform**

## 1  Vision

Empower every food venue—from single-site cafés to global quick-service chains—to create, localize, and maintain unforgettable menus **in minutes, not weeks**. Zestiq leverages large-language-model reasoning, retrieval-augmented generation, and domain-specific ontologies to automate the content, compliance, and customer-experience layers of modern menu management while remaining 100 % open source.

---

## 2  Problem Statement

Restaurant operators juggle a shifting mosaic of dishes, seasonal ingredients, dietary restrictions, languages, delivery channels, and marketing campaigns. Traditional back-office or headless CMS tools capture the *data*, but they *cannot*:

* translate menus fluently into multiple languages and dialects
* surface hidden allergens or religious dietary conflicts
* enrich sparse dish names with enticing yet concise narratives
* adapt tone and format for kiosks, QR code menus, third-party delivery apps, or voice assistants
* provide real-time feedback on pricing psychology, SKU profitability, or ingredient carbon footprint

The result is operational drag, inconsistent guest experiences, and lost revenue opportunities.

---

## 3  Solution Overview

Zestiq extends the fundamental CRUD capabilities of projects like **Grable** with an **AI-first** layer that:

1. **Understands** menu data semantically (vector embeddings, taxonomy enrichment).
2. **Generates** localized, brand-aligned descriptions on demand.
3. **Validates** nutritional, allergen, and regulatory compliance instantly.
4. **Distributes** optimized content to any downstream channel via a versioned, headless API.
5. **Learns** continuously from guest feedback, sales mix, and seasonal performance telemetry.

---

## 4  Core Use-Case Journeys

| Persona                             | Pain Today                                                           | Zestiq Outcome                                                                      |
| ----------------------------------- | -------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Independent owner**               | Manually writes and re-writes menus for dine-in, Uber Eats, DoorDash | Upload a CSV → get channel-specific menus ready for publishing in <5 min            |
| **Hospitality group menu engineer** | Tracks allergens across 300+ SKUs via spreadsheets                   | Real-time allergen graph with flagging, substitution suggestions, and export to POS |
| **Marketing manager**               | Needs seasonal promos localized into 8 languages                     | One-click tone-controlled translation with human-in-the-loop approval workflow      |
| **Corporate dietician**             | Must ensure new items meet regulatory nutrition limits               | Automatic nutrient breakdown and compliance dashboard                               |
| **Guest**                           | Has celiac disease; wants safe options fast                          | Conversational chat widget filtered to gluten-free dishes with confidence scores    |

---

## 5  Key Features

### 5.1  AI-Driven Semantic Menu Modeling

* Sentence-transformer embeddings stored in a vector database for instant similarity queries.
* Ingredient ontology mapping to unify synonyms (e.g., courgette ⇄ zucchini).

### 5.2  Multilingual Narrative Generation

* Retrieval-augmented prompts incorporate chef notes, brand voice guide, and ingredient facts.
* Supports reverse-context checks to eliminate literal but culturally awkward translations.

### 5.3  Dietary & Allergen Intelligence

* Rules engine plus probabilistic LLM reasoning for hidden allergens (fish sauce in kimchi).
* Real-time warnings and substitution proposals (cashew → sunflower seed “cheese”).

### 5.4  Dynamic Channel Formatting

* Template engine transforms a single canonical dish record into variants for:
  – POS / KDS line, 30 char limit
  – Mobile web with emoji accents
  – Voice (SSML) narration
  – AR glasses overlay

### 5.5  Visual Generation & Enhancement (Optional Module)

* Diffusion-model micro-service creates consistent hero images against brand guidelines.
* Automatic color-contrast checks for accessibility on light/dark themes.

### 5.6  Analytics & Continuous Learning

* A/B tests description variants, tracks click-through, cart-add, sell-through.
* Feeds performance back into prompt-tuning store to refine future generations.

### 5.7  Plugin Ecosystem

* Webhooks + event bus for custom pricing engines, climate-impact calculators, or loyalty CRM syncs.
* Starter plugins: Shopify sync, Stripe-based prepaid menu commerce, Algolia search booster.

---

## 6  High-Level Architecture

* **Edge API Gateway** – FastAPI with JWT/OAuth2, global rate limiting, and GraphQL overlay.
* **Core Relational Store** – PostgreSQL (menus, items, pricing, taxonomy).
* **Vector Store** – pgvector or Qdrant for embeddings and similarity search.
* **LLM Orchestrator** – Async task queue (Celery/RabbitMQ) coordinating calls to OpenAI, open-weights GGUF, or private Ollama clusters.
* **Inference Cache** – Redis for low-latency serving of repeated prompt generations.
* **Event Bus** – NATS for real-time change propagation to plugins and webhooks.
* **Analytics Warehouse** – ClickHouse powered; dbt models feed BI tooling.
* **Observability** – OpenTelemetry traces, Prometheus metrics, Grafana dashboards.
* **IaC** – Terraform & Helm charts targeting Kubernetes or single-node Docker Compose.
* **Security Layer** – Vault-managed secrets, E2EE for sensitive nutritional datasets.

---

## 7  Data Flow Narrative

1. Operator submits a dish draft via the Admin UI or REST/GraphQL endpoint.
2. A change event triggers the orchestrator:

   * embeddings are computed and stored;
   * allergens are inferred;
   * generation jobs enqueue multilingual descriptions & image variants.
3. Generated assets are versioned, signed, and stored on object storage (e.g., S3).
4. Downstream channels (POS, delivery, marketing site) receive webhook updates and purge caches.
5. Guest interactions feed telemetry (CTR, sentiment) to analytics warehouse; periodic batch jobs adjust prompt weights and recommend improvements.

---

## 8  Tech Stack Rationale

| Layer          | Choice                       | Why                                                                     |
| -------------- | ---------------------------- | ----------------------------------------------------------------------- |
| API            | FastAPI                      | Async-first, type-hinted, Swagger auto-docs                             |
| DB             | PostgreSQL + pgvector        | ACID for core data; unified store for embeddings simplifies infra       |
| Queue          | RabbitMQ                     | Proven, topology-rich, persistent deliveries                            |
| AI Engines     | OpenAI, Mistral-7B, Gemma-2B | Mix of SaaS and self-host for cost and privacy flexibility              |
| Infrastructure | Kubernetes                   | Blue/green deploys, horizontal pod auto-scaling of GPU-backed inference |
| Observability  | OpenTelemetry                | Vendor-neutral tracing into Grafana or Datadog                          |
| Licensing      | Apache-2.0                   | Permissive, business-friendly, patent grant                             |

---

## 9  Execution Roadmap

| Phase                          | Timeline  | Deliverables                                                         |
| ------------------------------ | --------- | -------------------------------------------------------------------- |
| **0 » Foundations**            | Month 1   | Repo scaffolding, CI/CD, Docker Compose dev stack                    |
| **1 » Core CRUD API**          | Month 2   | Restaurant/menu/item endpoints parity with Grable, OpenAPI spec      |
| **2 » Vector Intelligence**    | Month 3   | Embedding service, similarity search, basic allergen graph           |
| **3 » LLM Generation MVP**     | Month 4   | English description generation, brand-voice templates, admin preview |
| **4 » Multichannel Rollout**   | Month 5   | Webhooks, Shopify/Delivery aggregator plugins                        |
| **5 » Compliance & Analytics** | Month 6-7 | Nutrition validator, A/B test harness, BI dashboards                 |
| **6 » Community Launch**       | Month 8   | Contributor docs, RFC process, first public beta                     |

---

## 10  Contribution Guidelines (abridged)

* **Architecture discussions** → open GitHub Discussions; major changes require an RFC PR.
* **Feature work** → fork → feature branch → PR against `develop`; include unit tests & docs.
* **Commit message style** → Conventional Commits.
* **Code of Conduct** → Projects abide by the Contributor Covenant v2.1.
* **Governance** → Maintainer Core Team elected annually; voting rights by contribution merit.

---

## 11  Security & Privacy Model

* **Data residency**: pluggable storage adapters allow single-tenant EU deployment.
* **PII**: salted hashing for guest identifiers; zero stored payment info.
* **Prompt privacy**: can route all LLM calls to self-hosted models; no external data leakage.
* **SBOM & CVE scanning**: automated via GitHub Actions (Trivy).

---

## 12  Community, Ecosystem & Governance

* **Slack / Discord**: real-time support and weekly community office hours.
* **Monthly “Taste-up”**: virtual demo showcase featuring plugin creators.
* **Early-Access Partners**: restaurants contributing anonymized sales data receive influence on roadmap priorities.
* **Open Core vs. Plugins**: the entire generation pipeline remains Apache-2.0; optional enterprise addons (SOC 2, multi-region passive failover) may be dual-licensed.

---

## 13  Why Open Source?

1. **Transparency** in allergen and nutritional inference is critical for public trust.
2. **Innovation velocity** accelerates when chefs, dietitians, and devs can extend the ontology.
3. **Vendor neutrality** prevents lock-in to any single LLM API.
4. **Education**: provides a real-world reference stack for AI + food-tech engineering communities.

---

## 14  License

Zestiq is released under the **Apache License 2.0** with complete SPDX headers, fostering both community collaboration and commercial adoption.

---

## 15  Getting Started Snapshot

1. Install Docker (Desktop or server).
2. Clone the repository and copy the sample environment file.
3. Start the stack with the provided one-liner compose command.
4. Navigate to the web Admin UI (defaults to port 8080) to create your first restaurant.
5. Tweak the brand voice settings and watch Zestiq craft multilingual, allergen-aware menu narratives in seconds.

*(Comprehensive step-by-step instructions with screenshots live in the `/docs` directory.)*

---

## 16  Closing Note

Zestiq’s mission is simple: **turn raw ingredient data into delightful, inclusive dining narratives—automatically**. Join us to shape the future of menu intelligence and make every dining experience accessible, engaging, and profitable.
