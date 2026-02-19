# /analysis-learn-hint

Request a progressive hint for the current learning stage.

## Instructions

### Step 1: Identify current session and stage

Read `.analysis/education/progress.md` to find the active learning session.
- If no active session → "No active learning session. Run `/analysis-learn` to start one."

Determine the current ALIVE stage (same logic as `/analysis-learn-next` Step 2).

### Step 2: Track hint usage

Read the current hint level for this stage from the session's hint tracking.

The hint system works in 3 progressive levels per stage:
- **Level 1**: Direction hint — points toward the right area to explore
- **Level 2**: Specific hint — narrows down to the specific factor or method
- **Level 3**: Near-answer — provides most of the answer for learners who are stuck

Each `/analysis-learn-hint` call advances one level for the current stage.

### Step 3: Deliver the hint

Read the hint file: `core/education/scenarios/{scenario-id}/hints/{stage}.md`
- `{stage}` is one of: `ask`, `look`, `investigate`, `voice`, `evolve`

Present the appropriate level's hint based on how many times the user has asked for this stage:
- First call → Level 1
- Second call → Level 2
- Third call → Level 3
- Fourth+ call → "You've used all 3 hint levels for this stage. Review the hints above and try your best — you can always run `/analysis-learn-next` to see the feedback and move on."

**Presentation format:**
```
💡 Hint (Level {N}/3) for {STAGE}:

{hint content}
```

For Beginner scenarios, add encouragement: "Take a moment to think about how this applies to your analysis. You're doing great!"
For Intermediate scenarios, keep it concise — just the hint.

### Step 4: Record hint usage

Update `.analysis/education/progress.md`:
- Increment the hint count for the current session

Track internally which stages have had hints used and at what level, so `/analysis-learn-review` can report total hints used.
