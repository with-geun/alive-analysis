# Hints: VOICE Stage

## Level 1 (Direction)
Three different people need to hear this analysis. The CEO does not need the methodology. Engineering does not need the business framing. Product does not need the infra details. Write three separate messages, each tailored to what that person needs to act.

## Level 2 (Specific)
CEO: one sentence with the verdict and recovery timeline. Engineering: specific system, specific file, specific failure mechanism. Product: sprint decision (should we pause?), and what DAU to expect after the fix.

## Level 3 (Near-answer)
- **CEO**: "DAU dropped 15% because a push notification migration broke Android delivery — we're fixing it this week and expect recovery within 5 days."
- **Engineering**: "Android FCM delivery rate dropped from 94% to 61% after the migration on Feb 3. The token refresh logic in `PushService.refreshToken()` isn't handling the new API response format. iOS APNs path is unaffected. Hotfix PR needed."
- **Product**: "Don't pause the sprint — the drop is push infra (60%) + holiday (25%) + bot cleanup (10%). v3.2 navigation is not the cause. Post-fix, expect DAU recovery to ~115K-118K."

Also check guardrail metrics: unsubscribe rate stable at 0.3% (fix won't cause notification fatigue), crash rate unchanged.
Revenue impact: ~$13K/day in lost push-driven transactions — include in CEO message if it strengthens the urgency.
