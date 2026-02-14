# /analysis-status

Show current analysis status dashboard.

## Instructions

### Step 1: Read status.md

Read `.analysis/status.md` and parse the Active, Recently Archived, and Pending sections.

### Step 2: Validate against actual files

Cross-check status.md against actual files in `analyses/active/`:
- If a file exists in active/ but not in status.md → warn "untracked analysis"
- If status.md lists an analysis but file is missing → warn "stale entry"

### Step 3: Display dashboard

Format output as a clean dashboard:

```
═══════════════════════════════════════════════════
  alive-analysis Status Dashboard
═══════════════════════════════════════════════════

  Active Analyses (3)
  ───────────────────
  ❓ F-2026-0210-001  DAU drop investigation     @ye   ASK     [retention, mobile]
  📢 Q-2026-0210-002  Retention check            @ye   VOICE   [retention, onboarding]
  🌱 F-2026-0208-003  Payment funnel analysis    @kim  EVOLVE  [funnel, payment]

  Recently Archived (1)
  ─────────────────────
  ✅ Q-2026-0207-001  Sign-up conversion → "Mobile 30% lower"

  Pending (1)
  ───────────
  ⏳ New user cohort analysis (next week)

═══════════════════════════════════════════════════
```

### Step 4: Stage icons reference

Use these icons for each ALIVE stage:
```
❓ ASK → 👀 LOOK → 🔍 INVESTIGATE → 📢 VOICE → 🌱 EVOLVE
```

Completed/archived: ✅
Pending: ⏳

### Step 5: Suggestions

Based on the current state, suggest next actions:
- If any analysis is in VOICE/EVOLVE → "Consider archiving with `/analysis-archive`"
- If no active analyses → "Start a new analysis with `/analysis-new`"
- If analyses are stale (>7 days in same stage) → "Consider reviewing stalled analyses"
