# LOOK — Should We Lower Delivery Fees?
> Analysis ID: L-scenario-i2 | Mode: Learn | Stage: LOOK | Scenario: i2-delivery-fee

---

## Data Availability Assessment

| Data Source | Available | Quality | Usable For |
|-------------|-----------|---------|------------|
| 6-month order history | Yes | High | Baseline unit economics |
| Last quarter promo results | Yes | Medium (novelty bias) | Historical elasticity analogue |
| Competitor pricing | Yes | High | Market context |
| Rider cost structure | Yes | High | Cost modeling |
| Subscription analytics | Yes | High | Second-order effect modeling |
| Future demand curve | No | — | Must estimate from promo data |

**Key gap**: We have no true price elasticity data for a permanent fee reduction. The promo data is the best proxy, but promos behave differently from permanent changes (novelty effect, no competitor response during promo).

---

## Current Unit Economics Baseline (Per Order)

| Line Item | Per Order | Monthly (×450K) |
|-----------|-----------|-----------------|
| GMV | ₩25,000 | ₩11.25B |
| Platform commission (15%) | ₩3,750 | ₩1.69B |
| Delivery fee revenue | ₩3,000 | ₩1.35B* |
| **Total revenue** | **₩6,750** | **₩3.04B** |
| Rider cost | ₩2,200 | ₩990M |
| **Net contribution** | **₩4,550** | **₩2.05B** |

*Note: Delivery fee only applies to non-subscriber orders (~72% of orders, since subscribers account for ~28% of order volume and get free delivery). Effective delivery fee revenue = ₩3,000 × 450,000 × 0.72 ≈ ₩972M. The table above shows blended economics; the sensitivity analysis uses the correct non-subscriber adjustment.

**Corrected baseline:**
- Non-subscriber orders: 450,000 × 0.72 = 324,000/month
- Delivery fee revenue (actual): ₩3,000 × 324,000 = ₩972M/month
- Net monthly contribution: ~₩2.05B (commission + fee revenue − rider costs)

---

## Historical Analogue: The 50% Fee Promo (Last Quarter)

This is the most important data in the LOOK stage. It is the closest real-world experiment QuickBite has run.

| Metric | Baseline (pre-promo) | During Promo | Change |
|--------|---------------------|--------------|--------|
| Monthly orders | 438,000 | 534,360 | **+22%** |
| Monthly GMV | ₩10.95B | ₩12.59B | +15% |
| Delivery fee revenue | ₩1.31B | ₩0.80B | −39% |
| Subscription conversion | 12% of users | 15% of users | **+3pp** |

**Key observations from aggregate promo data:**
- AOV during promo was ₩23,600 (slightly lower — more small orders came in)
- Net platform revenue during promo: lower despite volume increase (delivery revenue fell faster than commission rose)
- Promo ended: volume returned to near-baseline within 2 weeks

**Important caveat**: The +22% is a 4-week average. The week-by-week breakdown (available in deeper investigation) will reveal whether this effect was decaying — which matters greatly for modeling a *permanent* change.

**Subscription effect during promo:**
- Pre-promo subscriber share: 12%
- During promo: subscription conversion rate increased to 15% on paper, but this may be misleading — when delivery is cheap for everyone, the subscription is less valuable, so some users delayed subscribing while new subscriber conversions slowed
- Post-promo: Settled at 13%

---

## Fixed vs Variable Revenue and Cost Identification

| Element | Fixed or Variable | Notes |
|---------|------------------|-------|
| Platform commission | Variable (% of GMV) | Scales directly with order volume and AOV |
| Delivery fee revenue | Variable per order | Fixed amount per order, but only on non-subscriber orders |
| Rider base pay | Fixed per delivery | ₩1,500 regardless of distance |
| Rider distance cost | Variable per delivery | ₩700 avg, negotiable at volume |
| Subscriber fee revenue | Fixed per subscriber | Monthly fee regardless of order frequency |

---

## Competitor Context

| Competitor | Current Fee | Response History |
|------------|-------------|------------------|
| Competitor A | ₩2,500 | Matched QuickBite's last promo within 2 weeks |
| Competitor B | Free for orders ≥ ₩20,000 | Premium positioning, slow to respond |

**Implication for scenarios**: If Competitor A matches a ₩1,500 fee, QuickBite's volume advantage erodes. In the Conservative scenario, assume Competitor A matches within 2 weeks. In the Aggressive scenario, assume a longer response lag.

---

## Look Summary

**Starting point confirmed**: QuickBite earns ₩4,550 net per order with a ₩3,000 fee. Monthly contribution is ₩2.05B at current 450K orders/month.

**Best evidence for volume elasticity**: The 50% fee promo produced +22% average order volume increase. However, this is a 4-week average — the week-by-week pattern (to be examined in INVESTIGATE) may reveal whether this is a sustained or decaying effect. Use +22% as a starting ceiling, not a guaranteed floor.

**Key risk signals from LOOK**:
1. Promo volume returned to near-baseline within 2 weeks of ending — suggesting limited habit formation
2. Competitor A is a fast responder — any pricing advantage may be temporary
3. Net platform revenue was *lower* during the promo despite higher volume — fee revenue fell faster than commission grew
