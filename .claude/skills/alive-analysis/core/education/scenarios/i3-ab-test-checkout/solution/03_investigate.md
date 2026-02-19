# INVESTIGATE — Did the New Checkout Flow Actually Improve Conversion?
> ID: L-i3-ab-test-checkout | Mode: Learn | Stage: INVESTIGATE | Difficulty: Intermediate | Updated: 2026-02-11

> **Reference Solution** — This is the expected output for the INVESTIGATE stage. Compare your own 03_investigate.md against this after completing the stage.

## Investigation 1: SRM Root Cause

### Evidence
- The caching bug in experimentation platform v2.1 causes some returning visitors whose hash maps to Control to be reassigned to Variant when their browser cookie expires and is regenerated
- The effect is concentrated on weekends (Sat/Sun: 54-55% Variant) because returning visitors have longer gaps between sessions, increasing the chance of cookie expiration
- Returning visitor composition: Variant has 58.3% returning visitors vs Control's 54.6%
- Returning visitors have a higher baseline conversion rate (~18%) compared to new visitors (~12%)

### Consequence
The Variant group is structurally advantaged — it contains more high-converting returning visitors. Part of the observed +6.4% lift is attributable to this compositional bias, not the 2-step checkout treatment. **The overall aggregate result cannot be trusted.**

### Verdict
**SRM confirmed and root cause identified.** The randomization is broken. The aggregate lift of +6.4% is an overestimate of the true treatment effect.

---

## Investigation 2: Device Segmentation

### Mobile (65% of traffic)

| Metric | Control | Variant | Relative Lift | p-value |
|--------|---------|---------|---------------|---------|
| Checkout conversion rate | 12.10% | 14.80% | +22.3% | 0.002 |

- Statistically significant (p = 0.002)
- Large effect size — the 2-step flow appears substantially better on mobile
- Makes intuitive sense: on small screens, fewer steps means less friction
- The SRM is present but device-level composition differences are smaller

### Desktop (35% of traffic)

| Metric | Control | Variant | Relative Lift | p-value |
|--------|---------|---------|---------------|---------|
| Checkout conversion rate | 18.30% | 18.89% | +3.2% | 0.41 |

- NOT statistically significant (p = 0.41)
- Desktop already has a high baseline conversion (18.3%) — less room to improve
- Desktop users have more screen space to handle a 4-step flow without friction

### Verdict
**The aggregate "6.4% lift" is almost entirely driven by mobile.** Desktop shows no meaningful improvement. The mobile effect is large and statistically significant, though it remains partially confounded by the SRM.

---

## Investigation 3: Guardrail Metrics

| Metric | Control | Variant | Change | p-value | Status |
|--------|---------|---------|--------|---------|--------|
| Average Order Value | 68,000 KRW | 61,200 KRW | **-10.0%** | **0.01** | **VIOLATION** |
| Revenue per user | 8,840 KRW | 8,770 KRW | -0.8% | 0.72 | OK |
| Checkout error rate | 1.2% | 1.1% | -0.1 pp | 0.83 | OK |
| Cart abandonment rate | 62.0% | 61.5% | -0.5 pp | 0.68 | OK |
| Payment failure rate | 2.1% | 2.3% | +0.2 pp | 0.55 | OK |

### AOV Analysis
The 2-step flow combines Cart Review with Shipping Info. This means users spend less time reviewing their cart before entering payment. The hypothesis: users are skipping the cart review step, leading to smaller orders (fewer items, less upselling).

Revenue per user is nearly flat because higher conversion partially offsets lower AOV. But this is a dangerous equilibrium — if the conversion lift fades (see novelty analysis below), only the AOV drop remains.

### Verdict
**AOV is a guardrail violation.** The 10% drop is statistically significant and economically meaningful. Shipping this checkout change would likely reduce average order size. The revenue-per-user metric looks OK only because of the temporary conversion boost.

---

## Investigation 4: Novelty Effect

| Week | Period | Control CVR | Variant CVR | Relative Lift |
|------|--------|-------------|-------------|---------------|
| Week 1 | Jan 13-19 | 15.4% | 17.8% | +15.6% |
| Week 2 | Jan 20-26 | 15.5% | 16.6% | +7.1% |
| Week 3 | Jan 27-Feb 2 | 15.6% | 15.7% | +0.6% |

The lift decayed from +15.6% in Week 1 to +0.6% in Week 3. This is a textbook novelty effect — users initially interacted more with the new flow because it was different, not because it was fundamentally better.

Daily data confirms a smooth decline from +18.2% on Day 1 to +0.1% on Day 21.

### Verdict
**Novelty effect confirmed.** The 3-week aggregate (+6.4%) is inflated by early data. The Week 3 lift (+0.6%) is a better predictor of long-term performance — and it is not significant. If the test had run 2 more weeks, the aggregate lift would have been smaller or possibly zero.

---

## Investigation 5: SUTVA Check

| Check | Result | Note |
|-------|--------|------|
| Network effects | Low risk | Checkout is individual |
| Shared accounts | Minor risk | ~3% share devices |
| CS interference | Low risk | No ticket volume change |

**SUTVA is largely satisfied.** This is not a concern for this test.

---

## Revenue Impact Projection

| Scenario | Conversion | AOV | Revenue per 1,000 Checkout Entrants |
|----------|-----------|-----|-------------------------------------|
| Control (current) | 15.51% | 68,000 KRW | 10,547 KRW |
| Variant (100% rollout) | 16.50% | 61,200 KRW | 10,098 KRW |
| **Net change** | +6.4% | -10.0% | **-4.3%** |

Even taking the aggregate numbers at face value, shipping to 100% would **reduce revenue by 4.3%** because the AOV drop more than offsets the conversion gain. Once the novelty effect wears off, the revenue loss would be even larger.

---

## Summary of Findings

| Finding | Severity | Impact on Decision |
|---------|----------|-------------------|
| SRM (broken randomization) | **Critical** | Invalidates overall result |
| Novelty effect (lift decayed to ~0% by Week 3) | **High** | Aggregate lift is not sustained |
| AOV guardrail violation (-10%) | **High** | Revenue negative at 100% rollout |
| Mobile-specific signal (+22.3%, p=0.002) | **Medium-positive** | Worth pursuing in a clean re-test |
| Desktop: no significant effect | **Neutral** | Desktop does not benefit |

## Checklist — INVESTIGATE
- [x] Have you investigated the SRM root cause? — Caching bug enriching Variant with returning visitors
- [x] Have you segmented by device? — Mobile +22.3% (significant), Desktop +3.2% (not significant)
- [x] Have you checked all guardrail metrics? — AOV dropped 10% (violation), others OK
- [x] Have you assessed novelty effect? — Lift decayed from +15.6% (Week 1) to +0.6% (Week 3)
- [x] Have you validated SUTVA? — Largely satisfied, minor shared-account concern
- [x] Have you projected revenue impact? — 100% rollout would be revenue-negative (-4.3%)
