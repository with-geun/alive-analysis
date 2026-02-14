# Conversation Examples

> Example conversations showing how the ALIVE loop works in practice.
> Extracted from the alive-analysis SKILL.md for readability.

---

## Full Mode: Stage-by-Stage Conversation Flow

### ASK Stage — Frame the question before touching data
```
AI: "What question are you trying to answer?"
User: (describes the problem)
AI: "Got it. Before we dive in — is this about WHY something happened (causation),
     or whether two things are related (correlation)?"
User: (clarifies intent)
AI: "Who requested this? What decision will this inform?"
User: (provides context)
AI: "Let me build a hypothesis tree. Here are possible explanations:"
    - Internal: product changes, channel mix, cross-service effects
    - External: seasonality, competitors, market shifts
    - Data artifacts: tracking changes, definition changes
AI: "Which of these feel most likely? Any I should add?"
User: (prioritizes hypotheses)
AI: "What's in scope and out of scope? And the deadline?"
User: (confirms)
AI: → Writes 01_ask.md with hypothesis tree and framing
AI: "Let's check before moving on:"
    - "Is the question framed as causal or correlational? 🟢/🔴"
    - "Do we have a hypothesis tree, not just one guess? 🟢/🔴"
    - "Do we know where the data lives? 🟢/🔴"
AI: "Ready to move to LOOK? Or anything to add?"
```

### LOOK Stage — Segment, don't just aggregate
```
AI: "What data sources will we use? Do you have MCP access, or will you
     run queries and share results?"
User: (describes access)
[If MCP]: AI proposes query → gets confirmation → runs → discusses results
[If file]: User shares file → AI reads → summarizes structure → asks what to look for
[If manual]: AI generates SQL/Python → user runs → shares results

AI: "Let's not look at averages yet. How should we segment this?"
    - "By time period (before/after event)?"
    - "By user cohort (new vs returning, by channel)?"
    - "By platform (iOS/Android, web/app)?"
User: (chooses segmentation)
AI: "Any external factors to check? I see {date} is near a holiday /
     your competitor launched X / there was a platform update..."
User: (confirms or adds context)
AI: "Let me also check — did anything change in adjacent services?
     Sometimes changes in service A affect metrics in service B."
User: (discusses cross-service)
AI: "Before we move on, let me check confounders:
    - Did anything else change at the same time?
    - Are we comparing apples to apples (same population)?
    - Could this be survivorship bias?"
User: (validates)
AI: → Updates 02_look.md with segmented findings
AI: "Checklist review:"
    - "Did we segment before drawing conclusions? 🟢/🔴"
    - "Have we checked for confounders and external factors? 🟢/🔴"
    - "Is the data quality confirmed? 🟢/🔴"
```

### INVESTIGATE Stage — Eliminate, don't just confirm
```
AI: "From our hypothesis tree in ASK, let's work through them systematically.
     Which is easiest to disprove? Let's start there."
User: (picks hypothesis)
AI: "What evidence would DISPROVE this hypothesis? Let's look for that first."
User: (discusses disproving evidence)
[AI runs queries via MCP or asks user to check]

AI: "Let's look at this from multiple angles:"
    - "Macro: Is this happening industry-wide, or just us?"
    - "Meso: Is this specific to one product/channel, or company-wide?"
    - "Micro: What does user-level behavior look like?"
User: (discusses each level)
AI: "Based on what we've found so far, here's the scorecard:
     ✅ Hypothesis 1 (channel mix): Strong evidence — explains ~70%
     ❌ Hypothesis 2 (bug): Disproved — no change in error rates
     ⚠️ Hypothesis 3 (competitor): Inconclusive — need more data"
User: (validates or challenges)

[If causal claim needed]:
AI: "You want to say X CAUSED Y. Let's check:
    - Time ordering: Did X happen before Y? ✅
    - Mechanism: Is there a plausible pathway?
    - Dose-response: More X → more Y?
    - Counterfactual: Unaffected segment stayed stable?"
User: (works through each)

AI: "Sensitivity check — does this hold if we:
    - Change the date range by a week?
    - Exclude outliers?
    - Use a different metric definition?"
User: (confirms robustness)
AI: → Updates 03_investigate.md with hypothesis results and evidence
AI: "Can someone else reproduce this? Let's save queries to assets/."
```

### VOICE Stage — So What, Now What
```
AI: "Let's frame each finding with 'So What → Now What'."
AI: "Finding 1: {summary}. So what does this mean for the business?"
User: (interprets business impact)
AI: "Now what? What are the options?"
User: (proposes actions)
AI: "Let me add trade-offs for each option:
    - Option A: {benefit} but {risk}
    - Option B: {benefit} but {risk}
    Does this affect any guardrail metrics from your config?"
User: (evaluates)

AI: "Confidence level on each finding:"
    - Finding 1: 🟢 High — multiple sources, robust to sensitivity checks
    - Finding 2: 🟡 Medium — supported but small sample
AI: "Does that feel right?"
User: (adjusts)

AI: "Who needs to hear this? From your config, stakeholders are: {list}"
    - "For {executive}: What's the one-sentence version?"
    - "For {product team}: What's the technical detail they need?"
    - "For {marketing}: How does this affect their metrics?"
User: (tailors messages)
AI: → Updates 04_voice.md
AI: "Important — what are the limitations and caveats? Let's make those visible,
     not buried in a footnote."
```

### EVOLVE Stage — Stress-test and look forward
```
AI: "Before we close — let's stress-test our conclusion."
    - "What new data could DISPROVE what we found?"
    - "What assumptions did we make that we didn't verify?"
    - "If a colleague challenged this, what would they attack?"
User: (identifies vulnerabilities)

AI: "Should we set up monitoring for this?"
    - "What metric should we track going forward?"
    - "What threshold should trigger re-investigation?"
    - "Who should own it?"
User: (sets up monitoring plan)

AI: "What questions came up that we didn't answer?"
User: (lists open questions)
AI: "Any reusable patterns from this analysis? SQL templates, segmentation
     approaches, data gotchas that future analyses should know about?"
User: (captures learnings)

AI: "Let's set up Impact Tracking. From your VOICE recommendations:
     1. {recommendation from VOICE}
     2. {recommendation from VOICE}
     Who owns each decision? And when should we check back on outcomes?"
User: (assigns owners, sets timeline)

AI: "Connecting back to your North Star ({metric from config}):
     Does this change our understanding of what drives it?"
User: (reflects)
AI: "One sentence — the single most important takeaway?"
User: (provides insight)
AI: → Updates 05_evolve.md
AI: "Ready to archive? Or want to revisit any stage?"
```

---

## Quick Mode Conversation

Quick mode follows the same methodology but compressed. The AI still guides through each lens but faster:

### Quick Investigation Example
```
AI: "What's the question? Is this a 'why did X happen' or 'are X and Y related'? (ASK)"
User: "Why did signups drop yesterday?"
AI: "Quick hypothesis: internal (bug, release, tracking), external (competitor, platform)?
     Which feels most likely?"
User: "Probably internal — we had a release yesterday"

AI: "Where will you look? Let's segment: which platform, which user type? (LOOK)"
User: "GA4 events and server logs — mobile seems affected"
AI: "Any external factors? Holiday? Competitor launch?"
User: "No, nothing I know of"

AI: "What did you find? (INVESTIGATE)"
User: "Mobile auth API was down 14-17h"
AI: "Can we confirm: was web unaffected? Does timing match the drop exactly?"
User: "Yes, web was fine. Drop is exactly 14-17h."

AI: "So what — and now what? (VOICE)"
User: "API maintenance caused mobile signup failures. We need a fallback."
AI: "Confidence? 🟢 High — timing matches, web unaffected, clear mechanism."

AI: "Any follow-up? Should we monitor this? (EVOLVE)"
User: "Add email auth as fallback. Set up uptime alert for auth API."
AI: → Writes the complete Quick file with all sections
AI: "Checklist: purpose clear? ✅ data segmented? ✅ conclusion answers question? ✅
     hypothesis tested (not just assumed)? ✅ data volume sufficient? ✅"
AI: "Archive this, or keep it active?"
```

### Quick Comparison Example (PM use case)
```
User: "Onboarding flow A vs B — which has higher conversion to paid?"
AI: "Good question. Let's frame it: is this Comparison (which is better?)
     or Causation (does A cause higher conversion)? (ASK)"
User: "Comparison for now — we just want to pick the better one."
AI: "Makes sense. Framing: Comparison. Are the two groups comparable?
     Same time period, same traffic source, similar user mix? (LOOK)"
User: "Both ran last month. A got organic traffic, B got paid ads."
AI: "⚠️ The groups aren't directly comparable — paid users behave differently
     from organic. We need to either: (a) compare within the same channel,
     or (b) adjust for channel mix. Which data do you have?"
User: "I can split by channel. Let me check..."
User: "OK — within organic only: A=12%, B=15%. Within paid: A=8%, B=9%."
AI: "B wins in both segments. Confidence? Sample size matters — how many
     users in each group? (INVESTIGATE)"
User: "Organic: A=2000, B=1800. Paid: A=500, B=450."
AI: "Organic difference (12→15%, n≈2000) looks reliable. Paid difference
     (8→9%, n≈500) is smaller and noisier — could be chance.
     🟢 High confidence: B is better for organic.
     🟡 Medium confidence: B may be better for paid — needs more data."
AI: "So What: B outperforms A, especially for organic users.
     Now What: Roll out B for organic. For paid, consider running longer
     or increasing sample. (VOICE)"
AI: "Follow-up: Why does B convert better? Worth investigating the specific
     step where A loses users. (EVOLVE)"
AI: "Checklist: purpose clear? ✅ segmented? ✅ alternatives considered? ✅
     confidence assigned? ✅ data volume sufficient? ✅"
```

---

## Mode-Specific Conversation Adjustments

### Modeling Mode

For 📈 Modeling analyses, the conversation focus shifts at each stage:
- **ASK**: "What are you trying to predict/classify?" + business impact + success criteria (AUC, MAPE targets)
- **LOOK**: Target variable distribution, feature exploration, leakage risk, train/val/test split strategy
- **INVESTIGATE**: Baseline → model comparison → best model analysis → error analysis → reproducibility
- **VOICE**: Model performance vs target, business interpretation, deploy recommendation, monitoring plan
- **EVOLVE**: Model drift risk, retraining schedule, feature pipeline automation, A/B test proposal

### Simulation Mode

For 🔮 Simulation analyses, the conversation focus shifts at each stage:
- **ASK**: "What policy/strategy are you evaluating?" + variables affected + success criteria + comparison scenarios. Framing is always Evaluative ("What would happen if X?")
- **LOOK**: Historical analogues for assumptions, baseline values for each variable, data availability per variable, identify which accounts are fixed vs variable
- **INVESTIGATE**: Map variable relationships → build scenario matrix (conservative/neutral/aggressive) → sensitivity analysis (which variable moves the needle most?) → breakeven analysis → Monte Carlo if 3+ uncertain variables
- **VOICE**: Present 3-scenario table, highlight breakeven point and most sensitive variable, offer "handle bars" (adjustable inputs for stakeholders)
- **EVOLVE**: Compare simulation predictions vs actual results after execution, update assumptions, discover new variables, version-manage the simulation model
