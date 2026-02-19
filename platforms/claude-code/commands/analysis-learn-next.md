# /analysis-learn-next

Review the current stage and advance to the next ALIVE stage in a learning session.

## Instructions

### Step 1: Identify current learning session

Read `.analysis/education/progress.md` to find the active learning session (In Progress table).

- If no active session → tell user: "No active learning session. Run `/analysis-learn` to start one."
- If multiple active sessions → ask which one to advance
- Read the scenario metadata from `core/education/scenarios/{scenario-id}/metadata.md`

### Step 2: Determine current stage

**Beginner (Quick):**
Read the learning file. Check which sections have been filled in (not just template placeholders):
- ASK filled → current stage is ASK, next is LOOK
- ASK + LOOK filled → current is LOOK, next is INVESTIGATE
- ASK + LOOK + INVESTIGATE filled → current is INVESTIGATE, next is VOICE
- ASK + LOOK + INVESTIGATE + VOICE filled → current is VOICE, next is EVOLVE
- All filled → current is EVOLVE, analysis complete → suggest `/analysis-learn-review`

**Intermediate (Full):**
Check which files exist in the learning folder:
- Only `01_ask.md` → current is ASK, next is LOOK
- Up to `02_look.md` → current is LOOK, next is INVESTIGATE
- Up to `03_investigate.md` → current is INVESTIGATE, next is VOICE
- Up to `04_voice.md` → current is VOICE, next is EVOLVE
- All 5 files → EVOLVE complete → suggest `/analysis-learn-review`

### Step 3: Review current stage (feedback)

Read the rubric from `core/education/scenarios/{scenario-id}/rubric.md`.
Read the solution from `core/education/scenarios/{scenario-id}/solution/`.
Read the learner's current stage content.

**Provide feedback:**

1. **Score** the current stage using the rubric criteria (out of the stage's max points)
2. **What you did well** — 2-3 specific things the learner got right
3. **What you missed** — 1-3 things that could be stronger, with explanation of WHY they matter
4. **Key takeaway** — One sentence summarizing the most important lesson from this stage

**Feedback tone by difficulty:**
- Beginner: Encouraging, detailed explanations, use analogies. "Great start! You correctly identified this as a causation question. One thing to add..."
- Intermediate: Concise, peer-level. "Solid hypothesis tree. Missing: cross-service impact branch. Sensitivity analysis should test ±1 week window."

**Feedback tone by role** (from the session setup):
- Data Analyst: Focus on methodology rigor
- PM: Focus on business framing and decision relevance
- Developer: Focus on data pipeline and system-level thinking
- Marketer: Focus on channel analysis and campaign impact

**Common Mistakes check:**

After scoring, read the `## Most Common Mistakes at Intermediate Level` section from `core/education/scenarios/{scenario-id}/rubric.md`. Compare each listed mistake against the learner's current stage work. For every mistake pattern that matches what the learner did, add a callout block immediately after the regular feedback:

> **Common Mistake Detected**: {mistake name} — {explanation of why this matters, drawn from the rubric description}

If no common mistakes were triggered, skip this block entirely.

### Step 4: Reveal stage-appropriate data

If the next stage has associated data, read it from `core/education/scenarios/{scenario-id}/data/`:
- Advancing to LOOK → reveal `data/stage-look.md`
- Advancing to INVESTIGATE → reveal `data/stage-investigate.md`
- Advancing to VOICE → reveal `data/stage-voice.md` (if exists)

Present the data to the user: "Here's the data available for the next stage:"

### Step 5: Generate next stage content

**Beginner (Quick):**
No new file needed — the next section is already in the Quick file. Just guide the user to fill in the next section.

Add educational annotations for the next stage as guidance in the conversation:
- "Why {STAGE} matters" explanation
- Relevant concept explanations (from the scenario's teaching objectives)
- Level 1 hint embedded naturally (for Beginner only)

**Intermediate (Full):**
Generate the next stage file from the appropriate template:
- `core/education/templates/learn-full-{stage}-template.md`
- Replace placeholders: {ID}, {title}, {YYYY-MM-DD}

### Step 6: Guide the learner

Tell the user:
- Their score for the current stage
- Summary of feedback (well done + to improve)
- The new data available (if any)
- What to focus on in the next stage
- For the last stage (EVOLVE): "After completing EVOLVE, run `/analysis-learn-review` for your full review."

### Step 7: Update tracking

Update `.analysis/education/progress.md`:
- Change the In Progress row's Current Stage to the new stage

Update `.analysis/status.md`:
- Change the stage icon for this learning session

If EVOLVE is complete:
- Tell user: "All stages complete! Run `/analysis-learn-review` for your full scored review."
