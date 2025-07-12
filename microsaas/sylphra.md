# **Sylphra — API-Only MicroSaaS for Global Course Intelligence**

---

## 1 · Executive Summary

Sylphra is a developer-first, API-only micro-platform that ingests, normalizes, and enriches worldwide university course data, then exposes it as actionable, AI-enriched endpoints.  It empowers admissions teams, ed-tech products, and credential-evaluation services to automate transcript parsing, perform semantic course-equivalency checks, and generate personalized academic or career recommendations at scale—all without building their own data pipelines or machine-learning infrastructure.

---

## 2 · Market Problem

| Challenge                                                          | Impact on Stakeholders                                                      |
| ------------------------------------------------------------------ | --------------------------------------------------------------------------- |
| **Fragmented course formats** across thousands of universities     | Manual mapping drains hours from admissions evaluators and LMS vendors      |
| **Unstructured transcripts** vary by country, language, and layout | Error-prone data entry delays credit-transfer decisions                     |
| **Lack of fine-grained course similarity metrics**                 | Students risk taking redundant classes; institutions lose transfer students |
| **Static academic databases** are hard to keep current             | Ed-tech apps ship outdated recommendations                                  |
| **Global accreditation divergence**                                | Credential evaluators struggle to prove equivalency                         |

---

## 3 · Solution Overview

Sylphra offers a suite of REST/GraphQL\* endpoints (transport-agnostic) that provide:

1. **Automated Data Ingestion**
   *Scheduled crawlers & connectors* continuously collect public syllabi, catalog APIs, and PDF bulletins, funneling them through normalization pipelines.

2. **Adaptive Transcript Parsing**
   A **zero-shot OCR+LLM engine** detects layout, language, and grading schema, returning structured JSON in minutes instead of days.

3. **Semantic Course Matching**
   A **multilingual vector-embedding service** computes similarity scores between any two course objects (content, outcomes, workload, assessments).

4. **Dynamic Equivalency Graph**
   A constantly-updated knowledge graph links equivalent or prerequisite courses across institutions and curricula.

5. **Guidance & Insights**
   AI models synthesize transferability reports, prerequisite gap analyses, and personalized course-sequence suggestions.

\*Transport choices are configurable by clients; no UI layer is provided—Sylphra is 100 % API.

---

## 4 · Core API Endpoints

| Endpoint                   | Verb   | Payload & Purpose                                                                                              |
| -------------------------- | ------ | -------------------------------------------------------------------------------------------------------------- |
| `/v1/transcripts:extract`  | `POST` | Upload a transcript (PDF / image / raw text); returns canonical JSON of courses, grades, credits, and metadata |
| `/v1/courses:lookup`       | `GET`  | Query Sylphra catalog via keyword, code, institution, or taxonomy filters                                      |
| `/v1/courses:match`        | `POST` | Input one or many course objects; receive ranked list of semantically similar courses across institutions      |
| `/v1/equivalency:graph`    | `GET`  | Retrieve subgraph of equivalencies, prerequisites, and accreditation links for a course ID                     |
| `/v1/recommendations:plan` | `POST` | Provide student profile + desired outcome; returns optimized course roadmap                                    |
| `/v1/insights:analytics`   | `GET`  | Aggregated metrics (e.g., most transferred courses, skill-gap hotspots) for institutional dashboards           |
| `/v1/webhooks`             | `POST` | Register for change events (new catalog updates, policy shifts, accreditation changes)                         |

---

## 5 · Data & Intelligence Pipeline

1. **Acquisition Layer**

   * Public catalog scrapers
   * Institution webhooks / SFTP drops
   * Bulk transcript uploads

2. **Normalization Layer**

   * Format & language detection
   * Schema transformation into Sylphra Course Object (SCO)

3. **Enrichment Layer**

   * LLM-powered key-phrase extraction
   * Topic mapping to global taxonomies (CIP, ISCED, SOC)
   * Vector embedding & storage

4. **Graph Layer**

   * Deduplication & entity resolution
   * Edge creation (similarity, prerequisite, corequisite, accreditation)

5. **Serving Layer**

   * Low-latency query engine with role-based access
   * Usage-metering & analytics unit

*No customer data is retained beyond agreed retention windows; PII is tokenized.*

---

## 6 · Business Model

| Stream                       | Mechanics                                                                                  |
| ---------------------------- | ------------------------------------------------------------------------------------------ |
| **Tiered API subscriptions** | Free sandbox → *Growth* (usage-metered) → *Enterprise* (flat + overages)                   |
| **Premium knowledge packs**  | Regional accreditation datasets, historical catalog archives, language-specific embeddings |
| **Professional services**    | Custom ingestion connectors, bulk migration projects                                       |
| **Marketplace rev-share**    | Third-party ed-tech plugins powered by Sylphra data                                        |

---

## 7 · Competitive Advantage

1. **API-only DNA** – zero UI overhead means faster iteration and true composability for dev teams.
2. **Global, multilingual coverage** – first provider to treat non-Latin syllabi as first-class citizens.
3. **Real-time equivalency graph** – updated continuously vs. annual static reports.
4. **Privacy-by-design** – tokenization and optional on-prem deployment for sensitive regions.
5. **MicroSaaS focus** – lean team, low burn, pricing that scales with institutional headcount.

---

## 8 · Target Customers & Use Cases

| Segment                       | Example Integrations                                                    |
| ----------------------------- | ----------------------------------------------------------------------- |
| **Transfer-credit offices**   | Auto-generate articulation tables within SIS workflows                  |
| **Ed-tech learning planners** | Inject course availability & similarity scores into student-facing apps |
| **Credential evaluators**     | Expedite foreign transcript assessments with AI-assisted mapping        |
| **MOOC providers**            | Align micro-credential offerings with university curricula              |
| **Scholarship platforms**     | Verify applicant coursework against eligibility criteria                |

---

## 9 · Go-To-Market Roadmap

| Phase         | Milestone                                          | KPI                         |
| ------------- | -------------------------------------------------- | --------------------------- |
| **0 → 3 mo**  | Closed beta with 3 transfer-credit offices         | 10k transcripts processed   |
| **4 → 6 mo**  | Self-serve portal & usage-based billing            | \$15k MRR                   |
| **7 → 12 mo** | Marketplace for add-ons + public catalog API       | 150 institutions integrated |
| **Year 2**    | Accreditation compliance pack (AACRAO, ENIC-NARIC) | 1 M course objects ingested |

---

## 10 · Metrics That Matter

* **Transcript parse accuracy** (≥ 98 % field-level precision)
* **Course match F1 score** (≥ 0.90 within top-5 results)
* **Catalog freshness lag** (< 48 h from source update)
* **Monthly active API consumers**
* **Gross margin** (target > 85 % given low infra footprint)

---

## 11 · Risks & Mitigations

| Risk                                      | Mitigation                                                          |
| ----------------------------------------- | ------------------------------------------------------------------- |
| Data-sharing reluctance from universities | Offer reciprocal analytics & on-prem connectors                     |
| Rapid curriculum changes                  | Near-real-time scraping & institution push feeds                    |
| Regulatory hurdles (GDPR, FERPA)          | Regional data centers, fine-grained consent, configurable retention |
| Competitor feature catch-up               | Maintain lead via graph analytics & multilingual embeddings         |
| Over-reliance on a single LLM vendor      | Abstracted model layer with pluggable providers                     |

---

## 12 · Future Extensions

1. **Real-time skill inference**: Map course outcomes to industry skill ontologies for employability analytics.
2. **Proctorless assessment verification**: Validate course rigor via assignment-level embeddings.
3. **Scholar-level reputation scores**: Aggregate instructor impact and research alignment to guide student choice.
4. **Credential blockchain anchor**: Optional tamper-proof proof-of-completion tokens.

---

## 13 · Call to Action

Developers, admissions innovators, and ed-tech founders are invited to **request early access** to Sylphra’s private beta.  Harness the power of unified, AI-enriched course intelligence through a single, elegant API—and build the next generation of global education tools without the heavy lifting.

---

<p align="center"><em>Sylphra — Accelerating academic mobility, one API call at a time.</em></p>
