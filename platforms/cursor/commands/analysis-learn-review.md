# /analysis-learn-review

Complete a learning session with a full scored review and self-assessment.

## Instructions

**Before executing**: Read `.analysis/education/progress.md` and `.analysis/status.md`.

### Step 1: Identify session

Find the active learning session. If not all stages are complete, inform the user.

### Step 2: Score against rubric

Read the scenario's rubric and solution. Read the learner's work.

### Step 3: Generate review report

**Present the full review in a single structured output:**

```markdown
# Learning Review: {scenario title}
> ID: {ID} | Scenario: {scenario-id} | Difficulty: {level}

## Scores
| Stage | Score | Max | Key Feedback |
|---|---|---|---|
| ASK | {n} | 20 | {summary} |
| LOOK | {n} | 20 | {summary} |
| INVESTIGATE | {n} | 25 | {summary} |
| VOICE | {n} | 20 | {summary} |
| EVOLVE | {n} | 15 | {summary} |
| **Total** | **{n}** | **100** | |

## What You Did Well
- {positive 1}
- {positive 2}
- {positive 3}

## Areas for Improvement
- {gap 1}: {explanation}
- {gap 2}: {explanation}

## Common Mistakes Found
{After generating the score table, read the `## Most Common Mistakes at Intermediate Level` section from `core/education/scenarios/{scenario-id}/rubric.md`. For each stage where the learner lost points, cross-reference the deduction against the common mistakes list. If one or more mistakes match, list them here:
- **{Mistake name}**: {What the learner did} → {Why it's wrong} → {What to do instead}
If no common mistakes were triggered across any stage, write: `None — well done!`}

## Key Takeaways
1. {generalizable lesson}
2. {generalizable lesson}
3. {generalizable lesson}

## Hints Used: {n} across {m} stages
```

### Step 4: Self-assessment prompt

**Beginner:** Ask confidence ratings 1-5 for each ALIVE stage skill.
**Intermediate:** Ask for written reflections (hardest part, what to redo, 30-second explanation).

### Step 5: Recommend next

Based on score and history:
- Score 70%+ with 2+ Beginner done → suggest Intermediate
- Score 75%+ on Intermediate → suggest `/analysis-new` for production
- Score < 70% → recommend scenario targeting weakest stage

### Step 6: Update progress

Move from In Progress to Completed in progress.md. Update Skill Radar averages. Update status.md.

Check graduation criteria and announce if met.

**After executing**: Update `.analysis/education/progress.md` and `.analysis/status.md`.
