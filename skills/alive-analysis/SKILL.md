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
**Core question**: What do we want to know — and WHY?

Purpose:
- Define the problem clearly and confirm the requester's REAL goal (not just what they said)
- Frame the question: Is this about **causation** ("Why did X happen?") or **correlation** ("Are X and Y related?")?
- Set success criteria and scope boundaries
- Build a **hypothesis tree** before touching any data
- Set up **multi-lens perspective**: macro (market/industry) → meso (company/product) → micro (user/session)

#### Hypothesis Tree
Before diving into data, structure thinking:
```
Main question: "Why did D30 retention drop?"
├── Internal factors
│   ├── Product changes (releases, feature removals)
│   ├── Channel mix changes (acquisition source shift)
│   ├── Cross-service impact (did another service change affect this?)
│   └── Pricing / promotion changes
├── External factors
│   ├── Seasonality / holidays
│   ├── Competitor actions
│   ├── Market / economic shifts
│   └── Platform changes (iOS/Android policy, algorithm updates)
└── Data artifacts
    ├── Tracking changes (instrumentation broke?)
    ├── Definition changes (metric recalculated?)
    └── Population changes (new user mix shifted?)
```

#### Causal vs Correlational Framing
Ask explicitly:
- "Are we trying to prove X **caused** Y? Or just that they move together?"
- "If we find a correlation, what would we need to prove causation?"
- This determines the methodology: correlation → observational analysis; causation → quasi-experimental or controlled experiment

#### Key Questions to Ask the User
- What triggered this question? (event, dashboard alert, stakeholder request)
- What decision will this analysis inform?
- What's the cost of being wrong?
- Are there related analyses or prior findings to build on?
- What data can you access? (MCP, exported files, BI dashboards)

Common mistakes to prevent:
- Starting analysis without a clear question
- Scope creep — trying to answer everything at once
- Not confirming the requester's actual goal (vs stated goal)
- Confusing "interesting" with "actionable"
- Ignoring the hypothesis tree — jumping to the first plausible explanation

### Stage 2: LOOK (👀)
**Core question**: What does the data ACTUALLY show — and what's missing?

Purpose:
- Review data quality (missing values, outliers, date ranges)
- **Segment before averaging** — never trust aggregate numbers alone
- Identify **confounding variables** that could mislead the analysis
- Check for **external factors** (seasonality, holidays, competitor actions)
- Map **cross-service dependencies** — changes in service A can affect metrics in service B
- Validate data access methods and establish a query/file pipeline

#### Segmentation Strategy
Always break the data down BEFORE forming conclusions:
- By time: daily/weekly trends, before/after specific events
- By cohort: new vs returning users, acquisition channel, geography
- By platform: iOS vs Android, web vs app
- By segment: free vs paid, high-value vs low-value

Ask: "Does the pattern hold across ALL segments, or is it driven by one?"

#### Confounding Variables
Before attributing any pattern, check:
- Did something else change at the same time? (release, campaign, holiday)
- Is there a **selection bias**? (are we comparing different populations?)
- Is there a **survivorship bias**? (are we only seeing users who stayed?)
- Could this be a **Simpson's paradox**? (aggregate trend vs segment trends)

#### External Data Consideration
- Check the calendar: holidays, industry events, competitor launches
- Check macro context: economic indicators, platform policy changes
- Check company context: other team's releases, cross-service changes
- Reference config.md guardrail metrics — are any of them moving too?

#### Data Access During Conversation
- **MCP connected**: AI can run queries directly — ask before executing
- **User provides files**: Read CSV/Excel/JSON files provided during conversation
- **BI tool screenshots**: User shares dashboard images — AI interprets visually
- **No direct access**: AI generates SQL/Python for user to run, then discusses results

Common mistakes to prevent:
- Looking at averages without segmentation
- Ignoring seasonality and external factors
- Re-verifying already confirmed data
- Skipping data quality checks
- Assuming correlation found in LOOK implies causation

### Stage 3: INVESTIGATE (🔍)
**Core question**: Why is it REALLY happening — can we prove it?

Purpose:
- **Eliminate hypotheses** systematically (not just confirm the first one)
- Apply **multi-lens analysis**: macro → meso → micro
- Test for **causation vs correlation** rigorously
- Check **cross-service impacts** and interaction effects
- Perform **sensitivity analysis** — how robust are the findings?
- Handle data mid-conversation (MCP queries, file uploads, ad-hoc analysis)

#### Hypothesis Elimination Process
Work through the hypothesis tree from ASK:
1. List all hypotheses (from the tree)
2. For each: What evidence would **support** it? What would **disprove** it?
3. Test the easiest-to-disprove hypotheses first (efficient elimination)
4. Track: ✅ Supported / ❌ Eliminated / ⚠️ Inconclusive
5. For surviving hypotheses: estimate relative contribution (e.g., "Channel mix explains ~70%, product change ~20%, unknown ~10%")

#### Multi-Lens Analysis Framework
```
Macro (market/industry level)
├── Market trends — is this industry-wide?
├── Competitor analysis — did competitors change?
├── Economic factors — recession, regulation, etc.
└── Platform/ecosystem — iOS policy, algorithm changes?

Meso (company/product level)
├── Cross-service impact — did another team's change affect us?
├── Channel mix — acquisition source distribution shift?
├── Product changes — releases, A/B tests, feature flags?
└── Business operations — pricing, campaigns, partnerships?

Micro (user/session level)
├── User behavior patterns — funnel analysis, session depth
├── Cohort-specific trends — new vs returning, by segment
├── Edge cases — specific user groups, extreme behaviors
└── Qualitative signals — CS tickets, reviews, survey data
```

#### Causation Testing (when causal claims are needed)
- **Time ordering**: Did the cause precede the effect?
- **Mechanism**: Is there a plausible pathway from cause to effect?
- **Dose-response**: Does more of the cause produce more of the effect?
- **Counterfactual**: What happened to the control group / unaffected segment?
- **Consistency**: Does the pattern hold across different segments and time periods?
- If true experiment isn't possible → quasi-experimental methods (diff-in-diff, regression discontinuity, propensity score matching)

#### Cross-Service Impact Analysis
In organizations with multiple products/services:
- Map service dependencies: "If service A changes onboarding, does service B's retention change?"
- Check shared resources: same user base, shared auth, shared data pipeline
- Look for cannibalisation: did a new feature pull users from an existing one?
- Check infrastructure: shared API, CDN, DB performance impacts

#### Sensitivity Analysis
Before finalizing findings, test robustness:
- "If we change the date range by ±1 week, does the conclusion hold?"
- "If we exclude the top/bottom 5% of users, does the pattern persist?"
- "If we use a different metric definition, do we get the same result?"
- "What's the minimum effect size that would be actionable?"

#### Mid-Conversation Data Handling
- When user provides a file: read it, summarize structure, ask what to look for
- When MCP is available: propose queries, get confirmation, run and discuss results
- When user shares screenshots: interpret patterns, ask clarifying questions
- When running ad-hoc analysis: document every query/step for reproducibility in `assets/`

Common mistakes to prevent:
- Confirmation bias — only looking for supporting evidence
- Stopping at the first plausible explanation without testing alternatives
- Claiming causation from correlation alone
- Ignoring external and cross-service factors
- Not recording queries/code for reproduction
- Over-complicating analysis when a simple comparison suffices

### Stage 4: VOICE (📢)
**Core question**: So what — and now what?

Purpose:
- Apply the **"So What → Now What"** framework for every finding
- Assign **confidence levels** to each conclusion
- Frame recommendations with **trade-off analysis**
- Tailor messages to different audiences using config.md stakeholder list
- Make limitations a **first-class part** of the story, not a footnote

#### "So What → Now What" Framework
For every finding, answer both questions:
```
Finding: "D30 retention dropped 8pp, driven by TikTok-acquired users"
├── So What?  → "TikTok users have 3x lower retention than organic.
│                Our channel mix shifted from 20% to 45% TikTok."
└── Now What? → "Option A: Reduce TikTok budget, reallocate to higher-LTV channels
                 Option B: Keep TikTok but improve onboarding for these users
                 Option C: Accept lower D30 if TikTok CAC justifies it on LTV basis"
```

#### Confidence Levels
Tag each finding explicitly:
- 🟢 **High confidence**: Multiple data sources confirm, robust to sensitivity checks, clear mechanism
- 🟡 **Medium confidence**: Supported by data but with caveats (small sample, single source, confounders possible)
- 🔴 **Low confidence**: Suggestive only — needs further analysis, could be noise or artifact

Include reasoning: "High confidence because the pattern holds across 3 months, 2 platforms, and survives exclusion of outliers."

#### Trade-off Analysis
For each recommendation, make the trade-offs explicit:
- What do we **gain** if we act on this?
- What do we **risk** or lose?
- What's the **cost of inaction**?
- Reference guardrail metrics from config.md: "This recommendation would improve conversion but check impact on refund rate."

#### Audience-Specific Communication
- **Executives / C-level**: Lead with business impact in one sentence. Numbers, not methodology. "So what does this mean for revenue?"
- **Product / Engineering**: Include technical detail. "Which feature, which release, which segment." Actionable next steps.
- **Cross-functional (marketing, ops)**: Connect to their KPIs. "Here's how this affects your campaign ROI."
- Reference stakeholders from config.md to auto-suggest audience sections.

Common mistakes to prevent:
- Burying the lead — not stating the conclusion first
- Presenting findings without "So what?" and "Now what?"
- Overstating confidence — not flagging uncertainty
- Using jargon with non-technical audiences
- Not answering the original question from ASK
- Presenting trade-offs as one-sided recommendations

### Stage 5: EVOLVE (🌱)
**Core question**: What would change our conclusion — and what should we ask next?

Purpose:
- **Robustness check**: Explicitly ask "What would change our conclusion?"
- Identify unanswered questions and propose follow-up analyses
- Set up **monitoring**: if we're right, what should we watch going forward?
- Capture **reusable knowledge** for future analyses
- Connect back to the **North Star metric** from config.md

#### Conclusion Robustness Check
Before finalizing, stress-test the analysis:
- "What new data could **disprove** our conclusion?"
- "What **assumptions** did we make that we didn't verify?"
- "If a colleague challenged this, what would they attack first?"
- "In 3 months, what would make us say 'we were wrong'?"

#### Monitoring Setup
If the analysis identified a real issue or opportunity:
- What metric should be tracked going forward?
- What threshold should trigger a re-investigation?
- Can we set up a dashboard or alert? (reference data stack from config.md)
- Who should own the monitoring?

#### Knowledge Capture
- What reusable patterns emerged? (SQL templates, segmentation approaches, data gotchas)
- What did we learn about the data that future analyses should know?
- Are there commonly-used queries worth saving to `assets/`?
- Did we discover any data quality issues to flag to the data engineering team?

#### Connect to North Star
- Reference the North Star metric from config.md: "How does this analysis connect to {metric}?"
- "Does this change our understanding of what drives {North Star}?"
- "Should our metric framework be updated based on these findings?"

Common mistakes to prevent:
- Treating the analysis as "done" without reflection
- Not capturing follow-up ideas while they're fresh
- Forgetting to set up monitoring for identified issues
- Missing the connection between this analysis and the bigger picture

---

## Checklist Templates

### Default: ASK Checklist
```markdown
## Checklist — ASK
- [ ] 🟢/🔴 Have you accurately identified the requester's REAL goal (not just stated goal)?
- [ ] 🟢/🔴 Is the question framed as causal or correlational?
- [ ] 🟢/🔴 Have you built a hypothesis tree (not just one guess)?
- [ ] 🟢/🔴 Have you secured relevant domain knowledge?
- [ ] 🟢/🔴 Have you created an analysis plan that fits the timeline?
- [ ] 🟢/🔴 Have you confirmed the data specification and access method?
- [ ] 🟢/🔴 Have you considered appropriate sample size?
```

### Default: LOOK Checklist
```markdown
## Checklist — LOOK
- [ ] 🟢/🔴 Have you segmented the data before drawing conclusions?
- [ ] 🟢/🔴 Have you checked for confounding variables?
- [ ] 🟢/🔴 Have you considered external factors (seasonality, competitors, market)?
- [ ] 🟢/🔴 Have you checked for cross-service impacts?
- [ ] 🟢/🔴 Is the sampling method appropriate?
- [ ] 🟢/🔴 Have you checked for data errors (outliers, missing values)?
- [ ] 🟢/🔴 Are you only performing analysis needed for the problem?
```

### Default: INVESTIGATE Checklist
```markdown
## Checklist — INVESTIGATE
- [ ] 🟢/🔴 Have you tested MULTIPLE hypotheses (not just confirmed one)?
- [ ] 🟢/🔴 Have you applied multi-lens analysis (macro/meso/micro)?
- [ ] 🟢/🔴 If claiming causation, have you verified: time ordering, mechanism, counterfactual?
- [ ] 🟢/🔴 Have you performed sensitivity analysis (robustness check)?
- [ ] 🟢/🔴 Have you clearly handled outliers/anomalies?
- [ ] 🟢/🔴 Have you assigned confidence levels to each finding?
- [ ] 🟢/🔴 Can the results be reproduced? (queries/code recorded in assets/)
```

### Default: VOICE Checklist
```markdown
## Checklist — VOICE
- [ ] 🟢/🔴 Have you applied "So What → Now What" for each finding?
- [ ] 🟢/🔴 Have you tagged confidence levels (🟢/🟡/🔴) with reasoning?
- [ ] 🟢/🔴 Have you included trade-off analysis for recommendations?
- [ ] 🟢/🔴 Have you checked guardrail metrics impact?
- [ ] 🟢/🔴 Are limitations visible (not buried in a footnote)?
- [ ] 🟢/🔴 Have you tailored messages for each stakeholder audience?
```

### Default: EVOLVE Checklist
```markdown
## Checklist — EVOLVE
- [ ] 🟢/🔴 Have you stress-tested the conclusion (what would disprove it)?
- [ ] 🟢/🔴 Have you set up monitoring for identified issues?
- [ ] 🟢/🔴 Are follow-up questions specifically defined?
- [ ] 🟢/🔴 Have you captured reusable knowledge for future analyses?
- [ ] 🟢/🔴 Have you connected findings back to the North Star metric?
- [ ] 🟢/🔴 Have you summarized the key insight in one sentence?
```

---

## Quick Analysis Checklist (Abbreviated)

For Quick mode, use these 4 items:
```markdown
Check: 🟢 Proceed / 🔴 Stop
- [ ] Is the purpose clear and framed (causal/correlational)?
- [ ] Was the data segmented (not just aggregated)?
- [ ] Were alternative hypotheses considered?
- [ ] Does the conclusion answer the question with confidence level?
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

#### ASK Stage — Frame the question before touching data
```
AI: "What question are you trying to answer?"
User: (describes the problem)
AI: "Got it. Before we dive in — is this about WHY something happened (causation),
     or whether two things are related (correlation)?"
User: (clarifies intent)
AI: "Who requested this? What decision will this inform?"
User: (provides context)
AI: "Let me build a hypothesis tree. Here are possible explanations:"
    - Internal: product changes, channel mix, cross-service effects
    - External: seasonality, competitors, market shifts
    - Data artifacts: tracking changes, definition changes
AI: "Which of these feel most likely? Any I should add?"
User: (prioritizes hypotheses)
AI: "What's in scope and out of scope? And the deadline?"
User: (confirms)
AI: → Writes 01_ask.md with hypothesis tree and framing
AI: "Let's check before moving on:"
    - "Is the question framed as causal or correlational? 🟢/🔴"
    - "Do we have a hypothesis tree, not just one guess? 🟢/🔴"
    - "Do we know where the data lives? 🟢/🔴"
AI: "Ready to move to LOOK? Or anything to add?"
```

#### LOOK Stage — Segment, don't just aggregate
```
AI: "What data sources will we use? Do you have MCP access, or will you
     run queries and share results?"
User: (describes access)
[If MCP]: AI proposes query → gets confirmation → runs → discusses results
[If file]: User shares file → AI reads → summarizes structure → asks what to look for
[If manual]: AI generates SQL/Python → user runs → shares results

AI: "Let's not look at averages yet. How should we segment this?"
    - "By time period (before/after event)?"
    - "By user cohort (new vs returning, by channel)?"
    - "By platform (iOS/Android, web/app)?"
User: (chooses segmentation)
AI: "Any external factors to check? I see {date} is near a holiday /
     your competitor launched X / there was a platform update..."
User: (confirms or adds context)
AI: "Let me also check — did anything change in adjacent services?
     Sometimes changes in service A affect metrics in service B."
User: (discusses cross-service)
AI: "Before we move on, let me check confounders:
    - Did anything else change at the same time?
    - Are we comparing apples to apples (same population)?
    - Could this be survivorship bias?"
User: (validates)
AI: → Updates 02_look.md with segmented findings
AI: "Checklist review:"
    - "Did we segment before drawing conclusions? 🟢/🔴"
    - "Have we checked for confounders and external factors? 🟢/🔴"
    - "Is the data quality confirmed? 🟢/🔴"
```

#### INVESTIGATE Stage — Eliminate, don't just confirm
```
AI: "From our hypothesis tree in ASK, let's work through them systematically.
     Which is easiest to disprove? Let's start there."
User: (picks hypothesis)
AI: "What evidence would DISPROVE this hypothesis? Let's look for that first."
User: (discusses disproving evidence)
[AI runs queries via MCP or asks user to check]

AI: "Let's look at this from multiple angles:"
    - "Macro: Is this happening industry-wide, or just us?"
    - "Meso: Is this specific to one product/channel, or company-wide?"
    - "Micro: What does user-level behavior look like?"
User: (discusses each level)
AI: "Based on what we've found so far, here's the scorecard:
     ✅ Hypothesis 1 (channel mix): Strong evidence — explains ~70%
     ❌ Hypothesis 2 (bug): Disproved — no change in error rates
     ⚠️ Hypothesis 3 (competitor): Inconclusive — need more data"
User: (validates or challenges)

[If causal claim needed]:
AI: "You want to say X CAUSED Y. Let's check:
    - Time ordering: Did X happen before Y? ✅
    - Mechanism: Is there a plausible pathway?
    - Dose-response: More X → more Y?
    - Counterfactual: Unaffected segment stayed stable?"
User: (works through each)

AI: "Sensitivity check — does this hold if we:
    - Change the date range by a week?
    - Exclude outliers?
    - Use a different metric definition?"
User: (confirms robustness)
AI: → Updates 03_investigate.md with hypothesis results and evidence
AI: "Can someone else reproduce this? Let's save queries to assets/."
```

#### VOICE Stage — So What, Now What
```
AI: "Let's frame each finding with 'So What → Now What'."
AI: "Finding 1: {summary}. So what does this mean for the business?"
User: (interprets business impact)
AI: "Now what? What are the options?"
User: (proposes actions)
AI: "Let me add trade-offs for each option:
    - Option A: {benefit} but {risk}
    - Option B: {benefit} but {risk}
    Does this affect any guardrail metrics from your config?"
User: (evaluates)

AI: "Confidence level on each finding:"
    - Finding 1: 🟢 High — multiple sources, robust to sensitivity checks
    - Finding 2: 🟡 Medium — supported but small sample
AI: "Does that feel right?"
User: (adjusts)

AI: "Who needs to hear this? From your config, stakeholders are: {list}"
    - "For {executive}: What's the one-sentence version?"
    - "For {product team}: What's the technical detail they need?"
    - "For {marketing}: How does this affect their metrics?"
User: (tailors messages)
AI: → Updates 04_voice.md
AI: "Important — what are the limitations and caveats? Let's make those visible,
     not buried in a footnote."
```

#### EVOLVE Stage — Stress-test and look forward
```
AI: "Before we close — let's stress-test our conclusion."
    - "What new data could DISPROVE what we found?"
    - "What assumptions did we make that we didn't verify?"
    - "If a colleague challenged this, what would they attack?"
User: (identifies vulnerabilities)

AI: "Should we set up monitoring for this?"
    - "What metric should we track going forward?"
    - "What threshold should trigger re-investigation?"
    - "Who should own it?"
User: (sets up monitoring plan)

AI: "What questions came up that we didn't answer?"
User: (lists open questions)
AI: "Any reusable patterns from this analysis? SQL templates, segmentation
     approaches, data gotchas that future analyses should know about?"
User: (captures learnings)

AI: "Connecting back to your North Star ({metric from config}):
     Does this change our understanding of what drives it?"
User: (reflects)
AI: "One sentence — the single most important takeaway?"
User: (provides insight)
AI: → Updates 05_evolve.md
AI: "Ready to archive? Or want to revisit any stage?"
```

### Quick Mode Conversation

Quick mode follows the same methodology but compressed. The AI still guides through each lens but faster:
```
AI: "What's the question? Is this a 'why did X happen' or 'are X and Y related'? (ASK)"
User: "Why did signups drop yesterday?"
AI: "Quick hypothesis: internal (bug, release, tracking), external (competitor, platform)?
     Which feels most likely?"
User: "Probably internal — we had a release yesterday"

AI: "Where will you look? Let's segment: which platform, which user type? (LOOK)"
User: "GA4 events and server logs — mobile seems affected"
AI: "Any external factors? Holiday? Competitor launch?"
User: "No, nothing I know of"

AI: "What did you find? (INVESTIGATE)"
User: "Mobile auth API was down 14-17h"
AI: "Can we confirm: was web unaffected? Does timing match the drop exactly?"
User: "Yes, web was fine. Drop is exactly 14-17h."

AI: "So what — and now what? (VOICE)"
User: "API maintenance caused mobile signup failures. We need a fallback."
AI: "Confidence? 🟢 High — timing matches, web unaffected, clear mechanism."

AI: "Any follow-up? Should we monitor this? (EVOLVE)"
User: "Add email auth as fallback. Set up uptime alert for auth API."
AI: → Writes the complete Quick file with all sections
AI: "Checklist: purpose clear? ✅ data segmented? ✅ conclusion answers question? ✅
     hypothesis tested (not just assumed)? ✅"
AI: "Archive this, or keep it active?"
```

### Modeling Mode Conversation Adjustments

For 📈 Modeling analyses, the conversation focus shifts at each stage:
- **ASK**: "What are you trying to predict/classify?" + business impact + success criteria (AUC, MAPE targets)
- **LOOK**: Target variable distribution, feature exploration, leakage risk, train/val/test split strategy
- **INVESTIGATE**: Baseline → model comparison → best model analysis → error analysis → reproducibility
- **VOICE**: Model performance vs target, business interpretation, deploy recommendation, monitoring plan
- **EVOLVE**: Model drift risk, retraining schedule, feature pipeline automation, A/B test proposal

### Mid-Conversation Data Handling

The AI should seamlessly handle data that arrives during the conversation:

1. **User provides a file** (CSV, Excel, JSON, SQL dump):
   - Read the file, summarize: rows, columns, date range, notable patterns
   - Ask: "What should I look for in this data?"
   - Document the file in the analysis's `assets/` folder

2. **MCP is connected** (database access):
   - Propose a query in natural language first
   - Show the actual SQL/query and get confirmation before running
   - Discuss results, then propose next query based on findings
   - Save all queries to `assets/` for reproducibility

3. **User shares a screenshot** (dashboard, chart):
   - Interpret the visual: trends, anomalies, patterns
   - Ask clarifying questions: "Is this Y-axis absolute or percent?"
   - Note the source for documentation

4. **No direct data access**:
   - Generate SQL/Python code for user to execute
   - Ask user to paste results back
   - AI interprets and continues the conversation

### What NOT to do

- ❌ Generate analysis content without asking the user
- ❌ Skip stages or combine multiple stages at once
- ❌ Auto-check all checklist items without discussion
- ❌ Move to the next stage without user confirmation
- ❌ Make assumptions about data, methods, or conclusions
- ❌ Claim causation without testing for it (time ordering, mechanism, counterfactual)
- ❌ Present aggregate numbers without segmentation
- ❌ Ignore external factors and cross-service impacts
- ❌ Stop at the first plausible hypothesis without testing alternatives
- ❌ Present findings without "So What?" and "Now What?"
- ❌ Skip sensitivity analysis — always check robustness
- ❌ Run MCP queries or read files without user confirmation
