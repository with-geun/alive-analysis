# Installation Guide

## Requirements

- [Claude Code](https://claude.ai/claude-code) CLI installed
- A project directory (any language/framework)

## Install

### Option 1: Plugin install (recommended)

```bash
claude plugin install alive-analysis
```

### Option 2: Manual setup

1. Clone this repository:
```bash
git clone https://github.com/your-org/alive-analysis.git
```

2. Copy the plugin files to your Claude Code configuration:
```bash
# Commands
cp -r alive-analysis/commands/ .claude/commands/

# Skills
cp -r alive-analysis/skills/ .claude/skills/

# Hooks
cp alive-analysis/hooks/hooks.json .claude/hooks.json
cp alive-analysis/hooks/session-start.sh .claude/hooks/session-start.sh
chmod +x .claude/hooks/session-start.sh
```

3. Initialize in your project:
```
/analysis init
```

## Verify Installation

Run `/analysis status` — you should see the status dashboard.

## Uninstall

### Plugin uninstall
```bash
claude plugin uninstall alive-analysis
```

### Manual cleanup
```bash
# Remove plugin files (keeps your analysis data)
rm -rf .claude/commands/analysis-*.md
rm -rf .claude/skills/alive-analysis/
rm .claude/hooks/session-start.sh

# Remove analysis data (irreversible!)
# rm -rf .analysis/ analyses/
```

## Updating

```bash
claude plugin update alive-analysis
```

Or manually pull the latest version and re-copy files.
