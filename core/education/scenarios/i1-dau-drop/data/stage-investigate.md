# Data: INVESTIGATE Stage

> Available when you reach the INVESTIGATE stage. Deeper drill-down data from push delivery logs, historical records, and extended analysis window.

---

## Push Notification Delivery Rates

| Platform | Baseline (Jan 27-Feb 2) | Feb 3-9 | Change |
|----------|------------------------|---------|--------|
| iOS (APNs) | 94% | 92% | -2 pts (stable) |
| Android (FCM) | 94% | **61%** | **-33 pts (broken)** |

*Android push delivery rate dropped sharply on Feb 3 — the same day the migration completed.*
*iOS path was unaffected — it serves as a natural control group.*

---

## Historical Lunar New Year Effect (ShopFlow)

| Year | Holiday Period | DAU Dip | Recovery Time |
|------|---------------|---------|---------------|
| 2024 | Feb 10-13 | -6% | 3 days post-holiday |
| 2025 | Jan 29-Feb 1 | -7% | 2 days post-holiday |
| 2026 | Feb 1-4 | -8% (non-push segments) | Expected: by Feb 7 |

*Holiday effect is real but bounded. It does not explain a drop that persists through Feb 9.*

---

## Competitor Analysis

| Signal | Data | Interpretation |
|--------|------|---------------|
| Paid acquisition CPC | Unchanged | If QuickBuy was pulling users, CAC would spike |
| App install rate | Unchanged | No evidence of accelerated QuickBuy adoption |
| ShopFlow uninstall rate | No spike detected | Users aren't leaving, they're just not being reached |

*No evidence of meaningful user migration to QuickBuy in this time window.*

---

## Bot Filter Impact Calculation

- Sessions removed by new filter: ~2,000/day
- Total DAU drop: ~18,000/day (120K - 102K)
- Bot filter contribution: 2,000 / 18,000 = **~11% of total drop**
- Adjusted DAU without bot filter change: ~104K (13.3% drop instead of 15%)

*Real but minor — does not change the conclusion.*

---

## Extended Analysis Window (through Feb 14)

| Segment | Feb 3-9 | Feb 10-14 | Trend |
|---------|---------|-----------|-------|
| Android push DAU | 42,000 | Still depressed (~28K/day) | Not recovering |
| Non-push organic DAU | Dipped with holiday | Recovering toward baseline | On track |
| iOS DAU | 48,000 | ~51,000 | Recovering (holiday rebound) |

*Android push DAU shows no recovery — sustained infrastructure issue, not a transient blip.*

---

## Timeline Correlation

| Date | Event | Push Delivery | DAU Impact |
|------|-------|--------------|------------|
| Feb 1 | Migration starts | Normal | Holiday starts |
| Feb 2 | v3.2 app update released | Normal | Holiday |
| Feb 3 AM | Migration completed | Android drops to 61% | — |
| Feb 3 PM | DAU drop first observed | 61% | Drop begins |
| Feb 4 | Holiday ends | 61% | Drop continues |
| Feb 9 | Analysis window closes | 61% | Drop ongoing |

*Migration completion and push delivery failure align exactly. App update (Feb 2) predates the delivery failure and iOS was unaffected.*
