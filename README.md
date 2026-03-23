# alive-analysis

**Make every data analysis traceable, repeatable, and team-shareable — inside your AI coding agent.**

---

## 🚀 TL;DR

Turn AI into a **structured analysis partner** instead of a one-shot answer machine.
Every analysis follows 5 stages (ASK → LOOK → INVESTIGATE → VOICE → EVOLVE), gets saved as Git-tracked markdown, and stays searchable forever.

```
/analysis-init     # One-time setup (3 min)
/analysis-new      # Start analyzing
```

Works in **Claude Code** and **Cursor 2.4+**. Free and open source.

> **Use this when:** You're doing analysis with AI and don't want your reasoning to disappear in chat history.

```
AI Agent → ALIVE Loop → Versioned Analysis Files → Searchable Knowledge Base
```

---

## 👥 Who is this for?

- **Data Analysts** — Full mode with 5 files, checklists, and quality gates for analyses that inform real decisions
- **PMs / Non-analysts** — Quick mode (single file) with guided questions so you can analyze without a statistics background
- **Growth / Marketing teams** — A/B test module, metric monitoring, impact tracking built in
- **Students / Aspiring analysts** — Learn mode with 7 practice scenarios, rubric-based scoring, and progressive hints
- **Anyone using AI for analysis** — Stop losing insights in chat history

---

## ❓ Why this exists

When you ask AI to "analyze this data," you get a one-shot answer. No structure, no tracking, no way to revisit your reasoning next month.

| Problem | How alive-analysis fixes it |
|---|---|
| Analysis is ad-hoc and different every time | Structured ALIVE loop, same quality every time |
| Insights vanish in chat history | Git-tracked markdown files, searchable archive |
| Easy to skip important checks | Stage checklists catch confounders, counter-metrics, sensitivity |
| Hard to share reasoning with your team | Audience-specific messaging, versioned documents |

---

## 🧠 The ALIVE Loop

Every analysis follows five stages. The AI doesn't generate answers — it **asks you questions** at each stage to structure your thinking.

```
ASK → LOOK → INVESTIGATE → VOICE → EVOLVE
 ?      👀       🔍          📢      🌱
```

- **ASK** — Define the question. Scope, hypothesis tree, success criteria.
- **LOOK** — Observe data. Quality checks, segmentation, confounders.
- **INVESTIGATE** — Analyze. Hypotheses, testing, multi-lens framework.
- **VOICE** — Communicate. "So what → Now what" for each audience.
- **EVOLVE** — Next questions. Follow-ups, impact tracking, reflection.

---

## ⚡ Quick Demo

```
1. /analysis-init --quick        # Set language, team, mode
2. /analysis-new                 # "Why did D7 retention drop?"
3. AI asks questions → you answer → ASK stage done
4. /analysis-next                # Move through LOOK → INVESTIGATE → VOICE → EVOLVE
5. /analysis-archive             # Done. File saved, searchable, Git-tracked.
```

The AI guides every step — you bring the domain knowledge, it brings the structure.

---

## 📄 Example Output

A completed Quick analysis looks like this:

```markdown
# Quick Investigation — Signup Rate Comparison
> ID: Q-2026-0212-001 | Type: Comparison | Status: Archived

## ASK
"Onboarding flow A vs B — which has higher signup completion?"

## LOOK
| Segment  | Flow A | Flow B | Users (A/B)    |
|----------|--------|--------|----------------|
| Organic  | 34%    | 41%    | 3,200 / 2,800  |
| Paid     | 28%    | 32%    | 1,500 / 1,200  |

## INVESTIGATE
Flow B outperforms A in every segment (+6-7pp).
No Simpson's Paradox. Drop-off at step 3 — Flow B made phone verification optional.

## VOICE
Ship Flow B. Monitor D7 activation as counter-metric.
Confidence: 🟢 High (organic), 🟡 Medium (paid — smaller sample)

## EVOLVE
Follow-up: Does simpler signup affect user quality? Check D30 activation.
```

See [`core/examples/`](core/examples/) for Full and Quick samples.

---

## ⚙️ Quick Start

### Install

```bash
git clone https://github.com/with-geun/alive-analysis.git /tmp/alive-analysis

bash /tmp/alive-analysis/install.sh            # Claude Code (default)
bash /tmp/alive-analysis/install.sh --cursor   # Cursor only
bash /tmp/alive-analysis/install.sh --both     # Both platforms
```

See [INSTALL.md](INSTALL.md) for manual setup.

### Start

Open your project in Claude Code or Cursor, then type in the **agent chat** (not the terminal):

```
/analysis-init            # Full setup (10 questions) or --quick (3 questions)
/analysis-new             # Start your first analysis
```

---

## ✨ Core Features

**21 commands** across analysis, experiments, monitoring, modeling, and education:

### Analysis (10 commands)
`/analysis-init` · `/analysis-new` · `/analysis-status` · `/analysis-next` · `/analysis-archive` · `/analysis-list` · `/analysis-promote` · `/analysis-search` · `/analysis-retro` · `/analysis-agent`

### Experiments (3 commands)
`/experiment-new` · `/experiment-next` · `/experiment-archive`

### Monitoring (3 commands)
`/monitor-setup` · `/monitor-check` · `/monitor-list`

### Modeling (1 command)
`/model-register`

### Education (4 commands)
`/analysis-learn` · `/analysis-learn-next` · `/analysis-learn-hint` · `/analysis-learn-review`

**Key capabilities:**

- **Full & Quick modes** — 5-file deep analysis or single-file fast turnaround. Quick auto-promotes to Full when complexity grows.
- **3 analysis types** — Investigation ("why did X happen?"), Modeling ("can we predict Y?"), Simulation ("what if Z?")
- **A/B test experiments** — Design → Validate → Analyze → Decide → Learn. Pre-registration, SRM checks, guardrail metrics.
- **Metric monitoring** — 4-tier classification (North Star → Leading → Guardrail → Diagnostic). Auto-escalation on consecutive warnings.
- **Insight search** — Full-text search across all analyses. Cross-reference analysis, conflicting finding detection, learning suggestions.
- **Auto retrospectives** — Period-based reports with impact outcomes, recurring patterns, and unresolved follow-ups.
- **Impact tracking** — Recommendation → Decision → Execution → Result. Know if your analyses actually changed anything.
- **Tags & model registry** — Connect related analyses. Track ML model versions with drift monitoring.
- **Education mode** — 7 practice scenarios across 4 analysis types. Rubric-based 100-point scoring, 3-level progressive hints, Common Mistakes feedback. Beginner (Quick) and Intermediate (Full) difficulty.
- **Sub-agent dispatch** — 31 specialist agents auto-run or surface recommendations at each stage. 4 required quality gates (scope, data quality, ethics, reproducibility) + 27 optional specialists (stats, SQL, ML, narrative, causal, etc.). One confirmation question, max 3 recommendations per stage.
- **Team Dashboard** — single HTML file visualizing all analyses as a node graph. Follow-up chains as edges, 3-level click highlighting, multi-select filters, ⌘K search. Export from `analyses/` with one bash command.

### Platform support

| | Claude Code | Cursor 2.4+ |
|---|---|---|
| Interaction | Conversational (one question at a time) | Batch (all questions at once) |
| State | Session memory | File-based (`.analysis/status.md`) |
| SKILL.md | ~1,870 lines | ~340 lines |

Both platforms share the same `core/` methodology and produce identical outputs. `SKILL.md` is an [open standard](https://github.com/anthropics/claude-code) — works with any agent that supports it.

---

## 📚 Education Mode (v1.1)

Learn data analysis thinking through guided practice — no real data needed.

```
/analysis-learn          # Pick a scenario and start practicing
/analysis-learn-next     # Get scored, then move to next stage
/analysis-learn-hint     # Stuck? Get a progressive hint (3 levels)
/analysis-learn-review   # Finish and get a full rubric review
```

### 7 Practice Scenarios

| | Scenario | Type | Difficulty |
|---|---|---|---|
| b1 | Why did signups drop yesterday? | Investigation | Beginner |
| b2 | Which onboarding flow is better? | Comparison | Beginner |
| b3 | How much does turnover cost us? | Quantification | Beginner |
| i1 | Why did DAU drop 15%? | Investigation | Intermediate |
| i2 | Should we lower delivery fees? | Simulation | Intermediate |
| i3 | Did the new checkout flow improve conversion? | Experiment | Intermediate |
| i4 | Can we predict which users will churn? | Modeling | Intermediate |

### How it works

1. Pick a scenario — you get a realistic business briefing
2. Work through each ALIVE stage — the AI guides you with educational annotations
3. Get scored at each stage — rubric-based 100-point scoring with targeted feedback
4. If you're stuck, ask for hints — they get progressively more specific (3 levels)
5. At the end, get a full review with key takeaways and next scenario recommendation

**Beginner** scenarios use Quick format (single file, rich explanations). **Intermediate** scenarios use Full format (5 files, minimal guidance — closer to real work).

> **Graduation path**: Complete 2+ Beginner scenarios at 70%+ → try Intermediate. Complete Intermediate at 75%+ → you're ready for real analysis with `/analysis-new`.

---

## 🤖 Sub-agent Dispatch (v1.2)

Specialist agents auto-activate at the right moment — without you having to ask.

```
/analysis-agent          # Show specialist recommendations for current stage
/analysis-agent 1        # Run the top recommendation directly
/analysis-agent "sql"    # Run by alias (Korean/English both work)
```

### How it works

At each stage transition (`/analysis-next`), the system:
1. **Auto-runs required gates** — no confirmation needed
2. **Surfaces up to 3 optional specialists** — one question, you pick

```
─────────────────────────────────────────────────────
🤖 Specialist Recommendations — INVESTIGATE stage
─────────────────────────────────────────────────────
  1. stats-agent  —  Hypothesis scorecard has causal claims
  2. ml-agent     —  Analysis type: Modeling
  3. peer-reviewer — Results section has content
─────────────────────────────────────────────────────
Run? (1 / 2 / 3 / all / n)  →
```

### 31 specialists across all stages

| Stage | Agents |
|-------|--------|
| **Required gates** ⚡ | scope-guard · data-quality-sentinel · ethics-guard · reproducibility-keeper |
| ASK | problem-framer · hypothesis-gen · metric-translator |
| LOOK | data-scout · tracking-auditor · lineage-mapper · sampling-designer · sql-writer |
| INVESTIGATE | eda-agent · stats-agent · experiment-designer · causal-agent · root-cause-analyst · ml-agent · forecast-agent · anomaly-detector |
| VOICE | chart-recommender · dashboard-designer · narrative-agent · exec-summarizer · decision-memo-writer |
| EVOLVE | metric-definer · semantic-layer-engineer · dre-agent · data-product-manager · governance-steward |
| Cross-cutting | peer-reviewer |

⚡ = auto-runs when triggered, no confirmation required

Configure in `.analysis/agents.yml` — enable/disable individual agents, adjust verbosity, set gates to always-run.

---

## 📊 Team Dashboard (v1.3)

Visualize your entire analysis history as an interactive node graph.

```bash
# Export your analyses (run from project root)
bash /path/to/alive-analysis/dashboard/export.sh > export.json

# Open dashboard/alive-dashboard.html in browser → Load → paste JSON
```

**What you see:**
- Each analysis as a node — size shows ALIVE stage progress, arc ring shows completed stages
- Follow-up connections as dashed edges — trace which questions spawned which
- Click any node — connected analyses highlight, others dim
- Filter by analyst (multi-select), tags, type, status, period
- ⌘K to search across title, ID, analyst, tags

**Add optional metadata per analysis:**

```yaml
# analyses/active/F-2026-0303-001_checkout-drop/meta.yml
analyst: geun
tags: [checkout, conversion]
followups: [F-2026-0305-001]
keyFinding: "결제 UI 리디자인 이후 2.4pp 하락 확인"
```

**Obsidian:** Open `analyses/` directly as a vault. Use `[[F-2026-0305-001]]` wiki-links in your markdown — Obsidian graph view picks them up automatically.

→ See `dashboard/README.md` for full setup guide.

---

## 🧩 What this is NOT

- **Not a BI dashboard** — No charts or visualizations. It structures your *thinking*, not your *reporting*.
- **Not a statistics library** — It doesn't run models or crunch numbers. You bring the data, it brings the process.
- **Not AI doing analysis for you** — The AI asks questions and enforces structure. You make the analytical judgments.

---

## 📊 How teams use it

- **Growth team**: Quick analysis on metric drops → finds root cause in one session → archives with action items
- **PM**: `/analysis-new` Quick mode to investigate a feature hypothesis before writing a spec
- **Data team**: Full analysis for board-level decisions → checklists ensure nothing is missed → Impact Tracking proves ROI
- **Cross-functional**: PMs do Quick analyses independently, escalate to analysts for Full when needed

---

## 🧪 Early use cases

Currently being tested in:
- Metric investigations (retention drops, conversion changes)
- Experiment reviews (A/B test design and post-analysis)
- Decision memos (structured reasoning for stakeholder alignment)

Real walkthrough coming soon.

---

## 🗺️ Roadmap

- **v1.0** ✅ — ALIVE loop, Full/Quick modes, 3 analysis types, experiments, monitoring, search, retrospectives, dual-platform
- **v1.1** ✅ — Education Mode with 7 practice scenarios, rubric scoring, progressive hints, Common Mistakes feedback
- **v1.2** ✅ — Sub-agent Dispatch System: 31 specialist agents, deterministic routing, 4 quality gates, `/analysis-agent` command
- **Next** — Team dashboard

---

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Feedback on checklists and methodology especially welcome.

---

## ⭐ If this resonates

If alive-analysis helps you think more clearly about data, consider giving it a star. It helps others find the project.

---

## 📜 License

MIT

---

**Glossary**: New to data analysis terms? See [GLOSSARY.md](GLOSSARY.md).
**Language**: Works in any language — set yours during `/analysis-init`.
