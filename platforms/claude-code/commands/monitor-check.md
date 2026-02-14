# /monitor-check

Run a metric health check on one or all monitors.

## Instructions

### Step 1: Determine scope

- If argument provided (monitor ID): check that specific monitor
- If `--all` flag: check all active monitors
- If no argument: show list and ask user which to check, or offer "check all"

### Step 2: Read monitor configuration

For each monitor to check:
1. Read the monitor file from `.analysis/metrics/monitors/{ID}_{slug}.md`
2. Read the linked metric definition from `.analysis/metrics/definitions/`
3. Note: check cadence, comparison basis, thresholds, auto-segment setting

### Step 3: Gather data

Ask the user for the current metric value(s).

Three data collection paths:
- **MCP query**: If MCP is configured in config.md, suggest running a query
- **Manual input**: "What's the current value of {metric}?"
- **File/screenshot**: "Paste or upload the latest data"

If auto-segment is enabled:
- Also ask for segment-level values (or suggest MCP query to get breakdown)

### Step 4: Evaluate

Compare the current value against the monitor's configuration.

**First check (no history)?**
If the Check History table is empty (this is the first check):
- Record the current value as the **baseline** — skip comparison-based evaluation
- Evaluate against **absolute thresholds** only (healthy range from the metric definition), if defined
- If no absolute thresholds available, mark status as `📊 Baseline recorded`
- Tell the user: "This is the first check. Recording {value} as your baseline. Meaningful comparisons will begin on the next check."
- Proceed directly to Step 7 (Update monitor file) — no alerts on the first check

**Normal check (history exists):**

**Comparison calculation:**

| Basis | Formula |
|-------|---------|
| WoW | (current - last_week) / last_week × 100 |
| MoM | (current - last_month) / last_month × 100 |
| YoY | (current - same_period_last_year) / same_period_last_year × 100 |
| Rolling avg | current vs {N}-day rolling average |
| Fixed target | current vs target |

**Status determination:**

| Current value | Status |
|---------------|--------|
| Within healthy range | 🟢 Healthy |
| Hits warning threshold | 🟡 Warning |
| Hits critical threshold | 🔴 Critical |

**Segment check (if enabled):**
- Check each segment independently
- Flag if any segment is in Warning/Critical even if aggregate is Healthy
- "Overall metric is 🟢, but {segment} is 🟡 — worth investigating?"

### Step 4b: Check counter-metric

If the metric definition has a counter-metric defined:
1. Look up the counter-metric's monitor (if it exists) and check its latest status
2. Report the counter-metric status alongside the primary metric:
   - Primary 🟢 + Counter 🟢: "Both healthy — improvement is genuine."
   - Primary 🟢 + Counter 🟡/🔴: "⚠️ Primary is improving but counter-metric is degrading. The improvement might come at a cost — investigate."
   - Primary 🟡/🔴 + Counter 🟢: "Counter-metric is stable, so the issue is likely real and not a measurement artifact."
3. Include the counter-metric status in the alert file's Context section (if an alert is generated)

### Step 5: Generate alert (if Warning or Critical)

If status is 🟡 or 🔴, create an alert file:

Create: `.analysis/metrics/alerts/{YYYY-MM}/{alert-id}.md`

Alert ID: `A-{YYYY}-{MMDD}-{seq}` (e.g., `A-2026-0301-001`)

```markdown
# Alert: {metric name} — {🟡 Warning / 🔴 Critical}
> Alert ID: {alert-id}
> Monitor: {monitor ID}
> Metric: {metric name}
> Detected: {YYYY-MM-DD HH:MM}

## Current Status
- **Current value**: {value}
- **Comparison basis**: {WoW / MoM / etc.}
- **Previous value**: {value}
- **Change**: {Δ absolute} ({Δ%})
- **Threshold breached**: {warning / critical}

## Context
- **Trend**: Improving / Stable / Declining (last {N} checks)
- **Counter-metric status**: {healthy / also affected}
- **Recent changes**:
  - Deployments:
  - Experiments running:
  - Marketing campaigns:
  - External events:

## Segment Breakdown (if available)
| Segment | Value | Δ | Status |
|---------|-------|---|--------|
| | | | |

## Recommended Action
- 🟡 Warning: Monitor closely in next check cycle
- 🔴 Critical: Consider escalating to Investigation

## Escalation
- [ ] Escalated to Investigation: {analysis ID, if created}
- [ ] Root cause identified:
- [ ] Resolved:
```

### Step 6: Escalation (if Critical or consecutive Warnings)

Check escalation rules from the monitor configuration:

- If **auto-escalate = Yes** and status is 🔴 Critical:
  - Suggest: "This metric hit critical threshold. Want to start an investigation? `/analysis-new --from-alert {alert-id}`"
  - If user agrees, create a new Investigation analysis with:
    - ASK pre-filled: "Why did {metric} drop to {value}? Alert {alert-id} triggered on {date}."
    - Reference the metric definition and alert context

- If **consecutive warnings** ≥ threshold (from monitor config):
  - Count consecutive 🟡 entries at the bottom of the Check History table (most recent entries)
  - Suggest: "{metric} has been in Warning for {N} consecutive checks. Want to start an investigation? `/analysis-new --from-alert {alert-id}`"

### Step 7: Update monitor file

Update the Check History table in the monitor file:
```markdown
| {date} | {value} | {Δ} | {🟢/🟡/🔴} | {notes} |
```

Update the Status and Last Checked fields in the header.

### Step 8: Update status.md

Update the Monitors table in `.analysis/status.md` with new status and last checked date.

### Step 9: Report

Show the user a summary:

**Single check:**
```
{metric}: {value} ({Δ} vs {basis}) — {🟢/🟡/🔴}
{segment issues, if any}
{recommended action, if any}
```

**Check all:**
```
Monitor Health Report — {date}
🟢 Healthy: {count}
🟡 Warning: {count} — {metric names}
🔴 Critical: {count} — {metric names}

Details:
| Monitor | Metric | Value | Δ | Status |
|---------|--------|-------|---|--------|
| ... | ... | ... | ... | ... |
```

If there are alerts: show them prominently and suggest next actions.
