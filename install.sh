#!/bin/bash
# alive-analysis installer
# Copies platform-specific files from platforms/ and shared references from core/
# Safe to re-run (idempotent) — merges hooks.json instead of overwriting

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "=== alive-analysis installer ==="
echo ""

# 0. Validate environment
# Prevent running from inside the alive-analysis repo itself
if [ -f "$SCRIPT_DIR/platforms/claude-code/SKILL.md" ] && [ "$(cd "$SCRIPT_DIR" && pwd)" = "$(pwd)" ]; then
    echo -e "${RED}Error: You're inside the alive-analysis repository.${NC}"
    echo ""
    echo "Run this installer from your PROJECT directory instead:"
    echo "  cd /path/to/your-project"
    echo "  bash /path/to/alive-analysis/install.sh"
    echo ""
    echo "Or clone and install in one step:"
    echo "  git clone https://github.com/with-geun/alive-analysis.git /tmp/alive-analysis"
    echo "  bash /tmp/alive-analysis/install.sh"
    exit 1
fi

# Check that source files exist (new structure)
if [ ! -f "$SCRIPT_DIR/platforms/claude-code/SKILL.md" ]; then
    echo -e "${RED}Error: Cannot find alive-analysis source files at $SCRIPT_DIR${NC}"
    echo "Make sure you're running the install.sh from the alive-analysis repository."
    exit 1
fi

# Parse arguments
INSTALL_CLAUDE=true
INSTALL_CURSOR=false
CURSOR_ONLY=false
for arg in "$@"; do
    case "$arg" in
        --cursor)
            INSTALL_CURSOR=true
            INSTALL_CLAUDE=false
            CURSOR_ONLY=true
            ;;
        --claude)
            INSTALL_CLAUDE=true
            INSTALL_CURSOR=false
            ;;
        --both)
            INSTALL_CLAUDE=true
            INSTALL_CURSOR=true
            ;;
    esac
done

# Auto-detect Cursor if .cursor/ directory exists and not explicitly --claude only
if [ -d ".cursor" ] && [ "$CURSOR_ONLY" = false ] && [ "$INSTALL_CURSOR" = false ]; then
    echo -e "${BLUE}Detected .cursor/ directory. Installing for Cursor as well.${NC}"
    echo "  (Use --claude for Claude Code only, --cursor for Cursor only, or --both explicitly)"
    INSTALL_CURSOR=true
fi

# ============================
# Shared merge function
# ============================
merge_hooks_json() {
    local TARGET_DIR="$1"
    local SOURCE_FILE="$2"

    # Try python3 first, then jq, then manual instructions
    if command -v python3 &>/dev/null; then
        python3 -c "
import json, sys
try:
    with open('${TARGET_DIR}/hooks.json', 'r') as f:
        existing = json.load(f)
    with open('${SOURCE_FILE}', 'r') as f:
        new_hooks = json.load(f)
    # Handle both Claude Code format (array) and Cursor format (object)
    if isinstance(existing.get('hooks'), list):
        existing['hooks'].extend(new_hooks.get('hooks', []))
    elif isinstance(existing.get('hooks'), dict):
        for key, val in new_hooks.get('hooks', {}).items():
            if key in existing['hooks']:
                existing['hooks'][key].extend(val)
            else:
                existing['hooks'][key] = val
    else:
        existing['hooks'] = new_hooks.get('hooks', [])
    with open('${TARGET_DIR}/hooks.json', 'w') as f:
        json.dump(existing, f, indent=2)
        f.write('\n')
    print('  Merged alive-analysis hooks into existing hooks.json')
except json.JSONDecodeError:
    import shutil
    shutil.copy('${TARGET_DIR}/hooks.json', '${TARGET_DIR}/hooks.json.backup')
    with open('${SOURCE_FILE}', 'r') as f:
        new_hooks = json.load(f)
    with open('${TARGET_DIR}/hooks.json', 'w') as f:
        json.dump(new_hooks, f, indent=2)
        f.write('\n')
    print('  Warning: existing hooks.json was malformed. Backed up to hooks.json.backup and replaced.')
except Exception as e:
    print(f'  Warning: Could not merge hooks.json: {e}', file=sys.stderr)
    sys.exit(1)
"
    elif command -v jq &>/dev/null; then
        MERGED=$(jq -s '.[0].hooks += .[1].hooks | .[0]' "${TARGET_DIR}/hooks.json" "${SOURCE_FILE}" 2>/dev/null)
        if [ $? -eq 0 ] && [ -n "$MERGED" ]; then
            echo "$MERGED" > "${TARGET_DIR}/hooks.json"
            echo "  Merged alive-analysis hooks into existing hooks.json (via jq)"
        else
            echo -e "  ${YELLOW}Warning: Could not merge hooks.json with jq.${NC}"
            return 1
        fi
    else
        return 1
    fi
}

# ============================
# Install for Claude Code
# ============================
if [ "$INSTALL_CLAUDE" = true ]; then
    echo "--- Claude Code ---"

    PLATFORM_DIR="$SCRIPT_DIR/platforms/claude-code"

    # 1. Create .claude directories if they don't exist
    echo "Creating .claude directories..."
    mkdir -p .claude/commands
    mkdir -p .claude/skills/alive-analysis
    mkdir -p .claude/hooks

    # 2. Copy commands
    echo "Copying commands..."
    if ls "$PLATFORM_DIR"/commands/*.md 1>/dev/null 2>&1; then
        cp -r "$PLATFORM_DIR"/commands/*.md .claude/commands/
        echo -e "  ${GREEN}Commands copied${NC}"
    else
        echo -e "  ${YELLOW}No command files found — skipping${NC}"
    fi

    # 3. Copy skills
    echo "Copying skills..."
    cp "$PLATFORM_DIR"/SKILL.md .claude/skills/alive-analysis/
    echo -e "  ${GREEN}Skills copied${NC}"

    # 4. Copy hook scripts
    echo "Copying hook scripts..."
    cp "$PLATFORM_DIR"/hooks/session-start.sh .claude/hooks/
    cp "$PLATFORM_DIR"/hooks/post-analysis-action.sh .claude/hooks/
    chmod +x .claude/hooks/session-start.sh
    chmod +x .claude/hooks/post-analysis-action.sh
    echo -e "  ${GREEN}Hook scripts copied${NC}"

    # 5. Handle hooks.json (merge, not overwrite)
    echo "Configuring hooks.json..."
    if [ -f .claude/hooks.json ]; then
        if grep -q "session-start.sh" .claude/hooks.json 2>/dev/null; then
            echo -e "  ${YELLOW}alive-analysis hooks already present in hooks.json — skipping${NC}"
        else
            if ! merge_hooks_json ".claude" "$PLATFORM_DIR/hooks/hooks.json"; then
                echo -e "  ${YELLOW}Warning: Could not auto-merge hooks.json (no python3 or jq found).${NC}"
                echo "  Please manually add the hooks from platforms/claude-code/hooks/hooks.json to .claude/hooks.json"
            fi
        fi
    else
        cp "$PLATFORM_DIR"/hooks/hooks.json .claude/hooks.json
        echo -e "  ${GREEN}hooks.json created${NC}"
    fi

    # 6. Copy core references
    if [ -d "$SCRIPT_DIR/core/references" ]; then
        echo "Copying references..."
        mkdir -p .claude/skills/alive-analysis/core/references
        cp "$SCRIPT_DIR"/core/references/*.md .claude/skills/alive-analysis/core/references/ 2>/dev/null || true
        echo -e "  ${GREEN}References copied${NC}"
    fi

    echo -e "${GREEN}Claude Code setup complete.${NC}"
fi

# ============================
# Install for Cursor
# ============================
if [ "$INSTALL_CURSOR" = true ]; then
    echo ""
    echo "--- Cursor ---"

    PLATFORM_DIR="$SCRIPT_DIR/platforms/cursor"

    # Create .cursor directories
    echo "Creating .cursor directories..."
    mkdir -p .cursor/commands
    mkdir -p .cursor/skills/alive-analysis
    mkdir -p .cursor/hooks
    mkdir -p .cursor/rules

    # Copy commands (Cursor-optimized versions)
    echo "Copying commands..."
    if ls "$PLATFORM_DIR"/commands/*.md 1>/dev/null 2>&1; then
        cp -r "$PLATFORM_DIR"/commands/*.md .cursor/commands/
        echo -e "  ${GREEN}Commands copied (Cursor-optimized)${NC}"
    else
        echo -e "  ${YELLOW}No command files found — skipping${NC}"
    fi

    # Copy skills (Cursor slim SKILL.md)
    echo "Copying skills..."
    cp "$PLATFORM_DIR"/SKILL.md .cursor/skills/alive-analysis/
    echo -e "  ${GREEN}Skills copied (Cursor slim version)${NC}"

    # Copy hook scripts (Cursor has no SessionStart, only post-analysis-action)
    echo "Copying hook scripts..."
    cp "$PLATFORM_DIR"/hooks/post-analysis-action.sh .cursor/hooks/
    chmod +x .cursor/hooks/post-analysis-action.sh
    echo -e "  ${GREEN}Hook scripts copied${NC}"

    # Handle Cursor hooks.json (different format from Claude Code)
    echo "Configuring Cursor hooks.json..."
    if [ -f .cursor/hooks.json ]; then
        if grep -q "post-analysis-action.sh" .cursor/hooks.json 2>/dev/null; then
            echo -e "  ${YELLOW}alive-analysis hooks already present — skipping${NC}"
        else
            if ! merge_hooks_json ".cursor" "$PLATFORM_DIR/hooks/hooks-cursor.json"; then
                echo -e "  ${YELLOW}Warning: Could not auto-merge .cursor/hooks.json.${NC}"
                echo "  Please manually add the hooks from platforms/cursor/hooks/hooks-cursor.json"
            fi
        fi
    else
        cp "$PLATFORM_DIR"/hooks/hooks-cursor.json .cursor/hooks.json
        echo -e "  ${GREEN}hooks.json created (Cursor format)${NC}"
    fi

    # Copy .mdc rule file
    echo "Copying Cursor rules..."
    cp "$PLATFORM_DIR"/rules/alive-analysis.mdc .cursor/rules/
    echo -e "  ${GREEN}Agent rule copied (.cursor/rules/alive-analysis.mdc)${NC}"

    # Copy core references
    if [ -d "$SCRIPT_DIR/core/references" ]; then
        echo "Copying references..."
        mkdir -p .cursor/skills/alive-analysis/core/references
        cp "$SCRIPT_DIR"/core/references/*.md .cursor/skills/alive-analysis/core/references/ 2>/dev/null || true
        echo -e "  ${GREEN}References copied${NC}"
    fi

    echo -e "${GREEN}Cursor setup complete.${NC}"
fi

# ============================
# Done
# ============================
echo ""
echo -e "${GREEN}=== alive-analysis installed successfully ===${NC}"
echo ""
echo "Next steps:"
if [ "$INSTALL_CLAUDE" = true ] && [ "$INSTALL_CURSOR" = true ]; then
    echo "  1. Open your project in Claude Code or Cursor"
elif [ "$INSTALL_CURSOR" = true ]; then
    echo "  1. Open your project in Cursor"
else
    echo "  1. Start Claude Code in your project directory"
fi
echo "  2. Run: /analysis init          (full setup)"
echo "     Or:  /analysis init --quick   (quick setup)"
echo "  3. Run: /analysis new            (start your first analysis)"
echo ""
echo "For more info: see README.md or INSTALL.md"
echo ""
