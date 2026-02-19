# Data: INVESTIGATE Stage

> This data is revealed after you have completed your LOOK stage assessment and formed initial hypotheses.

## D7 Activation Rates (Users who completed first core action within 7 days of signup)

### Overall
| Flow | D7 Activation Rate | Activated Users / Total Signups |
|------|--------------------|---------------------------------|
| Flow A | 45% | 807 / 1,792 |
| Flow B | 42% | 774 / 1,843 |

### By Acquisition Channel
| Segment | Flow A (D7 activation) | Flow B (D7 activation) | Difference |
|---------|------------------------|------------------------|------------|
| Organic | 48% | 46% | -2pp |
| Paid (Instagram) | 38% | 35% | -3pp |
| Paid (Google) | 42% | 40% | -2pp |

Notes:
- Flow B shows **lower D7 activation in every segment** (1–3 percentage points lower per segment)
- The overall difference (-3pp) is slightly amplified by segment mix composition
- D7 activation event = user completes "first project created" or "first team member invited" within 7 days of signup

## Funnel Step Detail: Where Flow A Loses Users

| Step | Flow A Drop-off | Note |
|------|-----------------|------|
| Role / company info | -15% (vs. previous step) | Friction but expected |
| **Phone verification** | **-35% (vs. previous step)** | Largest single drop-off in Flow A |

- Flow A's Step 3 (mandatory phone verification) is the dominant friction point
- Flow B replaced this with optional email verification — drop-off at email verification step is only -7%
- The 6pp signup improvement in Flow B is almost entirely explained by removing this step

## Simpson's Paradox Check

| Direction | Signup rate | D7 activation |
|-----------|-------------|---------------|
| Overall: Flow B wins | +6pp | -3pp |
| Organic: Flow B wins | +7pp | -2pp |
| Paid IG: Flow B wins | +4pp | -3pp |
| Paid Google: Flow B wins | +7pp | -2pp |

- **No Simpson's Paradox** for signup rate: Flow B wins in every segment AND overall
- **No Simpson's Paradox** for D7 activation: Flow A wins in every segment AND overall
- Both metrics are consistent across segments — the story is clean but nuanced

## Sample Size Notes
- Organic segment: n=6,000 combined — differences are reliable
- Paid Instagram: n=2,700 combined — directionally positive but noisier
- Paid Google: n=1,750 combined — smallest group, use with caution
- For the overall signup improvement (+6pp), the combined n=10,450 gives high confidence
- For the D7 activation gap (-3pp overall, -1 to -3pp per segment), confidence is medium given smaller per-segment activated user counts
