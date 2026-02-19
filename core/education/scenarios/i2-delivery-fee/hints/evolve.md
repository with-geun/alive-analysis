# Hints: EVOLVE Stage

---

## Level 1 — Direction

A Simulation is only useful if you check whether reality matched the model. After you deliver this analysis, what happens next? How will you know if your scenarios were right? And if QuickBite implements the fee change, what do you monitor, and what would cause you to revise the recommendation?

---

## Level 2 — Specific

Three things to do in EVOLVE for a Simulation:

1. **Plan the test before the rollout** — Strongly recommend an A/B test or a limited city launch before full implementation. Define exactly: which city, what duration, what metrics, and what threshold constitutes "go" vs "no-go" for the full rollout.

2. **Set up assumption tracking** — Your model has explicit assumptions (e.g., +18% sustained order increase, −1pp subscription conversion). Create a simple table that tracks: what you assumed, what actually happened, and the delta. This is the Actual vs Predicted template.

3. **Define your monitoring metrics and alerts** — After any launch, you need daily or weekly checks on: order volume, AOV, subscription conversion rate, rider utilization, and competitor response. What thresholds would trigger a review or a rollback?

Also: the simulation framework you built here (scenario matrix, breakeven, sensitivity ranking, handle bars) is reusable for any future pricing decision. Capture it as a reusable template.

---

## Level 3 — Near-Answer

**Recommended test plan:**
- Phase 1: Test ₩2,000 fee (not ₩1,500) in one city for 4 weeks
- Success threshold: Sustained order increase ≥ +10% by week 4 (above breakeven for ₩2,000 fee)
- If success: Roll out ₩1,500 company-wide
- If below threshold: Hold at ₩3,000, revisit in 6 months

**Metrics to monitor (weekly cadence):**
| Metric | Baseline | Alert Threshold |
|--------|----------|-----------------|
| Daily orders | 15,000 | <13,500 or >18,000 |
| AOV | ₩25,000 | <₩22,000 |
| Subscription conversion | 12% | <10% |
| Rider utilization | 83% | >95% |
| Competitor fee | Competitor A: ₩2,500 | Match within 2 weeks |

**Actual vs Predicted template (fill in post-execution):**
| Assumption | Predicted | Actual | Delta | Implication |
|-----------|-----------|--------|-------|-------------|
| Order volume increase | +18% | ___ | ___ | ___ |
| Subscription conversion change | −1pp | ___ | ___ | ___ |
| Rider cost discount achieved | −5% | ___ | ___ | ___ |
| Competitor response time | 2 weeks | ___ | ___ | ___ |

**Reusable framework:**
The scenario matrix + breakeven + sensitivity ranking approach used here applies to any pricing or policy simulation. Save this as the "delivery-pricing-simulation-template" for future use.
