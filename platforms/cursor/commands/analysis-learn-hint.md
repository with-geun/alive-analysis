# /analysis-learn-hint

Request a progressive hint for the current learning stage.

## Instructions

**Before executing**: Read `.analysis/education/progress.md` to identify the active session.

### Step 1: Identify session and stage

If no active session → "No active learning session. Run `/analysis-learn`."

Determine the current ALIVE stage.

### Step 2: Deliver progressive hint

Read `core/education/scenarios/{scenario-id}/hints/{stage}.md`.

Hints progress through 3 levels per stage:
- Level 1: Direction (first call)
- Level 2: Specific (second call)
- Level 3: Near-answer (third call)
- Beyond Level 3: "All hints used for this stage."

Present as:
```
Hint (Level {N}/3) for {STAGE}:
{hint content}
```

### Step 3: Record usage

Increment hint count in progress.md for this session.

**After executing**: Update `.analysis/education/progress.md` with hint count.
