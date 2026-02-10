# /analysis init

Initialize alive-analysis in the current project.

## Instructions

You are setting up the alive-analysis workflow kit for this project.
This is the most important step — the context collected here will be used
throughout every analysis to make conversations smarter and faster.

Follow these steps exactly:

### Step 1: Check existing setup

Check if `.analysis/` folder already exists.
- If it exists, warn the user and ask if they want to re-initialize.
- If not, proceed.

### Step 2: Team & Work Context

Use AskUserQuestion to ask:

**Q1. Team / Project name**
- Free text input

**Q2. What does your team do? What domain?**
- Examples: "이커머스 데이터분석팀", "핀테크 그로스팀", "SaaS PM팀"
- This helps the AI understand business context during analysis

**Q3. Primary language for documents**
- Korean (Recommended)
- English
- Japanese
- Other

**Q4. Default analysis mode**
- Full (for data analyst teams)
- Quick (for cross-functional teams)

### Step 3: Key Metrics & Definitions

Ask the user to define their core metrics. This prevents asking "what retention?" every time.

**Q5. What are your team's key metrics? (list up to 5)**
- Examples: "D7 리텐션", "DAU", "전환율", "ARPU", "NPS"
- For each metric, ask:
  - Definition (e.g., "D7 = 가입 후 7일차 재방문율")
  - Where the data lives (e.g., "BigQuery analytics.retention_cohort")

**Q6. Who are the typical stakeholders for your analyses?**
- Examples: "PM팀", "경영진", "마케팅팀", "개발팀"
- This will be used in the VOICE stage to suggest audience-specific messages

### Step 4: Data Stack & Connections

**Q7. What data tools/platforms does your team use?**
- Options (multi-select):
  - BigQuery
  - PostgreSQL / MySQL
  - Snowflake / Redshift
  - Looker / Tableau / Metabase
  - Python / Jupyter
  - Spreadsheets (Google Sheets / Excel)
  - Other (free text)

**Q8. MCP connection setup**
- If the user has MCP-compatible data tools, guide them:
  - "MCP를 연결하면 분석 중에 AI가 직접 쿼리를 실행할 수 있습니다."
  - "지금 설정할까요, 나중에 할까요?"
- If "now": walk through MCP server connection for their data stack
- If "later": note in config.md as "MCP: not configured (run /analysis init --mcp to set up later)"

**Important**: Never auto-install MCP servers. Always ask for explicit user confirmation.
Warn: "MCP 서버는 데이터 접근 권한이 필요합니다. 팀 보안 정책을 확인하세요."

### Step 5: Create folder structure

Create the following structure:

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

### Step 6: Generate config.md

```markdown
# alive-analysis Config

> Project: {project_name}
> Team: {team_description}
> Domain: {domain}
> Language: {language}
> Default Mode: {mode}
> Initialized: {YYYY-MM-DD}

## Team

- Default assignee: {user}
- Stakeholders: {stakeholder_list}

## Key Metrics

| Metric | Definition | Data Source |
|--------|-----------|-------------|
| {metric_1} | {definition} | {source} |
| {metric_2} | {definition} | {source} |
| ... | | |

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

### Step 7: Generate status.md

```markdown
# Analysis Status
> Last updated: {YYYY-MM-DD HH:mm}

## Active (0)

| ID | Title | Mode | Stage | Started | Owner |
|----|-------|------|-------|---------|-------|

## Recently Archived (latest 5)

| ID | Title | Key Insight | Completed |
|----|-------|-------------|-----------|

## Pending

(none)
```

### Step 8: Generate checklist files

Read the checklist templates from the alive-analysis skill and generate each file in `.analysis/checklists/`.
Each checklist file should contain the default checklist items with 🟢/🔴 signal format.

### Step 9: Confirmation

Tell the user:
- alive-analysis has been initialized
- Show the created folder structure
- Recap what was configured (team, metrics, data stack, MCP status)
- Suggest running `/analysis new` to start their first analysis
- Mention that checklists in `.analysis/checklists/` can be customized per team needs
- If MCP not configured: "데이터 직접 조회를 원하면 나중에 `/analysis init --mcp`로 설정할 수 있어요"

### How this context is used later

The AI should read `.analysis/config.md` at the start of every analysis command and use it:

- **ASK**: Suggest relevant key metrics, know the stakeholders already
- **LOOK**: Know which databases to query, connect via MCP if available
- **INVESTIGATE**: Use the right tools (SQL for BQ users, Python for notebook users)
- **VOICE**: Auto-suggest audience sections based on stakeholder list
- **EVOLVE**: Reference key metrics when proposing follow-up analyses
