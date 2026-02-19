# /analysis-learn-review

Complete a learning session with a full scored review and self-assessment.

## Instructions

### Step 1: Identify the learning session

Read `.analysis/education/progress.md` to find the active learning session.
- If no active session → "No active learning session."
- If the session hasn't completed all stages → "You're still on {STAGE}. Complete all stages with `/analysis-learn-next` first, or run this command to get an early review of what you've done so far."

### Step 2: Load reference materials

Read the scenario's files:
- `core/education/scenarios/{scenario-id}/rubric.md` — scoring criteria
- `core/education/scenarios/{scenario-id}/solution/` — reference solution (single file for Beginner, 5 files for Intermediate)

Read the learner's files:
- Beginner: the single Quick learning file
- Intermediate: all 5 stage files in the learning folder

### Step 3: Generate the review report

Compare the learner's work against the rubric and solution. Generate a comprehensive review:

**Header:**
```markdown
# 📚 Learning Review: {scenario title}
> ID: {ID} | Scenario: {scenario-id} | Difficulty: {level} | Date: {YYYY-MM-DD}
```

**Section 1: Stage-by-Stage Scores**

| Stage | Score | Max | Key Feedback |
|---|---|---|---|
| ❓ ASK | {n} | 20 | {1-sentence summary} |
| 👀 LOOK | {n} | 20 | {1-sentence summary} |
| 🔍 INVESTIGATE | {n} | 25 | {1-sentence summary} |
| 📢 VOICE | {n} | 20 | {1-sentence summary} |
| 🌱 EVOLVE | {n} | 15 | {1-sentence summary} |
| **Total** | **{n}** | **100** | |

**Section 2: What You Did Well** (3-5 specific positives)

**Section 3: Areas for Improvement** (2-4 specific items with explanations)

**Section 3b: Common Mistakes Found**

After generating the score table, read the `## Most Common Mistakes at Intermediate Level` section from `core/education/scenarios/{scenario-id}/rubric.md`. For each stage where the learner lost points, cross-reference the deduction against the common mistakes list. If one or more mistakes match:

```markdown
## Common Mistakes Found
- **{Mistake name}**: {What the learner did} → {Why it's wrong} → {What to do instead}
```

If no common mistakes were triggered across any stage, output:

```markdown
## Common Mistakes Found: None — well done!
```

**Section 4: Key Takeaways**
List 3 core lessons from this scenario. These should be generalizable to future analyses, not scenario-specific.

**Section 5: Hints Used**
- Total hints used: {n} across {m} stages
- Note: Hints are a learning tool, not a penalty. Using fewer hints indicates growing independence.

**Section 6: Self-Assessment**

Prompt the user to rate their confidence in each skill area:

**For Beginner:**
```
Rate your confidence (1-5) after this scenario:

1. Problem Framing (ASK): Can you identify the right question type and build hypotheses?
   [ ] 1-Not confident  [ ] 2  [ ] 3-Okay  [ ] 4  [ ] 5-Very confident

2. Data Exploration (LOOK): Can you segment data and check for confounders?
   [ ] 1  [ ] 2  [ ] 3  [ ] 4  [ ] 5

3. Hypothesis Testing (INVESTIGATE): Can you test and eliminate hypotheses systematically?
   [ ] 1  [ ] 2  [ ] 3  [ ] 4  [ ] 5

4. Communication (VOICE): Can you frame findings as "So What → Now What"?
   [ ] 1  [ ] 2  [ ] 3  [ ] 4  [ ] 5

5. Reflection (EVOLVE): Can you identify monitoring needs and follow-ups?
   [ ] 1  [ ] 2  [ ] 3  [ ] 4  [ ] 5
```

**For Intermediate:**
```
Reflect on your performance (write 1-2 sentences each):

1. What was the hardest part of this analysis? Why?
2. What would you do differently if you started over?
3. How would you explain the key finding to a non-technical stakeholder in 30 seconds?
```

### Step 4: Recommend next steps

Based on the score and progress history:

**If score ≥ 70% and this is a Beginner scenario:**
- Check if 2+ Beginner scenarios are now complete with avg 70%+
- If yes: "🎉 You're ready for Intermediate! Try `i1-dau-drop` for a deeper challenge."
- If no: recommend the next unfinished Beginner scenario

**If score ≥ 75% and this is an Intermediate scenario:**
- "🎉 Strong work! You're ready for real analysis. Try `/analysis-new` to start a production analysis."

**If score < 70%:**
- Identify the weakest stage(s) and recommend a scenario that emphasizes those skills
- "Your INVESTIGATE score was lower — try {scenario} which focuses on {skill}."

### Step 5: Update progress

Update `.analysis/education/progress.md`:

1. Move the session from In Progress to Completed Scenarios table:
```
| {ID} | {scenario-id} | {difficulty} | {score}/100 | {hints} | {YYYY-MM-DD} |
```

2. Update the Skill Radar with new averages:
- Recalculate each skill area's average from all completed scenarios
- Update the Recommended Next section based on weakest areas

3. Clear the In Progress row

Update `.analysis/status.md`:
- Change the learning session's stage to `✅ Complete`

### Step 6: Graduation check

If the graduation criteria are met, add a note:

**Beginner → Intermediate graduation:**
"📈 **Graduation milestone!** You've completed {n} Beginner scenarios with an average of {avg}%. You're ready for Intermediate scenarios that use the full 5-file analysis format."

**Education → Production graduation:**
"🎓 **Ready for production!** You've completed Intermediate scenarios with strong scores. Your ALIVE loop skills are solid — try `/analysis-new` to tackle a real analysis!"
