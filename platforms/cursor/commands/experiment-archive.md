# /experiment archive

Archive a completed experiment.

## Instructions

**Before executing**: Read `.analysis/status.md` and `.analysis/config.md` to load current state.

### Step 1: Identify experiment to archive

Read `.analysis/status.md` for active experiments (Type: Experiment).

- If argument provided (ID), use that
- If only 1 active experiment in LEARN stage -> select automatically
- Otherwise, show list and ask user which to archive
- Warn if the experiment hasn't reached DECIDE stage yet:
  "This experiment is still in {stage}. Archive anyway? (Archiving early is OK for cancelled/abandoned experiments)"

### Step 2: Generate summary.md

**For Full Experiment:**

Read all stage files (01_design.md through 05_learn.md) and generate:

```markdown
# Summary: {title}
> ID: {ID}
> Period: {start_date} ~ {end_date}
> Type: Experiment | Owner: {owner}

## Outcome
- **Hypothesis**: {from 01_design.md}
- **Result**: Confirmed / Rejected / Inconclusive
- **Decision**: Launched / Killed / Extended / Iterated

## Key Numbers
| Metric | Control | Treatment | D | Significant? |
|--------|---------|-----------|---|-------------|
| {primary} | | | | |

## Key Takeaway
- (Extract from 05_learn.md "One-Sentence Takeaway", or ask user)

## Impact
- (Extract from 04_decide.md impact estimate)

## Follow-Up
- Experiments: (from 05_learn.md)
- Analyses: (from 05_learn.md)
- Monitoring: (post-launch checkpoints status)

## Reproduction
- Key assets: `assets/`
- Design doc: `01_design.md`
```

**For Quick Experiment:**

Generate a compact summary appended to the Quick file header:

```markdown
> Archived: {today} | Result: {decision} | Takeaway: {one-line summary}
```

### Step 3: Move to archive

Determine archive folder: `ab-tests/archive/{YYYY-MM}/`

- Create the year-month folder if it doesn't exist
- Move the full experiment folder (or quick file) from `active/` to `archive/{YYYY-MM}/`
- For Full: place `summary.md` inside the experiment folder

### Step 4: Update status.md

- Remove the experiment from the "Active" table
- Add to "Recently Archived" table (keep max 5 entries, remove oldest)
- Update counts and "Last updated" timestamp

### Step 5: Clean up assets (Full only)

Ask the user:
"Any temporary files in assets/ to clean up? (Original queries/notebooks will be preserved)"
- If yes, let user specify which files to remove
- If no, keep everything

### Step 6: Confirmation

Tell the user:
- Experiment archived successfully
- Show archive path
- Show the key takeaway from summary
- If LEARN had follow-up experiments: "Don't forget the follow-up experiments suggested in LEARN"
- If LEARN had follow-up analyses: "Consider starting these analyses: {list}"
- If post-launch monitoring is pending: "Remember to check the monitoring checkpoints at weeks 2, 4, and 12"
- Suggest `/analysis status` to see updated dashboard

**After executing**: Update `.analysis/status.md` with any state changes.
