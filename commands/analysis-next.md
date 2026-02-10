# /analysis next

Advance the current analysis to the next ALIVE stage.

## Instructions

### Step 1: Identify current analysis

Read `.analysis/status.md` to find active analyses.

- If only 1 active Full analysis → select it automatically
- If multiple active → ask user which analysis to advance (show ID + title)
- Quick analyses don't use `/analysis next` (all sections are in one file)
  - If user selects a Quick, remind them to fill sections in order within the file

### Step 2: Determine current stage

Read the analysis folder to see which stage files exist:
- Only `01_ask.md` → current stage is ASK
- Up to `02_look.md` → current stage is LOOK
- Up to `03_investigate.md` → current stage is INVESTIGATE
- Up to `04_voice.md` → current stage is VOICE
- All 5 files exist → current stage is EVOLVE (analysis is complete)

### Step 3: Review current stage checklist

Read the current stage's checklist (embedded at the bottom of the current stage file).

Check if there are any 🔴 (stop) items:
- If 🔴 items exist → warn the user: "There are stop signals in your {stage} checklist. Review before proceeding."
- If all items are unchecked → remind: "Don't forget to review the checklist before moving on."
- If items are checked → proceed

### Step 4: Generate next stage file

Based on current stage, generate the next file.

**ASK → LOOK** (generate `02_look.md`):
```markdown
# LOOK: {title}
> ID: {ID} | Stage: 👀 LOOK | Updated: {YYYY-MM-DD}

## Data Sources
- Primary:
- Secondary:

## Data Quality Review
- Row count:
- Date range:
- Missing values:
- Known issues:

## Outliers & Anomalies
-

## Sampling
- Method:
- Size:
- Rationale:

## Initial Observations
-

---
{Insert LOOK checklist from .analysis/checklists/look.md}
```

**LOOK → INVESTIGATE** (generate `03_investigate.md`):
```markdown
# INVESTIGATE: {title}
> ID: {ID} | Stage: 🔍 INVESTIGATE | Updated: {YYYY-MM-DD}

## Hypotheses
1.
2.

## Methodology
- Approach:
- Tools:

## Results

### Finding 1
- Description:
- Evidence:
- Confidence:

### Finding 2
- Description:
- Evidence:
- Confidence:

## Interpretation
-

## Reproducibility
- Query/notebook location: `assets/`
- Steps to reproduce:

---
{Insert INVESTIGATE checklist from .analysis/checklists/investigate.md}
```

**INVESTIGATE → VOICE** (generate `04_voice.md`):
```markdown
# VOICE: {title}
> ID: {ID} | Stage: 📢 VOICE | Updated: {YYYY-MM-DD}

## Executive Summary
(1-3 sentences for leadership)

## Detailed Findings
(For the requesting team)

### Key Insight 1
-

### Key Insight 2
-

## Recommendations
1.
2.

## Audience-specific Messages

### For {stakeholder 1}
-

### For {stakeholder 2}
-

## Data Sources & Caveats
- Sources:
- Limitations:
- Confidence level:

---
{Insert VOICE checklist from .analysis/checklists/voice.md}
```

**VOICE → EVOLVE** (generate `05_evolve.md`):
```markdown
# EVOLVE: {title}
> ID: {ID} | Stage: 🌱 EVOLVE | Updated: {YYYY-MM-DD}

## Reflection
- What went well in this analysis?
- What could be improved?
- What surprised us?

## Unanswered Questions
-

## Follow-up Analysis Proposals
- [ ] {description} → (not yet created)
- [ ] {description} → (not yet created)

## Automation Opportunities
- Can any part of this analysis be automated/scheduled?
- Recommended cadence:

## One-Sentence Insight
> (Capture the single most important takeaway)

---
{Insert EVOLVE checklist from .analysis/checklists/evolve.md}
```

**EVOLVE reached** → Tell user:
"This analysis is complete. Run `/analysis archive` to archive it."

### Step 5: Update status.md

Update the analysis row in `.analysis/status.md`:
- Change the stage column to the new stage icon
- Update "Last updated" timestamp

### Step 6: Confirmation

Tell the user:
- Advanced from {old stage} to {new stage}
- Show the new file path
- Remind them to fill in the content and review the checklist
- If VOICE: "After completing VOICE and EVOLVE, run `/analysis archive`"
