# **Feryn**

*An Open-Source LLM Platform for Global Course Intelligence & Academic Mobility*

---

## 1 Executive Summary

Feryn is an open-source initiative that harnesses large-language-model (LLM) reasoning, advanced document intelligence, and continuously-evolving academic knowledge graphs to **standardize, compare, and contextualize university-level courses worldwide**. By transforming fragmented transcript data and scattered syllabi into a unified, searchable corpus, Feryn empowers students, institutions, and accreditation bodies to make faster, fairer, and better-informed decisions about credit transfer, programme design, and career pathways.

---

## 2 Vision & Mission

| **Aspect**  | **Statement**                                                                                                                                                                                                                                           |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Vision**  | Seamless academic mobility across the globe—where a course completed anywhere can be understood, valued, and built upon everywhere.                                                                                                                     |
| **Mission** | Provide an open, transparent, and community-driven platform that automates course data integration, transcript intelligence, and equivalency analytics using state-of-the-art AI, fostering collaboration among learners, educators, and policy-makers. |

---

## 3 Core Value Propositions

1. **Universal Course Ontology** – A living taxonomy that normalizes course metadata, outcomes, and instructional depth across institutions and languages.
2. **Transcript Intelligence Engine** – OCR + NLP pipelines that extract structured entities (courses, grades, credits, semesters) from any transcript layout in seconds.
3. **LLM-Powered Equivalency Scoring** – Context-aware similarity models that assess prerequisite chains, cognitive level, and learning outcomes to recommend transfer credit decisions with ranked confidence.
4. **Dynamic Knowledge Graph** – A continuously refreshed, queryable store linking courses, competencies, accreditation standards, and labour-market skills.
5. **Privacy-Preserving Personalization** – On-device or constrained-context inference that offers student-specific course planning without exposing sensitive data.
6. **Open Governance & Extensibility** – A modular architecture, permissive licence, and transparent roadmap inviting contributions from universities, ed-techs, and individual developers.

---

## 4 Problem Landscape

| **Challenge**                        | **Current Pain**                                                | **Feryn Impact**                                                                                 |
| ------------------------------------ | --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **Disparate Course Formats**         | Syllabi, PDFs, web pages, and catalogue APIs vary wildly.       | Unified extraction layer normalizes inputs into a common schema.                                 |
| **Transcript Incompatibility**       | Manual evaluation is slow, error-prone, and subjective.         | Automated entity extraction + equivalency scoring yields auditable, data-driven recommendations. |
| **Evolving Curricula**               | Course content changes each term; static databases age quickly. | Continuous crawling and community validation keep metadata fresh.                                |
| **Limited Cross-Border Recognition** | Students lose credits when moving between countries.            | Global ontology + multilingual LLM analysis improves recognition accuracy.                       |
| **Opaque Transfer Policies**         | Criteria are hidden or inconsistent.                            | Explainable AI surfaces rationale, boosting trust and compliance.                                |

---

## 5 Functional Architecture (Conceptual)

1. **Ingestion Layer**

   * Smart crawlers for public catalogues
   * Secure transcript upload endpoints
   * Partner API connectors for direct SIS feeds

2. **Document Intelligence Core**

   * OCR & layout reconstruction
   * Named-entity recognition (courses, instructors, hours, outcomes)
   * Section segmentation & hierarchical indexing

3. **Knowledge Graph & Storage**

   * Course nodes, outcome nodes, accreditation nodes
   * Versioning for historical syllabi
   * Provenance metadata for auditability

4. **LLM Reasoning Services**

   * Similarity & equivalency scoring
   * Prerequisite dependency resolution
   * Predictive workload & difficulty estimation

5. **Access & Experience Layer**

   * REST & GraphQL APIs
   * Dashboard UI (students, evaluators, researchers)
   * Webhooks & event streams for institutional workflows

*(Diagrammatic references appear in the repository README; no proprietary stack is prescribed.)*

---

## 6 Detailed Feature Matrix

| **Feature**               | **Functional ID** | **Priority** | **Brief Description**                                              |
| ------------------------- | ----------------- | ------------ | ------------------------------------------------------------------ |
| Automated PDF Extraction  | FR-001-01         | High         | Parse text, tables, and figures from course PDFs & transcripts.    |
| PowerPoint Capture        | FR-001-02         | High         | Extract slide text & speaker notes for courses delivered as decks. |
| Section Categorization    | FR-001-03         | Medium       | Detect syllabus sections (objectives, assessment, readings).       |
| Course Ontology Mapping   | FR-002-01         | High         | Align extracted data to universal taxonomy.                        |
| Transcript Entity Linking | FR-002-02         | High         | Connect transcript course codes to ontology entities.              |
| Equivalency Scoring       | FR-003-01         | High         | Generate similarity percentile + confidence.                       |
| Explainability Layer      | FR-003-02         | Medium       | Provide natural-language rationale & reference excerpts.           |
| Multilingual Support      | FR-004-01         | Medium       | N-way translation & semantic alignment for global coverage.        |
| Real-Time Update Pipeline | FR-005-01         | High         | Event-driven refresh of course metadata.                           |
| Personalized Pathways     | FR-006-01         | Medium       | Student-specific course bundle recommendations.                    |

---

## 7 Personas & Primary Use Cases

| **Persona**             | **Goals**                                              | **Key Feryn Use Case**                                                          |
| ----------------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------- |
| *Transfer Student*      | Maximize accepted credits at new university.           | Upload transcript → receive credit equivalency report & pathway suggestions.    |
| *Registrar / Evaluator* | Accelerate, standardize, and justify credit decisions. | Bulk import transcripts → auto-generated equivalency queue with explainability. |
| *Curriculum Designer*   | Benchmark course against peer institutions.            | Query knowledge graph → identify overlap & gaps for redesign.                   |
| *Accreditation Body*    | Ensure programmes meet regional standards.             | Compare course outcomes → audit alignment with competency frameworks.           |
| *Career Advisor*        | Map academic history to job market skills.             | Retrieve skill tags → suggest courses to fill competency gaps.                  |

---

## 8 Competitive Landscape

| **Solution**                     | **Coverage Scope**   | **AI Depth**      | **Openness**   | **Feryn Advantage**                       |
| -------------------------------- | -------------------- | ----------------- | -------------- | ----------------------------------------- |
| Proprietary Transfer Tools       | Institution-specific | Limited rules     | Closed         | Vendor-neutral; global ontology.          |
| Generic OCR Services             | Any docs             | No academic logic | Closed         | Domain-aware NLP + LLM reasoning.         |
| National Qualification Databases | Country-bound        | Manual curation   | Partially open | Cross-border mapping & automated updates. |

---

## 9 Governance & Community Model

1. **Stewardship Council** – Representatives from universities, ed-tech firms, and independent contributors oversee roadmap alignment with public-interest goals.
2. **RFC Process** – Proposals for new modules, schema changes, or governance rules are discussed publicly and approved via merit-based voting.
3. **Transparency Reports** – Quarterly disclosures on data provenance, model evaluations, and bias audits.
4. **Diversity & Inclusion Pledge** – Commit to multilingual support, accessibility, and equitable representation of global curricula.

---

## 10 Business Model Canvas (Open-Core Orientation)

| **Block**                  | **Summary**                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Key Partners**           | Universities, accreditation agencies, open-data initiatives, funding foundations, documentation translators               |
| **Key Activities**         | Data ingestion, model training, ontology curation, community governance, security & privacy reviews                       |
| **Key Resources**          | Domain experts, annotation corpora, compute grants, contributor ecosystem                                                 |
| **Value Propositions**     | Accurate credit transfer, reduced administrative cost, accelerated global collaboration, transparent AI                   |
| **Customer Relationships** | Self-service docs, community forums, paid support tiers for SLA guarantees                                                |
| **Channels**               | Git repository, package registries, education conferences, partner integrations                                           |
| **Customer Segments**      | Higher-ed institutions, transcript evaluation services, MOOC providers, scholarship programmes                            |
| **Cost Structure**         | Compute for model inference/training, documentation, community events, security audits                                    |
| **Revenue Streams**        | Institutional subscriptions for hosted dashboards, premium API quotas, consulting & customization, certification services |

---

## 11 Roadmap (High-Level)

| **Quarter**     | **Milestone**                                                             | **Outcome**                                   |
| --------------- | ------------------------------------------------------------------------- | --------------------------------------------- |
| **Q1 (Launch)** | Initial repo + ontology v0.1                                              | Core ingestion & transcript parsing MVP       |
| **Q2**          | Equivalency engine alpha                                                  | Pilot with 3 partner universities             |
| **Q3**          | Multilingual module, explainability                                       | Public beta & RFC round on bias mitigation    |
| **Q4**          | Hosted SaaS offering & plugin SDK                                         | First paid institutional adopters             |
| **Year 2**      | Skill graph integration, career pathway API, global accreditation toolkit | Expansion to 10+ languages & 50+ institutions |

---

## 12 Compliance, Privacy & Ethical Guardrails

* **Student Data Minimalism** – Only necessary transcript fields stored; PII hashed or tokenised.
* **Audit-Ready Logs** – Every LLM inference linked to source excerpts and confidence scores.
* **Bias Evaluation Suite** – Continuous monitoring of equivalency decisions across demographics and regions.
* **Opt-Out Framework** – Institutions can request removal of proprietary course data snapshots.

---

## 13 Success Metrics

| **KPI**                                       | **Year-1 Target**          |
| --------------------------------------------- | -------------------------- |
| Average credit-evaluation turnaround time     | ↓ 70 % vs. manual baseline |
| Course coverage in knowledge graph            | 500 k+ unique courses      |
| Transcript parsing accuracy (entity-level F1) | ≥ 0.93                     |
| Community contributors                        | 150+ active monthly        |
| Institutional adoption                        | 25 paying universities     |

---

## 14 Risk & Mitigation

| **Risk**                 | **Description**                          | **Mitigation Strategy**                                        |
| ------------------------ | ---------------------------------------- | -------------------------------------------------------------- |
| Data licensing conflicts | Universities restrict sharing of syllabi | Formal data-sharing agreements, API token controls             |
| LLM hallucination        | Incorrect equivalency suggestions        | Dual-model cross-checks, confidence gating, human-review flags |
| Regulatory changes       | New privacy laws affecting academic data | Modular compliance layer, rapid policy mapping                 |
| Community fragmentation  | Forks diverge without collaboration      | Clear contribution guidelines, inclusive governance            |

---

## 15 Contribution Pathways

1. **Quick-Start Issues** – Labelled tasks for first-time contributors (docs, localisation, testing).
2. **Domain Working Groups** – Regular calls on ontology design, model evaluation, and policy alignment.
3. **Academic Fellowships** – Sponsored research internships to improve subject-specific models.
4. **Annual Summit** – Hybrid event showcasing case studies, roadmap votes, and workshops.

---

## 16 Licensing Strategy

* **Code** – Permissive licence encouraging commercial use while requiring attribution.
* **Ontology & Data Schemas** – Creative Commons-ShareAlike to guarantee open accessibility.
* **Pre-Trained Models** – Released under weights-specific licence prohibiting uncredited redistribution.

---

## 17 Call to Action

Feryn invites **students**, **registrars**, **developers**, and **policy-makers** to collaborate on redefining academic mobility for the AI era. Join the discussion, open an issue, contribute a dataset, or pilot the platform at your institution. Together, we can remove the friction from global learning journeys and unlock a truly borderless future for higher education.

---

> *“Education is the passport to the future, for tomorrow belongs to those who prepare for it today.”* — Malcolm X
> Feryn is that passport’s new visa-free stamp.
