# **Harmora**

*An open-source, LLM-powered creative engine that transforms song lyrics and band names into typographically striking album covers—without writing a single line of layout code.*

---

## 1 Vision

Music is experienced with the eyes long before it reaches the ears. **Harmora** democratizes album-cover artistry by letting anyone, from indie acts to major labels, generate text-only visuals that weave a song’s lyrical essence with the band’s identity. It leverages large-language-model reasoning to satisfy stringent layout rules automatically, freeing designers to focus on narrative instead of manual alignment.

---

## 2 Core Use-Case Scenario

| Stage                  | User Action                                                                                                                                                                                  | Harmora’s Response                                                                                          |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| **1 Prompt**           | Marketing team submits *song\_lyrics* and *band\_name* plus style hints (e.g., “cyber-punk”, “minimalist noir”).                                                                             | LLM parses, cleans, and extracts candidate lyric substrings.                                                |
| **2 Layout Search**    | Behind the scenes, Harmora must find a contiguous lyric span whose first and last words intersect the band name’s vertical letters while obeying word-boundary and alphanumeric constraints. | LLM performs constrained beam search and returns one or more valid text-grids ranked by semantic relevance. |
| **3 Visual Rendering** | User selects a grid and optional typography preset.                                                                                                                                          | Rendering micro-service converts grid to SVG/PDF/PNG, ready for print.                                      |
| **4 Review & Iterate** | Stakeholders request tweaks (different lyric slice, font, or palette).                                                                                                                       | Harmora regenerates while preserving alignment invariants.                                                  |

---

## 3 Functional Requirements

1. **Alignment Intelligence**

   * Begin at the first lyric word whose first letter matches the band’s topmost vertical character.
   * Terminate at the last word that aligns with the bottom character.
   * Preserve whole words; no syllable splitting or hyphenation.
   * Strip all non-alphanumeric glyphs before layout.

2. **Quality Assurance**

   * Built-in regression suite (e.g., `test_creative_song_lyrics`) must remain green across model or rule updates.
   * Fails fast if no valid alignment exists, returning human-readable diagnostics.

3. **Multimodal Output**

   * Text-only grid for downstream typographers.
   * Optional vector artwork with customizable fonts, colors, and kerning.

4. **Extensibility Hooks**

   * Plugin system for language-specific tokenization (Japanese kana, Arabic script, etc.).
   * Style-guide presets (retro, vaporwave, brutalist) powered by CSS variables or design-token JSON.

---

## 4 Non-Functional Requirements

| Attribute       | Target & Rationale                                                 |
| --------------- | ------------------------------------------------------------------ |
| **Latency**     | ≤ 1 s for lyric spans < 500 words to enable ideation loops.        |
| **Throughput**  | 20 concurrent renders on commodity 4-core VM.                      |
| **Scalability** | Stateless API workers + GPU inference pool for LLM tasks.          |
| **Reliability** | 99.9 % monthly SLA (cover launches are date-critical).             |
| **Security**    | Lyrics stored encrypted at rest; opt-in anonymized telemetry only. |
| **Compliance**  | CC-BY-SA license for model prompts; artwork remains user-owned.    |

---

## 5 System Overview

### 5.1 Macro Components

1. **Prompt Gateway**
   *RESTful edge layer* that validates payloads, performs rate-limiting, and routes to the orchestrator.

2. **Orchestrator**
   Coordinates LLM calls, deterministic layout checks, and asset generation pipelines. Contains the *Invariance Engine* that enforces the four core requirements.

3. **LLM Alignment Service**
   Uses constrained-decoding techniques + heuristic pruning to locate valid lyric substrings. Fine-tuned on thousands of synthetic alignment puzzles.

4. **Renderer**
   Stateless micro-service that ingests a text grid + styling hints and emits SVG → raster formats via headless browser or Skia.

5. **Artifact Store**
   Version-controlled object storage (e.g., S3 + Git-style metadata) for reproducible covers.

6. **Telemetry & QA**
   Real-time dashboard aggregates unit-test pass-rates, alignment failure reasons, and user feedback loops for continuous improvement.

### 5.2 Data Flow Narrative

1. **Input** → Prompt Gateway (validation)
2. **Gateway** → Orchestrator (task graph init)
3. **Orchestrator** → LLM Alignment Service (lyric span search)
4. **Alignment OK** → Renderer (visualize)
5. **Renderer Output** → Artifact Store (persist & CDN edge)
6. **Orchestrator** → Client (cover URL + audit trail)

---

## 6 LLM Strategy

| Layer                  | Model Role                                                     | Specialization Technique                                                         |
| ---------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| **Base**               | Language understanding of lyrics across genres.                | Open-weights model (e.g., Mixtral) distilled for music corpora.                  |
| **Task-Specific Head** | Constrained generation of alignment grids.                     | Reinforcement learning from unit-test feedback; lexical alignment reward signal. |
| **Guardrails**         | Safety & compliance checks (e.g., explicit content filtering). | Regex + small “refusal” model ensemble; policy defined in YAML.                  |

---

## 7 User-Facing Interfaces

* **CLI** ― batch generate covers via `harmora create --lyrics path.txt --band "Muse" --preset "cyber"`
* **Web UI** ― drag-and-drop lyrics, live preview, real-time constraint-pass indicator.
* **Figma Plugin** ― import grid as editable text layers for advanced design tweaks.
* **REST API** ― JSON in, artifact URL & metadata out (e.g., layout validity score, token counts).

---

## 8 Roadmap

| Quarter     | Milestone                | Key Deliverables                                            |
| ----------- | ------------------------ | ----------------------------------------------------------- |
| **Q3 2025** | *Public Alpha*           | Core alignment engine, unit-tests, CLI.                     |
| **Q4 2025** | *Designer-Friendly Beta* | Web UI, preset theming, SVG export.                         |
| **Q1 2026** | *Multilingual Support*   | Tokenizer plugins, RTL layout handler.                      |
| **Q2 2026** | *Community Extensions*   | Marketplace for presets & tokenizer modules, plugin SDK v1. |

---

## 9 Community & Governance

* **License**: Apache-2.0 (code) + CC-BY-4.0 (documentation).
* **Stewardship**: Open collective with advisory board of designers & ML engineers.
* **Contribution Model**:

  1. Propose via GitHub Discussion → design review call.
  2. Draft PR with updated regression tests.
  3. Maintainer sign-off when *test\_creative\_song\_lyrics* remains green.

---

## 10 Value Proposition

| Stakeholder               | Benefit                                                                                                                                   |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Artists & Labels**      | Rapidly iterate album aesthetics without hiring specialized typographers for every concept.                                               |
| **Designers**             | Offload tedious alignment constraints, focusing on higher-order visual storytelling.                                                      |
| **Open-Source Community** | A showcase project blending LLM reasoning with deterministic constraints—ideal for educational deep-dives into hybrid AI + rules systems. |

---

## 11 Getting Started (No-Code)

1. **Clone** the repository.
2. **Install** dependencies via one-liner script.
3. **Run** `harmora demo` to launch the interactive playground in your browser.
4. **Explore** generated covers, inspect alignment diagnostics, and share feedback.

---

## 12 Call to Action

Join *Harmora* to push the boundaries of textual art in music. Whether you’re a developer eager to hack on constrained NLP, a designer craving automation superpowers, or a musician seeking standout visuals—your creativity belongs here. Fork, star, and start the conversation!
