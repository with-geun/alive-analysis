# Data: VOICE Stage

> Additional context available when preparing stakeholder communication and the launch decision.

---

## Stakeholder Positions

| Stakeholder | Role | Position | Key Concern |
|-------------|------|----------|-------------|
| Jiyeon (PM) | Product Manager | **Wants to ship** | Spring sale campaign starts next week; wants the "conversion win" |
| Minho (Eng Lead) | Engineering Lead | **Neutral** | Will implement whatever is decided; wants clean data to justify priority |
| Seonghyun (CFO) | Chief Financial Officer | **Concerned about AOV drop** | Saw the -10% AOV number in the weekly data review; worried about revenue impact |
| Eunji (Head of Design) | Design Lead | **Supportive of redesign** | Led the 2-step redesign; invested in the new flow |

---

## Previous Checkout Tests at ShopNow

| Test | Date | Result | Decision |
|------|------|--------|----------|
| Checkout v1.5 — single-page checkout | Apr 2025 | +5% conversion, -15% AOV, net revenue negative | **Killed** — AOV drop too severe |
| Checkout v1.8 — progress bar + saved addresses | Aug 2025 | +2% conversion, AOV flat, p=0.12 | **Extended** then killed — lift disappeared after 4 weeks |

*ShopNow has a history of checkout changes that look good on conversion but hurt AOV or fail to sustain. The CFO is aware of this pattern.*

---

## Competitive Context

| Competitor | Recent Checkout Change | Market Share |
|------------|----------------------|--------------|
| FastMall | Simplified to 2-step checkout (Oct 2025). Reported +12% conversion. | ~15% of market |
| TrendShop | 1-click checkout for logged-in users (Dec 2025). No public data. | ~10% of market |
| DailyDeal | Still using 5-step checkout. No recent changes. | ~8% of market |

*Three of four major competitors have recently simplified checkout. Industry trend is toward fewer steps.*

---

## Revenue Impact Modeling

### If shipped to 100% (assuming Week 1-3 aggregate numbers hold)

| Scenario | Conversion Rate | AOV | Revenue per 1,000 Checkout Entrants |
|----------|----------------|-----|-------------------------------------|
| Current (Control) | 15.51% | 68,000 KRW | 10,547 KRW |
| Variant (all traffic) | 16.50% | 61,200 KRW | 10,098 KRW |
| **Net change** | +6.4% conversion | -10.0% AOV | **-4.3% revenue** |

*Despite higher conversion, revenue per checkout entrant actually declines because of the AOV drop. If the novelty effect is real, the conversion lift would further erode over time, making the revenue loss worse.*

### If shipped to mobile only

| Scenario | Conversion Rate | AOV (mobile) | Revenue per 1,000 Mobile Checkout Entrants |
|----------|----------------|--------------|---------------------------------------------|
| Current (Control) | 12.10% | 52,000 KRW | 6,292 KRW |
| Variant (mobile) | 14.80% | 47,800 KRW | 7,074 KRW |
| **Net change** | +22.3% conversion | -8.1% AOV | **+12.4% revenue** |

*Mobile-only launch would be revenue-positive because the conversion lift is large enough to overcome the AOV drop.*

---

## Spring Sale Campaign Context

- Spring sale starts Feb 10 (8 days after test end)
- Historical spring sale AOV is ~85,000 KRW (25% higher than normal)
- Shipping a checkout change right before a high-AOV campaign carries risk: if the new flow suppresses AOV, the revenue impact is amplified during a high-value period
- The PM's urgency is driven by wanting the "conversion improvement" to boost spring sale performance
