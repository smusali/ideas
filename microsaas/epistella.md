# **Epistella** — *Illuminating the Scholarly Graph*

> \**One-word. API-first. Laser-focused on turning sprawling citation trails into crystal-clear knowledge graphs and actionable insights.*

---

## 1 ▪ Concept Snapshot

|                     |                                                                                                                                                                                                                                                                                 |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **What it is**      | An API-only MicroSaaS that ingests academic papers, recursively maps their citation networks, enriches every node with metadata and LLM-generated summaries, then exposes the entire scholarly graph—plus metrics, signals, and alerts—through elegant, rate-limited endpoints. |
| **Tagline**         | *“Trace Knowledge, Instantly.”*                                                                                                                                                                                                                                                 |
| **Primary Benefit** | Compresses weeks of literature-review drudgery into minutes, empowering researchers, libraries, and scholarly tool builders with real-time intelligence.                                                                                                                        |

---

## 2 ▪ North-Star

|                       | Statement                                                                                                                                                           |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Mission**           | *Democratize deep academic insight by transforming raw citations into living knowledge graphs accessible to every researcher and tool builder.*                     |
| **Vision**            | A world where navigating scholarly literature feels as intuitive as exploring an interactive map—zoom in, zoom out, discover hidden paths, and act with confidence. |
| **North-Star Metric** | *“Knowledge Minutes Saved”*—aggregate time users reclaim from manual citation chase.                                                                                |

---

## 3 ▪ Core Personas & Use-Cases

| Persona                    | Pain-Point                                                            | Epistella Solution                                                                  |
| -------------------------- | --------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Independent Researcher** | Manual, error-prone citation chasing for lit reviews.                 | One-call `/graph` endpoint yields an enriched, navigable citation network.          |
| **University Library**     | Difficulty tracking institutional research impact and collaborations. | `/metrics` surfaces author, department, and institution-level influence dashboards. |
| **Scholarly Tool Startup** | Needs a plug-and-play backend for paper ingestion and summarization.  | White-label endpoints (`/ingest`, `/summaries`) accelerate product launch.          |
| **Funding Body**           | Lacks real-time insight into grantees’ publication momentum.          | Webhooks push new-citation alerts scoped to funded projects.                        |

---

## 4 ▪ Feature Matrix

| Capability                        | Description                                                                                                                                 |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| **Recursive Citation Extraction** | User sets *depth* (1-n). Epistella crawls references, builds directed graph with DOI and persistent IDs.                                    |
| **Metadata Enrichment**           | Auto-fills titles, authors, affiliations, ORCID IDs, journal impact, open-access status, altmetrics, and more via federated scholarly APIs. |
| **LLM-Derived Intelligence**      | Generates: *one-liner gist*, *abstract-level synopsis*, *keyword vectors*, and *topic cluster IDs* for each node.                           |
| **Collaboration Graphs**          | Detects co-authorship links, institutional ties, and cross-disciplinary bridges.                                                            |
| **Impact Scoring**                | Combines citation counts, recency, journal rank, social buzz, and topical relevance into a composite *Epistella Score*.                     |
| **Contact Discovery (Opt-in)**    | Crawls public profiles to surface author emails and lab URLs with compliance checks.                                                        |
| **Realtime Webhooks**             | Push events for “new citation added,” “author reaches h-index milestone,” and custom triggers.                                              |
| **Export & Sync**                 | Snapshot any sub-graph to JSON, CSV, or direct sync with citation managers and BI warehouses.                                               |

---

## 5 ▪ API Design Overview

| Endpoint                | Verb | Purpose                                          | Core Parameters                         |
| ----------------------- | ---- | ------------------------------------------------ | --------------------------------------- |
| `/ingest`               | POST | Upload PDF (or DOI list) to kick-off processing. | `depth`, `callback_url`, `storage_mode` |
| `/graph/{job_id}`       | GET  | Retrieve live or completed citation graph.       | `format` (graphml, json), `filter`      |
| `/summaries/{paper_id}` | GET  | Fetch LLM-generated gist & keywords.             | `lang`, `length`                        |
| `/metrics/{entity_id}`  | GET  | Author / journal / institution analytics.        | `timespan`, `metric_type`               |
| `/alerts`               | POST | Register webhook for graph events.               | `event_type`, `scope`, `threshold`      |
| `/export/{graph_id}`    | POST | Push graph to 3rd-party store.                   | `destination_type`, `credentials_token` |

**Foundational Traits**

* Token-based auth (role-scoped keys)
* Deterministic versioning (`v1`, `v1.1`…)
* Tier-based rate-limiting & burst allowances
* SLA-backed uptime for Enterprise tier

---

## 6 ▪ Data Model (Conceptual)

```
Paper ──writes──► Author
Paper ──cites───► Paper (recursive)
Author ──affiliated_with──► Institution
Paper ──belongs_to──► Journal
Paper ──clusters_into──► TopicCluster
```

Each edge holds timestamps, weights (e.g., frequency, relevance), and provenance for auditability.

---

## 7 ▪ Intelligence & Ranking Layer

1. **Embedding Generation** – semantic vector for every title + abstract.
2. **Topic Clustering** – density-based grouping for quick thematic pivots.
3. **Composite Impact** – FCA (factor contribution analysis) blends signals into *Epistella Score*.
4. **Insights API** – top rising papers, dormant classics, under-explored bridges.

---

## 8 ▪ Operational Workflow

1. **Ingest** → File/DOI arrives; queued.
2. **Parse** → Structural extraction of text, references, tables.
3. **Enrich** → External API calls + internal lookup.
4. **Intelligence** → LLM summarization & embedding.
5. **Graph Build** → Nodes & edges materialized, deduplication.
6. **Notify** → Webhook / polling endpoint update.
7. **Lifecycle** → Periodic re-crawl for citation accrual & metric drift.

---

## 9 ▪ Privacy, Security & Compliance

* **User Data Isolation** – per-tenant encryption at rest/in transit.
* **Consent-Aware Scraping** – opt-in email discovery, adherence to robots.txt & jurisdictional privacy laws.
* **Academic Fair-Use Alignment** – respects publisher terms, caches only permissible data.
* **Regulatory Readiness** – GDPR, CCPA; FERPA guidance for educational institutions.

---

## 10 ▪ Monetization & Packaging

| Plan       | Monthly Quota              | Key Unlocks                                                        | Ideal User                               |
| ---------- | -------------------------- | ------------------------------------------------------------------ | ---------------------------------------- |
| **Seed**   | 1 000 API calls · 200 PDFs | Core endpoints; 2-level recursion                                  | Independent scholars, early-stage apps   |
| **Growth** | 10 000 calls · 2 000 PDFs  | 4-level recursion; webhooks; live metrics                          | Department libraries, scholarly startups |
| **Atlas**  | Unlimited                  | Full feature set; dedicated cluster; custom SLAs; priority support | Large universities, funding agencies     |

*Add-Ons*: On-demand historical backfills, custom model tuning, private cloud deployment.

---

## 11 ▪ Go-to-Market Flywheel

1. **Integration Partnerships** – plug into popular reference managers and research workflow tools.
2. **Community Editions** – limited free tier for open-access papers; drives grassroots adoption.
3. **Conference Presence** – sponsor digital humanities & library-tech events; host hackathon challenges.
4. **Thought Leadership** – publish “State of Citation Networks” quarterly reports powered by Epistella data.

---

## 12 ▪ 12-Month Roadmap

| Quarter | Milestone                                   | Outcome                                                  |
| ------- | ------------------------------------------- | -------------------------------------------------------- |
| **Q1**  | Public Beta & Feedback Program              | Stress-test ingestion throughput, refine impact scoring. |
| **Q2**  | Webhook Automations + Topic Drift Detection | Enable real-time alerts for emerging fields.             |
| **Q3**  | Multi-lingual Summaries & Search            | Expand beyond English abstracts, open new markets.       |
| **Q4**  | Self-Serve Institutional Dashboards         | No-code overlay for procurement-averse universities.     |

---

## 13 ▪ Competitive Edge

* **API-Only Focus** – zero UI distraction; perfect for embedding.
* **Depth-Controlled Recursion** – users balance cost vs. granularity.
* **Composite Impact Score** – nuanced ranking beyond raw citation counts.
* **Live Knowledge Graph** – event-driven updates keep data perpetually fresh.

---

## 14 ▪ Success Metrics

* *Knowledge Minutes Saved / user / month*
* API Retention (D30)
* Papers Ingested → Graph Density Ratio
* Avg. Time-to-Insight (file upload → metrics ready)
* Net-Promoter Score among research librarians

---

## 15 ▪ Risks & Mitigations

| Risk                                  | Mitigation                                                             |
| ------------------------------------- | ---------------------------------------------------------------------- |
| Upstream API rate changes or paywalls | Multi-source redundancy, cached tiers, and data-sharing agreements.    |
| Scraping compliance challenges        | Region-specific legal review, consent mechanisms, opt-out registry.    |
| LLM hallucination in summaries        | Cascade validation: fact-checking heuristics + user feedback flagging. |
| Vendor lock-in concerns               | Clear data export pathways; open schema documentation.                 |

---

### **Why Epistella, Why Now?**

The volume of scholarly output doubles roughly every 6–7 years. Navigating this ocean manually is unsustainable. Epistella weaponizes contemporary language models and graph analytics to **compress knowledge discovery, spotlight collaboration opportunities, and quantify impact**—all through a single, developer-friendly API surface.

> **Trace knowledge, instantly—so you can create the next breakthrough sooner.**
