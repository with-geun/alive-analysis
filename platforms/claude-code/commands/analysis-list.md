# /analysis-list

List all analyses (active + archived).

## Instructions

### Step 1: Scan active analyses

Read all files/folders in `analyses/active/`:
- Full analyses: folders matching `F-*`
- Quick analyses: files matching `quick_Q-*`

### Step 2: Scan archived analyses

Read all year-month folders in `analyses/archive/`:
- List each analysis with its summary (if summary.md exists)

### Step 3: Display full list

Format output grouped by status:

```
═══════════════════════════════════════════════════
  alive-analysis — All Analyses
═══════════════════════════════════════════════════

  🟡 Active (2)
  ─────────────
  F-2026-0210-001  DAU drop investigation      🔍 INVESTIGATE  [retention, mobile]
  Q-2026-0210-002  Retention check              📢 VOICE       [retention, onboarding]

  ✅ Archived — 2026-02 (3)
  ──────────────────────────
  F-2026-0208-001  Payment funnel analysis      → "Desktop 2x higher conversion"
  Q-2026-0207-001  Sign-up conversion rate      → "Mobile 30% lower"
  F-2026-0205-002  Churn root cause             → "Day-7 drop correlates with onboarding skip"

  ✅ Archived — 2026-01 (1)
  ──────────────────────────
  F-2026-0128-001  Q4 revenue deep dive         → "APAC grew 40% YoY"

  Total: 6 analyses (2 active, 4 archived)
═══════════════════════════════════════════════════
```

### Step 4: Optional filters

If the user provides arguments:
- `/analysis-list --active` → show only active
- `/analysis-list --archived` → show only archived
- `/analysis-list --month 2026-02` → filter by month
- `/analysis-list --search {keyword}` → search titles and insights
- `/analysis-list --tag {tag}` → filter by tag (e.g., `--tag retention`)
- `/analysis-list --related {ID}` → show analyses with overlapping tags to {ID}

### Step 5: Quick actions

After displaying the list, suggest:
- For active analyses: "Use `/analysis-next` to advance, `/analysis-archive` to complete"
- For archived analyses: "Archived analyses are in `analyses/archive/{month}/`"
- If `--related {ID}` used: show related analyses and suggest: "These analyses share tags with {ID}. Review them for reusable insights or methods."

### Step 6: Related analyses (automatic)

When displaying any single analysis (active or archived), check for related analyses:
- Find other analyses (active + archived) that share at least one tag
- If found, show: "Related: {list of IDs + titles with shared tags}"
- This helps users discover prior work and avoid duplicate analyses
