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
- Copy commands, skills, and hooks to your `.claude/` directory
- Auto-detect `.cursor/` and install for Cursor as well (if present)
- Safely merge with existing `hooks.json` if present

**Installer flags:**
- `bash install.sh` — Install for Claude Code (+ Cursor if `.cursor/` exists)
- `bash install.sh --cursor` — Also install for Cursor explicitly
- `bash install.sh --both` — Install for both Claude Code and Cursor

### Option 2: Manual copy

1. Clone this repository:
```bash
git clone https://github.com/with-geun/alive-analysis.git
```

2. Copy the plugin files to your Claude Code configuration:
```bash
# Commands
mkdir -p .claude/commands
cp alive-analysis/commands/*.md .claude/commands/

# Skills
mkdir -p .claude/skills/alive-analysis
cp alive-analysis/skills/alive-analysis/SKILL.md .claude/skills/alive-analysis/

# References
mkdir -p .claude/skills/alive-analysis/references
cp alive-analysis/references/*.md .claude/skills/alive-analysis/references/

# Hooks
mkdir -p .claude/hooks
cp alive-analysis/hooks/hooks.json .claude/hooks.json
cp alive-analysis/hooks/session-start.sh .claude/hooks/session-start.sh
cp alive-analysis/hooks/post-analysis-action.sh .claude/hooks/post-analysis-action.sh
chmod +x .claude/hooks/session-start.sh .claude/hooks/post-analysis-action.sh
```

3. Initialize in your project:
```
/analysis init
```

For a quick setup with minimal questions:
```
/analysis init --quick
```

### Cursor Setup

If you use Cursor 2.4+, copy the same files to `.cursor/` instead of (or in addition to) `.claude/`:

```bash
# Skills (same SKILL.md format)
mkdir -p .cursor/skills/alive-analysis
cp alive-analysis/skills/alive-analysis/SKILL.md .cursor/skills/alive-analysis/

# References
mkdir -p .cursor/skills/alive-analysis/references
cp alive-analysis/references/*.md .cursor/skills/alive-analysis/references/

# Commands (same format)
mkdir -p .cursor/commands
cp alive-analysis/commands/*.md .cursor/commands/

# Hooks (Cursor uses a different hooks.json format)
mkdir -p .cursor/hooks
cp alive-analysis/hooks/hooks-cursor.json .cursor/hooks.json
cp alive-analysis/hooks/session-start.sh .cursor/hooks/session-start.sh
cp alive-analysis/hooks/post-analysis-action.sh .cursor/hooks/post-analysis-action.sh
chmod +x .cursor/hooks/session-start.sh .cursor/hooks/post-analysis-action.sh
```

> **Important**: Claude Code and Cursor use different `hooks.json` formats. Use `hooks/hooks.json` for Claude Code and `hooks/hooks-cursor.json` for Cursor. The automated installer handles this automatically.

### Option 3: Plugin install (coming soon)

> Plugin publishing is not yet available. Use the automated installer above.

```bash
# Coming soon
claude plugin install alive-analysis
```

## Verify Installation

Run `/analysis status` — you should see the status dashboard.

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
rm .cursor/hooks/session-start.sh
rm .cursor/hooks/post-analysis-action.sh
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
