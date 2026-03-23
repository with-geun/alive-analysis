# alive-analysis

**Structured analysis workflow for AI coding agents — every analysis traceable, repeatable, and team-shareable.**

[![version](https://img.shields.io/badge/version-1.3.2-blue)](CHANGELOG.md)
[![npm](https://img.shields.io/npm/v/alive-analysis-mcp)](https://www.npmjs.com/package/alive-analysis-mcp)
[![license](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude_Code-✓-purple)](https://claude.ai/code)
[![Cursor](https://img.shields.io/badge/Cursor_2.4+-✓-orange)](https://cursor.sh)

---

## The problem

You ask AI to analyze a metric drop. It gives you an answer. You make a decision.

Three months later: *"Why did we do that?"* — gone. No reasoning, no data checks, no audit trail.

Or you open a fresh chat and start over from scratch, repeating work you've already done.

**alive-analysis fixes this.** It's an analysis workflow kit that runs inside Claude Code and Cursor. Every analysis follows a structured five-stage loop, gets saved as plain markdown files, and stays searchable. The AI guides the process — you bring the domain knowledge.

---

## How it works

```
You type a question
       ↓
AI walks you through 5 stages (ASK → LOOK → INVESTIGATE → VOICE → EVOLVE)
       ↓
Each stage is saved as a markdown file in your project
       ↓
Files are Git-tracked, searchable, and readable by any AI tool
       ↓
Three months later: open the file, see exactly why you made that call
```

---

## Quick start

```bash
# 1. Clone and install (2 minutes)
git clone https://github.com/with-geun/alive-analysis.git /tmp/alive-analysis
bash /tmp/alive-analysis/install.sh              # Claude Code
bash /tmp/alive-analysis/install.sh --cursor     # Cursor
bash /tmp/alive-analysis/install.sh --both       # Both

# 2. In your project, open the agent chat (not the terminal) and type:
/analysis-init    # One-time setup
/analysis-new     # Start your first analysis
```

That's it. The AI takes it from there.

---

## The ALIVE Loop

Every analysis — whether it takes 20 minutes or 2 weeks — follows the same five stages.

```
❓ ASK  →  👀 LOOK  →  🔍 INVESTIGATE  →  📢 VOICE  →  🌱 EVOLVE
```

| Stage | What happens |
|---|---|
| **ASK** | Define exactly what you're trying to answer. Scope, hypotheses, success criteria. The AI pushes back on vague questions until the framing is tight. |
| **LOOK** | Observe the data before drawing conclusions. Quality checks, segmentation, confounders, sample size validation. |
| **INVESTIGATE** | Analyze. Run hypotheses against data, test significance, check for Simpson's paradox, apply causal reasoning when needed. |
| **VOICE** | Communicate findings. The AI helps you write different versions for different audiences — exec summary, team walkthrough, decision memo. |
| **EVOLVE** | Close the loop. What did you learn? What comes next? Impact tracking, follow-up questions, knowledge transfer. |

The AI doesn't fill in the blanks for you. At each stage, it asks structured questions that force you to think — then records your answers.

---

## Two modes, one system

**Full mode** — for decisions that matter

Five separate files, one per stage. Built-in checklists for confounders, counter-metrics, and sensitivity analysis. Audience-specific communication templates. Used when analysis informs real action.

```
analyses/active/F-2026-0303-001_checkout-drop/
  01_ask.md
  02_look.md
  03_investigate.md
  04_voice.md
  05_evolve.md
```

**Quick mode** — for fast answers

Single file, all five stages. Same ALIVE structure, less ceremony. 20-40 minutes end-to-end. Auto-promotes to Full when complexity grows beyond a single file.

```
analyses/active/Q-2026-0308-001_dau-check.md
```

---

## Example output

```markdown
# Quick Investigation — Signup Rate Comparison
> ID: Q-2026-0212-001 | Type: Comparison | Status: Archived

## ASK
Question: Onboarding flow A vs B — which has higher signup completion?
Scope: Users who started onboarding in the last 30 days
Decision: Which flow to ship to 100% of new users

## LOOK
| Segment  | Flow A | Flow B | Users (A/B)    |
|----------|--------|--------|----------------|
| Organic  | 34%    | 41%    | 3,200 / 2,800  |
| Paid     | 28%    | 32%    | 1,500 / 1,200  |
Data quality: ✅ No tracking gaps. SRM check passed.

## INVESTIGATE
Flow B outperforms A in every segment (+6-7pp). No Simpson's Paradox.
Drop-off at step 3 — Flow B made phone verification optional.
Statistical significance: p < 0.001 (organic), p = 0.04 (paid).

## VOICE
→ Ship Flow B. Monitor D7 activation as counter-metric.
Confidence: 🟢 High (organic) · 🟡 Medium (paid — smaller sample)

## EVOLVE
Follow-up: Does simpler signup affect user quality? Check D30 activation.
Impact tracking: Decision made 2026-02-15. Review outcome in 30 days.
```

---

## Features

### 22 commands across five areas

**Analysis**
```
/analysis-init      One-time setup (language, team, data stack)
/analysis-new       Start a new analysis (Full or Quick)
/analysis-next      Move to the next ALIVE stage
/analysis-status    See current analysis progress
/analysis-archive   Mark complete and move to archive
/analysis-list      Browse all analyses with filters
/analysis-promote   Upgrade Quick → Full when complexity grows
/analysis-search    Full-text search across all analysis files
/analysis-retro     Auto-generate period retrospective report
/analysis-agent     Manually trigger specialist agent recommendations
```

**Experiments**
```
/experiment-new     Design an A/B test (pre-registration required)
/experiment-next    Move through Design → Validate → Analyze → Decide → Learn
/experiment-archive Close and archive with outcome recorded
```

**Monitoring**
```
/monitor-setup      Define metric tiers and alert thresholds
/monitor-check      Run a check against current metric values
/monitor-list       See all monitored metrics and their status
```

**Modeling**
```
/model-register     Register an ML model version (drift tracking, performance history)
```

**Education** *(see Education Mode below)*
```
/analysis-learn       Pick a practice scenario
/analysis-learn-next  Score current stage and move forward
/analysis-learn-hint  Get a progressive hint (3 levels)
/analysis-learn-review Full rubric review at the end
```

---

## 🤖 31 Specialist Agents (v1.2)

This is the part that changes how analysis actually feels.

When you move between stages with `/analysis-next`, the system automatically routes to specialists based on what's in your analysis. You don't need to know which agent to call — it figures that out from context signals in your files.

**The experience looks like this:**

```
─────────────────────────────────────────────────────────────
🤖 Specialists who may help at this stage — INVESTIGATE
─────────────────────────────────────────────────────────────
  1. stats-agent      — hypothesis scorecard has multiple tests without correction
  2. causal-agent     — causal claim present but no experiment designed
  3. peer-reviewer    — findings section has content ready for review
─────────────────────────────────────────────────────────────
Run? (1 / 2 / 3 / all / n)  →
```

Pick one number. The specialist runs, writes its output directly into your analysis file, and you move on. One question. No configuration.

### The 4 required quality gates

These run **automatically** when their conditions are triggered — no confirmation needed.

| Gate | When it runs | What it checks |
|---|---|---|
| **scope-guard** | At ASK stage start | Is the question answerable? Is scope defined? Are success criteria set? |
| **data-quality-sentinel** | At LOOK stage | Missing values, outliers, tracking gaps, SRM issues, sample size adequacy |
| **ethics-guard** | When PII or protected groups are detected | Bias risks, PII handling, fairness across demographic segments |
| **reproducibility-keeper** | At EVOLVE stage | Are methods documented? Can someone reproduce this from your file alone? |

### The 27 optional specialists

You choose these at each stage transition. The system surfaces at most 3 relevant ones.

**ASK stage**
| Agent | What it does |
|---|---|
| `problem-framer` | Restructures vague questions into crisp, answerable hypotheses |
| `hypothesis-gen` | Generates a hypothesis tree covering likely root causes |
| `metric-translator` | Maps business questions to measurable metrics and guardrails |

**LOOK stage**
| Agent | What it does |
|---|---|
| `data-scout` | Identifies what data exists, where to find it, and what's likely missing |
| `tracking-auditor` | Checks for event tracking gaps that could invalidate your analysis |
| `lineage-mapper` | Traces data from source systems to your analysis to catch transformation errors |
| `sampling-designer` | Calculates required sample sizes for statistical validity |
| `sql-writer` | Writes the SQL queries needed for your analysis, with joins and filters |

**INVESTIGATE stage**
| Agent | What it does |
|---|---|
| `eda-agent` | Suggests exploratory cuts: distributions, segments, time trends |
| `stats-agent` | Picks the right statistical test, applies multiple-testing correction, checks assumptions |
| `experiment-designer` | Designs a proper A/B test for your hypothesis (randomization, guardrails, duration) |
| `causal-agent` | Applies causal inference methods when you have a claim but no randomized experiment |
| `root-cause-analyst` | Builds a structured root cause tree (5 Whys + fishbone) |
| `ml-agent` | Recommends the right model type, features, and validation strategy |
| `forecast-agent` | Selects forecasting methods, handles seasonality, quantifies uncertainty |
| `anomaly-detector` | Classifies anomalies by type (spike, shift, gradual drift) with likely causes |

**VOICE stage**
| Agent | What it does |
|---|---|
| `chart-recommender` | Picks the right visualization type for each finding |
| `dashboard-designer` | Plans a dashboard layout around your key metrics |
| `narrative-agent` | Builds the "So what → Now what" narrative arc for your audience |
| `exec-summarizer` | Writes a 3-bullet executive summary with confidence levels |
| `decision-memo-writer` | Formats findings as a structured decision memo for stakeholders |

**EVOLVE stage**
| Agent | What it does |
|---|---|
| `metric-definer` | Formalizes metrics discovered during analysis into your metric registry |
| `semantic-layer-engineer` | Translates metric definitions into BI tool or dbt configurations |
| `dre-agent` | Designs data reliability engineering checks for your new metrics |
| `data-product-manager` | Scopes follow-up analyses as product requirements |
| `governance-steward` | Documents data ownership, access controls, and retention rules |

**Cross-cutting**
| Agent | What it does |
|---|---|
| `peer-reviewer` | Adversarial review of your findings — challenges assumptions, checks logic |

### Running agents manually

```
/analysis-agent            Show recommendations for current stage
/analysis-agent 2          Run the second recommendation
/analysis-agent "causal"   Run by name (partial match works)
/analysis-agent all        Run all recommended specialists
```

### Configuring the agent system

```yaml
# .analysis/agents.yml (auto-generated, edit freely)

agents:
  ethics-guard:
    enabled: true
    auto_run: true    # always runs when triggered
  stats-agent:
    enabled: true
    auto_run: false   # surfaces as recommendation, you decide
  peer-reviewer:
    enabled: false    # turn off entirely

settings:
  max_recommendations: 3    # how many agents to surface at once
  verbosity: normal         # minimal | normal | detailed
```

---

## 📚 Education Mode (v1.1)

Learn analysis thinking through practice — no data preparation needed.

```
/analysis-learn          Browse scenarios and pick one to start
/analysis-learn-next     Score your work and move to the next stage
/analysis-learn-hint     Get a hint (3 levels: direction → approach → near-solution)
/analysis-learn-review   Full rubric review with key takeaways
```

### 7 scenarios from real business problems

| ID | Scenario | Type | Level |
|---|---|---|---|
| b1 | Signup rate dropped yesterday — why? | Investigation | Beginner |
| b2 | Two onboarding flows — which is better? | Comparison | Beginner |
| b3 | How much does employee turnover actually cost? | Quantification | Beginner |
| i1 | DAU dropped 15% over 3 weeks | Investigation | Intermediate |
| i2 | Should we lower delivery fees? | Simulation | Intermediate |
| i3 | Did the new checkout flow improve conversion? | Experiment | Intermediate |
| i4 | Can we predict which users will churn next month? | Modeling | Intermediate |

Each scenario includes: a realistic business briefing, staged data reveals (you get data as you would in real work), 100-point rubric scoring, 3-level progressive hints, and a model solution you can compare against.

**Beginner** → Quick format (one file). Rich explanations at each step.
**Intermediate** → Full format (5 files). Minimal guidance — you're expected to know the basics.

> Graduation path: 70%+ on 2 Beginner scenarios → try Intermediate. 75%+ on Intermediate → ready for real analysis with `/analysis-new`.

---

## 📊 Team Dashboard (v1.3)

Visualize your entire analysis history as an interactive node graph. Each analysis is a node. Follow-up connections between analyses are edges.

```bash
# Export analyses from your project
bash /path/to/alive-analysis/dashboard/export.sh > export.json

# Open dashboard/alive-dashboard.html in any browser → click Load → paste JSON
```

**What you see:**
- Node size = ALIVE stage progress (small = just started, large = complete)
- Arc ring segments = which stages are done
- Dashed edges = follow-up connections between analyses
- Faint solid edges = analyses sharing the same tags
- Click a node → its connections highlight, everything else fades

**Filters:** analyst (multi-select), tags, type, status, period. ⌘K to search.

**Adding metadata per analysis:**
```yaml
# analyses/active/F-2026-0303-001_checkout-drop/meta.yml
analyst: geun
tags: [checkout, conversion]
followups: [F-2026-0305-001]
keyFinding: "2.4pp drop confirmed. UI redesign root cause."
```

**Works with Obsidian too.** Open your `analyses/` folder as an Obsidian vault. Use `[[F-2026-0305-001]]` wiki-links in your markdown — Obsidian's graph view picks them up automatically and draws the same connections the dashboard shows.

→ Full setup guide: [`dashboard/README.md`](dashboard/README.md)

---

## 🔌 MCP Server (v1.3)

alive-analysis normally runs through SKILL.md — a prompt-based system that Claude Code and Cursor read to understand the workflow. The MCP server exposes your analysis data as tool calls, so **any MCP-compatible AI client** can query it.

### When to use each

| | SKILL.md (default) | MCP Server |
|---|---|---|
| **Purpose** | Writing and running analyses | Querying analysis data |
| **Clients** | Claude Code, Cursor | Claude Code, Zed, Windsurf, Continue, any MCP client |
| **Can create analyses** | ✅ Yes | ❌ No (read-only) |
| **Install** | `install.sh` | `npx alive-analysis-mcp` |

The intended pattern: write analyses with Claude Code or Cursor using the SKILL.md workflow. Query and explore your analysis history from any other tool using the MCP server.

### Setup

Add this to `.mcp.json` in your project root:

```json
{
  "mcpServers": {
    "alive-analysis": {
      "command": "npx",
      "args": ["-y", "alive-analysis-mcp"],
      "env": {
        "ALIVE_ANALYSES_DIR": "./analyses"
      }
    }
  }
}
```

Same config works in Zed, Windsurf, and Continue — add it to whichever `settings.json` block handles MCP servers in your client.

### Available tools

| Tool | What you can ask |
|---|---|
| `alive_list` | "Show me all active investigations tagged 'checkout'" |
| `alive_get` | "Read the full content of F-2026-0303-001" |
| `alive_search` | "What have we found about retention before?" |
| `alive_dashboard_export` | "Give me the JSON to load into the dashboard" |

**npm:** [`alive-analysis-mcp`](https://www.npmjs.com/package/alive-analysis-mcp)
**MCP Registry:** [`io.github.with-geun/alive-analysis`](https://registry.modelcontextprotocol.io)
**Source:** [`mcp/`](mcp/)

---

## Platform support

| | Claude Code | Cursor 2.4+ |
|---|---|---|
| **Interaction style** | Conversational — one question at a time | Batch — all questions at once |
| **State persistence** | Session memory | File-based (`.analysis/status.md`) |
| **SKILL.md size** | ~1,870 lines (full methodology) | ~340 lines (streamlined) |
| **MCP support** | ✅ | ✅ |

Both platforms share `core/` — the same methodology, checklists, agent system, and output format. Your analysis files are identical regardless of which tool you used.

---

## File structure after install

```
your-project/
├── analyses/
│   ├── active/
│   │   ├── F-2026-0303-001_checkout-drop/   ← Full analysis (5 files)
│   │   │   ├── 01_ask.md
│   │   │   ├── 02_look.md
│   │   │   ├── 03_investigate.md
│   │   │   ├── 04_voice.md
│   │   │   ├── 05_evolve.md
│   │   │   └── meta.yml                     ← optional: analyst, tags, followups
│   │   └── Q-2026-0308-001_dau-check.md     ← Quick analysis (1 file)
│   └── archive/
│       └── 2026-03/
│           └── F-2026-0220-001_cohort/
├── ab-tests/                                 ← Experiment module
├── .analysis/
│   ├── config.md                             ← Your team settings
│   ├── agents.yml                            ← Agent enable/disable config
│   ├── metrics/                              ← Monitoring definitions
│   └── models/                              ← ML model registry
└── .mcp.json                                 ← MCP server config (optional)
```

All analysis files are plain markdown. Git-tracked. No proprietary format. Open in Obsidian, search with grep, diff in code review — it all works.

---

## Who this is for

**Data analysts** — Full mode gives you the structure to run analyses that hold up to scrutiny. Checklists catch what you'd otherwise miss at 11pm before a board presentation.

**Product managers** — Quick mode with guided questions means you can do structured analysis without a statistics background. When it gets complex, the AI tells you to escalate.

**Growth and marketing teams** — The A/B test module handles design through post-analysis. Metric monitoring connects to your analysis workflow.

**Students and aspiring analysts** — Education Mode gives you 7 realistic practice scenarios with rubric scoring and hints. The gap between textbook statistics and actual analysis work is real — this bridges it.

**Teams** — When everyone uses the same format, analysis becomes reviewable. A PM can read a data analyst's LOOK file and actually understand the data decisions made.

---

## What this is not

- **Not a BI tool.** No charts, no dashboards built in (the Team Dashboard is for visualization of your analysis history, not your metrics). alive-analysis structures your *thinking*, not your *reporting*.
- **Not a statistics library.** It doesn't run models or crunch numbers. You bring the data and the tools; it brings the process.
- **Not AI doing analysis for you.** The AI asks questions and enforces structure. The analytical judgments are yours.

---

## Roadmap

| Version | Status | What shipped |
|---|---|---|
| v1.0 | ✅ | ALIVE loop, Full/Quick modes, 3 analysis types, A/B experiments, metric monitoring, insight search, retrospectives, Claude Code + Cursor |
| v1.1 | ✅ | Education Mode: 7 practice scenarios, rubric scoring, progressive hints, Common Mistakes feedback |
| v1.2 | ✅ | Sub-agent Dispatch: 31 specialists, 4 quality gates, deterministic routing, `/analysis-agent` command |
| v1.3 | ✅ | Team Dashboard (node graph), MCP server (`alive-analysis-mcp` on npm + MCP Registry) |

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Feedback on methodology, checklists, and agent prompts especially welcome — those are the hardest parts to get right.

---

## License

MIT

---

**New to analysis terminology?** → [GLOSSARY.md](GLOSSARY.md)
**Step-by-step install help?** → [INSTALL.md](INSTALL.md)
**Language support:** Works in any language — set yours during `/analysis-init`.
