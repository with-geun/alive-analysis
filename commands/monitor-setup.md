# /monitor setup

Set up a new metric monitor or register a metric definition.

## Instructions

You are helping the user set up structured metric monitoring. This command does two things:
1. **Register a metric definition** in `.analysis/metrics/definitions/`
2. **Create a monitor** for that metric in `.analysis/metrics/monitors/`

Follow these steps in order.

### Step 1: Check prerequisites

- Check if `.analysis/metrics/` folder exists. If not, create the structure:
  ```
  .analysis/metrics/
  ├── definitions/
  │   ├── north-star/
  │   ├── leading/
  │   ├── guardrail/
  │   └── diagnostic/
  ├── monitors/
  └── alerts/
  ```
- Read `.analysis/config.md` for existing metric framework (North Star, Leading, Guardrail, Diagnostic).

### Step 2: Identify the metric

**Q1: Which metric do you want to monitor?**

Three paths:
- **From config.md**: "Pick from your existing metrics in config.md" → show list
- **From EVOLVE proposal**: "Register a metric proposed during analysis" → ask for analysis ID, then:
  1. Resolve file path: Full analysis → `analyses/active/{ID}_{slug}/05_evolve.md`, Quick → `analyses/active/quick_{ID}_{slug}.md` (EVOLVE section)
  2. Read the "Proposed New Metrics" section and extract: Background, Purpose (including proposed tier), Definition & Logic, Interpretation Guide, STEDII Validation
  3. Use the extracted content to pre-fill the metric definition in Step 3
  4. **STEDII carry-forward**: If the EVOLVE proposal has completed STEDII checkboxes (`[x]`), carry them into the definition. If any are unchecked (`[ ]`), guide the user through the remaining criteria before proceeding.
- **New metric**: "Define a new metric from scratch" → guide through definition

### Step 3: Register metric definition (if not already registered)

If the metric doesn't have a definition file yet, create one.

Create file: `.analysis/metrics/definitions/{tier}/{metric-slug}.md`

```markdown
# Metric: {name}
> Tier: {🌟 North Star / 📊 Leading / 🛡️ Guardrail / 🔬 Diagnostic}
> Registered: {YYYY-MM-DD}
> Owner: {team/person}
> Source: {config.md / analysis {ID} / experiment {ID} / new}

## Definition
- **What it measures**: (one sentence)
- **Formula**: {calculation}
- **Data source**: {table, API, dashboard}
- **Granularity**: daily / weekly / monthly / per-cohort
- **Refresh cadence**: {how often the data updates}

## Interpretation
- **Direction**: ↑ higher is better / ↓ lower is better
- **Healthy range**: {min} — {max}
- **Warning threshold**: {value}
- **Critical threshold**: {value}
- **Counter-metric**: {what to watch to prevent gaming}

## Context
- **Plain-language**: "When this goes up, it means... When it drops, it means..."
- **Segments that behave differently**: {list}
- **Seasonal patterns**: {if any}
- **Known data caveats**: {if any}

## STEDII Validation
- [x] **Sensitive** — {evidence}
- [x] **Trustworthy** — {evidence}
- [x] **Efficient** — {evidence}
- [x] **Debuggable** — {evidence}
- [x] **Interpretable** — {evidence}
- [x] **Inclusive** — {evidence}

## History
| Date | Change | Reason |
|------|--------|--------|
| {YYYY-MM-DD} | Created | {source} |
```

### Step 4: Create monitor configuration

Ask the user:

**Q2: How often should we check this metric?**
- Daily (recommended for Leading/Guardrail metrics)
- Weekly (recommended for North Star, Diagnostic)
- Monthly (for slow-moving metrics)

**Q3: What should we compare against?**
- Previous period (WoW, MoM)
- Same period last year (YoY)
- Rolling average (7-day, 30-day)
- Fixed target/goal

**Q4: Should we check segments automatically?**
- Yes — break down by: {list segments from config.md or suggest common ones}
- No — aggregate only

**Q5: Who should be notified when alerts fire?**
- Owner from metric definition
- Additional stakeholders

Create file: `.analysis/metrics/monitors/{ID}_{metric-slug}.md`

Monitor ID format: `M-{YYYY}-{MMDD}-{seq}` (e.g., `M-2026-0301-001`)

```markdown
# Monitor: {metric name}
> ID: {monitor ID}
> Metric: {link to definition file}
> Status: 🟢 Healthy / 🟡 Warning / 🔴 Critical
> Last checked: {never — not yet run}
> Created: {YYYY-MM-DD}

## Configuration
- **Check cadence**: daily / weekly / monthly
- **Comparison basis**: {WoW / MoM / YoY / rolling average / fixed target}
- **Auto-segment**: {Yes: segments list / No}
- **Alert recipients**: {list}

## Thresholds
| Level | Condition | Action |
|-------|-----------|--------|
| 🟢 Healthy | Within {healthy range} | No action |
| 🟡 Warning | {warning condition} | Notify owner, add to next check agenda |
| 🔴 Critical | {critical condition} | Immediate alert, consider escalation to Investigation |

## Escalation Rules
- **Auto-escalate to Investigation**: Yes / No
  - If yes: `/analysis new --from-alert {alert-id}` will be suggested
- **Consecutive warnings before escalation**: {N} (default: 2)
- **Cool-down period after alert**: {N days} (avoid alert fatigue)

## Check History
| Date | Value | Δ from comparison | Status | Notes |
|------|-------|-------------------|--------|-------|
| | | | | |

## Related
- Metric definition: `.analysis/metrics/definitions/{tier}/{slug}.md`
- Counter-metric monitor: {ID, if exists}
- Related analyses: {list}
- Related experiments: {list}
```

### Step 5: Update status.md

Add the new monitor to a Monitors section in `.analysis/status.md`.

If the Monitors section doesn't exist, create it:
```markdown
## Monitors ({count})

| ID | Metric | Cadence | Status | Last Checked |
|----|--------|---------|--------|-------------|
| M-2026-0301-001 | DAU | daily | 🟢 | — |
```

### Step 6: Confirmation

Tell the user:
- Metric definition registered at {path}
- Monitor created at {path}
- Check cadence: {cadence}
- "Run `/monitor check` to perform the first check"
- "Run `/monitor list` to see all active monitors"
- If the metric came from an EVOLVE proposal:
  - "Metric from analysis {ID} is now formally registered and monitored"
  - Update the originating analysis's EVOLVE file: check off `[x] Set up dashboard / alert` in the Proposed New Metrics action items
  - If config.md update is also needed, remind: "Don't forget to add this metric to `.analysis/config.md` under {tier}"
