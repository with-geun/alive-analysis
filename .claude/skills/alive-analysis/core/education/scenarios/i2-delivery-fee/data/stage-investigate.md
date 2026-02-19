# Data: INVESTIGATE Stage

> Deeper data revealed through analysis. Available once you begin building the scenario model.

---

## Price Elasticity Estimate (from Promo Data)

The 4-week promo gives us a direct elasticity signal:

- Fee change: ₩3,000 → ₩1,500 = **−50%**
- Order volume change: **+22%** overall

Implied price elasticity of demand ≈ −0.44 (inelastic, but meaningful)

**However, the promo effect was NOT uniform across the 4 weeks:**

| Week | Order Volume vs Baseline |
|------|--------------------------|
| Week 1 | +28% |
| Week 2 | +22% |
| Week 3 | +18% |
| Week 4 | +15% |

Interpretation: The initial surge includes one-time trial orders. The sustained (week 4) effect is closer to **+15%**, not +22%. A permanent fee reduction would likely converge toward the week 4 rate as novelty wears off.

---

## Subscription Conversion During Promo

- Pre-promo subscriber rate: 12% of active users
- During promo: jumped to 15% of active users
- Post-promo (4 weeks later): settled at 13% (1pp retained)

Analysis: Lower delivery fees reduce the perceived value of the subscription plan. Some users who would have subscribed chose not to — they could get cheap delivery anyway. Permanent fee reduction may suppress subscription growth.

---

## Non-Subscriber Behavior During Promo

| Metric | Pre-Promo | During Promo |
|--------|-----------|--------------|
| Non-subscriber order frequency | 1.8 orders/week | 2.1 orders/week |
| Average basket size (non-subscriber) | ₩25,400 | ₩23,600 |

Note: More frequent orders but smaller baskets — users ordered more casually (snacks, drinks) when the fee was low.

---

## Rider Cost Structure

| Cost Component | Amount | Notes |
|---------------|--------|-------|
| Fixed cost per delivery | ₩1,500 | Rider base pay, insurance, app overhead |
| Variable cost per delivery | ₩700 | Distance-based fuel/time compensation |
| **Current avg total** | **₩2,200** | Weighted average across all routes |

Volume discount potential:
- At current volume (15K/day): no discount
- At +10% to +15% volume: can negotiate **−5% on variable cost** (₩665 vs ₩700) → saves ₩35/order
- At +20% or more: can negotiate **−10% on variable cost** (₩630 vs ₩700) → saves ₩70/order

---

## Rider Capacity Ceiling

- Current fleet capacity: **18,000 orders/day** (max)
- Current utilization: 15,000 / 18,000 = **83%**
- At +22% volume: 18,300 orders/day → **exceeds capacity**
- At +15% volume: 17,250 orders/day → within capacity (96% utilization — tight but manageable)
- At +12% volume: 16,800 orders/day → within capacity (93% utilization)

Hiring lead time: 3-4 weeks to onboard new riders. If fee reduction launches without pre-hiring, operations will face overflow in weeks.

---

## Competitor Response Risk

Historical pattern: Competitor A matched QuickBite's last promo within **2 weeks**.

If Competitor A matches a permanent ₩1,500 fee:
- QuickBite loses the competitive advantage on pricing
- Both companies now earn lower delivery revenue
- Only users who prefer QuickBite for other reasons (UX, restaurant selection) stay
- The volume uplift partially erodes back toward baseline

Estimated post-competitor-response volume retention: 50-70% of the initial uplift (i.e., if volume jumped +18%, expect +9% to +12% sustained after competitor matches)

---

## Seasonal Adjustment Context

| Period | Volume vs Annual Average |
|--------|--------------------------|
| Summer (Jun-Aug) | +15% |
| Winter (Dec-Feb) | −10% |
| Spring/Fall | Baseline |

If the fee reduction launches in summer, initial results will look artificially strong. If it launches in winter, results may look deceptively weak. Timing matters for interpretation.

---

## Subscription Revenue Math (Second-Order Effect)

Monthly subscription revenue per subscriber: ₩9,900/month (subscription fee)
- Subscriber LTV: High (3.2x orders/week vs 1.8x for non-subscribers)
- If permanent low fee suppresses subscription growth by 1pp per year, that's approximately 1% × total users lost as future subscribers
- The commission revenue from subscriber orders compensates partially, but subscription fee revenue is pure margin

This is a second-order risk: the fee reduction may cannibalize the subscription business, which is the highest-margin customer segment.
