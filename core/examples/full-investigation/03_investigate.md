# INVESTIGATE — DAU Drop Investigation

> Analysis ID: F-2026-0210-001

## Hypothesis Testing

### Hypothesis 1: Push notification system migration broke Android delivery
**Evidence for:**
- Push-driven DAU dropped 37.1% — far worse than any other channel
- Android push delivery rate fell from 94% to 61% on Feb 3
- iOS push delivery rate stayed at 92% (unaffected)
- Timing matches exactly: migration completed Feb 3 AM, drop started Feb 3 PM

**Evidence against:**
- None found

**Verdict**: ✅ **Confirmed** — Android push delivery broke during migration

### Hypothesis 2: Lunar New Year holiday effect
**Evidence for:**
- Historical data shows 5-8% DAU dip during Lunar New Year
- Non-push DAU dropped ~8%, consistent with holiday effect

**Evidence against:**
- Drop continued through Feb 9, well past holiday end (Feb 4)
- The continuing drop is concentrated in Android push users

**Verdict**: ⚠️ **Partially explains** — accounts for ~8% of the 15% drop in non-push segments only

### Hypothesis 3: Competitor "QuickBuy" stole users
**Evidence for:**
- QuickBuy launched same-day delivery Feb 1

**Evidence against:**
- Paid acquisition metrics unchanged (no increase in CPC or decrease in install rate)
- Power user retention dipped only 10.9% (mostly explained by holiday + push)
- No spike in app uninstalls

**Verdict**: ❌ **Not supported** — no evidence of user migration

### Contribution Estimate
| Factor | Contribution | Confidence |
|--------|-------------|------------|
| Push notification failure (Android) | ~60% of total drop | High |
| Lunar New Year holiday | ~25% of total drop | High |
| Bot filter cleanup | ~10% of total drop | High |
| Unknown/noise | ~5% | — |

## Sensitivity Analysis
- Excluding bot filter adjustment: drop changes from 15% to 13.3% (conclusion unchanged)
- Extending analysis window to Feb 14: Android push DAU still depressed at 28K vs 35K baseline
- Holiday effect confirmed by comparing to 2025 Lunar New Year week: similar ~7% non-push dip

## Checklist — INVESTIGATE
- [x] Have you tested MULTIPLE hypotheses? — 3 tested, 1 confirmed, 1 partial, 1 eliminated
- [x] Have you applied multi-lens analysis? — Macro (holiday, competitor), Meso (push system), Micro (user segments)
- [x] If claiming causation, have you verified? — Time ordering yes, mechanism yes (delivery rate data), counterfactual yes (iOS unaffected)
- [x] Have you performed sensitivity analysis? — Date range, bot filter, historical comparison
- [x] Have you assigned confidence levels? — High for all three main factors
