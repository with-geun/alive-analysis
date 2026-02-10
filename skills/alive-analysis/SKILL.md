# alive-analysis Skill

> Data analysis workflow kit based on the ALIVE loop.
> Provides structured analysis methodology for data analysts and non-analyst roles.

---

## Overview

alive-analysis helps structure data analysis work using the **ALIVE loop**:
**Ask → Look → Investigate → Voice → Evolve**

It serves two personas:
- **Data analysts**: Deep, systematic analysis with full ALIVE flow
- **Non-analyst roles** (PM, engineers, marketers): Quick analysis with guided framework

---

## ALIVE Loop Reference

### Stage 1: ASK (❓)
**Core question**: What do we want to know?

Purpose:
- Define the problem clearly
- Set success criteria
- State assumptions and scope
- Identify data sources

Common mistakes to prevent:
- Starting analysis without a clear question
- Scope creep — trying to answer everything at once
- Not confirming the requester's actual goal (vs stated goal)

### Stage 2: LOOK (👀)
**Core question**: What does the data show?

Purpose:
- Review data quality (missing values, outliers, date ranges)
- Validate sampling approach
- Note initial observations before deep analysis

Common mistakes to prevent:
- Using unnecessarily large datasets
- Re-verifying already confirmed data
- Skipping data quality checks

### Stage 3: INVESTIGATE (🔍)
**Core question**: Why is it happening?

Purpose:
- Form and test hypotheses
- Apply analytical methods
- Document results with evidence
- Ensure reproducibility

Common mistakes to prevent:
- Confirmation bias — only looking for supporting evidence
- Not recording queries/code for reproduction
- Over-complicating visualizations

### Stage 4: VOICE (📢)
**Core question**: How do we communicate this?

Purpose:
- Summarize conclusions for different audiences
- Provide actionable recommendations
- Document data sources and limitations

Common mistakes to prevent:
- Burying the lead — not stating the conclusion first
- Using jargon with non-technical audiences
- Not answering the original question

### Stage 5: EVOLVE (🌱)
**Core question**: What should we ask next?

Purpose:
- Reflect on the analysis process
- Identify unanswered questions
- Propose follow-up analyses
- Find automation opportunities

Common mistakes to prevent:
- Treating the analysis as "done" without reflection
- Not capturing follow-up ideas while they're fresh

---

## Checklist Templates

### Default: ASK Checklist
```markdown
## Checklist — ASK
- [ ] 🟢/🔴 Have you accurately identified the requester's goal?
- [ ] 🟢/🔴 Have you secured relevant domain knowledge?
- [ ] 🟢/🔴 Have you created an analysis plan that fits the timeline?
- [ ] 🟢/🔴 Have you estimated time per scope area?
- [ ] 🟢/🔴 Have you confirmed the data specification?
- [ ] 🟢/🔴 Have you considered a confusion matrix (if applicable)?
- [ ] 🟢/🔴 Have you considered appropriate sample size?
```

### Default: LOOK Checklist
```markdown
## Checklist — LOOK
- [ ] 🟢/🔴 Are you avoiding unnecessarily large datasets?
- [ ] 🟢/🔴 Are you not wasting time re-verifying confirmed findings?
- [ ] 🟢/🔴 Is the sampling method appropriate?
- [ ] 🟢/🔴 Have you checked for data errors (outliers, missing values)?
- [ ] 🟢/🔴 Have you considered edge cases (specific IDs, exceptions)?
- [ ] 🟢/🔴 Are you only performing analysis needed for the problem?
- [ ] 🟢/🔴 Before long-running tasks, have you verified the method is optimal?
```

### Default: INVESTIGATE Checklist
```markdown
## Checklist — INVESTIGATE
- [ ] 🟢/🔴 Have you exchanged feedback with a colleague?
- [ ] 🟢/🔴 Have you clearly handled outliers/anomalies?
- [ ] 🟢/🔴 Have you visually verified the results yourself?
- [ ] 🟢/🔴 Are charts easy to understand?
- [ ] 🟢/🔴 Have you removed unnecessary visualizations/complexity?
- [ ] 🟢/🔴 Can the results be reproduced? (queries/code recorded)
```

### Default: VOICE Checklist
```markdown
## Checklist — VOICE
- [ ] 🟢/🔴 Have you accurately answered the requester's question?
- [ ] 🟢/🔴 Have you reviewed results with a colleague?
- [ ] 🟢/🔴 Have you validated explanations through simulation?
- [ ] 🟢/🔴 Have you documented data sources for re-verification?
```

### Default: EVOLVE Checklist
```markdown
## Checklist — EVOLVE
- [ ] 🟢/🔴 Are there perspectives missed in this analysis?
- [ ] 🟢/🔴 Are follow-up questions specifically defined?
- [ ] 🟢/🔴 Are there parts to automate or schedule?
- [ ] 🟢/🔴 Have you summarized the key insight in one sentence?
```

---

## Quick Analysis Checklist (Abbreviated)

For Quick mode, use only these 3 items:
```markdown
Check: 🟢 Proceed / 🔴 Stop
- [ ] Is the purpose of the question clear?
- [ ] Is the data source appropriate?
- [ ] Does the conclusion answer the question?
```

---

## ID Format

- **Full**: `F-{YYYY}-{MMDD}-{sequence}` (e.g., `F-2026-0210-001`)
- **Quick**: `Q-{YYYY}-{MMDD}-{sequence}` (e.g., `Q-2026-0210-002`)
- Sequence resets daily, starts at 001

---

## Stage Icons

```
❓ ASK → 👀 LOOK → 🔍 INVESTIGATE → 📢 VOICE → 🌱 EVOLVE
✅ Archived | ⏳ Pending | 🟡 In Progress
```

---

## File Naming Conventions

- Full analysis folder: `{ID}_{title-slug}/` (e.g., `F-2026-0210-001_dau-drop-investigation/`)
- Quick analysis file: `quick_{ID}_{title-slug}.md`
- Title slug: lowercase, hyphens, no special characters
- Stage files: `01_ask.md`, `02_look.md`, `03_investigate.md`, `04_voice.md`, `05_evolve.md`

---

## Archive Rules

1. Archive after VOICE + EVOLVE are complete
2. Generate `summary.md` with key insight, findings, and reproduction info
3. Move from `analyses/active/` to `analyses/archive/{YYYY-MM}/`
4. Update status.md (remove from Active, add to Recently Archived)
5. Keep max 5 entries in Recently Archived

---

## Language Support

- Document language is set in `.analysis/config.md`
- Checklists, templates, and status messages follow the configured language
- Default: Korean (한국어)
- Supported: Korean, English, Japanese

---

## Interaction Guidelines

**CRITICAL: alive-analysis is a conversational workflow.**
Do NOT auto-fill analysis content. Each stage must be a dialogue with the user.
The AI is a guide and co-analyst, not an auto-generator.

### Core Principles

1. **Ask, don't assume** — Every stage starts with questions to the user.
2. **One stage at a time** — Never skip ahead. Complete the current stage through conversation before moving on.
3. **User writes the insight, AI structures it** — The user provides domain knowledge and judgment. AI helps organize, challenge, and document.
4. **Pause at checklists** — Before advancing, walk through the checklist WITH the user. Each item is a conversation, not a checkbox to auto-fill.

### Stage-by-Stage Conversation Flow

#### ASK Stage
```
AI: "What question are you trying to answer?"
User: (describes the problem)
AI: "Who requested this? What's the deadline?"
User: (provides context)
AI: "Let me clarify the scope — is X in or out of scope?"
User: (confirms)
AI: → Writes 01_ask.md with user's answers
AI: "Let's check before moving on:"
    - "Do we clearly understand what the requester wants? 🟢/🔴"
    - "Do we know where the data lives? 🟢/🔴"
AI: "Ready to move to LOOK? Or anything to add?"
```

#### LOOK Stage
```
AI: "What data sources will you use?"
User: (lists sources)
AI: "Any known data quality issues? Missing values, date range gaps?"
User: (describes)
AI: "How large is the dataset? Do we need sampling?"
User: (answers)
AI: → Updates 02_look.md
AI: "Checklist review:"
    - "Are we using only necessary data? 🟢/🔴"
    - "Have we checked for outliers? 🟢/🔴"
```

#### INVESTIGATE Stage
```
AI: "What's your hypothesis for why this is happening?"
User: (states hypothesis)
AI: "What method will you use to test this?"
User: (describes approach)
AI: "What did you find?"
User: (shares results)
AI: "How confident are you? Any alternative explanations?"
User: (discusses)
AI: → Updates 03_investigate.md
AI: "Can someone else reproduce this? Is the query/code saved?"
```

#### VOICE Stage
```
AI: "If you had to explain this in one sentence to leadership, what would you say?"
User: (gives summary)
AI: "Who needs to hear this? What action should they take?"
User: (identifies audience + recommendations)
AI: "Any caveats or limitations they should know about?"
User: (lists limitations)
AI: → Updates 04_voice.md
```

#### EVOLVE Stage
```
AI: "What questions came up during this analysis that we didn't answer?"
User: (lists open questions)
AI: "Any part of this could be automated for next time?"
User: (considers)
AI: "One sentence — what's the single most important takeaway?"
User: (provides insight)
AI: → Updates 05_evolve.md
AI: "Ready to archive? Or want to revisit any stage?"
```

### Quick Mode Conversation

For Quick, the same dialogue happens but compressed:
```
AI: "What's the question? (ASK)"
User: "Why did signups drop yesterday?"
AI: "Where will you look? (LOOK)"
User: "GA4 events and server logs"
AI: "What did you find? (INVESTIGATE)"
User: "Mobile auth API was down 14-17h"
AI: "What's the conclusion? (VOICE)"
User: "SKT API maintenance caused mobile signup failures"
AI: "Any follow-up needed? (EVOLVE)"
User: "Yeah, should we add email auth as fallback?"
AI: → Writes the complete Quick file
AI: "Checklist: purpose clear? ✅ data source OK? ✅ conclusion answers question? ✅"
AI: "Archive this, or keep it active?"
```

### What NOT to do

- ❌ Generate analysis content without asking the user
- ❌ Skip stages or combine multiple stages at once
- ❌ Auto-check all checklist items without discussion
- ❌ Move to the next stage without user confirmation
- ❌ Make assumptions about data, methods, or conclusions
