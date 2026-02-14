# /analysis-search

Deep search across all analyses — full-text, context display, and pattern analysis.

## Instructions

### Step 1: Parse search parameters

Check the user's arguments:
- `--keyword {text}` — full-text case-insensitive search across all content
- `--tag {tag}` — filter by tag
- `--date {YYYY-MM}` or `--date {from to}` — period filter (e.g., `--date 2026-01 2026-03`)
- `--type {Investigation|Modeling|Simulation}` — analysis type filter
- `--confidence {high|medium|low}` — filter by confidence level (🟢/🟡/🔴)
- `--active` / `--archived` / `--both` (default: `--both`)

If no arguments provided, ask the user:
"What are you looking for? You can search by keyword, tag, date range, type, or confidence level."

### Step 2: Scan active analyses

Read all files/folders in `analyses/active/`:
- **Full analyses**: Read all stage files (`01_ask.md` through `05_evolve.md`) in each `F-*` or `S-*` folder
- **Quick analyses**: Read the full content of each `quick_Q-*` file

### Step 3: Scan archived analyses

Read all year-month folders in `analyses/archive/`:
- For each analysis folder: read `summary.md` + all stage files
- For each Quick file: read full content

### Step 4: Apply filters

For each analysis, apply all specified filters:
- **keyword**: Case-insensitive search across the full text of all files. Match against titles, content, insights, recommendations, hypothesis trees, findings — everything.
- **tag**: Match against tags in file headers or status.md
- **date**: Match against analysis ID date component or archive folder date
- **type**: Match against analysis type (Investigation/Modeling/Simulation) from file headers
- **confidence**: Search for confidence indicators (🟢 High / 🟡 Medium / 🔴 Low) in VOICE and INVESTIGATE sections

### Step 5: Display results with context

For each matching analysis, show:

```
═══════════════════════════════════════════════════
  alive-analysis — Search Results
  Query: {search parameters summary}
═══════════════════════════════════════════════════

  📊 {N} results found

  ─────────────────────────────────────────────────
  1. F-2026-0210-001  DAU drop investigation
     Status: ✅ Archived (2026-02)  |  Type: Investigation  |  Tags: [retention, mobile]
     Key Insight: "TikTok-acquired users have 3x lower D30 retention"

     Matches:
     ┌─ 03_investigate.md (line 42)
     │  ... channel mix shifted from 20% to 45% **TikTok**,
     │  driving the overall D30 **retention** drop by 8pp.
     │  Organic users showed no change ...
     └─

     ┌─ 04_voice.md (line 15)
     │  ... reduce **TikTok** budget or improve onboarding
     │  for **TikTok**-acquired users. Counter-metric:
     │  monitor CAC payback period ...
     └─

  ─────────────────────────────────────────────────
  2. Q-2026-0207-001  Sign-up conversion rate
     Status: ✅ Archived (2026-02)  |  Type: Investigation  |  Tags: [retention, onboarding]
     Key Insight: "Mobile 30% lower"

     Matches:
     ┌─ (line 28)
     │  ... mobile **retention** is significantly lower
     │  than desktop across all cohorts ...
     └─

═══════════════════════════════════════════════════
```

Rules for context display:
- Show 3 lines around each keyword match (context snippet)
- Bold the matched keyword(s) with `**keyword**`
- Show the source file and line number
- Max 3 snippets per analysis (show "... and {N} more matches" if exceeded)
- Extract Key Insight from summary.md or EVOLVE one-sentence insight

### Step 6: Cross-reference analysis

After displaying individual results, provide cross-reference insights:

**Similar conclusions**: Group analyses that reached related findings.
```
  🔗 Cross-References
  ─────────────────────────────────────────────────
  Similar conclusions:
  - F-2026-0210-001 + Q-2026-0207-001: Both identify mobile/TikTok channel as retention risk

  Conflicting findings:
  - (none found)

  Frequently recurring topics:
  - "retention" appeared in 5 analyses (2026-01 ~ 2026-02)
  - "onboarding" appeared in 3 analyses
```

### Step 7: Learning suggestions

Based on the search results, provide actionable suggestions:

```
  💡 Suggestions
  ─────────────────────────────────────────────────
  - "retention" has been analyzed 5 times. Consider a meta-analysis to consolidate findings.
  - 2 follow-up questions from EVOLVE sections remain unstarted:
    • F-2026-0210-001: "Does TikTok onboarding improvement affect D30?"
    • Q-2026-0207-001: "Compare mobile web vs app retention"
  - 1 Impact Tracking item still pending review (F-2026-0210-001, Rec #2)
```

Suggestions to generate:
- **Repeated topics**: If a keyword/tag appears in 3+ analyses → suggest meta-analysis
- **Unresolved follow-ups**: Scan EVOLVE sections for proposed follow-up analyses that don't have a matching newer analysis
- **Pending impact tracking**: Check EVOLVE Impact Tracking tables for "Pending" or empty status

### Step 8: Quick actions

After displaying results, suggest:
- "Use `/analysis-list --tag {tag}` to see all analyses with a specific tag"
- "Use `/analysis-new` to start a follow-up analysis on unresolved questions"
- If many results: "Try narrowing with `--date` or `--type` to focus"
