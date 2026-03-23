#!/usr/bin/env bash
# alive-analysis Dashboard Export
# Scans analyses/ folder and generates JSON for the ALIVE Dashboard.
#
# Usage:
#   bash dashboard/export.sh                    # outputs to stdout
#   bash dashboard/export.sh > export.json      # save to file
#   bash dashboard/export.sh analyses "My Team" > export.json
#
# Arguments:
#   $1  analyses directory (default: analyses)
#   $2  team name (default: reads from .analysis/config.md or "My Team")
#
# Per-analysis optional metadata (add meta.yml to each analysis folder):
#   analyst: geun
#   tags: [checkout, conversion]
#   followups: [F-2026-0304-001]
#   keyFinding: "one-liner insight"

set -euo pipefail

ANALYSES_DIR="${1:-analyses}"
DATE=$(date +%Y-%m-%d)

# Try to read team name from config
TEAM="My Team"
if [ -f ".analysis/config.md" ]; then
  t=$(grep -m1 -i "team\b" .analysis/config.md | grep -oP '(?<=: ).*' | tr -d '"' || true)
  [ -n "$t" ] && TEAM="$t"
fi
TEAM="${2:-$TEAM}"

# ─── helpers ──────────────────────────────────────────────────────────────────

json_str() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

stage_name() {
  case "$1" in
    1) echo "ASK" ;; 2) echo "LOOK" ;; 3) echo "INVESTIGATE" ;;
    4) echo "VOICE" ;; 5) echo "EVOLVE" ;; *) echo "ASK" ;;
  esac
}

parse_type() {
  echo "$1" | grep -oE 'Investigation|Experiment|Simulation|Learn' | head -1
}

parse_meta_field() {
  local file="$1" field="$2"
  grep -m1 -i "^${field}:" "$file" 2>/dev/null | sed "s/^${field}://I" | xargs || true
}

parse_tags_array() {
  local raw
  raw=$(grep -m1 -i '^tags:' "$1" 2>/dev/null | sed 's/^tags://I' | xargs || true)
  # handles: [checkout, conversion]  or  checkout, conversion
  raw=$(echo "$raw" | tr -d '[]')
  local result=""
  IFS=',' read -ra parts <<< "$raw"
  for p in "${parts[@]}"; do
    t=$(echo "$p" | xargs)
    [ -z "$t" ] && continue
    [ -n "$result" ] && result+=","
    result+="\"$t\""
  done
  echo "[$result]"
}

parse_followups_array() {
  local raw
  raw=$(grep -m1 -i '^followups:' "$1" 2>/dev/null | sed 's/^followups://I' | xargs || true)
  raw=$(echo "$raw" | tr -d '[]')
  local result=""
  IFS=',' read -ra parts <<< "$raw"
  for p in "${parts[@]}"; do
    t=$(echo "$p" | xargs)
    [ -z "$t" ] && continue
    [ -n "$result" ] && result+=","
    result+="\"$t\""
  done
  echo "[$result]"
}

# ─── collect analyses ──────────────────────────────────────────────────────────

entries=()

process_folder() {
  local dir="$1" status="$2"
  local folder id first_file title type_raw type mode stage_idx stage
  local created updated analyst tags followups key_finding

  folder=$(basename "$dir")

  # Extract ID: prefix letter + date + seq (e.g. F-2026-0303-001, Q-..., E-..., S-..., L-...)
  id=$(echo "$folder" | grep -oE '^[FQESLfqesl]-[0-9]{4}-[0-9]{4}-[0-9]+' | tr '[:lower:]' '[:upper:]' || true)
  [ -z "$id" ] && return

  # Find first stage file
  first_file=$(ls "$dir"01_ask.md "$dir"01_*.md 2>/dev/null | head -1 || ls "$dir"*.md 2>/dev/null | sort | head -1 || true)
  [ -z "$first_file" ] && return

  # Title: strip stage prefix from heading "# ASK — My Title"
  title=$(grep -m1 '^# ' "$first_file" | sed 's/^# [A-Z]* — //' | sed 's/^# //' || true)
  [ -z "$title" ] && title="$folder"

  # Type
  type_raw=$(grep -m1 '> Type:' "$first_file" || grep -m1 '^type:' "$first_file" || true)
  type=$(parse_type "$type_raw")
  [ -z "$type" ] && type="Investigation"

  # Stage: count 01–05 stage files
  stage_idx=$(ls "$dir"0[1-5]_*.md 2>/dev/null | wc -l | tr -d ' ' || echo 1)
  [ "$stage_idx" -lt 1 ] && stage_idx=1
  [ "$stage_idx" -gt 5 ] && stage_idx=5
  stage=$(stage_name "$stage_idx")

  # Dates
  created=$(grep -m1 '> Created:' "$first_file" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' || true)
  [ -z "$created" ] && created="$DATE"
  last_file=$(ls "$dir"0[1-5]_*.md 2>/dev/null | sort | tail -1 || echo "$first_file")
  updated=$(grep -m1 '> Created:\|> Updated:' "$last_file" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | tail -1 || true)
  [ -z "$updated" ] && updated="$created"

  # Mode: Full (folder) unless folder name starts with "quick_"
  mode="Full"
  [[ "$folder" == quick_* ]] && mode="Quick"

  # Optional: meta.yml per analysis
  meta_file="$dir/meta.yml"
  analyst=""
  tags="[]"
  followups="[]"
  key_finding="null"

  if [ -f "$meta_file" ]; then
    a=$(parse_meta_field "$meta_file" "analyst"); [ -n "$a" ] && analyst="$a"
    tags=$(parse_tags_array "$meta_file")
    followups=$(parse_followups_array "$meta_file")
    kf=$(parse_meta_field "$meta_file" "keyFinding"); [ -n "$kf" ] && key_finding="\"$(json_str "$kf")\""
  fi

  entries+=("{\"id\":\"$(json_str "$id")\",\"title\":\"$(json_str "$title")\",\"type\":\"$type\",\"mode\":\"$mode\",\"stage\":\"$stage\",\"stageIndex\":$stage_idx,\"created\":\"$created\",\"updated\":\"$updated\",\"status\":\"$status\",\"analyst\":\"$(json_str "$analyst")\",\"followups\":$followups,\"tags\":$tags,\"keyFinding\":$key_finding}")
}

# Active analyses
if [ -d "$ANALYSES_DIR/active" ]; then
  for dir in "$ANALYSES_DIR"/active/*/; do
    [ -d "$dir" ] && process_folder "$dir" "active"
  done
fi

# Archived analyses
if [ -d "$ANALYSES_DIR/archive" ]; then
  for month_dir in "$ANALYSES_DIR"/archive/*/; do
    [ -d "$month_dir" ] || continue
    for dir in "$month_dir"*/; do
      [ -d "$dir" ] && process_folder "$dir" "archived"
    done
  done
fi

# ─── output JSON ───────────────────────────────────────────────────────────────

echo "{"
echo "  \"team\": \"$(json_str "$TEAM")\","
echo "  \"generated\": \"$DATE\","
echo "  \"analyses\": ["

count=${#entries[@]}
for i in "${!entries[@]}"; do
  if [ $((i + 1)) -lt $count ]; then
    echo "    ${entries[$i]},"
  else
    echo "    ${entries[$i]}"
  fi
done

echo "  ]"
echo "}"
