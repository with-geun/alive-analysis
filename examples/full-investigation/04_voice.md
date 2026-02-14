# VOICE — DAU Drop Investigation

> Analysis ID: F-2026-0210-001

## Key Findings

### Finding 1: Android push notification delivery is broken
**So What**: 60% of the DAU drop is caused by a push notification migration that broke Android delivery. 13,000 daily users who normally return via push notifications aren't receiving them.

**Now What**:
- **Option A** (Recommended): Hotfix Android push delivery immediately. Expected recovery: 3-5 days after fix.
- **Option B**: Roll back to previous push system while investigating. Faster recovery but loses migration progress.

**Confidence**: High — timing matches, iOS unaffected (natural control group), delivery rate data confirms

### Finding 2: Holiday effect accounts for remainder
**So What**: ~25% of the drop is normal Lunar New Year seasonality. This will recover naturally.

**Now What**: No action needed. Monitor for recovery by Feb 14.

**Confidence**: High — consistent with historical pattern

### Counter-metric Check
- Unsubscribe rate: Stable at 0.3% — push fix won't cause notification fatigue issues
- App crash rate: Unchanged — the issue is delivery, not stability

## Audience-Specific Messages

### For CEO (1 sentence)
"DAU dropped 15% mostly because a push notification migration broke Android delivery — we're fixing it this week, and expect recovery within 5 days."

### For Engineering
"Android push delivery rate dropped from 94% to 61% after the FCM migration on Feb 3. Root cause: token refresh logic isn't handling the new API response format. Hotfix PR needed for `PushService.refreshToken()`. iOS APNs path unaffected."

### For Product Team
"The sprint doesn't need to pause. The drop is a push infra issue (60%) + holiday (25%) + bot cleanup (10%). Once push is fixed, DAU should recover to ~115K-118K (slight holiday residual)."

## Limitations
- We can't separate "users who would have come via push but didn't" from "users who left for other reasons" with perfect precision
- Competitor impact may be real but too small to detect in one week of data

## Checklist — VOICE
- [x] Have you applied "So What -> Now What" for each finding? — Yes, 2 findings with options
- [x] Have you tagged confidence levels? — High for both
- [x] Have you included trade-off analysis? — Hotfix vs rollback for Finding 1
- [x] Have you checked guardrail metrics? — Unsubscribe rate and crash rate stable
- [x] Have you tailored messages for each audience? — CEO, Engineering, Product
