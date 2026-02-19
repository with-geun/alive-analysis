# VOICE — Why did DAU drop 15%?
> ID: L-i1-dau-drop | Mode: Learn | Stage: VOICE | Difficulty: Intermediate | Updated: 2026-02-11

> **Reference Solution** — This is the expected output for the VOICE stage. Compare your own 04_voice.md against this after completing the stage.

## Key Findings

### Finding 1: Android push notification delivery is broken
**So What**: 60% of the DAU drop is caused by a push notification migration that broke Android FCM delivery. 13,000 daily users who normally return via push notifications are not receiving them. Estimated revenue impact: ~$13,000/day in lost push-driven transactions.

**Now What**:
- **Option A** (Recommended): Hotfix Android FCM delivery — fix the token refresh logic in `PushService.refreshToken()` to handle the new API response format. Expected recovery: 3-5 days after fix ships.
- **Option B**: Roll back to the legacy push provider while investigating. Faster recovery but loses migration progress and re-introduces technical debt.

**Confidence**: High — timing matches migration exactly, iOS unaffected (natural control group), delivery rate data confirms mechanism

---

### Finding 2: Lunar New Year accounts for 25% of the drop
**So What**: The remaining organic/non-push dip is normal seasonality. ShopFlow consistently sees a 5-8% DAU dip during Lunar New Year. This will recover naturally.

**Now What**: No action needed. Monitor for natural recovery by Feb 7-9.

**Confidence**: High — consistent with 2024 and 2025 historical patterns

---

### Finding 3: Bot filter cleanup and residual noise explain the rest
**So What**: ~10% of the drop is the bot filter removing ~2,000 sessions/day that were previously inflating DAU. This is expected infra hygiene — it makes the metric more accurate, not worse.

**Now What**: Update the baseline DAU in dashboards to reflect post-bot-filter numbers. Prevent future confusion by documenting the filter change.

**Confidence**: High — sessions confirmed as bots

---

## Counter-metric Check
- **Unsubscribe rate**: Stable at 0.3% — fixing push delivery will not cause notification fatigue
- **App crash rate**: Unchanged at 0.8% — this is a delivery issue, not an app stability issue
- **7-day new user retention**: 38% → 37%, negligible — acquisition quality is fine

## Audience-Specific Messages

### For CEO
"DAU dropped 15% mostly because a push notification migration broke Android delivery — we're fixing it this week and expect recovery to ~115K within 5 days. Holiday seasonality and bot cleanup explain the rest."

### For Engineering (Platform team)
"Android FCM delivery rate dropped from 94% to 61% after the migration completed on Feb 3. The likely root cause: token refresh logic in `PushService.refreshToken()` isn't handling the new API response format correctly. iOS APNs path is unaffected and serves as a clean control. Hotfix PR needed. Revenue impact is ~$13K/day while this is open."

### For Product Team
"The sprint does not need to pause. The DAU drop is a push infrastructure failure (60%) combined with normal Lunar New Year seasonality (25%) and expected bot filter cleanup (10%). The v3.2 navigation update is not the cause — iOS also got v3.2 and shows only the holiday-consistent 7.7% dip. Once push is fixed, expect DAU to recover to ~115K-118K."

## Limitations and Caveats
- The 60/25/10/5 contribution split is an estimate, not a precisely measured breakdown. Actual contributions may vary by ±5-10%.
- We cannot cleanly separate "users who would have returned via push but didn't" from "users who churned for other reasons" — some of the 13K lost push users may not fully return.
- Competitor impact (QuickBuy) may be real but is too small to detect in one week of data. Worth re-examining in 30 days.
- Long-term retention impact of missing 7+ push notifications is unknown — may affect D30 cohort metrics.

## Checklist — VOICE
- [x] Have you applied "So What → Now What" for each finding? — Yes, 3 findings with options
- [x] Have you tagged confidence levels? — High for all three, with reasoning
- [x] Have you included trade-off analysis? — Hotfix vs rollback for Finding 1
- [x] Have you checked guardrail metrics? — Unsubscribe rate and crash rate stable
- [x] Have you tailored messages for each audience? — CEO, Engineering, Product
