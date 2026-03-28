# OSS Tool Proposal: `checkOwners`

## The Problem This Solves

`CODEOWNERS` files drift. Teams grow, directories get restructured, new contributors appear, and the committed `CODEOWNERS` gradually stops reflecting who actually owns what. CI still passes because the file is syntactically valid. Reviews still get requested because the routing rules are intact. But the routing is wrong.

The underlying signal is in the commit history. Git already knows who touched which paths, how recently, and how often. Every team that wants accurate `CODEOWNERS` either maintains it by hand (and lets it drift) or writes a one-off script to infer it from `git log` output (and never generalizes it).

`checkOwners` makes the correct implementation a one-line install.

---

## The Product Idea

**`checkOwners`** — a Git-history-driven `CODEOWNERS` inference engine with first-class GitHub Actions support.

It observes repo history, infers likely ownership, prints the suggested `CODEOWNERS`, detects whether new commits changed the suggestion, and exposes the result inside GitHub Actions via structured outputs and workflow summaries.

```bash
pip install checkowners
```

---

## Naming

The brand is **checkOwners**, but all implementation identifiers are shell-friendly:

- **Python package:** `checkowners`
- **CLI executable:** `checkowners`
- **GitHub Action repo:** `your-org/checkowners-action`
- **Config file:** `.github/checkowners.yml`
- **Marketplace title:** `checkOwners`
- **Version tags:** `v1`, `v1.1`, `v2`

---

## CLI Commands

```bash
checkowners analyze
checkowners generate
checkowners print
checkowners validate
checkowners drift
checkowners notify
checkowners sync
checkowners github-action
```

---

## What `checkOwners` Does

The product promise:

- Observe repo history
- Infer likely ownership from commit patterns
- Print the suggested `CODEOWNERS`
- Detect whether new commits changed the suggestion
- Expose that result inside GitHub Actions via `GITHUB_OUTPUT` and `GITHUB_STEP_SUMMARY`
- Optionally notify downstream systems

---

## Core Commands

### `checkowners print`

Prints the inferred `CODEOWNERS` to stdout without mutating the repo.

```bash
checkowners print --config .github/checkowners.yml
```

Behavior:

- Print raw `CODEOWNERS` to stdout
- Optionally write to a temp file
- Optionally write a markdown explanation summary
- Always exit `0` unless the analysis itself fails

### `checkowners drift`

The core CI check.

```bash
checkowners drift --compare-to auto
```

Answers:

- Did the inferred owners change?
- What rules changed?
- Was the drift caused by the latest commits, or by a stale committed `CODEOWNERS`?

### `checkowners notify`

A thin wrapper around `drift` that emits a normalized JSON payload.

```bash
checkowners notify --compare-to auto --webhook-url "$WEBHOOK_URL"
```

The CLI decides **whether** there is something worth notifying about and produces the payload. The workflow decides whether that payload goes to Slack, Teams, email, a webhook, or a PR comment.

### `checkowners sync`

Scheduled PR-based update flow. Opens a PR that updates the committed `CODEOWNERS` to match the inferred suggestion.

---

## Drift Modes

### Repo drift

```text
suggested(HEAD) vs committed CODEOWNERS
```

Answers: is the committed `CODEOWNERS` stale relative to what history currently suggests?

### Commit-induced drift

```text
suggested(BASE_SHA) vs suggested(HEAD_SHA)
```

Answers: did the commits in this push or PR change the ownership model?

For CI use cases, **commit-induced drift** is the most important mode. It tells you whether the new commits changed the ownership model, regardless of whether anyone has updated `CODEOWNERS` yet.

---

## `compare-to: auto` Resolution

When `compare-to` is `auto`, the engine selects the comparison strategy based on the GitHub Actions event context:

| Event | Base | Head |
|---|---|---|
| `pull_request` | `github.event.pull_request.base.sha` | `github.event.pull_request.head.sha` |
| `push` | `github.event.before` | `github.sha` |
| fallback | committed `CODEOWNERS` | inferred output at `HEAD` |

On `pull_request`, `GITHUB_SHA` points at the PR merge branch, not the PR head commit. `github.event.pull_request.head.sha` must be used when the head commit is needed. If the repository uses merge queue, the `merge_group` trigger should be included or required checks can fail to report for queued merges.

---

## Repository Structure

`checkOwners` ships as two repos to keep the package lifecycle and the Marketplace lifecycle independent.

### Repo 1: `checkowners`

```text
checkowners/
  pyproject.toml
  README.md
  src/checkowners/
    cli.py
    config.py
    models.py
    repo_scanner.py
    git_analyzer.py
    ownership_engine.py
    rule_compiler.py
    drift_engine.py
    notifier.py
    platform/
      github.py
      gitlab.py
    output/
      text.py
      markdown.py
      json_report.py
```

### Repo 2: `checkowners-action`

```text
checkowners-action/
  action.yml
  README.md
  scripts/
    install.sh
    run.sh
```

Why two repos:

- Cleaner package lifecycle for the Python engine
- Cleaner Marketplace lifecycle for the action
- Fewer release collisions
- Easier semantic versioning for users who pin one but not the other

---

## GitHub Actions Integration

The action is a **composite action**, not a reusable workflow. Composite actions bundle steps into a single reusable workflow step. Reusable workflows operate at the whole-job level. The composite form fits the "drop into any workflow" goal.

### `action.yml`

```yaml
name: "checkOwners"
description: "Infer, print, and detect drift in CODEOWNERS from Git history"
author: "your-org"

inputs:
  config-path:
    description: "Path to checkOwners config"
    required: false
    default: ".github/checkowners.yml"
  compare-to:
    description: "auto | codeowners | base-sha | ref"
    required: false
    default: "auto"
  base-sha:
    description: "Explicit base SHA for drift comparison"
    required: false
  head-sha:
    description: "Explicit head SHA for drift comparison"
    required: false
  print-suggested:
    description: "Print inferred CODEOWNERS to logs"
    required: false
    default: "true"
  write-summary:
    description: "Write markdown report to workflow summary"
    required: false
    default: "true"
  fail-on-drift:
    description: "Exit non-zero when drift is detected"
    required: false
    default: "false"
  notify-webhook-url:
    description: "Optional generic webhook"
    required: false
  mode:
    description: "advisory | sync"
    required: false
    default: "advisory"

outputs:
  drift:
    description: "true if drift detected"
    value: ${{ steps.run.outputs.drift }}
  drift_kind:
    description: "repo | commit | both | none"
    value: ${{ steps.run.outputs.drift_kind }}
  suggested_path:
    description: "Path to generated suggested CODEOWNERS file"
    value: ${{ steps.run.outputs.suggested_path }}
  suggested_sha256:
    description: "SHA256 of suggested CODEOWNERS"
    value: ${{ steps.run.outputs.suggested_sha256 }}
  changed_rules_json:
    description: "JSON array of changed rules"
    value: ${{ steps.run.outputs.changed_rules_json }}
  report_json:
    description: "Full JSON report"
    value: ${{ steps.run.outputs.report_json }}

runs:
  using: "composite"
  steps:
    - name: Set up Python
      uses: actions/setup-python@v5
      with:
        python-version: "3.12"

    - name: Install checkowners
      shell: bash
      run: pip install checkowners

    - id: run
      name: Run checkOwners
      shell: bash
      env:
        INPUT_CONFIG_PATH: ${{ inputs.config-path }}
        INPUT_COMPARE_TO: ${{ inputs.compare-to }}
        INPUT_BASE_SHA: ${{ inputs.base-sha }}
        INPUT_HEAD_SHA: ${{ inputs.head-sha }}
        INPUT_PRINT_SUGGESTED: ${{ inputs.print-suggested }}
        INPUT_WRITE_SUMMARY: ${{ inputs.write-summary }}
        INPUT_FAIL_ON_DRIFT: ${{ inputs.fail-on-drift }}
        INPUT_NOTIFY_WEBHOOK_URL: ${{ inputs.notify-webhook-url }}
        INPUT_MODE: ${{ inputs.mode }}
      run: |
        checkowners github-action
```

### Inputs

| Input | Default | Description |
|---|---|---|
| `config-path` | `.github/checkowners.yml` | Path to checkOwners config |
| `compare-to` | `auto` | `auto \| codeowners \| base-sha \| ref` |
| `base-sha` | — | Explicit base SHA for drift comparison |
| `head-sha` | — | Explicit head SHA for drift comparison |
| `print-suggested` | `true` | Print inferred CODEOWNERS to logs |
| `write-summary` | `true` | Write markdown report to workflow summary |
| `fail-on-drift` | `false` | Exit non-zero when drift is detected |
| `notify-webhook-url` | — | Optional generic webhook URL |
| `mode` | `advisory` | `advisory \| sync` |

### Outputs

| Output | Description |
|---|---|
| `drift` | `true` if drift detected |
| `drift_kind` | `repo \| commit \| both \| none` |
| `suggested_path` | Path to the generated suggested CODEOWNERS file |
| `suggested_sha256` | SHA256 of suggested CODEOWNERS |
| `changed_rules_json` | JSON array of changed rules |
| `report_json` | Full JSON report |

The full suggested `CODEOWNERS` content is not exposed as a normal output string. Outputs are ideal for compact values. The suggested file is printed to logs, written to a temp file, and summarized as markdown — not stored in a step output.

---

## Usage

### Minimal workflow

```yaml
name: checkOwners

on:
  pull_request:
  push:
    branches: [main]
  merge_group:

jobs:
  ownership:
    runs-on: ubuntu-latest
    permissions:
      contents: read

    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - id: checkowners
        uses: your-org/checkowners-action@v1
        with:
          config-path: .github/checkowners.yml
          compare-to: auto
          print-suggested: true
          write-summary: true
          fail-on-drift: false
```

`fetch-depth: 0` is required. `actions/checkout` fetches only a single commit by default. `checkOwners` depends on history and commit-to-commit comparison, so the full history must be present.

### Optional notification step

```yaml
      - name: Notify webhook
        if: steps.checkowners.outputs.drift == 'true' && secrets.CHECKOWNERS_WEBHOOK_URL != ''
        env:
          WEBHOOK_URL: ${{ secrets.CHECKOWNERS_WEBHOOK_URL }}
          REPORT_JSON: ${{ steps.checkowners.outputs.report_json }}
        run: |
          curl -X POST "$WEBHOOK_URL" \
            -H "Content-Type: application/json" \
            -d "$REPORT_JSON"
```

`checkOwners` computes the decision and payload. The workflow handles delivery.

---

## What Users See in GitHub Actions

Every run produces three things:

1. **Raw suggested `CODEOWNERS` in step logs**
2. **Markdown summary in the run summary tab**
3. **Structured step outputs for downstream steps**

### Example workflow summary

```markdown
## checkOwners report

- Drift detected: yes
- Drift kind: commit
- Compared: base SHA → head SHA

### Changed rules
- `/src/payments/` from `@org/platform` to `@org/payments`
- `/src/billing/stripe/` added `@org/billing`

### Suggested CODEOWNERS
*                          @org/engineering
/.github/                  @org/platform
/src/payments/             @org/payments
/src/billing/stripe/       @org/billing
```

---

## Configuration

`.github/checkowners.yml`:

```yaml
analysis:
  lookback_days: 180
  min_commits: 3
  top_n_owners: 2

paths:
  exclude:
    - "*.lock"
    - "dist/**"
    - "vendor/**"

output:
  header: "# Generated by checkOwners. Do not edit manually."
  include_unowned: false

drift:
  mode: commit          # repo | commit | both
  compare_to: auto

notifications:
  webhook_url: ""
  include_unchanged: false
```

---

## Comparison with Manual `CODEOWNERS` Maintenance

| Capability | Manual | Ad-hoc script | `checkOwners` |
|---|:---:|:---:|:---:|
| Infers ownership from Git history | No | Partial | Yes |
| Detects stale committed `CODEOWNERS` | No | No | Yes |
| Detects commit-induced drift in CI | No | No | Yes |
| Structured outputs for downstream steps | No | No | Yes |
| Workflow summary with changed rules | No | No | Yes |
| Normalized webhook payload | No | No | Yes |
| Sync mode (auto PR to update file) | No | No | Yes |
| GitHub Actions composite action | No | No | Yes |
| Works across PR, push, and merge queue | No | No | Yes |
| Zero configuration required | Yes | Partial | Yes |

---

## Permissions

For advisory mode, the minimum required `GITHUB_TOKEN` permissions are:

```yaml
permissions:
  contents: read
```

No write access is needed unless `mode: sync` is enabled, in which case `contents: write` and `pull-requests: write` are required for the PR creation step.

---

## What `checkOwners` Does Not Do

- No enforcement of review requirements (use branch protection rules)
- No replacement of `CODEOWNERS` as the mechanism that triggers GitHub review requests
- No team membership resolution (uses handles as-is from commit author email mapping)
- No support for non-Git VCS

These are deliberate omissions. `checkOwners` infers and surfaces ownership signal. Enforcement is the responsibility of GitHub's branch protection layer.

---

## Why This Should Exist

`CODEOWNERS` is the right mechanism for routing reviews. GitHub treats it as first-class: it drives automatic reviewer assignment, required review gating, and ownership visibility across the repository. But maintaining it by hand does not scale. Teams change faster than `CODEOWNERS` files get updated, and the drift is invisible until a review goes to the wrong person or a required reviewer is unreachable.

The signal to keep `CODEOWNERS` accurate already exists in every repo's commit history. `checkOwners` reads that signal, makes the inference explicit, and surfaces the result where engineers already work — in pull request checks and workflow summaries.

Every team that wants accurate `CODEOWNERS` today either maintains it manually and watches it drift, or writes a one-off script that never gets generalized. `checkOwners` makes the correct implementation a one-line install.
