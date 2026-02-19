# /analysis-learn

Start a new learning session with a guided ALIVE loop scenario.

## Instructions

### Step 1: Check initialization

Verify `.analysis/config.md` exists. If not, tell the user to run `/analysis-init` first.
Read config.md to load language setting and team context.

### Step 2: Load progress

Check if `.analysis/education/progress.md` exists.
- If not, create it from the template below and inform the user: "Welcome to Education Mode! This is your first learning session."
- If it exists, read it to get completed scenarios, current skill levels, and any in-progress sessions.

Check if there's already an active learning session (In Progress table in progress.md):
- If yes, ask: "You have an active learning session ({ID} — {scenario}). Resume it with `/analysis-learn-next`, or start a new one?"

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

### Step 3: Ask setup questions

Use AskUserQuestion to gather:

**Q1. Difficulty level?**
- **Beginner** — Guided single-file analysis with annotations and built-in hints (20-30 min)
- **Intermediate** — Full 5-file analysis with minimal guidance (45-60 min)

**Q2. Choose a scenario:**

Present scenarios filtered by the chosen difficulty. Mark completed scenarios with ✅ and show scores. If the progress data suggests a recommended scenario, mark it with ⭐.

**Beginner scenarios:**
| | Scenario | Domain | Type | Status |
|---|---|---|---|---|
| ⭐ | b1: "Why did signups drop yesterday?" | SaaS/Mobile | Investigation | {✅ 82/100 or Available} |
| | b2: "Which onboarding flow is better?" | Product/Growth | Comparison | {status} |
| | b3: "How much does turnover cost us?" | HR/Finance | Quantification | {status} |

**Intermediate scenarios:**
| | Scenario | Domain | Type | Status |
|---|---|---|---|---|
| | i1: "Why did DAU drop 15%?" | E-commerce | Investigation | {status} |
| | i2: "Should we lower delivery fees?" | Marketplace | Simulation | {status} |

If the user hasn't completed 2+ Beginner scenarios with avg 70%+, show a note for Intermediate: "💡 Recommended: Complete 2+ Beginner scenarios first."

**Q3. Your role?** (adjusts explanation tone)
- Data Analyst
- PM
- Developer
- Marketer
- Other

### Step 4: Generate learning files

Generate a unique ID: `L-{YYYY}-{MMDD}-{seq}`
- Read status.md to avoid ID collisions with production analyses

Read the scenario files from the skills directory:
- `core/education/scenarios/{scenario-id}/metadata.md`
- `core/education/scenarios/{scenario-id}/briefing.md`

**For Beginner (Quick format):**
Create file: `analyses/active/learn_{ID}_{scenario-slug}.md`
- Use the `core/education/templates/learn-quick-template.md` as the base
- Replace placeholders: {ID}, {title}, {YYYY-MM-DD}, {Beginner/Intermediate}
- The file starts at the ASK stage

**For Intermediate (Full format):**
Create folder: `analyses/active/learn_{ID}_{scenario-slug}/`
- Generate `01_ask.md` using `core/education/templates/learn-full-ask-template.md`
- Replace placeholders: {ID}, {title}, {YYYY-MM-DD}

### Step 5: Present the briefing

Read `core/education/scenarios/{scenario-id}/briefing.md` and present it to the user.

Then guide them into the ASK stage:

**For Beginner:**
"Now it's your turn! Start by filling in the **ASK** section of your learning file. Think about:
- What type of question is this? (causation, correlation, comparison, evaluation)
- What are your top hypotheses?
- What data would you need?

When you're ready, run `/analysis-learn-next` for feedback and to advance to LOOK."

**For Intermediate:**
"The briefing is set. Fill in `01_ask.md` with your problem definition, framing, and hypothesis tree. Run `/analysis-learn-next` when you're ready for feedback."

### Step 6: Update tracking

Add entry to `.analysis/education/progress.md` In Progress table:
```
| {ID} | {scenario-id} | ASK | {YYYY-MM-DD} |
```

Add entry to `.analysis/status.md` Active table:
```
| {ID} | 📚 Learn: {title} | ❓ ASK | {YYYY-MM-DD} | learn |
```

### Step 7: Confirmation

Tell the user:
- Learning session started with ID and scenario
- Show file path(s)
- Remind: `/analysis-learn-next` to advance, `/analysis-learn-hint` for help
