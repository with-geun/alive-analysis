# /analysis init

Initialize alive-analysis in the current project.

## Instructions

You are setting up the alive-analysis workflow kit for this project.
This is the most important step — the context collected here will be used
throughout every analysis to make conversations smarter and faster.

All questions are optional — the user can skip anything they don't know yet.
Follow these steps in order:

### Step 1: Check existing setup

Check if `.analysis/` folder already exists.
- If it exists, warn the user and ask if they want to re-initialize.
- If not, proceed.

### Step 2: Language (ask first)

Ask the user what language they want for analysis documents.
Accept any natural language input — don't limit to a dropdown.

"What language would you like for your analysis documents?
 Type freely: English, 한국어, 日本語, Español, Deutsch, etc.
 Default: English"

This sets the tone for all subsequent questions and generated files.

### Step 3: Team & Work Context

**Q1. Team / Project name**
- Free text

**Q2. What does your team do? What domain?**
- Examples: "Ecommerce data analytics", "Fintech growth team", "SaaS product team"

**Q3. What are your company or team's key goals this year?**
- Examples: "Increase revenue 30% YoY", "Improve D30 retention to 25%", "Reduce CAC by 20%"
- This helps the AI understand what matters when framing analysis conclusions
- Can skip if unknown

### Step 4: Metrics — Structured Input

Explain the metric categories first:

"Let's set up the metrics your team tracks.
 We'll organize them into 3 tiers — skip any you don't have yet.

 🌟 North Star Metric: The ONE metric that best captures your product's core value
 📊 KPIs / Indirect Metrics: Metrics that drive or indicate the North Star
 🛡️ Guardrail Metrics: Metrics that must NOT get worse while optimizing others"

**Q4. North Star Metric** (0~1)
- Example: "Weekly active buyers", "Monthly recurring revenue"
- Ask: definition + data source (if known)
- Can skip: "Don't have one yet" or "Not sure"

**Q5. KPIs / Indirect Metrics** (0~5)
- Examples: "Purchase CVR", "ARPU", "D7 retention", "Signup rate"
- For each: definition + data source (if known)
- Can skip

**Q6. Guardrail Metrics** (0~3)
- Examples: "Refund rate must stay under 5%", "Page load time < 3s", "NPS > 40"
- These are constraints, not optimization targets
- Can skip

### Step 5: Stakeholders

**Q7. Who typically receives your analysis results?**
- Examples: "PM team", "C-level", "Marketing team", "Engineering"
- Used in VOICE stage to auto-suggest audience sections
- Can skip

### Step 6: Data Stack & Connections

**Q8. What data tools/platforms does your team use?**
- Accept free text or multi-select:
  - BigQuery / Snowflake / Redshift
  - MySQL / PostgreSQL
  - Looker / Tableau / Metabase
  - Python / Jupyter
  - Spreadsheets
  - Other

**Q9. MCP connection setup**
- Explain: "MCP lets the AI query your database directly during analysis."
- Options: Set up now / Later
- If "now": guide MCP server connection for their data stack
- If "later": note in config as "MCP: not configured"
- ⚠️ Never auto-install. Always get explicit confirmation.
- ⚠️ Warn: "MCP servers require data access permissions. Check your team's security policy."

### Step 7: Default analysis mode

**Q10. Default analysis mode?**
- Full: For data analyst teams — 5 ALIVE stage files + full checklists
- Quick: For cross-functional teams — single file with abbreviated flow

### Step 8: Create folder structure

```
.analysis/
├── config.md
├── status.md
└── checklists/
    ├── ask.md
    ├── look.md
    ├── investigate.md
    ├── voice.md
    └── evolve.md

analyses/
├── active/
│   └── .gitkeep
└── archive/
    └── .gitkeep
```

### Step 9: Generate config.md

```markdown
# alive-analysis Config

> Project: {project_name}
> Team: {team_description}
> Domain: {domain}
> Language: {language}
> Default Mode: {mode}
> Initialized: {YYYY-MM-DD}

## Annual Goals

- {goal_1}
- {goal_2}
- (or: "Not defined yet")

## Metrics

### 🌟 North Star
| Metric | Definition | Data Source |
|--------|-----------|-------------|
| {metric} | {definition} | {source} |

### 📊 KPIs / Indirect Metrics
| Metric | Definition | Data Source |
|--------|-----------|-------------|
| {metric_1} | {definition} | {source} |
| {metric_2} | {definition} | {source} |

### 🛡️ Guardrail Metrics
| Metric | Threshold | Data Source |
|--------|-----------|-------------|
| {metric_1} | {threshold} | {source} |

(Empty sections can say "Not defined yet — add later")

## Team

- Default assignee: {user}
- Stakeholders: {stakeholder_list}

## Data Stack

- Databases: {list}
- BI Tools: {list}
- Analysis Tools: {list}
- MCP: {connected / not configured}

## ID Format

- Full: F-{YYYY}-{MMDD}-{seq}
- Quick: Q-{YYYY}-{MMDD}-{seq}

## Archive

- Archive folder: analyses/archive/{YYYY-MM}/
- Summary required: true
```

### Step 10: Generate status.md and checklist files

Generate status.md (empty state) and all 5 checklist files from the skill templates.

### Step 11: Confirmation

Tell the user:
- alive-analysis has been initialized
- Show the created folder structure
- Recap what was configured:
  - Language, team, goals
  - Metrics (how many in each tier, or "skipped")
  - Data stack + MCP status
- Suggest: "Run `/analysis new` to start your first analysis"
- Note: "Checklists in `.analysis/checklists/` can be customized per team"
- If MCP not configured: "To connect later: `/analysis init --mcp`"
- If metrics skipped: "You can update metrics anytime by editing `.analysis/config.md`"

### How this context is used later

The AI should read `.analysis/config.md` at the start of every analysis command:

- **ASK**: Reference North Star + KPIs to frame the question. Know stakeholders.
- **LOOK**: Know which databases to query. Connect via MCP if available.
- **INVESTIGATE**: Use the right tools. Reference guardrail metrics ("does this change hurt refund rate?").
- **VOICE**: Auto-suggest audience sections from stakeholder list. Frame conclusions against annual goals.
- **EVOLVE**: Reference metric tiers when proposing follow-ups. Connect back to North Star.
