# /analysis init

Initialize alive-analysis in the current project.

## Instructions

You are setting up the alive-analysis workflow kit for this project.
Follow these steps exactly:

### Step 1: Check existing setup

Check if `.analysis/` folder already exists.
- If it exists, warn the user and ask if they want to re-initialize.
- If not, proceed.

### Step 2: Ask configuration questions

Use AskUserQuestion to ask:

**Q1. Team / Project name**
- Free text input
- This will be used in config.md

**Q2. Primary language for documents**
- Korean (Recommended)
- English
- Japanese
- Other

**Q3. Default analysis mode**
- Full (for data analyst teams)
- Quick (for cross-functional teams)

### Step 3: Create folder structure

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

### Step 4: Generate config.md

```markdown
# alive-analysis Config

> Project: {project_name}
> Language: {language}
> Default Mode: {mode}
> Initialized: {YYYY-MM-DD}

## Team

- Default assignee: (edit this)

## ID Format

- Full: F-{YYYY}-{MMDD}-{seq}
- Quick: Q-{YYYY}-{MMDD}-{seq}

## Archive

- Archive folder: analyses/archive/{YYYY-MM}/
- Summary required: true
```

### Step 5: Generate status.md

```markdown
# Analysis Status
> Last updated: {YYYY-MM-DD HH:mm}

## Active (0)

| ID | Title | Mode | Stage | Started | Owner |
|----|-------|------|-------|---------|-------|
| (no active analyses) | | | | | |

## Recently Archived (latest 5)

| ID | Title | Key Insight | Completed |
|----|-------|-------------|-----------|
| (none yet) | | | |

## Pending

(none)
```

### Step 6: Generate checklist files

Read the checklist templates from the alive-analysis skill and generate each file in `.analysis/checklists/`.

Each checklist file should contain the default checklist items with 🟢/🔴 signal format.

### Step 7: Confirmation

Tell the user:
- alive-analysis has been initialized
- Show the created folder structure
- Suggest running `/analysis new` to start their first analysis
- Mention that checklists in `.analysis/checklists/` can be customized per team needs
