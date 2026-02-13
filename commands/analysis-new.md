# /analysis new

Start a new analysis. Supports `--from {Quick ID}` for Quick-to-Full succession and `--from-alert {Alert ID}` for monitor alert escalation.

## Instructions

### Step 1: Check initialization

Verify `.analysis/config.md` exists. If not, tell the user to run `/analysis init` first.
Read config.md to load team context (metrics, stakeholders, data stack).

### Step 2: Parse arguments

- If `--from-alert {Alert ID}` is provided, this is a monitor alert escalation (skip to Step 2d)
- If `--from {ID}` is provided, this is a Quick→Full succession (skip to Step 2c)
- Otherwise, proceed to Step 2a

### Step 2a: Ask analysis type

Use AskUserQuestion:

**Q1. What type of analysis?**

- 🔍 **Investigation** — "Why did this happen?" Root cause analysis, anomaly detection, ad-hoc deep dives.
- 📈 **Modeling** — "Can we predict/classify/segment?" Statistical modeling, ML, forecasting.
- 🔮 **Simulation** — "What would happen if we do X?" Policy evaluation, pricing strategy, resource allocation.

(Phase 2 types — not yet available:)
- 📊 Monitoring — periodic metric health check
- 🧪 Experiment — A/B test analysis

### Step 2b: Ask mode and details

**Q2. Analysis mode?**
- **Full** — 5 ALIVE files + full checklists.
- **Quick** — Single file with abbreviated ALIVE flow.

**Q3. Analysis title?**
- Free text input

**Q4. (Full only) Brief description**
- Investigation: "What do you want to find out?"
- Modeling: "What do you want to predict or classify?"
- Simulation: "What policy or strategy are you evaluating?"
- This seeds the ASK phase.

**Q5. Tags** (optional)
- Suggest tags from config.md's Tags list if available
- Also suggest based on title/description: "Based on your title, relevant tags might be: `retention`, `mobile`"
- User can accept suggestions, add custom tags, or skip
- Format: comma-separated, lowercase, no spaces (use hyphens for multi-word: `user-onboarding`)

### Step 2c: Quick→Full succession

- Read the Quick file referenced by `--from {ID}`
- Extract content from each ALIVE section
- Use as seed content for Full analysis files using the mapping below
- Add a reference link in the Quick file: `> ⬆️ Promoted to Full: {new Full ID}`

**Content mapping (Quick section → Full file):**

| Quick Section | Full File | Field Mapping |
|---------------|-----------|---------------|
| ASK: Question → | 01_ask.md | Problem Definition |
| ASK: Hypotheses → | 01_ask.md | Hypothesis Tree |
| LOOK: Data source → | 02_look.md | Data Sources |
| LOOK: Segments → | 02_look.md | Segmentation |
| LOOK: Findings → | 02_look.md | Initial Observations |
| INVESTIGATE: Result → | 03_investigate.md | Results |
| INVESTIGATE: Confidence → | 03_investigate.md | Finding confidence level |
| VOICE: So What → | 04_voice.md | Finding 1 |
| VOICE: Audience → | 04_voice.md | Audience-specific Messages |
| EVOLVE: Follow-up → | 05_evolve.md | Follow-up Analysis Proposals |

**File generation rule:**
- Only generate stage files for which the Quick file has **non-empty content** (more than just the template placeholder).
- Example: If ASK, LOOK, and INVESTIGATE have content but VOICE and EVOLVE are empty → generate `01_ask.md`, `02_look.md`, `03_investigate.md` only.
- Always generate at least `01_ask.md` (the Quick must have ASK filled to be promotable).

**Resume guidance after promotion:**
- Determine the **last generated file** (the furthest stage with content from Quick).
- Tell the user: "Your Full analysis starts at **{last stage}**. Review and expand the content in `{last file}`, then run `/analysis next` to continue."
- If the Quick had all 5 sections filled, tell the user: "All stages were migrated. Review each file for depth, then run `/analysis archive` when ready."

**Post-promotion status handling:**
- Update the Quick file's Status line to `⬆️ Promoted to Full: {new Full ID}`
- In status.md, change the Quick row's Stage to `⬆️ Promoted → {new Full ID}`
- Keep the Quick file in `analyses/active/` for reference — do not archive or delete

### Step 2d: Monitor alert escalation (`--from-alert`)

When a monitor alert triggers an investigation:

1. **Read the alert file**: `.analysis/metrics/alerts/{YYYY-MM}/{alert-id}.md`
   - Extract: metric name, current value, change amount, comparison basis, severity, counter-metric status
2. **Read the linked metric definition**: from `.analysis/metrics/definitions/{tier}/{slug}.md`
   - Extract: metric context, interpretation guide, healthy range, counter-metric
3. **Read the linked monitor**: from `.analysis/metrics/monitors/{monitor-id}_{slug}.md`
   - Extract: check history (for trend context), related analyses

4. **Auto-fill the Investigation**:
   - Mode: **Full** (alert escalations always use Full mode)
   - Type: **Investigation**
   - Title: auto-suggest `{metric name} {severity} — {date}` (user can modify)
   - ASK pre-fill:
     - Problem Definition: "Why did {metric} hit {severity}? (Alert {alert-id})"
     - Current value: {value}, Previous: {previous}, Change: {delta} ({delta%})
     - Comparison basis: {WoW/MoM/etc.}
     - Counter-metric status at time of alert
     - Context from alert file (deployments, experiments, campaigns, external events)
   - Provenance section: `Triggered by alert: {alert-id} from monitor {monitor-id}`

5. **Update the alert file**: Check off the escalation line:
   - `[x] Escalated to Investigation: {new analysis ID}`

6. **Proceed to Step 3** (Generate ID) with type=Investigation, mode=Full

### Step 3: Generate ID

Read `.analysis/status.md` to determine the next sequence number for today.

- Full (Investigation/Modeling): `F-{YYYY}-{MMDD}-{seq}` (e.g., `F-2026-0210-001`)
- Full (Simulation): `S-{YYYY}-{MMDD}-{seq}` (e.g., `S-2026-0210-001`)
- Quick: `Q-{YYYY}-{MMDD}-{seq}` (e.g., `Q-2026-0210-002`)

Sequence resets daily, starts at 001.

### Step 4: Create files

---

#### 4A. Full Investigation

Create folder: `analyses/active/{ID}_{title-slug}/`

Generate `01_ask.md`:
```markdown
# ASK: {title}
> ID: {ID} | Type: 🔍 Investigation | Stage: ❓ ASK | Started: {YYYY-MM-DD}

## Problem Definition
- Question:
- Requester:
- Background:
- Trigger: What event/observation prompted this question?

## Framing
- Type: Causation ("Why did X happen?") / Correlation ("Are X and Y related?")
- Decision this will inform:
- Cost of being wrong:

## Hypothesis Tree
```
Main question: "{title}"
├── Internal factors
│   ├── Product changes:
│   ├── Channel/acquisition changes:
│   ├── Cross-service impact:
│   └── Operations/pricing changes:
├── External factors
│   ├── Seasonality/calendar:
│   ├── Competitor actions:
│   ├── Market/economic shifts:
│   └── Platform changes:
└── Data artifacts
    ├── Tracking/instrumentation changes:
    ├── Metric definition changes:
    └── Population/mix changes:
```

## Success Criteria
- What does "done" look like?

## Assumptions
-

## Scope
- In scope:
- Out of scope:
- Deadline:
- Multi-lens plan: macro (market) / meso (company) / micro (user)

## Data Sources
- Primary:
- Secondary:
- Access method: (MCP / file / manual query / BI dashboard)

---
{Insert ASK checklist from .analysis/checklists/ask.md}
```

Generate `assets/README.md`:
```markdown
# Assets: {title}
> Analysis ID: {ID}

## Contents
(Describe your SQL files, notebooks, charts, and other artifacts here)

## Key Files
- (add as you work)
```

---

#### 4B. Full Modeling

Create folder: `analyses/active/{ID}_{title-slug}/`

Generate `01_ask.md`:
```markdown
# ASK: {title}
> ID: {ID} | Type: 📈 Modeling | Stage: ❓ ASK | Started: {YYYY-MM-DD}

## Objective
- What are you trying to predict / classify / segment?
- Business impact: Why does this matter?
- Decision this model will inform:
- What happens if the model is wrong? (cost of false positives vs false negatives)

## Success Criteria
- Target metric (e.g., "AUC > 0.8", "MAPE < 10%")
- Business success (e.g., "reduce churn by 5% if deployed")
- Minimum viable performance (below which the model isn't useful):

## Assumptions
-

## Scope
- Target variable:
- Candidate features:
- Training period:
- Prediction horizon:
- Expected deployment context (batch / real-time / on-demand):

## Data Sources
- Primary:
- Secondary:
- External data opportunities: (market data, third-party signals)
- Cross-service features available:
- Access method: (MCP / file / manual query)

## Constraints
- Must be interpretable? (Yes / No — and for whom?)
- Real-time requirement? (Yes / No — latency budget?)
- Fairness constraints: (protected groups, bias concerns)
- Guardrail metrics to watch: (reference from config.md)

---
{Insert ASK checklist from .analysis/checklists/ask.md}
```

Generate `assets/README.md` (same as Investigation).

**Modeling-specific stage templates** (generated by `/analysis next`):

**02_look.md for Modeling:**
```markdown
# LOOK: {title}
> ID: {ID} | Type: 📈 Modeling | Stage: 👀 LOOK | Updated: {YYYY-MM-DD}

## Target Variable
- Distribution:
- Class balance (if classification):
- Missing rate:
- Temporal patterns:

## Feature Exploration
| Feature | Type | Missing % | Correlation w/ Target | Leakage Risk | Notes |
|---------|------|-----------|----------------------|-------------|-------|
| | | | | | |

## Data Quality
- Outliers:
- Leakage risk (features that contain future information):
- Time-based splits needed?
- Feature staleness (how fresh does each feature need to be?):

## External & Cross-Service Features
- External data sources worth including? (market, weather, competitor)
- Cross-service features available? (from adjacent products/services)
- Feature engineering opportunities:

## Confounding & Bias Check
- Selection bias in training data?
- Label quality (how reliable is the target variable?):
- Population drift risk (will the training population match production?):

## Sampling Strategy
- Training / Validation / Test split:
- Stratification:
- Temporal ordering preserved?

---
{Insert LOOK checklist}
```

**03_investigate.md for Modeling:**
```markdown
# INVESTIGATE: {title}
> ID: {ID} | Type: 📈 Modeling | Stage: 🔍 INVESTIGATE | Updated: {YYYY-MM-DD}

## Baseline
- Naive baseline method:
- Baseline performance:
- Why this baseline? (justification):

## Model Selection
| Model | Hyperparameters | Train Score | Val Score | Test Score | Overfit? | Notes |
|-------|----------------|-------------|-----------|-----------|---------|-------|
| | | | | | | |

## Best Model
- Model:
- Key features (importance / coefficients):
- Performance vs success criteria:
- Why this model over alternatives? (interpretability, speed, accuracy trade-off):

## Validation
- Cross-validation results:
- Test set performance:
- Overfitting check (train vs val gap):
- Temporal validation (if time-series): does performance degrade over time?

## Sensitivity Analysis
- Feature ablation: which features can be removed without significant loss?
- Hyperparameter sensitivity: how much does performance change with different params?
- Data size sensitivity: how does performance change with less training data?

## Error Analysis
- Where does the model fail? (which segments, which examples):
- Systematic bias? (does it consistently over/under-predict for certain groups):
- Fairness check: different performance across demographic segments?
- Edge cases: extreme values, rare classes, boundary conditions:

## Business Validation
- Does the model output make intuitive business sense?
- Have domain experts reviewed sample predictions?
- Sanity check: do feature importances align with domain knowledge?

## Reproducibility
- Code location: `assets/`
- Environment / dependencies:
- Random seed:
- Data snapshot / version:

---
{Insert INVESTIGATE checklist}
```

**04_voice.md for Modeling:**
```markdown
# VOICE: {title}
> ID: {ID} | Type: 📈 Modeling | Stage: 📢 VOICE | Updated: {YYYY-MM-DD}

## Executive Summary
(1-3 sentences: what the model does, how well it works, business impact)

## So What → Now What

### Model Performance
- Key metric: {metric} = {value} (target was {target})
- Comparison to baseline: {improvement}
- **So What?** What does this performance level mean in business terms?
- **Now What?** Deploy / iterate / abandon?

### Business Interpretation
- What does the model tell us about the business?
- Top drivers / features — do they match domain intuition?
- Unexpected findings:

## Deployment Recommendation
- Deploy to production? (Yes / No / Conditional)
- **Confidence**: 🟢 High / 🟡 Medium / 🔴 Low
- Expected business impact:
- Rollout strategy: (shadow mode → A/B test → full deployment)

## Trade-off Analysis
- Accuracy vs interpretability:
- Speed vs performance:
- Coverage vs precision:
- Guardrail metrics impact (reference config.md):

## Monitoring Plan
- Key metrics to track in production:
- Model drift detection strategy:
- Retraining trigger conditions:
- Fallback plan if model degrades:

## Limitations & Risks
(First-class content, not a footnote)
- Known failure modes and segments:
- Data freshness requirements:
- What would invalidate this model:
- Fairness concerns:

## Audience-specific Messages

### For {stakeholder}
-

---
{Insert VOICE checklist}
```

Generate Modeling-specific `05_evolve.md`:
```markdown
# EVOLVE: {title}
> ID: {ID} | Type: 📈 Modeling | Stage: 🌱 EVOLVE | Updated: {YYYY-MM-DD}

## Model Performance Review
- Final model selected:
- Key performance metrics (accuracy, AUC, RMSE, etc.):
- Performance vs baseline:
- Performance across segments:

## Model Drift Risk
- Which input features are most likely to shift over time?
- Seasonal patterns that affect model accuracy:
- External factors that could invalidate assumptions:
- Expected shelf life of this model:

## Retraining Plan
- Retraining trigger: (scheduled / metric-based / event-based)
- Retraining cadence:
- Minimum data requirements for retraining:
- Owner:

## Production Monitoring
- Metrics to track in production:
- Drift detection method: (PSI, KL divergence, statistical tests)
- Alert thresholds:
- Dashboard / alert setup: (reference data stack from config.md)
- Performance decay response plan:

## Feature Pipeline
- Feature generation steps to automate:
- Data dependencies (tables, APIs, schedules):
- Pipeline owner:

## A/B Test Proposal
- How to validate model in production:
- Test design (champion/challenger, shadow mode, gradual rollout):
- Success metric:
- Minimum sample size / duration:

## Reflection
- What went well in this modeling process?
- What could be improved?
- What surprised us?

## Knowledge Capture
- Reusable patterns (feature engineering, model pipelines):
- Data gotchas for future models:
- Saved notebooks/scripts: `assets/`

## Follow-up Analysis Proposals
- [ ] {description} → (not yet created)

## North Star Connection
- How does this model connect to {North Star metric from config.md}?
- Expected lift on North Star:
- Should our metric framework be updated? → If yes, use the section below.

## Proposed New Metrics
> Fill this section through conversation with the AI. Say "I think we need a metric for {X}" and the AI will guide you through defining it together.

### Metric: {name}

**Background**
- What gap did this analysis reveal in the current metric framework?
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
- Refresh cadence:
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

## One-Sentence Insight
> (Capture the single most important takeaway)

---
{Insert EVOLVE checklist}
```

---

#### 4D. Full Simulation

Create folder: `analyses/active/{ID}_{title-slug}/`

Generate `01_ask.md`:
```markdown
# ASK: {title}
> ID: {ID} | Type: 🔮 Simulation | Stage: ❓ ASK | Started: {YYYY-MM-DD}

## Policy / Change Under Evaluation
- What policy, strategy, or change are you evaluating?
- What triggered this evaluation?
- Decision this will inform:

## Framing
- Type: Evaluative ("What would happen if X?")
- Current state (baseline):
- Proposed change:

## Variables
- Variables directly affected by the change:
- Variables indirectly affected (cascading effects):
- Variables assumed constant:

## Assumptions
- Key assumptions and their evidence basis:
- Which assumptions are most uncertain?

## Success Criteria
- What outcome makes this policy "worth doing"?
- Breakeven threshold:

## Comparison Scenarios
- Conservative:
- Neutral:
- Aggressive:

## Scope
- In scope:
- Out of scope:
- Deadline:

## Data Sources
- Historical analogues:
- Baseline data:
- Access method: (MCP / file / manual query / BI dashboard)

---
{Insert ASK checklist from .analysis/checklists/ask.md}
```

Generate `assets/README.md` (same as Investigation).

**Simulation-specific stage templates** (generated by `/analysis next`):

**02_look.md for Simulation:**
```markdown
# LOOK: {title}
> ID: {ID} | Type: 🔮 Simulation | Stage: 👀 LOOK | Updated: {YYYY-MM-DD}

## Historical Analogues
- Similar past policies/changes and their outcomes:
- Analogous cases from competitors or industry:
- How comparable are these analogues to the current situation?

## Variable Baseline Values
| Variable | Current Value | Source | Confidence | Notes |
|----------|--------------|--------|------------|-------|
| | | | | |

## Data Availability
- Which variables have reliable historical data?
- Which variables require estimation/assumption?
- Data gaps that increase simulation uncertainty:

## Fixed vs Variable Accounts
- **Fixed** (unchanged by policy):
- **Variable** (directly/indirectly affected):

---
{Insert LOOK checklist}
```

**03_investigate.md for Simulation:**
```markdown
# INVESTIGATE: {title}
> ID: {ID} | Type: 🔮 Simulation | Stage: 🔍 INVESTIGATE | Updated: {YYYY-MM-DD}

## Variable Relationships
- How does the policy change cascade through variables?
- Relationship map: (policy change → variable A → variable B → outcome)
- Evidence basis for each relationship:

## Scenario Matrix
| Scenario | {Variable 1} | {Variable 2} | {Variable 3} | Outcome | P&L Impact |
|----------|-------------|-------------|-------------|---------|-----------|
| Conservative | | | | | |
| Neutral | | | | | |
| Aggressive | | | | | |

## Sensitivity Ranking
| Rank | Variable | Impact of ±10% Change | Notes |
|------|----------|----------------------|-------|
| 1 | | | Most sensitive |
| 2 | | | |
| 3 | | | |

## Breakeven Analysis
- Breakeven point: "Policy becomes unprofitable if {variable} drops below {threshold}"
- Safety margin from expected case:

## Monte Carlo (if 3+ uncertain variables)
- Distributions assigned to each variable:
- Number of iterations:
- Result: "{X}% probability the outcome is positive"
- Confidence interval:

---
{Insert INVESTIGATE checklist}
```

**04_voice.md for Simulation:**
```markdown
# VOICE: {title}
> ID: {ID} | Type: 🔮 Simulation | Stage: 📢 VOICE | Updated: {YYYY-MM-DD}

## Executive Summary
(1-3 sentences: what was evaluated, expected outcome range, recommendation)

## 3-Scenario Summary
| | Conservative | Neutral | Aggressive |
|--|-------------|---------|------------|
| Key outcome | | | |
| P&L impact | | | |
| Probability | | | |

## Key Decision Points
- **Breakeven**: {description}
- **Most sensitive variable**: {variable} — a ±X% change swings the outcome by ±Y%
- **Handle bars**: Adjustable inputs for stakeholders to explore:
  - {Input 1}: current assumption = {value}, try range {min}-{max}
  - {Input 2}: current assumption = {value}, try range {min}-{max}

## Recommendations
1. (with trade-off analysis)
2. (with trade-off analysis)

## Limitations & Risks
- Assumptions that could be wrong:
- External factors not modeled:
- What would invalidate this simulation:

## Audience-specific Messages

### For {stakeholder}
-

---
{Insert VOICE checklist}
```

**05_evolve.md for Simulation:**
```markdown
# EVOLVE: {title}
> ID: {ID} | Type: 🔮 Simulation | Stage: 🌱 EVOLVE | Updated: {YYYY-MM-DD}

## Actual vs Predicted
(Fill after policy execution)
| Variable | Predicted | Actual | Δ | Notes |
|----------|----------|--------|---|-------|
| | | | | |

## Assumption Updates
- Which assumptions were off?
- Updated values for next iteration:

## New Variable Discovery
- Variables we missed in the original simulation:
- How do they affect the model?

## Handle Bar Refinement
- Which inputs need tighter/wider ranges?
- New inputs to add based on actual results?

## Version History
| Version | Date | Changes | Trigger |
|---------|------|---------|---------|
| v1 | {date} | Initial simulation | |

## Reusability
- Can this simulation framework apply to similar future policies?
- Template-worthy components:

## Proposed New Metrics
> Fill this section through conversation with the AI. Say "I think we need a metric for {X}" and the AI will guide you through defining it together.

### Metric: {name}

**Background**
- What gap did this simulation reveal in the current metric framework?
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
- Refresh cadence:
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

## Follow-up Analysis Proposals
- [ ] {description} → (not yet created)

---
{Insert EVOLVE checklist}
```

---

#### 4C. Quick Analysis (any type)

Create file: `analyses/active/quick_{ID}_{title-slug}.md`

```markdown
# Quick: {title}
> ID: {ID} | Type: {🔍 Investigation / 📈 Modeling / 🔮 Simulation} | Status: 🟡 In Progress | Started: {YYYY-MM-DD}

## ASK
- Question / Objective:
- Framing: Causation / Correlation / Comparison / Evaluation
  > 💡 Tip: Causation = "Why did X happen?", Correlation = "Are X and Y related?", Comparison = "Which is better, A or B?", Evaluation = "What would happen if we do X?"
- Top hypotheses: (1) (2) (3)
- Deadline:

## LOOK
- Data source:
- Data readiness: Do we have enough data? (rows, date range, coverage)
- Key segments checked:
- Are groups comparable? (if comparing: same period? same population? similar conditions?)
- External factors considered:
- Notable findings:

## INVESTIGATE
- Method: (e.g., before/after comparison, A/B test analysis, trend analysis, cohort comparison, group average comparison, simulation)
- Hypotheses tested: ✅ / ❌ / ⚠️
- Result:
- Confidence: 🟢 High / 🟡 Medium / 🔴 Low

## VOICE
- So What? (business impact):
  > 💡 State the size of the effect and what it means in practice. e.g.:
  > - "Option B converts 3pp higher → ~200 extra paid users/month at current traffic"
  > - "Department A scored 15% higher on satisfaction → their practices could be a model for others"
  > - "Students with parent engagement gained 20% more in literacy → worth scaling the program"
- Now What? (recommended action):
- Audience:

## EVOLVE
- What would change this conclusion?
- Follow-up needed: Yes / No
- Next question:
- Impact: Did this analysis lead to a decision? What happened? (revisit in 2-4 weeks)
- New metric needed? → If yes, tell the AI "I think we need a metric for {X}" to define it together.
  - Name:
  - Why (what gap):
  - Formula:
  - Good/bad range:
  - Counter-metric:

---
Check: 🟢 Proceed / 🔴 Stop
- [ ] Is the purpose clear and framed (causation/correlation/comparison/evaluation)?
- [ ] Was the data broken down by groups (not just totals)?
- [ ] Were alternative explanations considered?
- [ ] Does the conclusion answer the question with a confidence level?
- [ ] Is there enough data (rows, time period) to support this conclusion?

---
> 💡 If this analysis is getting bigger: `/analysis new --from {ID}`
```

---

### Step 5: Update status.md

Add new entry to the Active table in `.analysis/status.md`.
Include the Type column.
Update the "Last updated" timestamp.

**If this is a Quick→Full promotion (`--from {ID}`):**
- Update the Quick row's Stage to `⬆️ Promoted → {new Full ID}`
- Add the new Full entry to the Active table
- The Quick file remains in `analyses/active/` for reference (do not archive or delete)

### Step 6: Confirmation

Tell the user:
- New analysis created with ID and type
- Show file path(s)
- Reference relevant metrics from config.md if applicable
- For Full: suggest filling out 01_ask.md, then running `/analysis next`
- For Quick: suggest filling out each section in order
- For Modeling: mention "INVESTIGATE will include model comparison and validation templates"
- For Simulation: mention "Templates include scenario matrix, sensitivity analysis, and handle bar setup"
- For Quick→Full promotion: show which stage files were generated, which stage to resume at, and what to do next (see Step 2c resume guidance)
