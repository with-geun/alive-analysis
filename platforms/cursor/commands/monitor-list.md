# /monitor list

Show all metric monitors with their current status.

## Instructions

**Before executing**: Read `.analysis/status.md` and `.analysis/config.md` to load current state.

### Step 1: Scan monitors

Read all files in `.analysis/metrics/monitors/` matching `M-*.md`.

For each monitor, extract from the header:
- ID
- Metric name
- Status (Healthy/Warning/Critical)
- Last checked date
- Check cadence

### Step 2: Scan recent alerts

Read `.analysis/metrics/alerts/` for the current and previous month.

For each alert, extract:
- Alert ID
- Monitor ID (to link back)
- Severity (Warning/Critical)
- Date
- Resolved status

### Step 3: Display dashboard

```
===================================================
  Metric Monitors — {date}
===================================================

  Summary
  -------
  Healthy: {count}
  Warning: {count}
  Critical: {count}
  Not yet checked: {count}

  All Monitors ({total})
  ----------------------
  | ID | Metric | Cadence | Status | Last Checked | Alerts (30d) |
  |----|--------|---------|--------|-------------|--------------|
  | M-2026-0301-001 | DAU | daily | Healthy | 2026-03-05 | 0 |
  | M-2026-0301-002 | Conversion Rate | weekly | Warning | 2026-03-03 | 1 |
  | M-2026-0302-001 | Error Rate | daily | Critical | 2026-03-05 | 2 |

  Recent Alerts ({count})
  -----------------------
  | Alert ID | Monitor | Metric | Severity | Date | Resolved? |
  |----------|---------|--------|----------|------|-----------|
  | A-2026-0305-001 | M-...-002 | Conversion Rate | Warning | 2026-03-05 | No |
  | A-2026-0304-001 | M-...-001 | Error Rate | Critical | 2026-03-04 | Yes -> F-2026-0304-001 |

===================================================
```

### Step 4: Highlight overdue checks

For each monitor, compare the last checked date against the cadence:
- Daily: overdue if last checked > 1 day ago
- Weekly: overdue if last checked > 7 days ago
- Monthly: overdue if last checked > 30 days ago

If overdue, show: `{metric} is overdue for a check (last: {date}, cadence: {cadence})`

### Step 5: Optional filters

If the user provides arguments:
- `/monitor list --status warning` -> show only Warning monitors
- `/monitor list --status critical` -> show only Critical monitors
- `/monitor list --overdue` -> show only overdue monitors
- `/monitor list --alerts` -> show only monitors with unresolved alerts

### Step 6: Quick actions

After displaying the list, suggest relevant actions:
- If overdue monitors exist: "Run `/monitor check --all` to update all monitors"
- If unresolved alerts exist: "Review alerts in `.analysis/metrics/alerts/`"
- If no monitors exist: "Run `/monitor setup` to create your first monitor"
- General: "Use `/monitor check {ID}` to check a specific monitor"

**After executing**: Update `.analysis/status.md` with any state changes.
