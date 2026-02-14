# Glossary

Key terms used throughout alive-analysis, sorted alphabetically.

---

### ALIVE Loop
The five-stage analysis framework: **A**sk, **L**ook, **I**nvestigate, **V**oice, **E**volve. Each stage has a specific purpose and checklist to ensure thorough analysis.

### ANOVA (Analysis of Variance)
A statistical method to compare means across 3 or more groups. Answers: "Is at least one group meaningfully different from the others?"

### Counter-metric
A metric you monitor alongside your primary metric to ensure optimization doesn't cause unintended harm. Example: if you optimize for signup rate, monitor D7 activation as a counter-metric to catch cases where easier signups attract low-quality users.

### CV (Coefficient of Variation)
A measure of data spread relative to the mean (σ / μ). High CV (>1) means the average is unreliable. Low CV (<0.3) means the data is consistent.

### D7 / D30 Activation
The percentage of users who return and perform a key action within 7 or 30 days of signing up. Used as a proxy for user quality and engagement.

### DiD (Difference-in-Differences)
A quasi-experimental method that compares the change in a treatment group to the change in a control group over the same period. Useful when a true A/B test isn't possible.

### Full Analysis
An analysis mode that creates 5 separate files (one per ALIVE stage) with detailed checklists. Best for decisions that matter and need thorough documentation.

### Guardrail Metric
A metric that should NOT get worse while you optimize something else. Example: while improving load time, page error rate is a guardrail — it must stay stable.

### Lift
In association analysis, how much more likely two things appear together compared to random chance. Lift > 1 = positive association. Lift = 1 = no relationship.

### LTV (Lifetime Value)
The total revenue or value a customer generates over their entire relationship with your product. Useful for acquisition and retention decisions.

### MCP (Model Context Protocol)
A protocol that allows AI agents to connect to external tools and data sources. In alive-analysis, MCP connections can provide direct database access or API integration for analysis.

### MDE (Minimum Detectable Effect)
The smallest improvement an A/B test can reliably detect given its sample size. Smaller effects need larger samples.

### North Star Metric
The single metric that best captures the core value your product delivers to customers. All other metrics should ultimately connect back to this one.

### pp (Percentage Points)
The absolute difference between two percentages. Example: going from 30% to 36% is a 6pp increase (not a 20% increase). Always use "pp" to avoid confusion with relative percentage changes.

### PSM (Propensity Score Matching)
A method to create fair comparisons by matching treated and untreated users based on their probability of receiving treatment. Used when groups differ in demographics or behavior.

### Quick Analysis
An analysis mode that uses a single file with abbreviated ALIVE sections and a 5-item checklist. Best for fast turnaround and simpler questions.

### RDD (Regression Discontinuity Design)
A quasi-experimental method that uses a threshold/cutoff as a natural experiment. Compares users just above and just below the threshold.

### SHAP (SHapley Additive exPlanations)
A method to explain individual predictions by showing each feature's additive contribution. SHAP values sum to the final prediction: base value + all contributions = prediction.

### Simpson's Paradox
A phenomenon where a trend that appears in several groups reverses when the groups are combined. Always check segment-level results to catch this.

### SRM (Sample Ratio Mismatch)
When the actual split in an A/B test doesn't match the intended split (e.g., 52/48 instead of 50/50). Indicates a problem with randomization that makes results unreliable.

### STEDII
A metric quality framework from Microsoft Research. A good metric should be: **S**ensitive, **T**rustworthy, **E**fficient, **D**ebuggable, **I**nterpretable, **I**nclusive.
