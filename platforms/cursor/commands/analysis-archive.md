# /analysis archive

Archive a completed analysis.

## Instructions

**Before executing**: Read `.analysis/status.md` and `.analysis/config.md` to load current state.

### Step 1: Identify analysis to archive

Read `.analysis/status.md` for active analyses.

- If argument provided (ID), use that
- If only 1 active analysis in EVOLVE stage -> select automatically
- Otherwise, show list and ask user which to archive
- Warn if the analysis hasn't reached VOICE stage yet:
  "This analysis is still in {stage}. Archive anyway? (Archiving early is OK for cancelled/abandoned analyses)"
- Check Impact Tracking status in the EVOLVE file (or Quick EVOLVE section):
  - If empty or all "Pending": warn before proceeding: "Impact Tracking hasn't been filled yet for {n} recommendations. Want to update it before archiving, or archive now with a reminder to revisit in 2-4 weeks?"
  - This is advisory, not blocking — proceed if user chooses to archive

### Step 2: Generate summary.md

**For Full Analysis:**

Read all stage files (01_ask.md through 05_evolve.md) and generate:

```markdown
# Summary: {title}
> ID: {ID}
> Period: {start_date} ~ {today}
> Mode: Full | Owner: {owner}

## Key Insight
- (Extract from 05_evolve.md "One-Sentence Insight", or ask user)

## Key Findings
- (Extract top findings from 03_investigate.md)
- (Extract top findings from 03_investigate.md)

## Decision Impact
- (Extract from 04_voice.md recommendations AND 05_evolve.md Impact Tracking table)
- Decision status: {Accepted / Rejected / Modified / Pending}
- Outcome: {what happened — extract from Impact Tracking if filled}

## Follow-up Analyses
- (Extract from 05_evolve.md proposals)

## Reproduction
- Key assets: `assets/`
- (Extract from 03_investigate.md reproducibility section)
```

**For Quick Analysis:**

Generate a compact summary appended to the Quick file header:

```markdown
> Archived: {today} | Insight: {one-line summary}
```

### Step 3: Move to archive

Determine archive folder: `analyses/archive/{YYYY-MM}/`

- Create the year-month folder if it doesn't exist
- Move the full analysis folder (or quick file) from `active/` to `archive/{YYYY-MM}/`
- For Full: place `summary.md` inside the analysis folder

### Step 4: Update status.md

- Remove the analysis from the "Active" table
- Add to "Recently Archived" table (keep max 5 entries, remove oldest)
- Update counts and "Last updated" timestamp

### Step 5: Clean up assets (Full only)

Ask the user:
"Any temporary files in assets/ to clean up? (Original SQL/notebooks will be preserved)"
- If yes, let user specify which files to remove
- If no, keep everything

### Step 6: Confirmation

Tell the user:
- Analysis archived successfully
- Show archive path
- Show the key insight from summary
- If EVOLVE had follow-up proposals: "Don't forget the follow-up analyses suggested in EVOLVE"
- If Impact Tracking section is empty or all "Pending": "Don't forget to revisit the Impact Tracking section in 2-4 weeks to check if recommendations were acted on."
- Suggest `/analysis status` to see updated dashboard

**After executing**: Update `.analysis/status.md` with any state changes.
