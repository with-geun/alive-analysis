# /analysis-learn-next

Review the current stage and advance to the next ALIVE stage in a learning session.

## Instructions

**Before executing**: Read `.analysis/status.md` and `.analysis/education/progress.md` to load current state.

### Step 1: Identify current session

Read progress.md In Progress table. If no active session, tell user to run `/analysis-learn`.

### Step 2: Determine current stage

**Beginner (Quick):** Check which sections have content (not just placeholders).
**Intermediate (Full):** Check which stage files exist in the learning folder.

If all stages complete → suggest `/analysis-learn-review`.

### Step 3: Review current stage

Read the scenario's rubric and solution. Compare against learner's work.

**Provide feedback in a single structured block:**

**Stage: {STAGE} — Score: {n}/{max}**

**Well done:**
- {specific positive 1}
- {specific positive 2}

**To improve:**
- {specific gap 1} — Why it matters: {explanation}
- {specific gap 2} — Why it matters: {explanation}

**Key takeaway:** {one sentence}

**Common Mistakes check:**

After the feedback block, read the `## Most Common Mistakes at Intermediate Level` section from `core/education/scenarios/{scenario-id}/rubric.md`. Compare each listed mistake against the learner's current stage work. For every mistake pattern that matches, append a callout block:

> **Common Mistake Detected**: {mistake name} — {explanation of why this matters, drawn from the rubric description}

If no common mistakes were triggered, skip this block entirely.

### Step 4: Reveal data and generate next stage

If the next stage has data, read from `core/education/scenarios/{scenario-id}/data/stage-{stage}.md` and present it.

**Beginner:** Guide user to fill next section in the Quick file.
**Intermediate:** Generate the next stage file from the template.

### Step 5: Update tracking

Update progress.md current stage and status.md stage icon.

**After executing**: Update `.analysis/status.md` and `.analysis/education/progress.md`.
