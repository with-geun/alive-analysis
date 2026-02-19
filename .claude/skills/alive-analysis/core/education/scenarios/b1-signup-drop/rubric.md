# Rubric: b1-signup-drop

> Total: 100 points across 5 ALIVE stages

## ASK (20 points)

| Item | Points | Criteria |
|------|--------|----------|
| Framing | 5 | Correctly identifies as causation question |
| Hypotheses | 5 | Lists 3+ hypotheses covering internal, external, and data artifact categories |
| Scope | 5 | Identifies deadline, data sources, and platform as a key dimension |
| Clarity | 5 | Question is specific and answerable (not vague) |

## LOOK (20 points)

| Item | Points | Criteria |
|------|--------|----------|
| Segmentation | 5 | Breaks down by platform (iOS/Android/Web) — not just total |
| Pattern identification | 5 | Identifies Android as the sole source of the drop |
| Funnel analysis | 5 | Pinpoints the password step as the drop-off point |
| External factors | 5 | Checks and rules out holidays, competitors, tracking changes |

## INVESTIGATE (25 points)

| Item | Points | Criteria |
|------|--------|----------|
| Root cause identification | 7 | Identifies v2.8 password validation as root cause |
| Evidence quality | 6 | Uses error logs AND release notes AND funnel data (multiple evidence types) |
| Alternative elimination | 6 | Explicitly tests and eliminates other hypotheses |
| Confidence calibration | 6 | Assigns High confidence with correct reasoning (timing, mechanism, control group) |

## VOICE (20 points)

| Item | Points | Criteria |
|------|--------|----------|
| Impact quantification | 5 | Quantifies lost signups (~185/day or ~1,300/week) |
| Actionable recommendation | 5 | Provides specific fix (revert or improve UX), not vague |
| Audience adaptation | 5 | Adjusts message for at least 2 audiences (CEO, engineering, PM) |
| Confidence + limitations | 5 | States confidence level and what would change conclusion |

## EVOLVE (15 points)

| Item | Points | Criteria |
|------|--------|----------|
| Monitoring | 5 | Sets up a monitoring plan (metric, threshold, cadence) |
| Follow-up | 5 | Identifies verification step (check recovery after fix) |
| Reusable insight | 5 | Captures a generalizable lesson (auth changes → test signup flow) |

---

## Most Common Mistakes at Beginner Level

1. **Skipping platform segmentation** — Looking at total signups instead of breaking down by iOS/Android/Web. The root cause is Android-only; without segmentation, you might blame external factors.

2. **Jumping to external causes** — Assuming a marketing issue or seasonal effect without checking internal changes (v2.8 release). Always check release notes and deployment logs first.

3. **Correlation vs causation framing** — Framing the question as "what's correlated with the drop?" instead of "what caused it?" The causal framing drives you to look for mechanisms, not just patterns.

4. **Vague recommendation** — Saying "fix the bug" without specifying what to fix, the urgency, or a rollback plan. VOICE requires an actionable path with named owners.

5. **No monitoring plan** — Fixing the issue and moving on without setting up a check to verify recovery. EVOLVE requires a verification step.
