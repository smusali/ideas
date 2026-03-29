# `microsaas/`: MicroSaaS API and Product Specifications

This directory contains **Hosted Product Specs**: APIs (usually REST-shaped), pricing, usage limits, data models, go-to-market, and week-one launch plans. Each file targets **Solo Founders or Tiny Teams** building revenue from day one while keeping scope shippable in **about seven days** of focused work.

Portfolio analysis, domain notes, and feasibility tables live in [`REPORT.md`](../REPORT.md). The high-level index lives in the root [`README.md`](../README.md).

---

## What Belongs in `microsaas/`

| Criterion | Expectation |
|-----------|-------------|
| **Delivery Model** | Hosted API and/or web product; multi-tenant or API-key auth |
| **Revenue** | Explicit tiers (Free / Pro / Team / Enterprise) or usage-based add-ons |
| **Scope** | One primary job-to-be-done; upsells are features, not new products |
| **MVP Horizon** | **7-day** build table: backend, auth, billing hook, minimal docs |
| **Compliance** | Call out PII, email, financial, or health data **honestly** |

Specs describe **what to build and sell**, not production deployments. Implementation stack sections are suggestions, not mandates.

---

## Relationship to `oss/` and `agents/`

```text
oss/          →  Free tools that prove demand and teach you the problem domain
microsaas/    →  Paid API or app (Stripe, dashboards, SLAs)
agents/       →  Autonomous loops on top (webhooks, schedules, approvals)
```

| Pattern | Meaning |
|---------|---------|
| **OSS → MicroSaaS** | Same problem: CLI proves workflow; API removes install friction and enables billing. |
| **MicroSaaS → Agent** | Same brand or theme: API does on-demand work; agent does continuous monitoring and action. |
| **MicroSaaS Only** | Valid. Example in this repo: [`microtutor`](./microtutor.md) has no `agents/` twin yet. |
| **Agent Without MicroSaaS In-Repo** | Example: [`applynt`](../agents/applynt.md) is specified as an agent product; there is no `microsaas/applynt.md` in this repository. |

---

## Conventions

| Topic | Rule |
|-------|------|
| **File Names** | Lowercase product slug: `redactguard.md`, `orchestiq.md`. |
| **Header Block** | Lead with **Domain** (primary `.io`, optional `.ai` / `.dev`) and **Market** one-liner. |
| **Template** | Start from [`template.md`](./template.md); remove all `{{placeholders}}` and comments when publishing. |
| **API Shape** | Use `## API Design` with method + path lines and JSON examples that validate mentally. |
| **Pricing** | Table + PAYG line if applicable; avoid hidden limits. |

---

## Catalog: Thirteen Products

Alphabetical by slug. **Agent Spec** points to `agents/` when a matching autonomous spec exists in this repo.

| Spec | Intent | Primary domain (spec) | Related OSS | Agent spec |
|------|--------|------------------------|-------------|------------|
| [`configguard.md`](./configguard.md) | YAML/JSON config validation API | `configguard.io` | [`confcheck`](../oss/confcheck.md) | [`configguard`](../agents/configguard.md) |
| [`contributehq.md`](./contributehq.md) | OSS contributor onboarding from repo URL | `contributehq.io` | [`forkco`](../oss/forkco.md) | [`contributehq`](../agents/contributehq.md) |
| [`depchain.md`](./depchain.md) | Dependencies, gates, SBOM/CVE-aware flows | `depchain.io` | N/A | [`depchain`](../agents/depchain.md) |
| [`feedbackflow.md`](./feedbackflow.md) | Feedback ingest + VoC-style analysis | `feedbackflow.io` | N/A | [`feedbackflow`](../agents/feedbackflow.md) |
| [`fundos.md`](./fundos.md) | VC deal intake, deck scoring, thesis fit | `fundos.io` | N/A | [`fundos`](../agents/fundos.md) |
| [`insightify.md`](./insightify.md) | Insights from logs, surveys, text blobs | `insightify.io` | [`loglens`](../oss/loglens.md) | [`insightify`](../agents/insightify.md) |
| [`mailcraft.md`](./mailcraft.md) | AI-assisted email workflows (draft, schedule, triage) | `mailcraft.io` | N/A | [`mailcraft`](../agents/mailcraft.md) |
| [`microtutor.md`](./microtutor.md) | Tutor admin: exercises, notes, lesson plans | `microtutor.io` | N/A | *No `agents/` file in-repo* |
| [`orchestiq.md`](./orchestiq.md) | Agent/workflow orchestration API | `orchestiq.io` | [`mycelium`](../oss/mycelium.md) | [`orchestiq`](../agents/orchestiq.md) |
| [`postforge.md`](./postforge.md) | Social content generation for creators/SMBs | `postforge.io` | N/A | [`postforge`](../agents/postforge.md) |
| [`promptgrade.md`](./promptgrade.md) | Prompt testing, benchmarks, comparisons | `promptgrade.io` | [`promptco`](../oss/promptco.md) | [`promptgrade`](../agents/promptgrade.md) |
| [`redactguard.md`](./redactguard.md) | PII redaction for text before LLMs or third parties | `redactguard.io` | N/A | [`redactguard`](../agents/redactguard.md) |
| [`stmtparse.md`](./stmtparse.md) | Statement parsing, subscriptions, spend signals | `stmtparse.io` | N/A | [`stmtparse`](../agents/stmtparse.md) |

**Supporting File:** [`template.md`](./template.md).

---

## Domain and Branding

Specs assume **`.io` as primary** for B2D/B2B positioning; `.ai` and `.dev` are documented as secondaries where relevant. Before you pay for domains:

1. Match the **slug** in the spec filename to the **registrable brand**.
2. Run a quick **trademark / competitor** search in your jurisdiction.
3. Align **package or API** names with the marketing name to avoid split-brain (`stmtparse` API vs unrelated domain).

[`REPORT.md`](../REPORT.md) Section 7 summarizes recommended registrations for this portfolio.

---

## Compound Paths

| Upstream OSS | This folder | Downstream agent |
|--------------|-------------|------------------|
| `confcheck` | `configguard` | `agents/configguard.md` |
| `forkco` | `contributehq` | `agents/contributehq.md` |
| `loglens` | `insightify` | `agents/insightify.md` |
| `mycelium` | `orchestiq` | `agents/orchestiq.md` |
| `promptco` | `promptgrade` | `agents/promptgrade.md` |
| N/A | `fundos` | `agents/fundos.md` (same product family) |

---

## Specification Anatomy

Aligned with [`template.md`](./template.md). Implementers typically extract these sections into tickets.

| Section | Content |
|---------|---------|
| **Header** | Name, domain, market line |
| **Problem Statement** | Buyer pains, not feature lists |
| **Core Features** | Grouped capabilities |
| **Interaction Sequence** | Mermaid diagram: client → API → workers |
| **API Design** | Endpoints + request/response JSON |
| **7-Day Build Plan** | Daily deliverables; day 7 = launch motion |
| **Simple Data Model** | Entities for tenants, API keys, usage |
| **Revenue Model** | Tier table + overage |
| **Go-to-Market** | Channels, outreach, content hook |
| **Stack** | Suggested hosting, DB, Stripe |
| **Market Positioning** | ICP, trends, competitors |
| **Success Metrics** | 90-day numeric targets |

---

## Adding a New MicroSaaS Spec

1. Duplicate [`template.md`](./template.md) → `productslug.md`.
2. Define **one core resource** the API revolves around; resist extra resources until v1 ships.
3. Specify **auth** (API key in header is the default pattern in these specs).
4. Add **Stripe** or billing placeholder in day plan if you intend to charge.
5. If you add an autonomous story, create [`../agents/productslug.md`](../agents/README.md) or link to an existing agent file.
6. Update root [`README.md`](../README.md) and [`REPORT.md`](../REPORT.md) if this is a portfolio-level addition.

---

## Operational Checklist (Pre-Launch)

- [ ] Free tier limit is defensible against abuse (IP rate limits, caps).
- [ ] PII-heavy products mention **retention**, **encryption**, and **region** intent.
- [ ] Financial products mention **partner** APIs (e.g. Plaid) if used in agent specs downstream.
- [ ] `GET /health` and usage accounting exist in the API sketch.
- [ ] Pricing table matches what your Stripe products would actually be.

---

*For CLI/library ideas see [`../oss/README.md`](../oss/README.md). For autonomous automation see [`../agents/README.md`](../agents/README.md).*
