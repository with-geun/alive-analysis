# Archive Summary — DAU Drop Investigation

> **ID**: F-2026-0210-001
> **Title**: DAU Drop Investigation — Push Notification Migration Failure
> **Type**: Investigation
> **Duration**: Feb 10-12, 2026 (3 days)
> **Archived**: 2026-02-14

## Key Insight
ShopFlow's 15% DAU drop was caused by a push notification migration that broke Android delivery (60%), amplified by Lunar New Year holiday effect (25%) and bot filter cleanup (10%). Hotfix restored delivery within 48 hours; DAU recovered to baseline within 5 days.

## Findings Summary
| Finding | Confidence | Action Taken |
|---------|------------|-------------|
| Android push delivery broken (94% → 61%) | High | Hotfixed Feb 11, recovered by Feb 12 |
| Lunar New Year holiday effect (~8% dip) | High | No action needed, natural recovery |
| Bot filter removed ~2K fake sessions | High | Expected, no action needed |

## Tags
`dau`, `push-notification`, `android`, `infrastructure`, `holiday-effect`

## Reproduction
- Queries saved in `assets/` folder
- BigQuery: `shopflow.events` filtered by date range Jan 20 - Feb 14
- Push delivery logs: `platform_eng.push_delivery` table
