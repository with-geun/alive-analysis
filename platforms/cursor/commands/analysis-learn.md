# /analysis-learn

Start a new learning session with a guided ALIVE loop scenario.

## Instructions

**Before executing**: Read `.analysis/status.md`, `.analysis/config.md`, and `.analysis/education/progress.md` to load current state.

### Step 1: Check initialization

Verify `.analysis/config.md` exists. If not, tell the user to run `/analysis-init` first.

### Step 2: Load progress

Check if `.analysis/education/progress.md` exists.
- If not, create it from the template below.
- If it exists, check for active learning sessions.

If there's an active session, ask: "Resume active session ({ID}) with `/analysis-learn-next`, or start new?"

**progress.md template:**
```markdown
# Learning Progress
> Last updated: {YYYY-MM-DD}

## Completed Scenarios
| ID | Scenario | Difficulty | Score | Hints | Completed |
|---|---|---|---|---|---|

## Skill Radar
| Skill Area | Avg Score | Stage |
|---|---|---|
| Problem Framing | — | ASK |
| Data Exploration | — | LOOK |
| Hypothesis Testing | — | INVESTIGATE |
| Communication | — | VOICE |
| Reflection | — | EVOLVE |

## Recommended Next
- Start with b1-signup-drop (Beginner)

## In Progress
| ID | Scenario | Current Stage | Started |
|---|---|---|---|
```

### Step 3: Ask all setup questions at once

**Present all questions at once** in a single structured form:

**Q1. Difficulty?**
- Beginner (guided, single file, 20-30 min)
- Intermediate (full 5-file, 45-60 min)

**Q2. Scenario?**
Show all scenarios for the chosen difficulty with completion status from progress.md.

Beginner:
- b1: "Why did signups drop yesterday?" (SaaS/Mobile, Investigation)
- b2: "Which onboarding flow is better?" (Product/Growth, Comparison)
- b3: "How much does turnover cost us?" (HR/Finance, Quantification)

Intermediate:
- i1: "Why did DAU drop 15%?" (E-commerce, Investigation)
- i2: "Should we lower delivery fees?" (Marketplace, Simulation)

**Q3. Your role?** (adjusts explanation tone)
- Data Analyst / PM / Developer / Marketer / Other

### Step 4: Generate learning files

Generate ID: `L-{YYYY}-{MMDD}-{seq}`

Read scenario files from `core/education/scenarios/{scenario-id}/`.

**Beginner**: Create `analyses/active/learn_{ID}_{scenario-slug}.md` from quick template.
**Intermediate**: Create folder `analyses/active/learn_{ID}_{scenario-slug}/` with `01_ask.md` from full ASK template.

### Step 5: Present briefing and guide

Present the scenario briefing. Guide user to start ASK stage.

### Step 6: Update tracking

Update progress.md In Progress table and status.md Active table.

**After executing**: Update `.analysis/status.md` with the new learning session entry.
