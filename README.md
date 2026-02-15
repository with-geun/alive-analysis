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

---

## 👥 Who is this for?

- **Data Analysts** — Full mode with 5 files, checklists, and quality gates for analyses that inform real decisions
- **PMs / Non-analysts** — Quick mode (single file) with guided questions so you can analyze without a statistics background
- **Growth / Marketing teams** — A/B test module, metric monitoring, impact tracking built in
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

**16 commands** across analysis, experiments, monitoring, and modeling:

### Analysis (9 commands)
`/analysis-init` · `/analysis-new` · `/analysis-status` · `/analysis-next` · `/analysis-archive` · `/analysis-list` · `/analysis-promote` · `/analysis-search` · `/analysis-retro`

### Experiments (3 commands)
`/experiment-new` · `/experiment-next` · `/experiment-archive`

### Monitoring (3 commands)
`/monitor-setup` · `/monitor-check` · `/monitor-list`

### Modeling (1 command)
`/model-register`

**Key capabilities:**

- **Full & Quick modes** — 5-file deep analysis or single-file fast turnaround. Quick auto-promotes to Full when complexity grows.
- **3 analysis types** — Investigation ("why did X happen?"), Modeling ("can we predict Y?"), Simulation ("what if Z?")
- **A/B test experiments** — Design → Validate → Analyze → Decide → Learn. Pre-registration, SRM checks, guardrail metrics.
- **Metric monitoring** — 4-tier classification (North Star → Leading → Guardrail → Diagnostic). Auto-escalation on consecutive warnings.
- **Insight search** — Full-text search across all analyses. Cross-reference analysis, conflicting finding detection, learning suggestions.
- **Auto retrospectives** — Period-based reports with impact outcomes, recurring patterns, and unresolved follow-ups.
- **Impact tracking** — Recommendation → Decision → Execution → Result. Know if your analyses actually changed anything.
- **Tags & model registry** — Connect related analyses. Track ML model versions with drift monitoring.

### Platform support

| | Claude Code | Cursor 2.4+ |
|---|---|---|
| Interaction | Conversational (one question at a time) | Batch (all questions at once) |
| State | Session memory | File-based (`.analysis/status.md`) |
| SKILL.md | ~1,660 lines | ~265 lines |

Both platforms share the same `core/` methodology and produce identical outputs. `SKILL.md` is an [open standard](https://github.com/anthropics/claude-code) — works with any agent that supports it.

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

## 🗺️ Roadmap

- **v1.0** ✅ — ALIVE loop, Full/Quick modes, 3 analysis types, experiments, monitoring, search, retrospectives, dual-platform
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
