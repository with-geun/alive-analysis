# Installation Guide

## Requirements

- [Claude Code](https://claude.ai/claude-code) CLI or [Cursor](https://cursor.com/) 2.4+ installed
- A project directory (any language/framework)

## Install

### Option 1: Automated installer (recommended)

Run from your **project directory** (not inside the alive-analysis repo):

```bash
git clone https://github.com/with-geun/alive-analysis.git /tmp/alive-analysis
bash /tmp/alive-analysis/install.sh
```

The installer will:
- Copy platform-specific commands, skills, and hooks from `platforms/`
- Copy shared references from `core/references/`
- Safely merge with existing `hooks.json` if present
- Auto-detect `.cursor/` and install for Cursor as well (if present)

**Installer flags:**
- `bash install.sh` — Install for Claude Code (+ Cursor if `.cursor/` exists)
- `bash install.sh --claude` — Install for Claude Code only
- `bash install.sh --cursor` — Install for Cursor only
- `bash install.sh --both` — Install for both Claude Code and Cursor

### Option 2: Manual copy

#### Claude Code

```bash
# Clone the repository
git clone https://github.com/with-geun/alive-analysis.git

# Commands
mkdir -p .claude/commands
cp alive-analysis/platforms/claude-code/commands/*.md .claude/commands/

# Skills
mkdir -p .claude/skills/alive-analysis
cp alive-analysis/platforms/claude-code/SKILL.md .claude/skills/alive-analysis/

# References
mkdir -p .claude/skills/alive-analysis/core/references
cp alive-analysis/core/references/*.md .claude/skills/alive-analysis/core/references/

# Hooks
mkdir -p .claude/hooks
cp alive-analysis/platforms/claude-code/hooks/hooks.json .claude/hooks.json
cp alive-analysis/platforms/claude-code/hooks/session-start.sh .claude/hooks/session-start.sh
cp alive-analysis/platforms/claude-code/hooks/post-analysis-action.sh .claude/hooks/post-analysis-action.sh
chmod +x .claude/hooks/session-start.sh .claude/hooks/post-analysis-action.sh
```

#### Cursor

```bash
# Commands (Cursor-optimized, batch-oriented)
mkdir -p .cursor/commands
cp alive-analysis/platforms/cursor/commands/*.md .cursor/commands/

# Skills (slim version)
mkdir -p .cursor/skills/alive-analysis
cp alive-analysis/platforms/cursor/SKILL.md .cursor/skills/alive-analysis/

# References
mkdir -p .cursor/skills/alive-analysis/core/references
cp alive-analysis/core/references/*.md .cursor/skills/alive-analysis/core/references/

# Hooks (Cursor uses a different hooks.json format, no SessionStart equivalent)
mkdir -p .cursor/hooks
cp alive-analysis/platforms/cursor/hooks/hooks-cursor.json .cursor/hooks.json
cp alive-analysis/platforms/cursor/hooks/post-analysis-action.sh .cursor/hooks/post-analysis-action.sh
chmod +x .cursor/hooks/post-analysis-action.sh

# Agent-requested rule
mkdir -p .cursor/rules
cp alive-analysis/platforms/cursor/rules/alive-analysis.mdc .cursor/rules/
```

> **Important**: Claude Code and Cursor have different SKILL.md versions (full vs slim) and different command files (conversational vs batch). Use the files from the correct `platforms/` subdirectory. The automated installer handles this automatically.

### Initialize

Open your project in Claude Code or Cursor, then type in the **agent chat** (not the terminal):

```
/analysis-init            # Full setup
/analysis-init --quick    # Quick setup (3 questions)
```

### Option 3: Plugin install (coming soon)

> Plugin publishing is not yet available. Use the automated installer above.

```bash
# Coming soon
claude plugin install alive-analysis
```

## Verify Installation

Type `/analysis-status` in the agent chat — you should see the status dashboard.

## Uninstall

### Manual cleanup
```bash
# Remove Claude Code plugin files (keeps your analysis data)
rm -rf .claude/commands/analysis-*.md
rm -rf .claude/commands/experiment-*.md
rm -rf .claude/commands/monitor-*.md
rm -rf .claude/commands/model-*.md
rm -rf .claude/skills/alive-analysis/
rm .claude/hooks/session-start.sh
rm .claude/hooks/post-analysis-action.sh
# Edit .claude/hooks.json to remove the alive-analysis hook entries

# Remove Cursor plugin files (if installed)
rm -rf .cursor/commands/analysis-*.md
rm -rf .cursor/commands/experiment-*.md
rm -rf .cursor/commands/monitor-*.md
rm -rf .cursor/commands/model-*.md
rm -rf .cursor/skills/alive-analysis/
rm .cursor/hooks/post-analysis-action.sh
rm .cursor/rules/alive-analysis.mdc
# Edit .cursor/hooks.json to remove the alive-analysis hook entries

# Remove analysis data (irreversible!)
# rm -rf .analysis/ analyses/ ab-tests/
```

## Updating

Pull the latest version and re-run the installer:
```bash
cd /tmp/alive-analysis && git pull
bash /tmp/alive-analysis/install.sh
```
