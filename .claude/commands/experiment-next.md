# /experiment next

Advance the current experiment to the next stage.

## Instructions

### Step 1: Identify current experiment

Read `.analysis/status.md` to find active experiments (Type: 🧪 Experiment).

- If only 1 active Full experiment → select it automatically
- If multiple active → ask user which experiment to advance (show ID + title)
- Quick experiments don't use `/experiment next` (all sections are in one file)
  - If user selects a Quick, remind them to fill sections in order within the file

### Step 2: Determine current stage

Read the experiment folder to see which stage files exist:
- Only `01_design.md` → current stage is DESIGN
- Up to `02_validate.md` → current stage is VALIDATE
- Up to `03_analyze.md` → current stage is ANALYZE
- Up to `04_decide.md` → current stage is DECIDE
- All 5 files exist → current stage is LEARN (experiment is complete)

### Step 3: Review current stage checklist

Read the current stage's checklist (embedded at the bottom of the current stage file).

Check if there are any 🔴 (stop) items:
- If 🔴 items exist → warn the user: "There are stop signals in your {stage} checklist. Review before proceeding."
- If all items are unchecked → remind: "Don't forget to review the checklist before moving on."
- If items are checked → proceed

**Special gate: DESIGN → VALIDATE**
Before advancing from DESIGN, verify:
- Pre-registration section is filled (this MUST be locked before seeing any data)
- If empty, warn: "Your analysis plan should be pre-registered before starting the experiment. Fill the Pre-registration section in 01_design.md first."

### Step 4: Generate next stage file

Based on current stage, generate the next file.

**DESIGN → VALIDATE** (generate `02_validate.md`):
```markdown
# VALIDATE: {title}
> ID: {ID} | Type: 🧪 Experiment | Stage: ✅ VALIDATE | Updated: {YYYY-MM-DD}

## Pre-Experiment Checks

### AA Test / Historical Balance
- Method: (AA test on pre-period data / historical segment comparison)
- Result: Groups are balanced / not balanced
- Key metrics checked:
  | Metric | Control | Treatment | Δ | Balanced? |
  |--------|---------|-----------|---|-----------|
  | | | | | |

### Sample Ratio Mismatch (SRM)
- Expected ratio: {from 01_design.md}
- Actual ratio: {observed}
- Chi-square test p-value: (p < 0.001 indicates SRM)
- SRM detected? No / Yes → ⚠️ investigate before proceeding

> 💡 SRM indicates a problem with randomization. Common causes:
> - Bot filtering differences between variants
> - Redirect timing differences
> - Initialization bias (treatment takes longer to load)
> If SRM is detected, DO NOT proceed to Analyze. Fix the root cause first.

### Segment Balance
| Segment | Control % | Treatment % | Balanced? |
|---------|-----------|-------------|-----------|
| New users | | | |
| Returning users | | | |
| Platform (iOS/Android/Web) | | | |
| {custom segment} | | | |

### Instrumentation Check
- [ ] Primary metric events logging correctly
- [ ] Secondary metric events logging correctly
- [ ] Guardrail metric events logging correctly
- [ ] No duplicate counting
- [ ] Attribution window correctly set

## External Factors
- Holidays/events during experiment period:
- Planned releases/deployments:
- Marketing campaigns:
- Other active experiments on same population:

## Ramp-Up Log
| Date | Traffic % | Observation | Action |
|------|-----------|-------------|--------|
| {start} | {initial}% | | |

## Validation Summary
- Ready to proceed? ✅ Yes / 🔴 No — {reason}
- Issues found:
- Mitigation:

---
{Insert VALIDATE checklist from ab-tests/checklists/validate.md}
```

**VALIDATE → ANALYZE** (generate `03_analyze.md`):

**Important**: Before generating this file, ask the user: "Has the experiment reached the minimum duration from 01_design.md? Ending early risks false conclusions."

If the experiment was stopped before the minimum duration, add a warning banner at the top of the file:
```
> ⚠️ **EARLY STOPPING WARNING**: This experiment ran {X} of {Y} planned days.
> Results may be inflated due to optional stopping bias. Post-launch monitoring is critical.
```

```markdown
# ANALYZE: {title}
> ID: {ID} | Type: 🧪 Experiment | Stage: 🔬 ANALYZE | Updated: {YYYY-MM-DD}

## Experiment Summary
- Duration: {start} to {end} ({N} days)
- Sample size: Control = {n₁}, Treatment = {n₂}
- Total: {N}

## SRM Re-check (Final)
- Expected ratio: {from design}
- Final ratio: Control {n₁} / Treatment {n₂} = {ratio}
- SRM test p-value:
- Result: ✅ No SRM / 🔴 SRM detected → results may be invalid

## Primary Metric Results
| | Control | Treatment | Δ (absolute) | Δ (relative) | 95% CI | p-value |
|--|---------|-----------|---------------|--------------|--------|---------|
| {metric} | | | | | | |

- **Statistically significant?** Yes (p < 0.05) / No
- **Practically significant?** Is the effect size meaningful for the business?
  - MDE was: {from design}
  - Observed effect: {actual}
  - "Even if significant, is {Δ} worth the cost of shipping this?"

> 💡 Statistical significance ≠ practical significance.
> A tiny effect can be "significant" with large samples.
> Always ask: "Would I make a different decision knowing this effect size?"

## Secondary Metrics
| Metric | Control | Treatment | Δ | p-value | Direction | Notable? |
|--------|---------|-----------|---|---------|-----------|----------|
| | | | | | | |
| | | | | | | |

## Guardrail Metrics
| Metric | Control | Treatment | Δ | Acceptable? | Threshold |
|--------|---------|-----------|---|-------------|-----------|
| | | | | ✅ / 🔴 | from config.md |

**Guardrail verdict**: All clear / ⚠️ {metric} degraded

## Statistical Method
- Test used: {t-test / chi-square / Mann-Whitney / z-test for proportions}
- Why this test: {justification based on metric type and distribution}
- One-sided or two-sided:
- Multiple comparison correction: {none / Bonferroni / Holm / FDR} (if >2 variants)
- Bayesian analysis (optional):
  - P(treatment > control):
  - Expected loss:
  - Credible interval:

## Segment Analysis
> Check if the overall effect holds across segments — watch for Simpson's Paradox.

| Segment | n (C) | n (T) | Δ | p-value | Different from overall? |
|---------|-------|-------|---|---------|------------------------|
| New users | | | | | |
| Returning users | | | | | |
| {platform} | | | | | |
| {custom} | | | | | |

- Simpson's Paradox risk: {overall effect driven by one segment?}

> 💡 Segment analysis note: Report all pre-planned segments from the pre-registration. For exploratory segments discovered during analysis, note them separately — use Holm-Bonferroni correction if making segment-level decisions.

## Time Series Analysis
- Effect over time: Stable / Growing / Declining
- Novelty effect risk: {first few days showed large effect that faded?}
- Primacy effect risk: {effect grew over time as users learned?}
- Day-of-week patterns:

## Sensitivity Checks
- Exclude first day (initialization effects): Same result?
- Exclude outliers (top/bottom 1%): Same result?
- Different attribution window: Same result?
- Winsorized metrics (if applicable): Same result?

## Reproducibility
- Query/notebook location: `assets/`
- Steps to reproduce:

---
{Insert ANALYZE checklist from ab-tests/checklists/analyze.md}
```

**ANALYZE → DECIDE** (generate `04_decide.md`):
```markdown
# DECIDE: {title}
> ID: {ID} | Type: 🧪 Experiment | Stage: 🏁 DECIDE | Updated: {YYYY-MM-DD}

## Decision

### Verdict: {🚀 Launch / 🔴 Kill / ⏳ Extend / 🔄 Iterate}

### Decision Matrix
| Criterion | Result | Pass? |
|-----------|--------|-------|
| Primary metric improved? | {Δ, p-value} | ✅ / 🔴 |
| Effect ≥ MDE? | {observed vs MDE} | ✅ / 🔴 |
| Guardrails safe? | {status} | ✅ / 🔴 |
| No segment shows harm? | {segment check} | ✅ / 🔴 |
| Consistent with pre-registration? | {any deviation?} | ✅ / 🔴 |

### Decision Rules (from pre-registration)
| Scenario | Decision |
|----------|----------|
| Primary ✅ + Guardrails ✅ | 🚀 Launch |
| Primary 🔴 or Guardrails 🔴 | 🔴 Kill |
| Primary trending ✅ but underpowered | ⏳ Extend {N more days} |
| Primary mixed (some segments ✅, some 🔴) | 🔄 Iterate (redesign treatment) |

### Reasoning
- (Why this decision, in 2-3 sentences)

## Impact Estimate
- Expected impact on primary metric:
- Expected impact on North Star metric (from config.md):
- Revenue/cost implication:
- Users affected:

## Rollout Plan (if Launch)
- Rollout strategy: {immediate 100% / gradual ramp / segment-first}
- Ramp schedule:
- Kill switch: {how to revert if issues arise post-launch}
- Monitoring plan post-launch:

## Risk Assessment (if Launch)
- Long-term effects unknown: {list}
- Interaction with upcoming changes: {list}
- Edge cases not covered: {list}
- Optional stopping bias: {if experiment was stopped early, note the risk}

## Salvage Assessment (if Kill or Iterate)
- Is there any segment where the treatment worked? (Could we ship to that segment only?)
- Which components of the treatment are still valuable?
- What modified version might work? (Informs Iterate decision)
- Root cause of failure: (Informs next experiment design)

## Multi-Variant Results (if >2 variants)
| Variant | Primary Δ | p-value (adj) | Guardrails | Verdict |
|---------|-----------|---------------|------------|---------|
| Treatment A | | | | ✅ / 🔴 |
| Treatment B | | | | ✅ / 🔴 |

- Best performing variant:
- Decision: Launch {variant} / Run pairwise follow-up / Kill all

## Audience-Specific Messages

### For Product/PM
-

### For Engineering
-

### For Leadership
-

## Limitations & Caveats
- What this experiment did NOT test:
- Population limitations:
- Duration limitations:

---
{Insert DECIDE checklist from ab-tests/checklists/decide.md}
```

**DECIDE → LEARN** (generate `05_learn.md`):
```markdown
# LEARN: {title}
> ID: {ID} | Type: 🧪 Experiment | Stage: 📚 LEARN | Updated: {YYYY-MM-DD}

## Experiment Outcome Summary
- **Hypothesis**: {from 01_design.md}
- **Result**: Confirmed / Rejected / Inconclusive
- **Decision**: 🚀 Launched / 🔴 Killed / ⏳ Extended / 🔄 Iterated
- **Actual effect**: {observed Δ} on {primary metric}

## What We Learned
- What went as expected?
- What was surprising?
- What would we do differently in the experiment design?

## Post-Launch Monitoring (if launched)
| Checkpoint | Date | Primary Metric | Guardrail | Status | Notes |
|------------|------|----------------|-----------|--------|-------|
| Week 1 | | | | | |
| Week 2 | | | | | |
| Week 4 | | | | | |
| Week 12 | | | | | |

- Long-term effect: Stable / Growing / Declining / Unknown yet
- Any unexpected side effects:

## Hypothesis Evolution
- Original hypothesis correct? Fully / Partially / No
- Updated understanding:
- New hypotheses generated:

## Follow-Up Experiments
- [ ] {experiment idea} — to test {what}
- [ ] {experiment idea} — to test {what}

## Follow-Up Analyses
- [ ] {analysis} → `/analysis new` (e.g., deeper segment investigation)
- [ ] {analysis} → `/analysis new`

## Proposed New Metrics
> If this experiment revealed a gap in the metric framework, define it here.
> Say "I think we need a metric for {X}" and the AI will guide you through it.

### Metric: {name}

**Background**
- What gap did this experiment reveal in the current metric framework?
- Trigger:
- Replaces or complements:

**Purpose**
- Decision this metric informs:
- Primary audience:
- Proposed tier: 🌟 North Star / 📊 Leading / 🛡️ Guardrail / 🔬 Diagnostic

**Definition & Logic**
- Formula / calculation:
- Data source:
- Granularity: (daily / weekly / monthly / per-cohort)
- Edge cases handled:

**Interpretation Guide**
- Healthy range:
- Alert threshold:
- Counter-metric:
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

## Knowledge Capture
- Reusable experiment patterns:
- Audience/segment insights:
- Technical gotchas (instrumentation, SRM causes):
- Saved queries/notebooks: `assets/`

## Connection to Analyses
- Related analyses: {list analysis IDs}
- This experiment was triggered by: {analysis ID, if any}
- Next analysis from these results: {planned}

## One-Sentence Takeaway
> (Capture the single most important learning)

---
{Insert LEARN checklist from ab-tests/checklists/learn.md}
```

**LEARN reached** → Tell user:
"This experiment is complete. Run `/experiment archive` to archive it."

### Step 5: Update status.md

Update the experiment row in `.analysis/status.md`:
- Change the stage column to the new stage icon
- Update "Last updated" timestamp

Stage icons for experiments:
```
📐 DESIGN → ✅ VALIDATE → 🔬 ANALYZE → 🏁 DECIDE → 📚 LEARN
```

### Step 6: Confirmation

Tell the user:
- Advanced from {old stage} to {new stage}
- Show the new file path
- Remind them to fill in the content and review the checklist
- **DESIGN → VALIDATE**: "Make sure your Pre-registration section is locked. Don't peek at results yet!"
- **VALIDATE → ANALYZE**: "Has the experiment run for the minimum duration? Stopping early risks false conclusions."
- **ANALYZE → DECIDE**: "Use the pre-registered decision criteria. Resist the urge to move the goalposts."
- **DECIDE → LEARN**: "Set up post-launch monitoring checkpoints. The experiment isn't truly done until you've validated the long-term effect."
