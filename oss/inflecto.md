# **Inflecto – Multilingual Drift Explorer**

*An open-source research tool that quantifies how technical meaning distorts when statements are cycled through multiple languages by Large-Language-Model translators.*

---

## 1. Problem Statement

Natural-language processing systems are increasingly used for cross-lingual knowledge sharing, yet **semantic drift**—the incremental loss or mutation of meaning during translation—remains poorly understood.
**Inflecto** measures how quickly and in what ways core technical content degrades when it is:

1. **Translated** from English into a series of *N* randomly selected natural languages by different LLMs.
2. **Back-translated** to English after each hop.
3. **Scored** for fidelity against the original statement using an independent “judge” LLM.

The goal is to surface patterns of degradation, identify high-risk language pairs, and produce actionable insights for anyone building multilingual AI systems.

---

## 2. Translation Cycle

| Phase     | Prompt Role                                                                                      | Expected Output                                       |
| --------- | ------------------------------------------------------------------------------------------------ | ----------------------------------------------------- |
| **E → L** | “Translate the following technical statement into *Language X*.”                                 | A concise, domain-accurate translation.               |
| **L → E** | “Translate the following text back to English, preserving as much technical detail as possible.” | A concise English rendition of the prior translation. |

### Example Chain (Excerpt)

| Cycle | Language     | Model         | Content                                                                   |
| ----- | ------------ | ------------- | ------------------------------------------------------------------------- |
| 0     | —            | —             | `Redis uses single-threaded event loops with epoll for I/O multiplexing.` |
| 1     | German       | Gemini-Flash  | `Redis verwendet ereignisgesteuerte Einzelschleifen...`                   |
| 2     | — (Back-ENG) | Claude-Sonnet | `Redis relies on an event-driven single loop with epoll to handle I/O.`   |
| 3     | Japanese     | Llama-Edge    | `Redis は epoll を用いたイベント駆動型の単一ループを使用しています。`                                |
| …     | …            | …             | …                                                                         |

---

## 3. Implementation Requirements

### 3.1 LLM & Language Selection

* Connect via a unified gateway (e.g., OpenRouter) to **≥ 3 distinct LLM families**.
* Support **≥ 10 target languages**; pick a new language each cycle using weighted randomness.
* Reserve one high-capacity model exclusively as the **judge**.

### 3.2 Prompt Templates

#### ENGLISH → LANGUAGE X

```
You are a professional technical translator. Translate the statement below into <LANGUAGE>. 
Maintain terminology and avoid paraphrasing.

Statement:
"{english_text}"

Translation (<LANGUAGE>):
```

#### LANGUAGE X → ENGLISH

```
Translate the text below back to English. Preserve all technical nuance.

Text (<LANGUAGE>):
"{foreign_text}"

Translation (English):
```

### 3.3 Scoring (LLM-as-Judge)

* Judge prompt must request a **JSON** object: `{"score": {1-10}, "notes": "<optional>"}`
* Evaluate **semantic preservation**, **terminology accuracy**, and **lack of hallucination**.
* **Termination rule:** stop when average score ≤ 3 or after 25 cycles.

### 3.4 Robustness & Observability

* Exponential back-off, retry queues, and graceful degradation on API errors.
* Real-time streaming of cycle metadata to STDOUT and persistent storage.

### 3.5 Persistence Schema

Store every hop as a structured record (e.g., JSONL or Parquet):

| Field       | Description                  |
| ----------- | ---------------------------- |
| `timestamp` | ISO-8601 UTC                 |
| `cycle`     | Sequential integer           |
| `direction` | `E→L` or `L→E`               |
| `language`  | ISO-639-1 code               |
| `model`     | Provider/model-id            |
| `text`      | Raw segment                  |
| `score`     | Judge score *(null for E→L)* |

---

## 4. Command-Line Example

```bash
inflecto --seed "B-tree indices provide O(log n) lookup complexity" --languages 15
```

Upon completion:

```
DRIFT THRESHOLD REACHED (cycle 14) – results saved to experiments/btree_2025-07-11/
```

---

## 5. Acceptance Criteria

1. **Functional**

   * Runs end-to-end with a single shell command after dependency installation.
   * Executes **≥ 3 experiments** across **≥ 3 distinct seed statements**.

2. **Reporting**

   * Writes chain data to `experiments/` with cycle-level granularity.
   * Generates an **aggregated summary**: average cycles to drift, highest-risk languages, and model fidelity ranking.

3. **Quality**

   * 90 %+ automated test coverage for core logic (prompt generation, scoring, persistence).
   * Clear, modular project structure enabling plug-and-play LLM or judge replacements.

---

## 6. Suggested Seed Statements

1. `TLS uses asymmetric cryptography for key exchange and symmetric cryptography for data encryption.`
2. `Kafka achieves fault tolerance by replicating partitions across multiple brokers.`
3. `Docker layers leverage copy-on-write filesystems to minimize storage overhead.`
4. `Kubernetes employs etcd with Raft consensus for distributed state storage.`
5. `TCP congestion control relies on slow-start and AIMD to avoid network collapse.`

---

## 7. Project Structure

```
inflecto/
├── cli/                # Entry points & argument parsing
├── core/               # Orchestration, language routing, cycle controller
├── prompts/            # Jinja or text-template files
├── judge/              # Scoring logic & model abstraction
├── storage/            # Persistence adapters (local FS, cloud object, SQL)
├── experiments/        # Auto-created run folders
└── docs/               # Full project documentation
```

---

## 8. Key Features

| Feature                       | Description                                                                                             |
| ----------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Random Language Walk**      | Each cycle selects a new language by weighted probability, mimicking real-world multilingual pipelines. |
| **Model Rotation**            | Source translators stagger across LLM providers to isolate model-specific drift.                        |
| **Judge Ensemble (Optional)** | Average multiple judge scores for greater robustness.                                                   |
| **Drift Heat-Map**            | Auto-generated visualization of score decay over cycles and languages.                                  |
| **Plugin System**             | Drop-in modules for custom prompt templates, scoring strategies, or storage back-ends.                  |

---

## 9. Roadmap & Nice-to-Haves

* **Adaptive Pathing:** Dynamically choose next language based on current score trajectory.
* **Domain Packs:** Pre-bundled seed statements for networking, databases, security, and ML.
* **Interactive Dashboard:** Real-time explorer powered by lightweight web UI.
* **Community Benchmarks:** Shared leaderboard of language pairs and model combinations.
* **Bias Sentinel:** Parallel evaluation of cultural or gender bias drift during translation cycles.

---

## 10. Documentation Suite

1. **`README.md`** – Quick-start, core concepts, and basic configuration.
2. **`CONTRIBUTING.md`** – Branch strategy, linting rules, commit message conventions, and review workflow.
3. **`DESIGN.md`** – Architectural diagrams, sequence flows, and trade-off analysis.
4. **`ROADMAP.md`** – Milestones, feature backlog, and release cadence.
5. **`LICENSE`** – Permissive OSS license (e.g., MIT).

---

## 11. Community & Governance

* **Issues & Discussions** – Use GitHub issues for bugs and feature ideas; discussions for research findings.
* **Code of Conduct** – Inclusive, respectful collaboration guidelines.
* **Steering Group** – Rotating maintainers curate PRs and roadmap priorities.
* **Research Citations** – Encourage users to cite Inflecto in academic papers via provided BibTeX entry.

---

## 12. Acknowledgments

* Inspired by the classic “telephone game” and multilingual translation studies.
* Leverages modern LLM gateways for seamless model interoperability.
* Special thanks to the open-source community for testing, feedback, and continued innovation.

---

> **Inflecto** helps practitioners, researchers, and language technologists **see the invisible slipstream** where meaning drifts—and empowers them to build more reliable multilingual AI systems.
