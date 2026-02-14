# /experiment-new

Start a new A/B test experiment.

## Instructions

**Before executing**: Read `.analysis/status.md` and `.analysis/config.md` to load current state.

You are helping the user design and run a structured experiment using the ALIVE loop adapted for A/B testing: **Design -> Validate -> Analyze -> Decide -> Learn**.

Do NOT auto-fill any content — ask the user and build the experiment together through conversation.

### Step 1: Ask initial questions

**Present all questions at once** in a single structured form:

**Q1: What do you want to test?**
Understand the change, feature, or hypothesis the user wants to experiment with.
- "What change are you testing? Describe the control (current) and treatment (new)."

**Q2: Full or Quick?**
- **Full Experiment** — For experiments with business impact. 5 files, full statistical rigor, checklists.
- **Quick Experiment** — For low-risk experiments (feature flag toggles, small UI tweaks). Single file, abbreviated.

Guide:
- "Will this experiment influence a product/business decision?" -> Full
- "Is this a quick validation or low-stakes test?" -> Quick

**Q3: What's the primary metric?**
The single metric that determines success or failure.
- "If you could only look at ONE number to decide whether this worked, what would it be?"
- Reference config.md metrics if available.

**Q4: Guardrail metrics?**
Metrics that must NOT get worse. Reference config.md guardrails.
- "What must NOT break if this experiment succeeds? (e.g., crash rate, page load time, revenue)"

**Q5: How long can this experiment run?**
- "What's the maximum duration you'd accept? (1 week, 2 weeks, 4 weeks)"
- This informs sample size feasibility.

### Step 2: Generate ID

Read `.analysis/status.md` to determine the next sequence number for today.

- Full Experiment: `E-{YYYY}-{MMDD}-{seq}` (e.g., `E-2026-0215-001`)
- Quick Experiment: `QE-{YYYY}-{MMDD}-{seq}` (e.g., `QE-2026-0215-001`)

Sequence resets daily, starts at 001.

### Step 3: Create files

#### 3A. Full Experiment

Create folder: `ab-tests/active/{ID}_{title-slug}/`

Generate `01_design.md`:
```markdown
# DESIGN: {title}
> ID: {ID} | Type: Experiment | Stage: DESIGN | Started: {YYYY-MM-DD}

## Hypothesis
- **If** we {change/treatment description},
- **Then** {primary metric} will {direction} by {expected magnitude},
- **Because** {mechanism/reasoning}.

## Experiment Setup
- **Control**: {current experience}
- **Treatment**: {new experience}
- **Variants**: {number of variants, including control}
- **Randomization unit**: user / session / device / other
- **Traffic allocation**: {control %}% / {treatment %}%
- **Target population**: {all users / specific segment}
- **Exclusions**: {who should NOT be in the experiment}

## Metric Structure

### Primary Metric (decision criterion)
| Metric | Current Baseline | MDE (Minimum Detectable Effect) | Direction |
|--------|-----------------|--------------------------------|-----------|
| {metric} | {value} | {absolute or relative change} | up / down |

### Secondary Metrics (additional insight)
| Metric | Baseline | Expected Direction | Why Track |
|--------|----------|--------------------|-----------|
| | | | |
| | | | |

### Guardrail Metrics (must not degrade)
| Metric | Current Value | Acceptable Range | Source |
|--------|--------------|-------------------|--------|
| | | | config.md / custom |

## Sample Size Calculation
- **Test type**: two-sided / one-sided
- **Significance level (a)**: 0.05
- **Power (1-b)**: 0.80
- **Baseline rate/mean**: {from primary metric}
- **MDE**: {from primary metric}
- **Required sample size per variant**: {AI calculates}
- **With current daily traffic ({N}/day)**: ~{X} days needed
- **Feasibility**: fits within timeline / tight / not feasible

> AI will guide through the calculation:
> - For proportions: n = (Z_a/2 + Z_b)^2 x [p1(1-p1) + p2(1-p2)] / (p1-p2)^2
> - For means: n = (Z_a/2 + Z_b)^2 x 2s^2 / d^2
> - Practical shortcut: "Can we get {n} users per variant within {max duration}?"

## Duration & Schedule
- **Start date**: {planned}
- **Minimum duration**: {from sample size calculation}
- **Maximum duration**: {from Q5}
- **Include full week cycles**: Yes (avoid day-of-week effects)
- **Ramp-up plan**: {start at X% -> full allocation after Y days} / none

## Risk Assessment
- **Worst-case scenario**: If treatment is bad, what's the impact?
- **Rollback trigger**: {specific condition for emergency stop}
- **Blast radius**: {number of affected users, revenue at risk}
- **Reversibility**: Fully reversible / Partially / Irreversible

## Stakeholders
- **Experiment owner**: {name}
- **Decision maker**: {name/role}
- **Engineering contact**: {name}

## Provenance
- Triggered by analysis: {analysis ID, if any — e.g., "F-2026-0210-001 found that X correlates with Y"}
- Key finding that motivated this experiment:

## Pre-registration
> This section locks the analysis plan BEFORE seeing results (prevents p-hacking).
- Primary metric: {locked}
- Success threshold: {locked — what constitutes a "win"?}
- Analysis method: {locked — frequentist / bayesian / both}
- Segment analysis planned: {list segments you'll check, if any}
- Decision framework: {when to Launch / Kill / Extend / Iterate}

---
{Insert DESIGN checklist from ab-tests/checklists/design.md}
```

#### 3B. Quick Experiment

Create file: `ab-tests/active/quick_{ID}_{title-slug}.md`

```markdown
# Quick Experiment: {title}
> ID: {ID} | Type: Quick Experiment | Status: In Progress | Started: {YYYY-MM-DD}

## DESIGN
- Hypothesis: If {change}, then {metric} will {direction}, because {reason}.
- Control vs Treatment:
- Primary metric:
- Guardrail metric:
- Traffic split: % / %
- Duration: {planned}
- Sample size feasible? Yes / No / Need to check

## VALIDATE
- Randomization working? (SRM check)
- Groups balanced?
- Logging confirmed?
- External factors during test period:

## ANALYZE
- Primary metric result: {control} vs {treatment}, D = {diff}, p = {value}
- Statistically significant? Yes / No
- Practically significant? (Is the effect big enough to matter?)
- Guardrail check: No degradation / Degraded
- Segment differences:

## DECIDE
- Decision: Launch / Kill / Extend / Iterate
- Reasoning:
- Follow-up needed:

## LEARN
- What did we learn?
- What would we do differently?
- Next experiment idea:

---
Check: Proceed / Stop
- [ ] Is the hypothesis clearly stated with expected direction?
- [ ] Is there a guardrail metric to prevent unintended harm?
- [ ] Was significance checked (not just "looks better")?
- [ ] Was the decision made based on pre-defined criteria (not post-hoc)?
- [ ] Are learnings documented for future experiments?
```

### Step 4: Create checklists (if not exist)

Check if `ab-tests/checklists/` exists. If not, create the folder and default checklists:

**ab-tests/checklists/design.md:**
```markdown
## Checklist — DESIGN
### Methodology
- [ ] Is the hypothesis specific and falsifiable?
- [ ] Is there exactly ONE primary metric for the decision?
- [ ] Is the MDE realistic and meaningful for the business?
- [ ] Is the sample size calculation documented?
- [ ] Does the timeline allow for full-week cycles?
- [ ] Are guardrail metrics defined (referencing config.md)?
### Quality
- [ ] Is the randomization unit appropriate (no interference between units)?
- [ ] Is the rollback plan defined?
- [ ] Has the analysis plan been pre-registered (locked before results)?
- [ ] Are stakeholders aligned on what "success" means?
```

**ab-tests/checklists/validate.md:**
```markdown
## Checklist — VALIDATE
### Methodology
- [ ] Has an AA test or historical balance check been done?
- [ ] Is the sample ratio within expected range (SRM check)?
- [ ] Are key segments balanced between control and treatment?
- [ ] Is event logging confirmed working for all metrics?
### Quality
- [ ] Have external factors been documented (holidays, releases, campaigns)?
- [ ] Is the ramp-up plan being followed?
- [ ] Are there no other overlapping experiments on the same population?
```

**ab-tests/checklists/analyze.md:**
```markdown
## Checklist — ANALYZE
### Methodology
- [ ] Has SRM been re-checked on final data?
- [ ] Is the correct statistical test applied for the metric type?
- [ ] Are confidence intervals reported (not just p-values)?
- [ ] Has multiple comparison correction been applied (if >2 variants)?
- [ ] Have novelty/primacy effects been considered (time series check)?
### Quality
- [ ] Has segment analysis been done (does effect hold across segments)?
- [ ] Have guardrail metrics been checked?
- [ ] Is the effect size practically meaningful (not just statistically significant)?
- [ ] Is the analysis reproducible (queries/notebooks saved to assets/)?
```

**ab-tests/checklists/decide.md:**
```markdown
## Checklist — DECIDE
### Methodology
- [ ] Is the decision based on pre-registered criteria (not post-hoc)?
- [ ] Have all guardrail metrics been verified as safe?
- [ ] Is the rollback plan ready if launching?
### Quality
- [ ] Has the decision been communicated to all stakeholders?
- [ ] Is a long-term monitoring plan in place?
- [ ] Are audience-specific messages prepared (PM, engineering, leadership)?
```

**ab-tests/checklists/learn.md:**
```markdown
## Checklist — LEARN
### Methodology
- [ ] Is the experiment outcome documented (what happened and why)?
- [ ] Are follow-up experiments or analyses identified?
- [ ] Is long-term monitoring set up (2-week and 4-week checkpoints)?
### Quality
- [ ] Are reusable assets saved (queries, segment definitions, analysis code)?
- [ ] Have unexpected findings been captured?
- [ ] Has the metric framework been updated if needed (new metrics proposed)?
```

### Step 5: Update status.md

Add new entry to the Active table in `.analysis/status.md`.
- Include Type column: `Experiment`
- Stage: `DESIGN`
- Update "Last updated" timestamp

### Step 6: Confirmation

Tell the user:
- New experiment created with ID and type
- Show file path(s)
- For Full: suggest filling out 01_design.md, focusing on the hypothesis and metric structure first
- For Quick: suggest filling out each section in order
- Remind: "Lock your analysis plan in the Pre-registration section BEFORE looking at any results"
- If config.md has metrics defined, reference relevant ones for guardrails

**After executing**: Update `.analysis/status.md` with any state changes.
