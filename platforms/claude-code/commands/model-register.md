# /model register

Register a deployed model from a Modeling analysis into the model registry.

## Instructions

### Step 1: Check prerequisites

- Check if `.analysis/models/` folder exists. If not, create it.
- Read `.analysis/config.md` for team context.

### Step 2: Identify the model

**Three paths:**
- **From analysis**: "Register a model from a completed Modeling analysis" → ask for analysis ID, read the EVOLVE stage for model details
- **From experiment**: "Register a model validated through an experiment" → ask for experiment ID
- **New model**: "Register an existing deployed model" → guide through definition

If from analysis:
1. Resolve file path: `analyses/active/{ID}_{slug}/05_evolve.md` or `analyses/archive/{YYYY-MM}/{ID}_{slug}/05_evolve.md`
2. Extract: model name, type, performance metrics, features, deployment status

**Version detection**: Check `.analysis/models/` for existing model cards matching the same slug (`{slug}_v*.md`):
- If found (retraining): Read the latest version card.
  1. Auto-increment version: new version = latest + 1
  2. Copy the Version History table from the latest card — append the new version row
  3. Ask: "The previous version (v{N}) is currently {status}. Should it be marked as `retired`?" If yes, update the previous card's Status to `retired (replaced by v{N+1})`
  4. In status.md Models table, update the existing row to the new version
- If not found (new model): version starts at v1

### Step 3: Create model card

Create file: `.analysis/models/{model-slug}_v{version}.md`

```markdown
# Model: {name}
> Version: v{version}
> Type: {classification / regression / clustering / recommendation / forecasting}
> Status: {deployed / staging / retired}
> Registered: {YYYY-MM-DD}

## Origin
- Analysis: {analysis ID, if any}
- Experiment: {experiment ID, if any — validation experiment}
- Owner: {team/person}

## Performance
| Metric | Train | Validation | Test | Production |
|--------|-------|------------|------|------------|
| {primary: AUC/RMSE/F1/etc.} | | | | |
| {secondary} | | | | |

- **Baseline comparison**: {vs. previous model or simple heuristic}
- **Business impact**: {e.g., "Reduces false positives by 15%, saving ~$50K/month"}

## Features
| Feature | Type | Importance | Source |
|---------|------|------------|--------|
| {feature_1} | numeric/categorical | high/medium/low | {table.column} |
| {feature_2} | | | |

- **Feature count**: {N}
- **Known leakage risks**: {if any}

## Training
- **Algorithm**: {e.g., XGBoost, LightGBM, logistic regression, neural net}
- **Training data**: {date range, sample size, sampling method}
- **Hyperparameters**: {key params or link to config file}
- **Training time**: {approximate}
- **Reproducibility**: {notebook/script location in assets/}

## Deployment
- **Endpoint/service**: {where the model is served}
- **Input format**: {expected input schema}
- **Output format**: {prediction format}
- **Latency requirement**: {p99 target}
- **Fallback**: {what happens if model fails}

## Monitoring
- **Drift detection**: {method — PSI, KS test, etc.}
- **Retraining trigger**: {condition — e.g., "AUC drops below 0.85", "monthly schedule"}
- **Retraining cadence**: {planned schedule}
- **Monitor ID**: {M-..., if metric monitor is set up}

## Version History
| Version | Date | Change | Performance Δ | Reason |
|---------|------|--------|---------------|--------|
| v{N} | {date} | {what changed} | {metric change} | {why} |

## Risks & Limitations
- **Known biases**: {if any}
- **Population limitations**: {model trained on X, may not generalize to Y}
- **Staleness risk**: {how quickly does the model degrade?}
```

### Step 4: Update status tracking

Add the model to a Models section in `.analysis/status.md`.

If the Models section doesn't exist, create it:
```markdown
## Models ({count})

| Model | Version | Status | Performance | Last Retrained | Monitor |
|-------|---------|--------|-------------|----------------|---------|
| {name} | v{N} | deployed | {primary metric}={value} | {date} | {M-ID or —} |
```

### Step 5: Link back to analysis

If the model came from an analysis:
- Update the analysis's EVOLVE file: note "Model registered as {model-slug} v{version}"
- If a monitor is set up for model performance metrics, cross-reference

### Step 6: Confirmation

Tell the user:
- Model card created at {path}
- Version: v{N}, Status: {status}
- "Set up drift monitoring with `/monitor setup` to track model performance over time"
- "When you retrain, run `/model register` again to create a new version"
