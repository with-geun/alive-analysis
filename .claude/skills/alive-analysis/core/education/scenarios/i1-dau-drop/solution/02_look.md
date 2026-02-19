# LOOK — Why did DAU drop 15%?
> ID: L-i1-dau-drop | Mode: Learn | Stage: LOOK | Difficulty: Intermediate | Updated: 2026-02-10

> **Reference Solution** — This is the expected output for the LOOK stage. Compare your own 02_look.md against this after completing the stage.

## Data Sources
- BigQuery: `shopflow.events` table (event-level user activity logs)
- GA4: Traffic source and session data
- Internal: `platform_eng.push_delivery` (push notification delivery logs)

## Data Quality Review
- **Date range**: Jan 27 - Feb 9 (baseline: Jan 27-Feb 2, comparison: Feb 3-9)
- **Row count**: ~120K daily events at baseline — consistent with reported DAU
- **Known issues**:
  - Bot filter deployed Feb 3 removed ~2,000 daily sessions (previously counted as DAU)
  - GA4 migration completed Feb 1 — event parity verified, no data loss
- **Conclusion on data quality**: Total reported drop (15%) includes ~1.7% from bot cleanup. The remaining ~13.3% is a real behavioral change.

## Segmented Findings

### By Platform
| Platform | Baseline (Jan 27-Feb 2) | Feb 3-9 | Change |
|----------|------------------------|---------|--------|
| iOS | 52,000 | 48,000 | -7.7% |
| Android | 55,000 | 42,000 | **-23.6%** |
| Web | 13,000 | 12,000 | -7.7% |

**Key insight**: Android dropped 3x more than iOS or Web. iOS and Web behave similarly — Android is an outlier.

### By Acquisition Channel
| Channel | Baseline | Feb 3-9 | Change |
|---------|----------|---------|--------|
| Organic (direct/search) | 65,000 | 60,000 | -7.7% |
| Push notification-driven | 35,000 | 22,000 | **-37.1%** |
| Paid ads (SEM/social) | 20,000 | 20,000 | 0% |

**Key insight**: Push notification-driven DAU collapsed by more than a third. Paid acquisition is completely unaffected — this is not a market-wide issue.

### By User Segment
| Segment | Baseline | Feb 3-9 | Change |
|---------|----------|---------|--------|
| New users (D0-D7) | 25,000 | 23,000 | -8.0% |
| Returning (D8-D30) | 40,000 | 30,000 | **-25.0%** |
| Power users (D30+) | 55,000 | 49,000 | -10.9% |

**Key insight**: Returning segment (D8-D30) hit hardest — these are the users most dependent on push re-engagement. Power users have stronger intrinsic motivation to open the app, so they're partially protected.

## Confounding Variables
- **Bot filter**: Real effect — removes ~2K sessions/day. Explains ~1.7% of the 15% drop. Not the main cause.
- **GA4 migration**: Verified clean. Not a data artifact.
- **Comparison group consistency**: Baseline and comparison are same day-of-week distribution (Mon-Sun both periods). Weekday mix is not a confounder.

## External Factors
- **Lunar New Year (Feb 1-4)**: Historical effect of 5-8% DAU dip — consistent with what we see in organic and non-push segments. However, holiday ended Feb 4; the drop continues through Feb 9. Holiday alone cannot explain the full drop.
- **Competitor "QuickBuy"**: Launched same-day delivery Feb 1. Paid acquisition metrics unchanged — no evidence of user migration in this window.
- **Seoul snowstorm (Feb 3-4)**: Localized. Unlikely to explain a nationwide 15% drop across a mobile app.

## Outliers and Anomalies
- Android push channel is the clearest anomaly: -37.1% in a channel that accounts for 29% of total baseline DAU
- Returning segment (D8-D30) shows disproportionate impact — aligns with push dependency profile

## Initial Observations
1. The intersection of "Android" and "push notification" is the primary signal
2. The 7.7% dip in iOS/Web/Organic is consistent with Lunar New Year seasonality
3. Data artifacts explain a small fraction (~1.7%) — not the main story
4. A platform-specific infra change (Feb 1-3 push migration) is the strongest candidate for the Android/push intersection

## Checklist — LOOK
- [x] Have you segmented the data before drawing conclusions? — By platform, channel, user segment
- [x] Have you checked for confounding variables? — Holiday, bot filter, GA4 migration, weekday mix
- [x] Have you considered external factors? — Holiday, competitor, weather
- [x] Have you checked variability? — Android and push channels show abnormal deviation vs baseline
- [x] Have you checked for data errors? — Bot filter accounts for 1.7%, GA4 verified clean
