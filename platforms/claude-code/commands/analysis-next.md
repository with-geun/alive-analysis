# /analysis-next

Advance the current analysis to the next ALIVE stage.
Includes Sub-agent Dispatch: auto-runs required gates + shows specialist recommendations.

## Instructions

### Step 1: Identify current analysis

Read `.analysis/status.md` to find active analyses.

- If only 1 active Full analysis → select it automatically
- If multiple active → ask user which analysis to advance (show ID + title)
- Quick analyses don't use `/analysis-next` (all sections are in one file)
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

**Note:** If this is a 📈 Modeling analysis, use the Modeling-specific templates defined in `analysis-new.md` Section 4B instead of the Investigation templates below. This applies to LOOK, INVESTIGATE, VOICE, and EVOLVE stages. If this is a 🔮 Simulation analysis, use the Simulation-specific templates from `analysis-new.md` Section 4D for all stages.

```markdown
# LOOK: {title}
> ID: {ID} | Type: 🔍 Investigation | Stage: 👀 LOOK | Updated: {YYYY-MM-DD}

## Data Sources
- Primary:
- Secondary:
- Access method: (MCP / exported file / manual query / BI dashboard)

## Data Quality Review
- Row count:
- Date range:
- Missing values:
- Known issues:

## Segmentation
Break down BEFORE drawing conclusions:
- By time:
- By cohort:
- By platform:
- By segment:

Key question: "Does the pattern hold across ALL segments, or is it driven by one?"

## Confounding Variables
- What else changed at the same time?
- Population comparison: Are we comparing the same groups?
- Survivorship bias risk:
- Simpson's paradox check:

## External Factors
- Calendar: holidays, seasonality, industry events
- Competitors: recent launches, pricing changes
- Platform: iOS/Android policy, algorithm updates
- Macro: economic indicators, regulation changes

## Cross-Service Check
- Related services that may be affected:
- Shared resources (auth, data pipeline, user base):
- Recent changes in adjacent services:

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
> ID: {ID} | Type: 🔍 Investigation | Stage: 🔍 INVESTIGATE | Updated: {YYYY-MM-DD}

## Hypothesis Scorecard
| # | Hypothesis | Evidence For | Evidence Against | Status | Contribution |
|---|-----------|-------------|-----------------|--------|-------------|
| 1 | | | | ✅/❌/⚠️ | ~%  |
| 2 | | | | ✅/❌/⚠️ | ~%  |
| 3 | | | | ✅/❌/⚠️ | ~%  |

Strategy: Test the easiest-to-disprove hypotheses first.

## Multi-Lens Analysis

### Macro (market/industry)
- Industry-wide trend?
- Competitor actions?
- Economic/regulatory factors?

### Meso (company/product)
- Cross-service impact?
- Channel mix shift?
- Product changes (releases, A/B tests)?

### Micro (user/session)
- User behavior patterns:
- Cohort-specific trends:
- Edge cases:

## Causation vs Correlation
(Fill if causal claims are being made)
- Time ordering: Did cause precede effect?
- Mechanism: Plausible pathway?
- Dose-response: More cause → more effect?
- Counterfactual: Control group / unaffected segment?
- Conclusion: Causal / Correlational / Inconclusive

## Results

### Finding 1
- Description:
- Evidence:
- Confidence: 🟢 High / 🟡 Medium / 🔴 Low
- Reasoning:

### Finding 2
- Description:
- Evidence:
- Confidence: 🟢 High / 🟡 Medium / 🔴 Low
- Reasoning:

## Sensitivity Analysis
- Date range ±1 week: Same result?
- Exclude outliers: Same pattern?
- Different metric definition: Consistent?
- Minimum actionable effect size:

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
> ID: {ID} | Type: 🔍 Investigation | Stage: 📢 VOICE | Updated: {YYYY-MM-DD}

## Executive Summary
(1-3 sentences for leadership — lead with business impact)

## So What → Now What

### Finding 1
- **Finding**:
- **So What?** (business impact):
- **Now What?** (options):
  - Option A: {action} — benefit: {X}, risk: {Y}
  - Option B: {action} — benefit: {X}, risk: {Y}
- **Confidence**: 🟢 High / 🟡 Medium / 🔴 Low
- **Reasoning**:

### Finding 2
- **Finding**:
- **So What?**:
- **Now What?**:
- **Confidence**: 🟢 High / 🟡 Medium / 🔴 Low
- **Reasoning**:

## Recommendations
1. (with trade-off analysis)
2. (with trade-off analysis)

## Guardrail Impact
- Does this recommendation affect any guardrail metrics? (reference config.md)
- Trade-off: improving {metric A} may risk {metric B}

## Audience-specific Messages

### For {stakeholder 1}
-

### For {stakeholder 2}
-

## Limitations & Caveats
(These are first-class content, not a footnote)
- What we couldn't verify:
- Where sample was small:
- Assumptions we made:
- What would change our conclusion:

## Data Sources
- Sources used:
- Query locations: `assets/`

---
{Insert VOICE checklist from .analysis/checklists/voice.md}
```

**VOICE → EVOLVE** (generate `05_evolve.md`):
```markdown
# EVOLVE: {title}
> ID: {ID} | Type: 🔍 Investigation | Stage: 🌱 EVOLVE | Updated: {YYYY-MM-DD}

## Conclusion Robustness Check
- What new data could **disprove** our conclusion?
- What **assumptions** did we make but not verify?
- If a colleague challenged this, what would they attack?
- In 3 months, what would make us say "we were wrong"?

## Reflection
- What went well in this analysis?
- What could be improved?
- What surprised us?

## Monitoring Setup
- Metric to track going forward:
- Threshold for re-investigation:
- Dashboard / alert: (reference data stack from config.md)
- Owner:

## Unanswered Questions
-

## Follow-up Analysis Proposals
- [ ] {description} → (not yet created)
- [ ] {description} → (not yet created)

## Impact Tracking
> Track whether this analysis led to real decisions and outcomes. Revisit this section after 2-4 weeks.

| # | Recommendation | Decision | Owner | Status | Outcome |
|---|---------------|----------|-------|--------|---------|
| 1 | {from VOICE} | Accepted / Rejected / Modified | {who} | Not started / In progress / Done | {what happened} |
| 2 | | | | | |

- **Analysis influenced a decision?** Yes / No / Pending
- **Decision date**: {when the decision was made}
- **Outcome check date**: {2-4 weeks after decision — set a reminder}
- **Retrospective**: Was the recommendation correct? What would we do differently?

## Knowledge Capture
- Reusable patterns (SQL templates, segmentation approaches):
- Data gotchas for future analyses:
- Saved queries/notebooks: `assets/`
- Data quality issues to flag:

## North Star Connection
- How does this connect to {North Star metric from config.md}?
- Does this change our understanding of what drives it?
- Should our metric framework be updated? → If yes, use the section below.

## Proposed New Metrics
> Fill this section through conversation with the AI. Say "I think we need a metric for {X}" and the AI will guide you through defining it together.

### Metric: {name}

**Background**
- What gap did this analysis reveal in the current metric framework?
- Trigger: (the finding, blind spot, or missing visibility that led to this proposal)
- Replaces or complements: (existing metric, or "new")

**Purpose**
- Decision this metric informs:
- Primary audience:
- Proposed tier: 🌟 North Star / 📊 Leading / 🛡️ Guardrail / 🔬 Diagnostic

**Definition & Logic**
- Formula / calculation:
- Data source:
- Granularity: (daily / weekly / monthly / per-cohort)
- Refresh cadence:
- Edge cases handled: (zero denominator, new users, seasonality)

**Interpretation Guide**
- Healthy range:
- Alert threshold:
- Counter-metric: (what to watch so this metric isn't gamed)
- Plain-language: "When this goes up, it means... When it drops, it means..."

**STEDII Validation**
- [ ] **Sensitive** — Can it detect real changes?
- [ ] **Trustworthy** — Is the data accurate and the definition unambiguous?
- [ ] **Efficient** — Can it be computed in a practical timeframe?
- [ ] **Debuggable** — When it moves, can you decompose WHY?
- [ ] **Interpretable** — Does the team understand it without a 5-minute explanation?
- [ ] **Inclusive** — Does it fairly represent all user segments?

**Action**
- [ ] Add to `.analysis/config.md` → {tier}
- [ ] Set up dashboard / alert
- [ ] Communicate definition to stakeholders

(Copy this block for additional metrics)

## Automation Opportunities
- Can any part of this analysis be automated/scheduled?
- Recommended cadence:

## One-Sentence Insight
> (Capture the single most important takeaway)

---
{Insert EVOLVE checklist from .analysis/checklists/evolve.md}
```

**EVOLVE reached** → Tell user:
"This analysis is complete. Run `/analysis-archive` to archive it."

### Step 4.5: Sub-agent Dispatch

After generating the new stage file, run the Sub-agent Dispatch system.

#### 4.5a — Load config and state
1. Read `.analysis/agents.yml` (if exists) else `core/config/agents.yml`
2. If `global.enabled: false` → skip entire Step 4.5
3. Read `.analysis/agent-state.md` (suppression history)

#### 4.5b — Auto-run required gates (no user confirmation)
Evaluate gate conditions from `core/agents/router.yml` for the NEW stage:

**scope-guard** (ASK stage only):
- Auto-run if: Scope section empty AND Problem Definition has content
- Auto-run if: user message contains scope-explosion patterns
- Skip if: config `gates.scope_guard.enabled: false`

**data-quality-sentinel** (LOOK→INVESTIGATE transition):
- Auto-run if: Data Quality Review incomplete at LOOK→INVESTIGATE transition
- Auto-run if: quality risk keywords in stage content
- Skip if: config `gates.data_quality_sentinel.enabled: false`

**ethics-guard** (any stage):
- Auto-run if: PII keywords detected in user message or stage content
- Auto-run if: config `gates.ethics_guard.always_run: true`
- Skip if: config `gates.ethics_guard.enabled: false`

**reproducibility-keeper** (INVESTIGATE→EVOLVE transition):
- Auto-run if: Reproducibility section empty at INVESTIGATE→EVOLVE transition
- Auto-run if: config `gates.reproducibility_keeper.auto_run: true`
- Skip if: config `gates.reproducibility_keeper.enabled: false`

For each gate that fires:
- Print: `[auto] Running {gate-id} — {reason}`
- Apply the gate's prompt from `core/agents/prompts/{gate-id}.md`
- Write output to stage file
- Update `.analysis/agent-state.md`

#### 4.5c — Evaluate optional recommendations
Apply routing rules from `core/agents/router.yml` for the new stage:
1. Score all optional agents by matching conditions + bonuses
2. Apply suppression (skip if same agent ran in this stage without content change)
3. Apply user config (skip disabled agents)
4. Take top_k (max 3, limited by stage config)

#### 4.5d — Show recommendation block (at most one question)
If recommendations exist:
```
─────────────────────────────────────────────────────
🤖 이번 단계에서 도움이 필요할 수 있는 전문가들이에요 — {NEW STAGE}
─────────────────────────────────────────────────────
  1. {label}  —  {reason}
  2. {label}  —  {reason}
  3. {label}  —  {reason}
─────────────────────────────────────────────────────
Run? (1 / 2 / 3 / all / n)  →
```

- This is the **only** question asked beyond Step 2 (multiple analyses case)
- If `ask_confirmation: false` in config → skip question, run all automatically
- If user says n/no → proceed without running, no further questions
- If user picks numbers: run those agents (parallel if multiple)
- If no recommendations: skip this block entirely, proceed to Step 5

#### 4.5e — Execute selected agents
For each selected agent:
1. Apply prompt from `core/agents/prompts/{agent-id}.md`
2. Write output to stage file per agent's output_contract
3. Update `.analysis/agent-state.md`

### Step 5: Update status.md

Update the analysis row in `.analysis/status.md`:
- Change the stage column to the new stage icon
- Update "Last updated" timestamp

### Step 6: Confirmation

Tell the user:
- Advanced from {old stage} to {new stage}
- Show the new file path
- If agents ran: list them with one-line summary of what they produced
- Remind them to fill in the content and review the checklist
- If VOICE: "After completing VOICE and EVOLVE, run `/analysis-archive`"
- Tip: "Run `/analysis-agent` anytime for specialist help within this stage"
