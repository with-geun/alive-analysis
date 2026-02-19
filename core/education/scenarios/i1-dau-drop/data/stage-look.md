# Data: LOOK Stage

> Available when you reach the LOOK stage. Query BigQuery and GA4 for the following.
> Date range: Jan 27 - Feb 9, 2026. Baseline = Jan 27-Feb 2. Comparison = Feb 3-9.

---

## DAU by Platform

| Platform | Baseline (Jan 27-Feb 2) | Feb 3-9 | Change |
|----------|------------------------|---------|--------|
| iOS | 52,000 | 48,000 | -7.7% |
| Android | 55,000 | 42,000 | **-23.6%** |
| Web | 13,000 | 12,000 | -7.7% |

*Android drop is approximately 3x worse than other platforms.*

---

## DAU by Acquisition Channel

| Channel | Baseline | Feb 3-9 | Change |
|---------|----------|---------|--------|
| Organic (direct/search) | 65,000 | 60,000 | -7.7% |
| Push notification-driven | 35,000 | 22,000 | **-37.1%** |
| Paid ads (SEM/social) | 20,000 | 20,000 | 0% |

*Push notification-driven DAU collapsed. Paid acquisition is completely unaffected.*

---

## DAU by User Segment

| Segment | Baseline | Feb 3-9 | Change |
|---------|----------|---------|--------|
| New users (D0-D7) | 25,000 | 23,000 | -8.0% |
| Returning (D8-D30) | 40,000 | 30,000 | **-25.0%** |
| Power users (D30+) | 55,000 | 49,000 | -10.9% |

*Returning segment (D8-D30) hit hardest — these are the users most reliant on push re-engagement.*

---

## External Factors

| Factor | Period | Notes |
|--------|--------|-------|
| Lunar New Year | Feb 1-4 | Historical effect: 5-8% DAU dip. Typically recovers within 3 days after holiday ends. |
| Competitor "QuickBuy" launch | Feb 1 (ongoing) | Launched same-day delivery in Seoul metro market. |
| Seoul snowstorm | Feb 3-4 | Heavy snowfall in greater Seoul area — possible localized impact. |

---

## Data Quality Notes

| Issue | Details |
|-------|---------|
| Bot filter deployment | New bot filtering deployed Feb 3 removed approximately 2,000 sessions/day that were previously counted as DAU. |
| GA4 migration | Analytics migration to GA4 completed Feb 1. Event parity verified — no data loss detected. |
