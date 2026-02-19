# Hints: LOOK Stage

## Level 1 (Direction)
The total 15% drop tells you nothing useful. Segment by platform, then by channel — one of those segmentations will reveal a clear outlier that isolates the primary cause.

## Level 2 (Specific)
Platform segmentation: Android dropped 23.6% while iOS and Web dropped only 7.7%. Channel segmentation: push notification-driven DAU dropped 37.1% while paid ads DAU dropped 0%. The intersection of "Android" and "push" is your primary signal.

## Level 3 (Near-answer)
Three segmentations are necessary:
- **Platform**: Android -23.6% vs iOS -7.7% vs Web -7.7% — Android is the outlier
- **Channel**: Push -37.1% vs Organic -7.7% vs Paid 0% — push collapsed
- **User segment**: Returning D8-D30 -25% — these users depend on push re-engagement

Also check data quality: bot filter removed ~2K sessions (real but minor, ~1.7% of drop). GA4 migration verified clean. External factors: Lunar New Year explains ~7% dip in organic/non-push segments, but not the Android push collapse or the persistence past Feb 4.
