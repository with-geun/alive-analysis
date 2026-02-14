# alive-analysis

Data analysis workflow kit for AI coding agents.

Structure your analysis process with the **ALIVE loop** — keep your analyses alive, not just done.

```
ASK → LOOK → INVESTIGATE → VOICE → EVOLVE
 ?      👀       🔍          📢      🌱
```

## Why alive-analysis?

You ask Claude to "analyze this data" and get a one-shot answer. No structure, no tracking, no way to share the reasoning with your team. Next month, you can't even remember what you concluded.

alive-analysis fixes this:

| | Without | With alive-analysis |
|--|---------|-------------------|
| Process | Ad-hoc, different every time | Structured ALIVE loop, repeatable |
| Tracking | Lost in chat history | Versioned files, searchable archive |
| Quality | No self-check, easy to miss things | Stage checklists with quality gates |
| Team sharing | Copy-paste from chat | Git-tracked documents, audience-specific messages |

## What is this?

alive-analysis helps you:
- **Structure** analysis work into clear, repeatable stages
- **Track** multiple analyses in parallel
- **Archive** completed work with searchable summaries
- **Maintain** quality with built-in checklists

## Who is this for?

| | Data Analysts | Non-Analyst Roles |
|--|--|--|
| Goal | Deep, systematic analysis | Quick analysis with guided framework |
| Mode | Full (5 files) | Quick (1 file) |
| ALIVE loop | Thinking framework | Analysis guide |
| Types | Investigation, Modeling, Simulation | All types available |
| Checklists | Quality self-check | "Check these and you're good" guardrails |

## Example Output

Here's what a Quick analysis looks like:

```markdown
# Quick Investigation — Signup Rate Comparison
> ID: Q-2026-0212-001 | Type: Comparison | Status: Archived

## ASK
"Onboarding flow A vs B — which has higher signup completion?"
Framing: Comparison (which is better?)

## LOOK
| Segment  | Flow A | Flow B | Users (A/B)    |
|----------|--------|--------|----------------|
| Organic  | 34%    | 41%    | 3,200 / 2,800  |
| Paid     | 28%    | 32%    | 1,500 / 1,200  |

## INVESTIGATE
Flow B outperforms A in every segment (+6-7pp (percentage points)).
No Simpson's Paradox (overall trend matches every segment — no reversal).
Drop-off at step 3 (phone verification) — Flow B made it optional.

## VOICE
Ship Flow B. Monitor D7 activation (7-day return rate) as counter-metric.
Confidence: 🟢 High (organic), 🟡 Medium (paid — smaller sample)

## EVOLVE
Follow-up: Does simpler signup affect user quality? Check D30 activation.
```

See [`core/examples/`](core/examples/) for complete Full and Quick samples.

## Quick Start

### Install

```bash
# From your project directory (not inside alive-analysis)
git clone https://github.com/with-geun/alive-analysis.git /tmp/alive-analysis

# Claude Code (default)
bash /tmp/alive-analysis/install.sh

# Cursor only
bash /tmp/alive-analysis/install.sh --cursor

# Both platforms
bash /tmp/alive-analysis/install.sh --both
```

Or see [INSTALL.md](INSTALL.md) for manual setup and other options.

> **Plugin install**: Coming soon. Use manual setup for now.

### Initialize & Start

Open your project in Claude Code or Cursor, then type in the **agent chat**:

```
/analysis-init            # Full setup (10 questions)
/analysis-init --quick    # Quick setup (3 questions)
/analysis-new             # Start your first analysis
```

> All `/` commands are typed in the AI agent chat, not the terminal.

### Typical Workflow

```
/analysis-init            # One-time setup
/analysis-new             # Start an analysis (Full or Quick)
/analysis-next            # Move to the next ALIVE stage
  ... repeat until EVOLVE ...
/analysis-archive         # Archive when done
/analysis-status          # Check your dashboard anytime
```

### For PMs and Non-Analysts

Don't know what a North Star metric is? No problem.

```
/analysis-init --quick    # Just set language, team name, and mode
/analysis-new             # Pick "Quick" → start analyzing right away
```

The AI guides you through each step with questions:

```
AI: "What's the question? Is this 'why did X happen' or 'are X and Y related'?"
You: "Why did signups drop yesterday?"
AI: "Quick hypothesis: internal (bug, release) or external (competitor, platform)?"
You: "We had a release yesterday"
AI: "Let's check the data by platform and user type..."
```

See [`core/examples/quick-investigation.md`](core/examples/quick-investigation.md) for a full PM walkthrough.

## Platform Support

alive-analysis is optimized for each platform's agent model:

| | Claude Code | Cursor 2.4+ |
|---|---|---|
| Best for | Deep analysis workflows, multi-turn conversations | Quick analyses integrated into coding workflow |
| Interaction | Conversational (asks questions one by one) | Batch (presents all questions at once) |
| State management | Session memory | File-based (`.analysis/status.md`) |
| Session welcome | Auto status display on start | Manual: `/analysis-status` |
| Setup | `/analysis-init` (guided 10-step) | `/analysis-init` (single form) |
| SKILL.md | Full (~1,660 lines) | Slim (~265 lines) |
| Install | `bash install.sh` | `bash install.sh --cursor` |

Both platforms share the same core methodology (`core/`) and produce identical analysis outputs.

## Compatibility

`SKILL.md` is an open standard. alive-analysis works across agents that support it.

| Agent | Skills | Commands | Hooks | Optimized |
|-------|--------|----------|-------|-----------|
| **Claude Code** | `.claude/skills/` | `.claude/commands/` | `.claude/hooks.json` | Yes |
| **Cursor 2.4+** | `.cursor/skills/` | `.cursor/commands/` | `.cursor/hooks.json` + `.cursor/rules/` | Yes |
| **Codex** | `.codex/skills/` | — | — | Partial |

> The installer auto-detects Cursor and installs to both `.claude/` and `.cursor/`. Use `bash install.sh --cursor` for Cursor only, `--claude` for Claude Code only, or `--both` explicitly.

## Commands

### Analysis
| Command | Description |
|---------|-------------|
| `/analysis-init` | Initialize alive-analysis in your project |
| `/analysis-new` | Start a new analysis (Full or Quick) |
| `/analysis-status` | Show current analysis dashboard |
| `/analysis-next` | Advance to the next ALIVE stage |
| `/analysis-archive` | Archive a completed analysis |
| `/analysis-list` | List all analyses (active + archived, filter by tag) |
| `/analysis-promote` | Promote a Quick analysis to Full |
| `/analysis-search` | Deep search across all analyses (full-text, context, patterns) |
| `/analysis-retro` | Generate automatic retrospective report from archived analyses |

### Experiment
| Command | Description |
|---------|-------------|
| `/experiment-new` | Start a new A/B test (Full or Quick) |
| `/experiment-next` | Advance to the next experiment stage |
| `/experiment-archive` | Archive a completed experiment |

### Monitoring
| Command | Description |
|---------|-------------|
| `/monitor-setup` | Register a metric and create a monitor |
| `/monitor-check` | Run a health check on one or all monitors |
| `/monitor-list` | Show all monitors with status dashboard |

### Modeling
| Command | Description |
|---------|-------------|
| `/model-register` | Register a deployed model with version tracking |

## Features

### The ALIVE Loop

Every analysis follows five stages:

**ASK** — Define the question. Set the problem, scope, and success criteria.
**LOOK** — Observe the data. Check quality, outliers, and sampling.
**INVESTIGATE** — Analyze deeply. Form hypotheses, test them, document results.
**VOICE** — Communicate findings. Tailor messages to each audience.
**EVOLVE** — Generate next questions. Reflect, propose follow-ups, track impact.

### Analysis Modes

**Full Analysis** — For decisions that matter. Creates 5 separate files (one per ALIVE stage) with detailed checklists and quality gates.

**Quick Analysis** — Fast turnaround. Single file with abbreviated ALIVE sections and a 5-item checklist. Ideal for PMs and time-sensitive questions.

**Promote** — When a Quick analysis grows too complex (multiple hypotheses, multiple data sources, scope creep), `/analysis-promote` converts it to Full. The AI proactively suggests promotion when it detects complexity signals.

### Analysis Types

**Investigation** ("Why did X happen?") — Retrospective root cause analysis. Uses hypothesis elimination, multi-lens framework (macro/meso/micro), and causation testing with confounding checks.

**Modeling** ("Can we predict Y?") — Predictive model building. Covers feature exploration, model comparison, SHAP explanations for interpretability, and integrates with the model registry for deployment tracking.

**Simulation** ("What would happen if Z?") — Prospective policy/strategy evaluation. Defines variable relationships, runs scenario experiments with sensitivity and breakeven analysis, and uses Monte Carlo for multiple uncertain variables.

### Experiments (A/B Tests)

The ALIVE loop adapted for controlled experiments:

```
DESIGN → VALIDATE → ANALYZE → DECIDE → LEARN
  📐        ✅         🔬        🏁       📚
```

**When to use**: Testing a product change with measurable impact — feature launches, UX variations, pricing changes.

**Full experiments** (`E-*`) get 5 stage files with pre-registration, sample size calculation, and SRM checks. **Quick experiments** (`QE-*`) get a single file for low-risk tests. Both enforce guardrail metrics and confidence intervals.

### Metric Monitoring

Track key metrics with structured health checks and alert escalation.

**4-tier classification**: 🌟 North Star (1 core metric) → 📊 Leading (3-5 predictive) → 🛡️ Guardrail (safety, must not degrade) → 🔬 Diagnostic (debug on-demand).

**Alert flow**: 🟢 Healthy → 🟡 Warning (alert created, owner notified) → 🔴 Critical (investigation suggested). Consecutive warnings auto-escalate to a new analysis. Every check includes counter-metric status to detect Goodhart's Law gaming.

### Insight Search

`/analysis-search` — Deep full-text search across all analyses, not just titles.

- **Context snippets**: Shows matching lines with surrounding context, file path, and line number
- **Cross-reference analysis**: Groups analyses with similar conclusions, flags conflicting findings
- **Learning suggestions**: Detects repeated topics (suggests meta-analysis), tracks unresolved EVOLVE follow-ups, flags pending Impact Tracking items

Filter by keyword, tag, date range, analysis type, or confidence level.

### Retrospective Reports

`/analysis-retro` — Automatically generates a retrospective report from archived analyses.

Reports cover a selected period (last month, quarter, or custom range) and include: analysis activity counts, Impact Tracking outcomes (acceptance rate, top wins), recurring patterns and confidence distribution, unresolved EVOLVE follow-ups, and data-driven recommendations. Saved to `analyses/.retro/`.

### Impact Tracking

Track whether analysis recommendations actually made a difference.

```
Recommendation → Decision → Execution → Result
   (VOICE)      (Accept/   (In progress/  (Outcome
                 Reject/    Done)          notes)
                 Modify)
```

Built into the EVOLVE stage. The AI reminds you to update impact status when starting new analyses. Retrospective reports aggregate impact data across all analyses.

### Tags

Connect related analyses across time with tags (e.g., `retention`, `user-onboarding`, `pricing`).

Tags are defined at team level in `config.md` and can also be added ad-hoc per analysis. The AI suggests relevant tags when creating analyses and checks for related tagged work before starting new analysis. Tags are preserved during Quick→Full promotion.

### Model Registry

Track deployed ML models with versioned model cards in `.analysis/models/`.

Each card records performance metrics (train/validation/test/production), feature importance, training details, deployment info, and drift monitoring triggers. Versions auto-increment on retraining, with previous versions marked as retired. Links back to the originating Modeling analysis.

## Customization

Checklists live in `.analysis/checklists/` — edit them to match your team's standards. Changes are Git-tracked, so your team conventions evolve naturally.

## Roadmap

- **v1.0** ✅: ALIVE loop, Full/Quick modes, 3 analysis types, checklists, archive, metric proposal
- **v1.0** ✅: A/B test experiments, metric monitoring, Quick→Full promotion, tags, model registry
- **v1.0** ✅: Insight search (`/analysis-search`), auto retrospectives (`/analysis-retro`)
- **v1.0** ✅: Claude Code + Cursor 2.4+ dual-platform optimization
- **Next**: Team dashboard

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute.

## Glossary

New to data analysis terms? See [GLOSSARY.md](GLOSSARY.md) for definitions of key terms like Simpson's Paradox, counter-metric, STEDII, and more.

## Language Support

alive-analysis works in any language. Set your preferred language during `/analysis-init` — all AI responses, generated files, and checklist feedback will follow that language. Technical terms (ALIVE, STEDII, SHAP) stay in English as proper nouns.

## License

MIT
