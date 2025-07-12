# **Refactyl — *Weave the Web of Knowledge***

---

## 1 ▪ North-Star

|                      | Statement                                                                                                                                          |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Mission**          | *Empower every researcher to traverse, enrich, and share the world’s academic knowledge graph through open, interoperable LLM-driven automations.* |
| **Vision**           | *Transform isolated documents into a living, hyper-connected ecosystem where insights propagate instantly and collaboration emerges organically.*  |
| **Tagline / Domain** | **“Weave the Web of Knowledge”** — **refactyl.org** (community-owned, permissively licensed)                                                       |

---

## 2 ▪ Problem Landscape

1. **Fragmented Literature Silos** — Journals, preprint servers, and institutional repositories often lack unified, machine-readable structures, impeding large-scale synthesis.
2. **Citation Snowballing Overload** — Manually chasing references across generations of papers quickly becomes unmanageable, leaving hidden gems undiscovered.
3. **Opaque Collaboration Networks** — Potential co-authors, reviewers, and interdisciplinary partners remain invisible within tangled authorship graphs.
4. **Impact Blind Spots** — Institutions struggle to track real-time influence of their scholars beyond traditional metrics like h-index or static journal rankings.
5. **Limited Knowledge Accessibility** — Paywalls, inconsistent metadata, and inaccessible formats hinder equitable participation in global research.

---

## 3 ▪ Solution Overview

**Refactyl** is an open-source platform that ingests academic artifacts, recursively extracts and enriches their knowledge components, and publishes an **open knowledge graph** accompanied by AI-generated insights. At its core, Refactyl provides:

* **Document Ingestion Pipelines** that accept PDFs, preprint URLs, and interoperable data dumps.
* **LLM-Enhanced Extraction Engines** that parse structure, metadata, citations, tables, and graphical abstracts.
* **Recursive Expansion** that follows citations to any configurable depth while de-duplicating nodes in real time.
* **Semantic Summaries & Embeddings** enabling instant comprehension and downstream search / recommendation applications.
* **Graph-Native Analytics** delivering collaboration maps, topic evolution timelines, and impact heat-maps.
* **Extensible Plugin System** for community-contributed enrichment routines (e.g., funding source detection, dataset linkage).

All artifacts, annotations, and graph snapshots are **released under an open data license**, allowing unrestricted reuse by institutions, individual researchers, and third-party tools.

---

## 4 ▪ Core Functional Pillars

| Pillar                               | Description                                                                                                                                              | Outcomes                                                              |
| ------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **1. Universal Ingestion**           | Accepts uploads, URLs, and dataset feeds; validates digital object identifiers; auto-fetches supplementary materials.                                    | Zero-friction onboarding of new literature sources.                   |
| **2. Structural & Citation Parsing** | Detects sections, figures, references, appendices; identifies citation boundaries even in noisy scans; normalizes references across styles.              | High-fidelity citation chains and consistent metadata.                |
| **3. Recursive Graph Expansion**     | Traverses outbound citations, preprints, conference proceedings, patents—respecting depth & breadth constraints and open-access policies.                | Exponential discovery with controlled resource usage.                 |
| **4. LLM-Powered Enrichment**        | Generates one-line “executive flashes,” detailed abstracts, key findings, and “why-it-matters” blurbs; extracts entities (methods, datasets, chemicals). | Accelerated comprehension and thematic clustering.                    |
| **5. Knowledge Graph Persistence**   | Stores authors, institutions, funding bodies, keywords, and citation edges as first-class graph nodes; supports time-series versioning.                  | Robust foundation for analytics, queries, and visualizations.         |
| **6. Insight & Visualization Layer** | Interactive dashboards: author influence galaxies, institution collaboration chord diagrams, topic drift river charts, and citation cascade animations.  | Evidence-backed strategic decisions for researchers & administrators. |
| **7. Open API & Plugin Hub**         | REST & GraphQL endpoints plus event-driven webhooks; plugin SDK lets the community add new enrichers (e.g., alt-metrics, code repository links).         | Vibrant ecosystem and infinite extensibility.                         |

---

## 5 ▪ Differentiators vs. Traditional Tools

| Dimension                   | Traditional Reference Managers     | **Refactyl**                                                                   |
| --------------------------- | ---------------------------------- | ------------------------------------------------------------------------------ |
| **Openness**                | Proprietary databases, closed APIs | Fully open data & libre license                                                |
| **Depth of Citation Crawl** | Single-layer import                | Multi-layer, configurable recursion                                            |
| **AI Insights**             | Basic keyword tagging              | Rich LLM summaries, entity recognition, rhetorical role labeling               |
| **Graph Orientation**       | Tabular lists & folders            | Native graph with temporal snapshots                                           |
| **Community Extensions**    | Limited / paid plugins             | FOSS plugin marketplace & federation standards                                 |
| **Institutional Analytics** | Basic counts                       | Dynamic dashboards: influence flow, funding impact, interdisciplinarity scores |

---

## 6 ▪ Representative Use Cases

1. **Early-Career Scholar Literature Mapping**

   * Upload seminal survey and instantly receive a **knowledge map** of foundational works, influential authors, and under-explored forks.
2. **Grant Committee Portfolio Assessment**

   * Query **funding impact lenses** to visualize cross-program collaborations and downstream citation cascades.
3. **University Library Open-Access Audit**

   * Run institution-wide scans to gauge how many publications are available under open licenses and strategize repository outreach.
4. **Journal Editorial Board Reviewer Discovery**

   * Identify reviewers with balanced expertise and minimal prior collaboration with submitting authors via **conflict-aware author graphs**.
5. **Data Steward FAIR-ness Check**

   * Integrate plugin detecting dataset DOIs and code repositories; surface compliance gaps for targeted outreach.

---

## 7 ▪ High-Level Architecture (Technology-Agnostic)

```
[Source Ingestion]
       │
       ▼
[Pre-Processor] ──► [Document Store]
       │
       ▼
[LLM Extraction] ──► [Knowledge Graph Builder] ──► [Graph DB]
       │                                   ▲
       ▼                                   │
[Enrichment Plugins] ──────────────────────┘
       │
       ▼
[Analytics & Visualization Layer] ──► [User Interfaces & APIs]
```

*Each block exposes event streams for observability and can be deployed independently, enabling elastic scaling and air-gapped institutional installs.*

---

## 8 ▪ Governance & Community Model

| Aspect              | Approach                                                                                                                   |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **License**         | Dual-license (permissive for software, CC-BY for data) encouraging both academic and commercial participation.             |
| **Stewardship**     | Non-profit foundation with steering committee elected by contributors and institutional sponsors.                          |
| **Roadmap Voting**  | Transparent issue board where features are prioritized via weighted votes from maintainers, backers, and new contributors. |
| **Code of Conduct** | Inclusive, DEI-focused guidelines aligning with major open-source communities.                                             |
| **Funding Streams** | Grants, institutional memberships, optional managed-hosted offerings, and consultancy ecosystem.                           |

---

## 9 ▪ Success Metrics

| Layer             | Metric                                   | Target (Year 1)      |
| ----------------- | ---------------------------------------- | -------------------- |
| **Adoption**      | Active monthly users                     | 10 k researchers     |
| **Coverage**      | Papers ingested                          | 5 M open-access docs |
| **Graph Quality** | Citation edge accuracy                   | ≥ 97 % validated     |
| **Community**     | Unique code contributors                 | 200+                 |
| **Impact**        | Average time saved per literature review | 40 % reduction       |

---

## 10 ▪ Roadmap Snapshot

| Quarter | Milestone                      | Highlights                                                                  |
| ------- | ------------------------------ | --------------------------------------------------------------------------- |
| **Q1**  | *Launch Alpha*                 | Core ingestion, single-layer parsing, basic summaries, public issue tracker |
| **Q2**  | *Recursive Graph & Plugin SDK* | Citation depth ≤ 3, graph explorer UI, first community plugin hackathon     |
| **Q3**  | *Institutional Analytics Pack* | Collaboration maps, alt-metric integration, user roles and org dashboards   |
| **Q4**  | *Federated Nodes & Edge-Sync*  | Cross-deployment graph merging, offline campus mode, DOIPool integration    |

---

## 11 ▪ Sustainability & Monetization Paths (Optional Services)

1. **Managed Cloud Instances** — Turn-key hosting with SLA, elastic scale, and compliance audits.
2. **Premium Insight Modules** — Custom algorithm packs (e.g., grant matching, patent linkage) licensed to enterprises.
3. **Enterprise Support Subscriptions** — Priority bug fixes, roadmap influence seats, dedicated Slack channels.
4. **Training & Certification** — Workshops for librarians, research offices, and data stewards on graph analytics best practices.

*(All paid offerings remain optional; core remains 100 % free and open.)*

---

## 12 ▪ Call to Action

* **Researchers & Students** — Pilot Refactyl on your next literature review and share feedback.
* **Libraries & Repositories** — Partner as a mirror node to democratize access.
* **Developers & Data Scientists** — Contribute plugins: alt-metrics, domain-specific ontologies, automated dataset evaluation.
* **Funders & Foundations** — Sponsor features that advance open science and reproducibility.

> **Join the movement to weave a richer, more connected web of knowledge—one citation at a time.** Visit **refactyl.org** and star the repository to get started!
