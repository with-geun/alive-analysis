#!/bin/bash
# alive-analysis session start hook
# Displays welcome message and current analysis/experiment/monitor status

if [ -f ".analysis/config.md" ]; then
    # Count active analyses
    ANALYSIS_COUNT=0
    if [ -d "analyses/active" ]; then
        FULL_COUNT=$(find analyses/active -maxdepth 1 \( -type d -name "F-*" -o -type d -name "S-*" \) 2>/dev/null | wc -l | tr -d ' ')
        QUICK_COUNT=$(find analyses/active -maxdepth 1 -type f -name "quick_*" 2>/dev/null | wc -l | tr -d ' ')
        ANALYSIS_COUNT=$((FULL_COUNT + QUICK_COUNT))
    fi

    # Count active experiments
    EXP_COUNT=0
    if [ -d "ab-tests/active" ]; then
        FULL_EXP=$(find ab-tests/active -maxdepth 1 -type d -name "E-*" 2>/dev/null | wc -l | tr -d ' ')
        QUICK_EXP=$(find ab-tests/active -maxdepth 1 -type f -name "quick_*" 2>/dev/null | wc -l | tr -d ' ')
        EXP_COUNT=$((FULL_EXP + QUICK_EXP))
    fi

    # Count monitors
    MON_COUNT=0
    if [ -d ".analysis/metrics/monitors" ]; then
        MON_COUNT=$(find .analysis/metrics/monitors -maxdepth 1 -type f -name "M-*" 2>/dev/null | wc -l | tr -d ' ')
    fi

    # Build status line
    STATUS="alive-analysis | Analyses: ${ANALYSIS_COUNT}"
    if [ "$EXP_COUNT" -gt 0 ]; then
        STATUS="${STATUS} | Experiments: ${EXP_COUNT}"
    fi
    if [ "$MON_COUNT" -gt 0 ]; then
        STATUS="${STATUS} | Monitors: ${MON_COUNT}"
    fi
    STATUS="${STATUS} | /analysis-status for details"

    echo "$STATUS"
else
    echo "alive-analysis | Not initialized | Run /analysis-init to get started"
fi
