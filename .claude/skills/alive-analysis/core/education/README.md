# Education Mode

Education Mode provides a structured learning environment for the ALIVE analysis methodology. Learners practice with realistic scenarios and receive step-by-step guidance, hints, and feedback.

## How It Works

1. **`/analysis-learn`** — Start a learning session by choosing a scenario
2. **`/analysis-learn-next`** — Get feedback on your current stage and advance to the next
3. **`/analysis-learn-hint`** — Request progressive hints (3 levels: direction → specific → near-answer)
4. **`/analysis-learn-review`** — Complete the scenario with a scored review and self-assessment

## Difficulty Levels

### Beginner (Quick format, single file)
- Guided annotations explain WHY each step matters
- Built-in hints at each stage
- Simpler data with clear single causes
- 20-30 minute scenarios

### Intermediate (Full format, 5 files)
- Minimal annotations (brief reminders only)
- Hints available only via `/analysis-learn-hint`
- Complex data with multiple causes, noise, and traps
- 45-60 minute scenarios

## Scenarios

| ID | Title | Difficulty | Domain | Type |
|---|---|---|---|---|
| b1-signup-drop | "Why did signups drop yesterday?" | Beginner | B2C App/Mobile | Investigation |
| b2-onboarding-comparison | "Which onboarding flow is better?" | Beginner | Product/Growth | Investigation (Comparison) |
| b3-turnover-cost | "How much does turnover cost us?" | Beginner | HR/Finance | Investigation (Quantification) |
| i1-dau-drop | "Why did DAU drop 15%?" | Intermediate | E-commerce | Investigation |
| i2-delivery-fee | "Should we lower delivery fees?" | Intermediate | Marketplace | Simulation |
| i3-ab-test-checkout | "Did the new checkout flow actually improve conversion?" | Intermediate | E-commerce | Experiment |
| i4-churn-prediction | "Can we predict which users will churn?" | Intermediate | SaaS/B2B | Modeling |

## Graduation Path

- **Beginner → Intermediate**: Complete 2+ Beginner scenarios with average score 70%+
- **Education → Production**: Complete 1+ Intermediate scenario with score 75%+ → ready for `/analysis-new`

## File Structure

```
core/education/
├── README.md                  # This file
├── pedagogy.md                # Educational design philosophy
├── scenarios/
│   ├── b1-signup-drop/        # Each scenario contains:
│   │   ├── metadata.md        #   Difficulty, type, domain, concepts
│   │   ├── briefing.md        #   Situation + role + available data
│   │   ├── data/              #   Stage-gated data reveals
│   │   ├── hints/             #   3-level progressive hints per stage
│   │   ├── solution/          #   Reference solution
│   │   └── rubric.md          #   Scoring criteria (100 points)
│   └── ...
└── templates/
    ├── learn-quick-template.md
    ├── learn-full-ask-template.md
    ├── learn-full-look-template.md
    ├── learn-full-investigate-template.md
    ├── learn-full-voice-template.md
    └── learn-full-evolve-template.md
```

## Progress Tracking

Learning progress is stored per-project in `.analysis/education/progress.md`, tracking:
- Completed scenarios with scores
- Hint usage
- Skill Radar (per-ALIVE-stage averages)
- Recommended next scenarios
