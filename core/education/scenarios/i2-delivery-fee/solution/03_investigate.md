# INVESTIGATE — Should We Lower Delivery Fees?
> Analysis ID: L-scenario-i2 | Mode: Learn | Stage: INVESTIGATE | Scenario: i2-delivery-fee

---

## Variable Relationships Map

```
Fee reduction (₩3,000 → ₩1,500)
    ├── Direct: Delivery fee revenue per order ↓ by ₩1,500
    ├── → Order volume ↑ (price elasticity)
    │       ├── Commission revenue ↑ (more orders × 15% commission)
    │       ├── Delivery fee revenue ↑ (more orders, even at lower fee)
    │       └── Rider costs ↑ (more deliveries needed)
    │               └── Volume discount opportunity (−5% to −10% variable cost)
    └── → Subscription conversion ↓ (lower fee reduces subscription value)
            └── Subscription fee revenue ↓ (fewer new subscribers)
            └── LTV impact: Subscribers order 3.2x vs 1.8x — losing potential subscribers hurts long-term
```

---

## Breakeven Calculation

**Revenue lost from fee cut (per month, non-subscriber orders only):**
- Non-subscriber order share: 72% (100% − 28% subscriber order share)
- Non-subscriber monthly orders: 450,000 × 0.72 = 324,000
- Monthly delivery fee revenue lost: ₩1,500 × 324,000 = **₩486M/month**

**Net margin per additional order:**
- New delivery fee revenue: ₩1,500
- Commission revenue: ₩3,750
- Rider cost: ₩2,200
- Net per additional order: ₩1,500 + ₩3,750 − ₩2,200 = **₩3,050/order**

**Orders needed to recover ₩486M:**
- ₩486,000,000 ÷ ₩3,050 = **59,344 additional orders/month**
- As % of baseline: 59,344 ÷ 450,000 = **+13.2%**

**Breakeven: +13% sustained order increase**

---

## Scenario Matrix with Monthly P&L

### Shared Parameters
- Baseline orders: 450,000/month
- Baseline net contribution: ₩2,050M/month
- New delivery fee: ₩1,500 (down from ₩3,000)
- Non-subscriber order share: 72%

### Corrected Baseline

> **Analyst's note — Why re-derive the baseline?**
> The per-order net margin of ₩4,550 (from LOOK) uses blended figures. For the scenario matrix, we need the full P&L built from components, because delivery fee revenue only applies to non-subscriber orders (72%).

**Baseline (current):**
- Orders: 450,000/month
- Commission: 450,000 × ₩3,750 = ₩1,688M
- Delivery fee revenue: 324,000 non-sub orders × ₩3,000 = ₩972M
- Total revenue: ₩2,660M
- Rider costs: 450,000 × ₩2,200 = ₩990M
- **Net operating contribution: ₩1,670M/month**

### Scenario Matrix — 3-Scenario P&L

| | Conservative | Neutral | Aggressive |
|-|-------------|---------|------------|
| Sustained order uplift | +12% | +18% | +25% |
| Monthly orders | 504,000 | 531,000 | 562,500 |
| Commission revenue | ₩1,890M | ₩1,991M | ₩2,109M |
| Fee revenue (non-sub, ₩1,500) | ₩544M | ₩574M | ₩607M |
| Total revenue | ₩2,434M | ₩2,565M | ₩2,716M |
| Rider costs | ₩1,098M* | ₩1,150M** | ₩1,194M*** |
| **Net contribution** | **₩1,336M** | **₩1,415M** | **₩1,522M** |
| **vs baseline (₩1,670M)** | **−₩334M** | **−₩255M** | **−₩148M** |

\*Conservative: ₩2,178/order (−1% variable discount)
\*\*Neutral: ₩2,165/order (−5% variable discount)
\*\*\*Aggressive: ₩2,130/order (−10% variable discount)

> **Analyst's note — The surprising result**
> Even the Aggressive scenario (+25% orders) is ₩148M/month *below* the current baseline. This seems counterintuitive — how can 25% more orders produce less profit? The answer: the fee cut applies to ALL existing non-subscriber orders, not just the new ones. You lose ₩1,500 per existing order and only gain ₩3,050 per new order. The losses on existing volume overwhelm the gains on new volume.

### Two-Layer Breakeven

**Layer 1 — Incremental breakeven** (commonly cited, but incomplete):
- Revenue lost from fee cut: ₩1,500 × 324,000 = ₩486M/month
- Net per new order: ₩3,050
- Orders needed: ₩486M ÷ ₩3,050 = 59,344 → **+13.2%**

**Layer 2 — True breakeven** (accounts for fee loss on entire non-subscriber base):
- New non-subscriber orders also pay ₩1,500 less than they would have at ₩3,000
- The volume increase compounds the fee loss: more orders, each at lower margin
- **True breakeven: ~+32% sustained order increase** — well above what the promo data (+15% at week 4) suggests is achievable

> **Analyst's note — Why this matters for learners**
> The +13% "incremental breakeven" is a common trap in pricing analysis. It only answers "how many NEW orders cover the LOST fee revenue" — it ignores that existing orders also earn less. Always build the full P&L, not just the marginal calculation. This is the central finding: the math is harder than the CEO expects.

---

## Sensitivity Ranking

| Rank | Variable | P&L Swing | Why It Matters |
|------|----------|-----------|----------------|
| #1 | Sustained order volume increase | ±₩300M+ per 10pp | Dominates all other effects |
| #2 | Subscription conversion impact | ±₩40-80M over 12 months | Slower but compounds |
| #3 | Rider cost volume discount | ±₩30M | Smaller lever |
| #4 | AOV shift | ±₩20M | Promo shows small AOV drop — model it |

---

## Second-Order: Subscription Effect

If permanent fee reduction suppresses subscription growth:
- Current subscribers: ~12% of users
- Promo showed: slowed new subscriber conversion during low-fee period
- If permanent fee suppresses subscription rate by 2pp over 12 months: 2% × user base × ₩9,900/month subscription fee = meaningful LTV loss
- Plus: subscribers order 3.2x vs non-subscribers 1.8x — losing potential subscribers reduces long-term order frequency

This is a 6-12 month risk, not immediately visible in first-quarter P&L.

---

## INVESTIGATE Summary

**The math is tighter than the headline promo numbers suggest.**

- Breakeven requires sustained +13% on NEW orders alone (not accounting for revenue lost on existing order base), but the full picture shows the model is still negative at +25% volume increase in the first year.
- The policy works over a long horizon if: (1) volume increase is sustained and grows, (2) competitor matching is slow or incomplete, (3) subscription revenue is protected.
- Primary sensitivity: sustained order volume increase. Everything else is secondary.
- Recommendation going into VOICE: Frame this as a "test to learn" — not a guaranteed win.
