# Quick: Why did signups drop yesterday?
> **ID**: L-scenario-b1 | **Type**: Quick Analysis (Investigation) | **Scenario**: b1-signup-drop | **Status**: Reference Solution

## ASK
- **Question**: "Why did signups drop ~30% on Feb 18 compared to Feb 17?"
- **Framing**: Causation — "What caused the drop?"
- **Top hypotheses**:
  1. Android v2.8 release (Feb 17) introduced a change that broke the signup flow
  2. Server-side issue or tracking problem
  3. External factor (competitor, seasonal)
- **Deadline**: End of day

## LOOK
- **Data source**: GA4 event data + server logs
- **Data readiness**: 5 days of daily data by platform, plus Feb 18 funnel detail
- **Key segments checked**: iOS / Android / Web
  - iOS: 185 → 175 (−5%, normal fluctuation)
  - Android: 305 → 120 (−61%, severe drop)
  - Web: 90 → 88 (−2%, normal)
- **Are groups comparable?** Yes — same weekday comparison
- **External factors**: No holidays, no competitor events, no marketing changes
- **Notable findings**: The drop is entirely Android. Funnel shows massive drop-off at "Password set" step (640 start → 180 complete = 72% drop, vs iOS 420 → 390 = 7% drop).

## INVESTIGATE
- **Method**: Before/after comparison (pre- vs post-release) + error log analysis
- **Hypotheses tested**:
  - Android v2.8 password validation change: Confirmed. Error rate jumped from 6% to 72%. 460 PWD_VALIDATION_FAIL errors in server logs. Release notes confirm "updated password validation rules (min 10 chars, special character required)."
  - Server issue: Only 12 timeouts, normal range
  - External factors: iOS and Web unaffected, ruling out market-level causes
  - Tracking issue: GA4 unchanged, server logs confirm real signup failures
- **Result**: Root cause is the v2.8 password validation rule change. New rules (10+ chars, special character) are too strict AND the error message doesn't communicate the new requirements, causing 72% of Android users to fail at password creation.
- **Confidence**: High — platform-specific timing matches release, error logs provide mechanism, iOS serves as natural control group.

## VOICE
- **So What?** ~185 Android signups lost per day. At current rates, this costs ~1,300 signups/week until fixed. Android is 53% of total signups, making this a critical issue.
- **Now What?**
  - **Immediate (today)**: Hotfix — either revert to previous password rules OR add clear inline validation showing requirements as user types. Estimated recovery: within 24 hours of deploy.
  - **Short-term (this sprint)**: Redesign password field with strength meter and real-time requirement indicators. Keep the security improvement but make it user-friendly.
  - **Process**: Add signup funnel regression test to Android release checklist.
- **Audience**:
  - CEO: "Android signups dropped 61% due to a password rule change in yesterday's release. We're hotfixing today — expect full recovery tomorrow."
  - Engineering: "v2.8 password validation rejects 72% of signup attempts. PWD_VALIDATION_FAIL errors at 460/day. Hotfix: show requirements inline or revert PasswordValidator.minLength to 8."
  - PM: "The security improvement is good but needs better UX. Hotfix now, redesign in next sprint."

## EVOLVE
- **What would change this conclusion?** If Android signups don't recover within 48 hours of the hotfix, there may be an additional factor.
- **Follow-up needed**: Yes — verify recovery after hotfix
- **Next question**: Should we analyze the 120 users who DID sign up despite the new rules? Are they higher quality (better passwords)?
- **Monitor**: Daily signup rate by platform, alert if any drops >15% day-over-day
- **Reusable insight**: Authentication/password changes can silently break signup funnels. Always run the full signup flow on all platforms after any auth change.

---
Check: Proceed / Stop
- [x] Is the purpose clear and framed? — Yes, causation: what caused the 30% signup drop
- [x] Was the data broken down by groups? — Yes, by platform (iOS/Android/Web) and funnel step
- [x] Were alternative explanations considered? — Yes, tested 4 hypotheses, eliminated 3
- [x] Does the conclusion answer the question with confidence? — Yes, High confidence with mechanism
- [x] Is there enough data? — Yes, 5 days + funnel + error logs

**Tags**: `signup`, `android`, `password`, `release`, `funnel`
