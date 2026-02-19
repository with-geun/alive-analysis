---
name: alive-analysis
description: Data analysis workflow kit using the ALIVE loop (Ask, Look, Investigate, Voice, Evolve)
---

# alive-analysis Skill (Cursor Edition)

> Data analysis workflow kit based on the ALIVE loop.
> Optimized for Cursor's batch-oriented agent model.

---

## Cursor-Specific Behavior

**State management**: Read `.analysis/status.md` and `.analysis/config.md` at the start of EVERY command. Write updates back to `.analysis/status.md` after EVERY action.

**Question style**: Present ALL questions at once in a structured form. Do NOT ask questions one by one — Cursor agents work best with batch input.

**File-based context**: There is no session memory. Always read state from files before acting.

---

## Overview

alive-analysis structures data analysis using the **ALIVE loop**:
**Ask → Look → Investigate → Voice → Evolve**

Two personas:
- **Data analysts**: Deep, systematic analysis with full ALIVE flow (5 files)
- **Non-analyst roles** (PM, engineers, marketers): Quick analysis with guided framework (1 file)

---

## ALIVE Loop Summary

### Stage 1: ASK
**What do we want to know — and WHY?**

- Define the problem clearly; confirm the requester's REAL goal
- Frame: causation ("Why did X happen?") vs correlation ("Are X and Y related?")
- Build a hypothesis tree before touching data
- Set success criteria and scope boundaries
- Use the Structured Data Request: `[Period] + [Subject] + [Condition] + [Metric] + [Output Format]`

### Stage 2: LOOK
**What does the data ACTUALLY show — and what's missing?**

- Review data quality (missing values, outliers, date ranges)
- Segment before averaging — never trust aggregates alone
- Check for confounding variables and external factors
- Map cross-service dependencies
- Validate data access methods

### Stage 3: INVESTIGATE
**Why is it REALLY happening — can we prove it?**

- Eliminate hypotheses systematically (not just confirm the first one)
- Apply multi-lens analysis: macro → meso → micro
- Test causation vs correlation rigorously
- Perform sensitivity analysis for robustness
- Assign confidence levels to findings

### Stage 4: VOICE
**So what — and now what?**

- Apply "So What → Now What" for every finding
- Assign confidence levels: 🟢 High / 🟡 Medium / 🔴 Low
- Frame recommendations with trade-off analysis
- Tailor messages to different audiences
- Make limitations first-class content

### Stage 5: EVOLVE
**What would change our conclusion — and what should we ask next?**

- Stress-test conclusions: "What would disprove this?"
- Identify follow-up analyses
- Set up monitoring for identified issues
- Capture reusable knowledge
- Connect back to North Star metric

> For detailed methodology, see `core/references/analytical-methods.md`
> For conversation examples, see `core/references/conversation-examples.md`

---

## Analysis Types

### Investigation
"Why did X happen?" — Root cause analysis, anomaly detection, ad-hoc deep dives.

### Modeling
"Can we predict/classify/segment?" — Statistical modeling, ML, forecasting. Focus on prediction targets, feature exploration, model comparison, drift monitoring.

### Simulation
"What would happen if we do X?" — Policy evaluation, pricing strategy. Uses 4-step framework: identify variable accounts → define relationships → scenario experiments → continuous refinement.

---

## Checklist Summary

### Full Mode (per stage)

**ASK**: Real goal identified? Causal/correlational framing? Hypothesis tree built? Actionable question? Data spec confirmed?

**LOOK**: Segmented before conclusions? Confounders checked? External factors? Cross-service impacts? Variability checked?

**INVESTIGATE**: Multiple hypotheses tested? Multi-lens applied? Causation verified (if claimed)? Sensitivity analysis? Confidence levels assigned?

**VOICE**: "So What → Now What" applied? Confidence tagged with reasoning? Trade-offs explicit? Guardrails checked? Execution path included?

**EVOLVE**: Conclusion stress-tested? Monitoring set up? North Star connected? Follow-ups defined? Knowledge captured?

### Quick Mode (5 items)

```
- [ ] Is the purpose clear and framed (causation/correlation/comparison/evaluation)?
- [ ] Was the data broken down by groups (not just totals)?
- [ ] Were alternative explanations considered?
- [ ] Does the conclusion answer the question with a confidence level?
- [ ] Is there enough data (rows, time period) to support this conclusion?
```

---

## Experiment (A/B Test) Summary

ALIVE loop adapted for experiments:

| ALIVE | Experiment | Key Question |
|-------|-----------|-------------|
| ASK → DESIGN | What exactly are we testing? | Is the hypothesis falsifiable? |
| LOOK → VALIDATE | Is the setup correct? | Is randomization clean? |
| INVESTIGATE → ANALYZE | What do the numbers say? | Is the effect real? |
| VOICE → DECIDE | What should we do? | Launch, kill, extend, iterate? |
| EVOLVE → LEARN | What did we learn? | What's next? |

Key principles: One question per experiment. Pre-register analysis plan. Respect sample size. Check for interference (SUTVA). Guardrails are non-negotiable.

> For statistical methods, see `core/references/experiment-statistics.md`

---

## Metric Monitoring Summary

```
Analysis → Monitor Setup → Regular Checks → Alerts → Investigation
```

**4 tiers**: 🌟 North Star (1) → 📊 Leading (3-5) → 🛡️ Guardrail (2-4) → 🔬 Diagnostic (unlimited)

**STEDII validation**: Sensitive, Trustworthy, Efficient, Debuggable, Interpretable, Inclusive

**Alert escalation**: 🟢 Healthy → 🟡 Warning → 🔴 Critical → Investigation

---

## ID Format

- Full (Investigation/Modeling): `F-{YYYY}-{MMDD}-{seq}`
- Full (Simulation): `S-{YYYY}-{MMDD}-{seq}`
- Quick: `Q-{YYYY}-{MMDD}-{seq}`
- Experiment: `E-{YYYY}-{MMDD}-{seq}` / Quick: `QE-{YYYY}-{MMDD}-{seq}`
- Monitor: `M-{YYYY}-{MMDD}-{seq}`
- Alert: `A-{YYYY}-{MMDD}-{seq}`

---

## Stage Icons

```
Analysis: ❓ ASK → 👀 LOOK → 🔍 INVESTIGATE → 📢 VOICE → 🌱 EVOLVE
Experiment: 📐 DESIGN → ✅ VALIDATE → 🔬 ANALYZE → 🏁 DECIDE → 📚 LEARN
Status: ✅ Archived | ⏳ Pending | 🟡 In Progress
```

---

## File Naming

- Full folder: `{ID}_{title-slug}/`
- Quick file: `quick_{ID}_{title-slug}.md`
- Stage files: `01_ask.md` through `05_evolve.md`
- Model card: `.analysis/models/{model-slug}_v{version}.md`

---

## Interaction Guidelines (Cursor-Adapted)

### Core Principles

1. **Ask, don't assume** — Present questions to the user before filling content.
2. **One stage at a time** — Complete the current stage before moving on.
3. **User writes the insight, AI structures it** — AI helps organize and challenge.
4. **Batch questions** — Present all questions for a stage at once in a structured form.
5. **State via files** — Always read/write `.analysis/status.md` for state tracking.

### What NOT to do

- Generate analysis content without asking the user
- Skip stages or combine multiple stages
- Auto-check checklist items without discussion
- Move to next stage without user confirmation
- Make assumptions about data, methods, or conclusions
- Run queries or read data files without user confirmation

---

## Situational Protocols

### Scope Creep
When scope expands mid-analysis: park the new question for EVOLVE follow-ups, swap the current scope, or expand with timeline re-estimation.

### Rabbit Hole Guard
If spending 3+ rounds on a sub-question without actionable progress, check: "Does knowing this change what we'd recommend?" If no → move to VOICE.

### Data Quality Emergency
If bad data is discovered: assess impact on core question, then patch & continue, scope down, pause & fix, report with caveat, or reframe.

### Analysis Independence
Never comply with requests to reach predetermined conclusions. Present data honestly with trade-off framing.

---

## Language Support

All AI responses and generated files follow the language set in `.analysis/config.md`. Default: English. Technical terms (ALIVE, STEDII, SHAP) remain in English.

---

## Quick Reference

| Question | Method |
|----------|--------|
| Which groups are different? | t-test (2), ANOVA (3+) |
| Which users are similar? | K-Means clustering |
| What appears together? | Association rules (Lift) |
| Can we predict an outcome? | LTV models, time series |
| Is this A/B test real? | Experiment analysis |
| How spread out / risky? | CV, Sharpe ratio adaptation |

| Quasi-Experimental | When |
|-------------------|------|
| DiD | Before/after + comparison group |
| RDD | Clear threshold determines treatment |
| PSM | Groups inherently different |
| IV | External factor affects treatment only |

> For full details on all methods, see `core/references/analytical-methods.md`

---

## Impact Tracking, Tags & Model Registry

### Impact Tracking
Track whether recommendations led to real outcomes. Built into EVOLVE stage.

```
Recommendation → Decision (Accept/Reject/Modify) → Execution → Result
```

When creating analyses, remind the user to update pending Impact Tracking items. `/analysis-retro` aggregates impact data across all analyses.

### Tags
Connect related analyses with tags (e.g., `retention`, `pricing`). Defined in `config.md` (team-level) or ad-hoc per analysis. AI suggests relevant tags on creation and checks for related work. Tags are preserved during Quick→Full promotion.

### Model Registry
Track deployed ML models in `.analysis/models/{model-slug}_v{version}.md`. Each model card includes: performance metrics, feature importance, training details, deployment info, and drift monitoring triggers. Versions auto-increment on retraining. Links to originating Modeling analysis and metric monitors.

---

## Education Mode

Structured learning for the ALIVE methodology through guided scenarios.

**Commands:**
- `/analysis-learn` — Start a learning session
- `/analysis-learn-next` — Get feedback and advance to next stage
- `/analysis-learn-hint` — Request progressive hints (3 levels per stage)
- `/analysis-learn-review` — Complete with scored review

**Difficulty levels:**
- **Beginner** (Quick format): Rich annotations, built-in hints, single-cause scenarios, 20-30 min
- **Intermediate** (Full format): Brief reminders, hints via command only, complex scenarios, 45-60 min

**Scenarios:**
- b1: "Why did signups drop?" (Beginner, Investigation)
- b2: "Which onboarding flow is better?" (Beginner, Comparison)
- b3: "How much does turnover cost us?" (Beginner, Quantification)
- i1: "Why did DAU drop 15%?" (Intermediate, Investigation)
- i2: "Should we lower delivery fees?" (Intermediate, Simulation)
- i3: "Did the new checkout flow improve conversion?" (Intermediate, Experiment)
- i4: "Can we predict which users will churn?" (Intermediate, Modeling)

**Feedback protocol:** Score each stage using rubric → highlight strengths → identify gaps with explanations → check `## Most Common Mistakes` in rubric.md and present matched patterns as `> **Common Mistake Detected**: {name} — {explanation}` → reveal next-stage data. Adjust tone by learner's role.

**Hints:** 3 progressive levels per stage (Direction → Specific → Near-answer). Tracked in progress.md.

**Progress:** `.analysis/education/progress.md` — scores, Skill Radar, recommended next.

**Graduation:** Beginner → Intermediate (2+ scenarios, 70%+). Education → Production (Intermediate 75%+).

**ID format:** `L-{YYYY}-{MMDD}-{seq}`

**Integration:** Learning sessions show as 📚 in status, excluded from search/retro by default.

---

## Insight Search & Retrospective

### `/analysis-search`
Deep full-text search across all analyses (active + archived). Shows matching context with surrounding lines, cross-references similar conclusions, and surfaces unresolved follow-ups.

Filters: `--keyword`, `--tag`, `--date`, `--type`, `--confidence`, `--active`/`--archived`/`--both`

### `/analysis-retro`
Generates a retrospective report from archived analyses for a given period. Outputs to `analyses/.retro/retro_{period}.md`.

Sections: Summary, Analysis Activity, Impact Tracking, Patterns, Unresolved Follow-ups, Recommendations, Appendix.

Options: `--last-month` (default), `--last-quarter`, `--range {from to}`, `--all`
