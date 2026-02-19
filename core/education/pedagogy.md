# Education Design Philosophy

## Core Principles

### 1. Learn by Doing
The ALIVE loop is best learned through practice, not reading. Each scenario places the learner in a realistic situation where they must apply the methodology to solve a real-world-like problem.

### 2. Scaffolded Complexity
Beginner scenarios have single causes, clean data, and rich guidance. Intermediate scenarios introduce ambiguity, multiple causes, noisy data, and analytical traps. This progression builds confidence before challenging assumptions.

### 3. Progressive Disclosure
Data is revealed stage-by-stage, mirroring real analysis work:
- ASK: Only the briefing (the question and context)
- LOOK: First data set (primary metrics, segments)
- INVESTIGATE: Deeper data (root cause evidence, confounders)
- VOICE: (Optional) Additional context for communication
- EVOLVE: Full picture for reflection

### 4. Feedback Over Grades
Scores exist to track progress, not to judge. The feedback focuses on:
- What was done well (reinforcement)
- What was missed and WHY it matters (learning)
- Concrete examples of stronger approaches (modeling)

## Hint Policy

Hints are provided in 3 progressive levels:

| Level | Type | Example |
|---|---|---|
| 1 | Direction | "Consider external factors during this period" |
| 2 | Specific | "Check if there were holidays or competitor events" |
| 3 | Near-answer | "Lunar New Year fell on Feb 1-4, typically causing a 5-8% dip" |

### Rules
- Hints are always available but tracked in progress
- Fewer hints used = higher learning autonomy (noted in review, not penalized in score)
- Beginner: Level 1 hints are embedded in the template; Level 2-3 via `/analysis-learn-hint`
- Intermediate: All hints via `/analysis-learn-hint` only

## Annotation Style

### Beginner Annotations
Embedded as blockquotes in the learning file:

```markdown
> **Why This Matters**: [Explanation with analogy or example]

> **Hint**: [Level 1 direction hint]

> **Concept — [Name]**: [Explanation accessible to non-experts]
```

### Intermediate Annotations
Brief reminders only:

```markdown
> **Reminder**: [One-line methodological reminder]
```

## Rubric Design

Each scenario has a 100-point rubric across ALIVE stages:

| Stage | Weight | Focus |
|---|---|---|
| ASK | 20 pts | Problem framing, hypothesis quality, scope clarity |
| LOOK | 20 pts | Data exploration, segmentation, external factors |
| INVESTIGATE | 25 pts | Hypothesis testing rigor, evidence quality, sensitivity |
| VOICE | 20 pts | "So What → Now What", confidence calibration, audience fit |
| EVOLVE | 15 pts | Reflection depth, monitoring setup, knowledge capture |

### Scoring Approach
- Each stage has 4-5 rubric items worth 4-5 points each
- Items are scored on a 0-5 scale: 0 (missing), 1-2 (attempted), 3 (adequate), 4 (good), 5 (excellent)
- The AI compares learner's work against the rubric criteria and solution, providing qualitative feedback alongside scores

## Role-Based Tone Adjustment

The learner selects a role at session start. This adjusts explanation depth:

| Role | Adjustment |
|---|---|
| Data Analyst | Technical language OK, focus on methodology rigor |
| PM | Business context emphasis, lighter on statistics |
| Developer | Technical examples, system-level analogies |
| Marketer | Campaign/channel examples, ROI framing |
| Other | Balanced, general-purpose explanations |

## Graduation Logic

### Beginner → Intermediate
- Completed 2+ Beginner scenarios
- Average score 70%+
- AI suggests: "You've shown solid fundamentals. Ready for an Intermediate challenge?"

### Education → Production
- Completed 1+ Intermediate scenario
- Score 75%+
- AI suggests: "Your analytical thinking is strong. Try `/analysis-new` for a real analysis!"
