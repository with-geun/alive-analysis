# alive-analysis

Data analysis workflow kit for AI coding agents.

Structure your analysis process with the **ALIVE loop** — keep your analyses alive, not just done.

```
ASK → LOOK → INVESTIGATE → VOICE → EVOLVE
 ?      👀       🔍          📢      🌱
```

## What is this?

alive-analysis helps you:
- **Structure** analysis work into clear, repeatable stages
- **Track** multiple analyses in parallel
- **Archive** completed work with searchable summaries
- **Maintain** quality with built-in checklists (🟢 proceed / 🔴 stop)

## Who is this for?

| | Data Analysts | Non-Analyst Roles |
|--|--|--|
| Goal | Deep, systematic analysis | Quick analysis with guided framework |
| Mode | Full (5 files) | Quick (1 file) |
| ALIVE loop | Thinking framework | Analysis guide |
| Types | 🔍 Investigation, 📈 Modeling, 🔮 Simulation | All types available |
| Checklists | Quality self-check | "Check these and you're good" guardrails |

## Compatibility

`SKILL.md` is an open standard. alive-analysis works across agents that support it.

| Agent | Skills | Commands | Hooks |
|-------|--------|----------|-------|
| **Claude Code** | `.claude/skills/` | `.claude/commands/` | `.claude/hooks.json` |
| **Cursor 2.4+** | `.cursor/skills/` or `.claude/skills/` | `/migrate-to-skills` | Supported |
| **Codex** | `.codex/skills/` | — | — |

Cursor reads `.claude/skills/` directly — no conversion needed.

## Quick Start

### Claude Code
```bash
claude plugin install alive-analysis
/analysis init
/analysis new
```

### Cursor
```bash
# Copy skills to your project
cp -r skills/ .cursor/skills/

# Or let Cursor auto-detect from .claude/skills/
cp -r skills/ .claude/skills/
```
Then ask the agent: "Start a new analysis" — it will pick up the ALIVE skill automatically.

## Commands

| Command | Description |
|---------|-------------|
| `/analysis init` | Initialize alive-analysis in your project |
| `/analysis new` | Start a new analysis (Full or Quick) |
| `/analysis status` | Show current analysis dashboard |
| `/analysis next` | Advance to the next ALIVE stage |
| `/analysis archive` | Archive a completed analysis |
| `/analysis list` | List all analyses (active + archived) |

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
Fast turnaround. Single file with abbreviated ALIVE sections and 4-item checklist.

```
analyses/active/quick_Q-2026-0210-002_retention-check.md
```

If a Quick analysis grows too big: `/analysis new --from Q-2026-0210-002`

## Customization

Checklists live in `.analysis/checklists/` — edit them to match your team's standards.

```
.analysis/checklists/
├── ask.md
├── look.md
├── investigate.md
├── voice.md
└── evolve.md
```

Changes are Git-tracked, so your team conventions evolve naturally.

## Roadmap

- **Phase 1 (current)**: ALIVE loop, Full/Quick modes, 3 analysis types (Investigation/Modeling/Simulation), checklists, archive
- **Phase 2**: AB test module, metric monitoring, auto Quick-to-Full promotion
- **Phase 3**: Team dashboard, insight search, auto retrospectives

## License

MIT
