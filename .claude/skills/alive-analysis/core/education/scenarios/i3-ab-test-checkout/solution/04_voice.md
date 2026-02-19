# VOICE — Did the New Checkout Flow Actually Improve Conversion?
> ID: L-i3-ab-test-checkout | Mode: Learn | Stage: VOICE | Difficulty: Intermediate | Updated: 2026-02-11

> **Reference Solution** — This is the expected output for the VOICE stage. Compare your own 04_voice.md against this after completing the stage.

## Key Findings

### Finding 1: The test has a broken randomization (SRM) — overall result is unreliable
**So What**: A caching bug in the experimentation platform caused a 51.3/48.7 split instead of 50/50. The Variant group was enriched with returning visitors who have inherently higher conversion rates. This means the reported "+6.4% lift" is contaminated by group composition bias. We cannot know how much of the lift is real treatment effect vs how much is from the biased sample.

**Now What**:
- **Immediate**: Do NOT ship to 100% based on this test
- **Short-term**: Fix the caching bug in the experimentation platform before running any new tests
- **Medium-term**: Re-run the checkout test with clean randomization

**Confidence**: High — chi-square test p < 0.001, root cause identified and confirmed

---

### Finding 2: Mobile users show a strong conversion signal (+22.3%)
**So What**: When segmented by device, mobile checkout conversion improved 22.3% (12.1% → 14.8%, p=0.002). This is a large, statistically significant effect that makes intuitive sense — fewer steps on a small screen reduces friction. Desktop showed no meaningful change (+3.2%, p=0.41). The mobile signal is partially confounded by the SRM but the effect size is large enough that it likely reflects a real improvement.

**Now What**:
- **Option A** (Recommended): Re-run a clean A/B test on mobile users only, with the caching bug fixed and AOV monitoring as a hard guardrail
- **Option B**: Ship to mobile only with real-time AOV monitoring and an automatic rollback trigger — riskier, but faster

**Confidence**: Medium — the signal is strong, but confounded by SRM and subject to novelty decay. A clean re-test would raise this to High.

---

### Finding 3: Average order value dropped 10% — a guardrail violation
**So What**: The 2-step checkout combines the cart review with shipping info, which appears to reduce the time users spend reviewing their cart. AOV fell from 68,000 KRW to 61,200 KRW (p=0.01). Even with the conversion lift, revenue per checkout entrant dropped 4.3%. During the spring sale (historical AOV ~85,000 KRW), this effect would be amplified — the revenue loss would be larger on higher-value orders.

**Now What**: AOV must be a hard launch gate for any re-test. If AOV drops more than 5% in a clean test, the test should auto-pause. The design team should explore adding a cart summary to the 2-step flow to preserve the review moment.

**Confidence**: High — statistically significant (p=0.01), consistent with the UX explanation

---

### Finding 4: Novelty effect — the lift decayed to near-zero by Week 3
**So What**: The variant's conversion advantage was +15.6% in Week 1, +7.1% in Week 2, and just +0.6% in Week 3. The 3-week aggregate of +6.4% is inflated by the early novelty spike. The long-term steady-state lift is likely close to zero for the aggregate population. This means even if we ignore the SRM and the AOV drop, the conversion lift would not sustain.

**Now What**: Any re-test should run for at least 4 weeks, with the first week excluded from the primary analysis (or analyzed separately as a novelty burn-in period). Week 3+ data is the true signal.

**Confidence**: High — smooth, monotonic decline over 21 days is a textbook novelty pattern

---

## Decision Recommendation

| Option | Recommendation | Rationale |
|--------|---------------|-----------|
| Ship to 100% | **No** | SRM invalidates overall result; AOV violation; novelty effect |
| Ship to mobile only | **Not yet** | Signal is promising but needs clean re-test |
| Kill permanently | **No** | Mobile signal is too strong to abandon entirely |
| **Re-test (recommended)** | **Yes** | Fix SRM, add AOV gate, run mobile-focused clean test |

**Overall recommendation: Iterate — re-test with fixes.**

---

## Audience-Specific Messages

### For PM (Jiyeon)
"I know you want to ship before the spring sale, and the mobile signal is genuinely exciting — +22% conversion on mobile is a big deal. But the test has a randomization bug that makes the overall result unreliable, and AOV dropped 10%, which would actually reduce revenue if we ship to 100%. I recommend we fix the platform bug and re-run a clean mobile-focused test. We can have trustworthy results within 2-3 weeks, well before the next major campaign. Shipping a flawed result during the spring sale is the riskier move."

### For CFO (Seonghyun)
"Your instinct about the AOV drop is correct. Despite the headline conversion improvement, revenue per checkout entrant actually decreased 4.3%. A full rollout during the spring sale — when AOV is typically 85,000 KRW — would amplify the revenue loss. However, a mobile-only launch could be revenue-positive: mobile conversion lifted 22.3% while mobile AOV dropped only 8.1%, yielding a +12.4% net revenue improvement per mobile checkout entrant. I recommend we validate this with a clean re-test before committing."

### For Engineering Lead (Minho)
"There is a caching bug in the experimentation platform v2.1. When returning visitors' cookies expire, the hash-based assignment can reassign users from Control to Variant. This caused a Sample Ratio Mismatch: 51.3/48.7 instead of 50/50 (chi-square p < 0.001). The bug is concentrated on weekends when returning visitors have longer session gaps. This bug affects all tests running on the platform, not just this one. It needs to be fixed before any test result from this platform can be trusted. I also recommend adding an automated daily SRM check to the platform."

### For Design Lead (Eunji)
"The 2-step flow shows real promise on mobile — users convert 22% more on small screens with fewer steps. Desktop users were unaffected, which makes sense since they have more screen space to handle the 4-step flow. The AOV drop suggests users might be skipping the cart review moment. For the next iteration, consider adding a compact cart summary within the 2-step flow so users still see what they are buying before paying."

## Limitations and Caveats
- The SRM means we cannot precisely quantify the true treatment effect — the +6.4% aggregate is an upper bound
- The mobile +22.3% signal is promising but partially confounded by the same SRM; a clean test is needed to confirm it
- Novelty effect assessment is based on 3 weeks; the true steady-state could be slightly above or below the Week 3 numbers
- AOV impact may vary by product category — the aggregate -10% could be driven by specific categories
- ShopNow has a history of checkout tests that failed to sustain (v1.5 and v1.8) — prior base rate suggests caution

## Checklist — VOICE
- [x] Have you applied "So What → Now What" for each finding? — Yes, 4 findings with specific actions
- [x] Have you tagged confidence levels? — High for SRM/AOV/novelty, Medium for mobile signal
- [x] Have you provided a clear decision recommendation? — Iterate (re-test), not ship or kill
- [x] Have you checked guardrail metrics? — AOV is a violation, revenue per user flat, error rate OK
- [x] Have you tailored messages for each audience? — PM, CFO, Engineering, Design
