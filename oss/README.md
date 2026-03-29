# `oss/`: Open-Source Project Specifications

This directory holds **Product-Ready Idea Specs** for command-line tools and libraries aimed at developers and platform teams. Each file is a self-contained blueprint: problem, features, CLI surface, build plan, packaging, and positioning, sized so a **Solo Builder Can Ship a Credible MVP in About Seven Days**.

For portfolio context, cross-folder pipelines, and market analysis, see the repository root [`README.md`](../README.md) and [`REPORT.md`](../REPORT.md).

---

## What Belongs in `oss/`

| Criterion | Expectation |
|-----------|-------------|
| **Primary Interface** | CLI and/or importable library; local-first or explicit opt-in to network |
| **Audience** | Developers, SREs, maintainers, ML engineers (people who live in terminals and repos) |
| **Scope** | One sharp problem per tool; avoid “platform that does everything” |
| **Distribution** | PyPI and/or npm (or GitHub Action) with a clear install one-liner |
| **MVP Horizon** | Documented **7-day** phased plan in every spec |
| **Honesty** | Competitors named; gaps stated; optional AI called out where it is optional |

Specs are **not** runnable code. They are the contract you implement against.

---

## Relationship to `microsaas/` and `agents/`

```text
oss/          →  Developer tools & libraries (credibility, adoption, low friction)
microsaas/  →  Hosted APIs & products (billing, SLAs, multi-tenant)
agents/     →  Long-running, event-driven automation (webhooks, schedules, human gates)
```

Several OSS tools are intentionally **paired** with a MicroSaaS and/or an agent spec so you can compound value: ship the CLI first, monetize with an API, then add autonomous loops. Those pairings are listed in [Compound Paths](#compound-paths-oss--microsaas--agent) and in [`REPORT.md`](../REPORT.md).

Not every OSS project has a downstream MicroSaaS file in this repo (and that is fine). The catalog table marks **related** specs where they exist.

---

## Conventions

| Topic | Rule |
|-------|------|
| **File Names** | One markdown file per project: `projectname.md`. Use the same stem as the primary package where possible (`checkOwners.md` matches the product name `checkOwners`). |
| **Template** | Copy [`template.md`](./template.md) when authoring a new idea; replace all `{{placeholders}}` and remove HTML comments once the spec is final. |
| **Registries** | Call out **PyPI** and **npm** names in the spec header. Note `N/A` for GitHub Actions-only or npm-only libraries. |
| **Mermaid** | Sequence diagrams are encouraged in `## Interaction Sequence`; keep diagrams short and valid. |
| **Language** | Prefer concrete commands, JSON/YAML examples, and real endpoint-shaped paths over vague prose. |

---

## Catalog: Thirteen Projects

Alphabetical by file name. Each row links to the spec and summarizes intent.

| Spec | One-line intent | PyPI | npm | Notes |
|------|-----------------|------|-----|--------|
| [`chatco.md`](./chatco.md) | Terminal-first multi-provider LLM chat, sessions, prompt library | `chatco` | `chatco` | LLM tooling |
| [`checkOwners.md`](./checkOwners.md) | Infer and maintain `CODEOWNERS` from git history; GitHub Action + CLI | `checkowners` | N/A (Action) | CI / ownership |
| [`clusterkit.md`](./clusterkit.md) | Node.js cluster helper: rolling restart, singleton workers, systemd | N/A | `clusterkit` (verify before publish) | Library, not a CLI-only story |
| [`confcheck.md`](./confcheck.md) | Lint, format, simulate infra configs; optional LLM diagnostics | `confcheck` | `confcheck` | Pairs with [`configguard`](../microsaas/configguard.md) |
| [`docsight.md`](./docsight.md) | Extract and summarize PDF/TXT/DOCX locally | `docsight` | `docsight` | Unstructured docs |
| [`finstatecli.md`](./finstatecli.md) | Financial statements → structured data; optional LLM | `finstatecli` | `finstatecli` | High parsing variance |
| [`forkco.md`](./forkco.md) | Fork sync, upstream change summaries, contribution discovery | `forkco` | `forkco` | Pairs with [`contributehq`](../microsaas/contributehq.md) |
| [`loglens.md`](./loglens.md) | Log parsing + patterns + optional natural-language queries | `loglens` | `loglens` | Pairs with [`insightify`](../microsaas/insightify.md) |
| [`modelmeter.md`](./modelmeter.md) | Benchmark and compare models from the CLI | `modelmeter` | `modelmeter` | Complements [`promptco`](./promptco.md) |
| [`mycelium.md`](./mycelium.md) | Multi-agent orchestration CLI (workflows, routing, context) | `mycelium` | `mycelium` | Pairs with [`orchestiq`](../microsaas/orchestiq.md) |
| [`openpulse.md`](./openpulse.md) | OSS health, contributors, funding pledges | `openpulse` | `openpulse` | Maintainer-focused |
| [`promptco.md`](./promptco.md) | LLM cost tracking, policies, alerts (local) | `promptco` | `promptco` | Pairs with [`promptgrade`](../microsaas/promptgrade.md) |
| [`specguard.md`](./specguard.md) | OpenAPI/Swagger validation and CI-friendly reporting | `specguard` | `specguard` | API design loop |

**Supporting File:** [`template.md`](./template.md) (blank structure for new OSS specs).

---

## Compound Paths (OSS → MicroSaaS → Agent)

These are the **documented** compound lines in this repository (not an exclusive list of what you could build).

| OSS spec | MicroSaaS spec | Agent spec |
|----------|------------------|------------|
| `mycelium` | [`orchestiq`](../microsaas/orchestiq.md) | [`orchestiq`](../agents/orchestiq.md) |
| `promptco` | [`promptgrade`](../microsaas/promptgrade.md) | [`promptgrade`](../agents/promptgrade.md) |
| `loglens` | [`insightify`](../microsaas/insightify.md) | [`insightify`](../agents/insightify.md) |
| `confcheck` | [`configguard`](../microsaas/configguard.md) | [`configguard`](../agents/configguard.md) |
| `forkco` | [`contributehq`](../microsaas/contributehq.md) | [`contributehq`](../agents/contributehq.md) |

**MicroSaaS-Only Agent Thread:** [`fundos`](../microsaas/fundos.md) and [`fundos` agent](../agents/fundos.md) share a name by design (API product + autonomous deal-flow layer).

**No OSS Twin In-Repo:** Many OSS tools (e.g. `checkOwners`, `clusterkit`, `specguard`) are strong standalone products; add a new `microsaas/` file only when you have a hosted API story worth specifying.

---

## Specification Anatomy

Every OSS spec is expected to follow the same **spine** (see [`template.md`](./template.md)). Sections below map 1:1 to what implementers search for.

| Section | Purpose |
|---------|---------|
| **Title + Tagline** | Name and single-sentence value |
| **Registry Callouts** | PyPI/npm availability or verification notes |
| **Problem Statement** | 3 to 5 concrete pains; closing line = what the tool *does* |
| **Core Features** | Grouped by `###` headings; avoid feature soup |
| **Interaction Sequence** | Mermaid `sequenceDiagram` for happy path |
| **CLI Commands** | Copy-pastable examples with real subcommands |
| **Configuration** | YAML/JSON example when the tool is configurable |
| **7-Day Build Plan** | Day-by-day deliverables ending in publish |
| **Simple Data Model** | Local state / cache layout |
| **Installation** | `pip` / `npm` lines |
| **Stack** | Language, CLI framework, key libraries |
| **Market Positioning** | Users, trend alignment, competitors |
| **Success Metrics** | 6-month measurable targets |

Omit **Configuration** only when the tool is genuinely zero-config.

---

## Adding a New OSS Spec

1. **Copy** [`template.md`](./template.md) to `yourproject.md` (filename = public product name).
2. **Fill** every section; delete template HTML comments when done.
3. **Verify** PyPI/npm names (HTTP 404 on registry JSON = likely available; confirm before claiming).
4. **Cross-link** from the root [`README.md`](../README.md) table if the idea is part of the maintained set of thirteen.
5. **Optional:** Add a MicroSaaS and/or `agents/` spec if you are defining a full stack path; update [`REPORT.md`](../REPORT.md) if the portfolio narrative should include it.

---

## Quality Checklist Before You Implement

- [ ] Problem statement is specific (no generic “developers need productivity”).
- [ ] CLI examples use consistent binary/package names.
- [ ] Day 7 ends with **published** artifacts, not “polish forever.”
- [ ] Competitors are real products or libraries, not strawmen.
- [ ] AI/LLM usage is labeled **optional** or **core** explicitly.
- [ ] Data paths (`~/.tool/`) and security boundaries (what leaves the machine) are clear.

---

*This README describes the `oss/` slice of the ideas monorepo. For API products see [`../microsaas/README.md`](../microsaas/README.md); for autonomous agents see [`../agents/README.md`](../agents/README.md).*
