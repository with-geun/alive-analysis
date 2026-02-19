# EVOLVE — Should We Lower Delivery Fees?
> Analysis ID: L-scenario-i2 | Mode: Learn | Stage: EVOLVE | Scenario: i2-delivery-fee

---

## What Happens Next

This analysis is complete — but the work only matters if what we predicted gets tested against reality. EVOLVE has three parts: the test plan (before any rollout), the monitoring setup (during rollout), and the assumption tracking template (to improve future models).

---

## Test Plan: Before Full Rollout

**Recommended test: A/B test (or geo-split) for 4 weeks**

| Parameter | Value |
|-----------|-------|
| Test market | Busan (second-largest city, representative demographics) |
| Control market | Daegu (similar size, no fee change) |
| Test fee | ₩2,000 (not ₩1,500 — lower risk first, still meaningful signal) |
| Duration | 4 weeks |
| Start date | After rider capacity check — do not start until Busan fleet can handle +20% volume |

**Go/No-Go criteria after 4 weeks:**

| Outcome | Week 4 Sustained Order Increase | Decision |
|---------|--------------------------------|----------|
| Strong | ≥ +15% | Proceed to ₩2,000 nationwide, begin modeling ₩1,500 |
| Moderate | +10% to +14% | Extend test 2 more weeks, investigate competitor response |
| Weak | < +10% | Hold at ₩3,000 nationwide, revisit in Q3 |

**Why ₩2,000 first, not ₩1,500**: The ₩2,000 test generates real elasticity data at lower financial risk. It also signals market intention to competitors without committing fully.

---

## Monitoring Metrics (During and After Rollout)

Track these weekly. Alert immediately if thresholds are breached.

| Metric | Baseline | Target (Neutral) | Alert Threshold | Cadence |
|--------|----------|-----------------|-----------------|---------|
| Daily order volume | 15,000 | 17,700 | < 14,000 or > 18,000 | Daily |
| Average order value (AOV) | ₩25,000 | ₩25,000 | < ₩22,000 | Weekly |
| Delivery fee revenue/order | ₩2,160* | ₩1,080* | N/A (expected drop) | Weekly |
| Subscription conversion rate | 12% | 11% | < 10% | Weekly |
| Rider utilization | 83% | 98% | > 95% → trigger hiring | Daily |
| Competitor A delivery fee | ₩2,500 | ₩2,500 | Any reduction | Real-time |
| Net operating contribution | ₩1,670M/month | ₩1,415M/month | < ₩1,200M | Monthly |

*Effective per-order fee revenue accounts for subscriber share.

**Competitor monitoring**: Set up weekly price checks for Competitor A. If they match within 2 weeks (as they did historically), update the scenario model to reflect reduced competitive advantage.

---

## Actual vs Predicted Template

Fill this in at 4 weeks, 8 weeks, and 12 weeks post-launch.

| Assumption | Predicted (Neutral) | 4-Week Actual | 8-Week Actual | 12-Week Actual | Delta | Implication |
|-----------|--------------------|--------------:|---------------:|----------------:|-------|-------------|
| Sustained order increase | +18% | ___ | ___ | ___ | ___ | ___ |
| AOV | ₩25,000 | ___ | ___ | ___ | ___ | ___ |
| Subscription conversion change | −1pp | ___ | ___ | ___ | ___ | ___ |
| Rider variable cost discount achieved | −5% | ___ | ___ | ___ | ___ | ___ |
| Competitor A response time | 2 weeks | ___ | ___ | ___ | ___ | ___ |
| Net monthly P&L vs baseline | −₩255M | ___ | ___ | ___ | ___ | ___ |

**Decision trigger**: If week 4 actual order increase is below +10%, immediately escalate to CFO with revised P&L. Do not wait for 8-week review.

---

## Questions This Analysis Opened

1. **Long-run elasticity**: The promo data is 4 weeks — what does month 3, month 6 look like for a permanent change? Run the Busan test long enough to see if the volume increase is truly sustained or continues to decay.

2. **Subscription cannibalization**: Does a permanently lower delivery fee materially slow subscription growth? Track new subscriber acquisition rate monthly for 6 months post-launch.

3. **Small-order behavior**: AOV dropped slightly during the promo (₩25,400 → ₩23,600). If permanent low fees encourage more small orders, does that change the commission revenue math? Calculate: if AOV drops 5%, how does that affect monthly commission revenue?

4. **Competitive equilibrium**: If both QuickBite and Competitor A are at ₩1,500, are we both worse off? Is there a game theory argument for maintaining ₩3,000?

---

## Reusable Framework: Delivery/Pricing Simulation Template

This scenario's analytical structure is reusable for any pricing policy evaluation:

```
1. ASK
   - Policy: What exactly changes?
   - Variables: What moves (directly and indirectly)?
   - Constants: What are we assuming stays fixed?
   - Scenarios: Conservative / Neutral / Aggressive (define the key uncertain variable)
   - Success criteria: What outcome makes this a good decision?

2. LOOK
   - Baseline unit economics (per unit and per month)
   - Historical analogues (any prior experiments?)
   - Fixed vs variable cost/revenue split
   - Competitive context

3. INVESTIGATE
   - Variable relationship map (what causes what?)
   - Breakeven calculation
   - Scenario matrix P&L
   - Sensitivity ranking (which variable dominates?)
   - Second-order effects

4. VOICE
   - 3-scenario table (side-by-side)
   - Breakeven named explicitly
   - Handle bars (adjustable inputs)
   - Phased recommendation (test before full rollout)
   - Audience-specific messages (growth / margin / operations)

5. EVOLVE
   - Test plan (geography, duration, go/no-go criteria)
   - Monitoring metrics + alert thresholds
   - Actual vs Predicted tracking template
   - Reusable framework capture
```

**Save this template as**: `delivery-pricing-simulation-v1`
**Applicable to**: Any marketplace pricing decision (subscription pricing, surge pricing, commission rate changes)
