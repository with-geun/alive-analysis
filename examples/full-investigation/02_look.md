# LOOK — DAU Drop Investigation

> Analysis ID: F-2026-0210-001

## Data Sources
- BigQuery: `shopflow.events` table (event-level logs)
- GA4: Traffic source and session data
- Internal: Push notification delivery logs

## Segmented Findings

### By Platform
| Platform | Jan 27-Feb 2 (baseline) | Feb 3-9 | Change |
|----------|------------------------|---------|--------|
| iOS | 52,000 | 48,000 | -7.7% |
| Android | 55,000 | 42,000 | **-23.6%** |
| Web | 13,000 | 12,000 | -7.7% |

**Key insight**: Android drop is 3x worse than other platforms.

### By Acquisition Channel
| Channel | Baseline | Feb 3-9 | Change |
|---------|----------|---------|--------|
| Organic | 65,000 | 60,000 | -7.7% |
| Push notification | 35,000 | 22,000 | **-37.1%** |
| Paid ads | 20,000 | 20,000 | 0% |

**Key insight**: Push notification-driven DAU collapsed. Paid ads unaffected.

### By User Segment
| Segment | Baseline | Feb 3-9 | Change |
|---------|----------|---------|--------|
| New users (D0-D7) | 25,000 | 23,000 | -8.0% |
| Returning (D8-D30) | 40,000 | 30,000 | **-25.0%** |
| Power users (D30+) | 55,000 | 49,000 | -10.9% |

### External Factors Check
- Lunar New Year (Feb 1-4): Explains ~5-8% dip historically. But drop continued through Feb 9.
- Competitor launch: QuickBuy same-day delivery — possible but no evidence of user migration yet.
- Snowstorm: Localized, unlikely to explain national 15% drop.

### Data Quality Check
- Bot filtering: New filter removed ~2K daily bot sessions. This accounts for ~1.7% of the drop — real but minor.
- GA4 migration: Verified event parity. No data loss detected.

## Checklist — LOOK
- [x] Have you segmented the data before drawing conclusions? — By platform, channel, segment
- [x] Have you checked for confounding variables? — Holiday, bot filter, GA4 migration
- [x] Have you considered external factors? — Holiday, competitor, weather
- [x] Have you checked variability? — Android and push channels show abnormal deviation
- [x] Have you checked for data errors? — Bot filter accounts for 1.7%, GA4 clean
