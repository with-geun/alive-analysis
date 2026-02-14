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

```bash
/analysis init            # Full setup (10 questions)
/analysis init --quick    # Quick setup (3 questions)
/analysis new             # Start your first analysis
```

### For PMs and Non-Analysts

Don't know what a North Star metric is? No problem.

```bash
/analysis init --quick    # Just set language, team name, and mode
/analysis new             # Pick "Quick" → start analyzing right away
```

The AI will guide you through each step. Here's a taste:

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
| Session welcome | Auto status display on start | Manual: `/analysis status` |
| Setup | `/analysis init` (guided 10-step) | `/analysis init` (single form) |
| SKILL.md | Full (~1,660 lines) | Slim (~250 lines) |
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
| `/analysis init` | Initialize alive-analysis in your project |
| `/analysis new` | Start a new analysis (Full or Quick) |
| `/analysis status` | Show current analysis dashboard |
| `/analysis next` | Advance to the next ALIVE stage |
| `/analysis archive` | Archive a completed analysis |
| `/analysis list` | List all analyses (active + archived, filter by tag) |
| `/analysis promote` | Promote a Quick analysis to Full |

### Experiment
| Command | Description |
|---------|-------------|
| `/experiment new` | Start a new A/B test (Full or Quick) |
| `/experiment next` | Advance to the next experiment stage |
| `/experiment archive` | Archive a completed experiment |

### Monitoring
| Command | Description |
|---------|-------------|
| `/monitor setup` | Register a metric and create a monitor |
| `/monitor check` | Run a health check on one or all monitors |
| `/monitor list` | Show all monitors with status dashboard |

### Modeling
| Command | Description |
|---------|-------------|
| `/model register` | Register a deployed model with version tracking |

## The ALIVE Loop

### ASK — Define the question
What do we want to know? Set the problem, scope, and success criteria.

### LOOK — Observe the data
What does the data show? Check quality, outliers, and sampling.

### INVESTIGATE — Analyze deeply
Why is it happening? Form hypotheses, test them, document results.

### VOICE — Communicate findings
How do we explain this? Tailor messages to each audience.

### EVOLVE — Generate next questions
What should we ask next? Reflect, propose follow-ups, find automation opportunities.

## Analysis Modes

### Full Analysis
For decisions that matter. Creates 5 separate files, one per ALIVE stage, with full checklists.

```
analyses/active/F-2026-0210-001_dau-drop/
├── 01_ask.md
├── 02_look.md
├── 03_investigate.md
├── 04_voice.md
├── 05_evolve.md
└── assets/
```

### Quick Analysis
Fast turnaround. Single file with abbreviated ALIVE sections and 5-item checklist.

```
analyses/active/quick_Q-2026-0210-002_retention-check.md
```

If a Quick analysis grows too big: `/analysis promote`

## Experiments (A/B Tests)

The ALIVE loop adapted for controlled experiments:

```
DESIGN → VALIDATE → ANALYZE → DECIDE → LEARN
  📐        ✅         🔬        🏁       📚
```

Full experiments get 5 files with pre-registration, sample size calculation, and SRM checks. Quick experiments get a single file for low-risk tests.

## Metric Monitoring

Track key metrics over time with structured health checks and alerts.

```
Monitor Setup → Regular Checks → Alerts → Escalation to Investigation
```

Metrics from EVOLVE proposals flow directly into monitoring: propose a metric during analysis, then `/monitor setup` to track it.

## Customization

Checklists live in `.analysis/checklists/` — edit them to match your team's standards. Changes are Git-tracked, so your team conventions evolve naturally.

## Roadmap

- **Phase 1** ✅: ALIVE loop, Full/Quick modes, 3 analysis types, checklists, archive, metric proposal conversation
- **Phase 2** ✅: A/B test experiments, metric monitoring, Quick→Full promotion, tags, model registry, analysis ethics
- **Phase 3**: Team dashboard, insight search, auto retrospectives

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute.

## Glossary

New to data analysis terms? See [GLOSSARY.md](GLOSSARY.md) for definitions of key terms like Simpson's Paradox, counter-metric, STEDII, and more.

## Language Support

alive-analysis works in any language. Set your preferred language during `/analysis init` — all AI responses, generated files, and checklist feedback will follow that language. Technical terms (ALIVE, STEDII, SHAP) stay in English as proper nouns.

## License

MIT
