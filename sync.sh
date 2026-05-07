#!/usr/bin/env bash
# sync.sh — pull latest upstream versions of every skill in manifest.json
# and install them into ~/.claude/skills/
#
# Usage:
#   ./sync.sh              # full sync
#   ./sync.sh --check      # dry-run, show what would change without writing
#   ./sync.sh --skill X    # sync just skill X
#
# Exit codes:
#   0  success
#   1  manifest missing or invalid
#   2  partial failure (some skills failed)
#   3  network / clone error

set -euo pipefail

JSTACK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$JSTACK_DIR/manifest.json"
TARGET="${JSTACK_TARGET:-$HOME/.claude/skills}"
TMP="$(mktemp -d -t jstack-sync.XXXXXX)"
trap 'rm -rf "$TMP"' EXIT

DRY_RUN=0
ONLY_SKILL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check|--dry-run) DRY_RUN=1; shift ;;
    --skill) ONLY_SKILL="$2"; shift 2 ;;
    -h|--help)
      sed -n '2,/^$/p' "$0" | sed 's/^# \?//'
      exit 0
      ;;
    *) echo "Unknown flag: $1" >&2; exit 1 ;;
  esac
done

if [[ ! -f "$MANIFEST" ]]; then
  echo "❌ manifest.json not found at $MANIFEST" >&2
  exit 1
fi

mkdir -p "$TARGET"

echo "🔄 jstack sync — $(date '+%Y-%m-%d %H:%M:%S')"
echo "   manifest: $MANIFEST"
echo "   target:   $TARGET"
[[ $DRY_RUN -eq 1 ]] && echo "   mode:     DRY-RUN (no files will change)"
[[ -n "$ONLY_SKILL" ]] && echo "   filter:   skill=$ONLY_SKILL"
echo

# Collect unique upstreams
UPSTREAMS=$(python3 -c "
import json
with open('$MANIFEST') as f: data = json.load(f)
upstreams = set()
filter_skill = '$ONLY_SKILL'
for skill, meta in data['skills'].items():
    if filter_skill and skill != filter_skill: continue
    if meta.get('source') != 'self':
        upstreams.add(meta['upstream'])
for u in sorted(upstreams):
    print(u)
")

if [[ -z "$UPSTREAMS" ]] && [[ -z "$ONLY_SKILL" ]]; then
  echo "⚠️  No upstreams in manifest." >&2
fi

# Clone each upstream once
for upstream in $UPSTREAMS; do
  safe_name=$(echo "$upstream" | tr '/' '_')
  printf "📦 cloning %-60s" "$upstream..."
  if git clone --depth 1 --quiet "https://github.com/$upstream.git" "$TMP/$safe_name" 2>/dev/null; then
    sha=$(cd "$TMP/$safe_name" && git rev-parse --short HEAD)
    echo " @${sha}"
  else
    echo " ❌ FAILED"
    exit 3
  fi
done

echo
echo "📂 syncing skills..."
echo

INSTALLED=0
UPDATED=0
UNCHANGED=0
SKIPPED=0
FAILED=0

while IFS='|' read -r skill upstream src_path; do
  [[ -n "$ONLY_SKILL" ]] && [[ "$skill" != "$ONLY_SKILL" ]] && continue

  if [[ "$src_path" == "self" ]]; then
    src="$JSTACK_DIR/skills/$skill"
  else
    safe_name=$(echo "$upstream" | tr '/' '_')
    src="$TMP/$safe_name/$src_path"
  fi

  if [[ ! -d "$src" ]]; then
    printf "  ⚠️  %-30s source missing: %s\n" "$skill" "$src"
    FAILED=$((FAILED+1))
    continue
  fi

  dest="$TARGET/$skill"
  if [[ -d "$dest" ]] && [[ -f "$dest/SKILL.md" ]] && [[ -f "$src/SKILL.md" ]]; then
    old_hash=$(shasum -a 256 "$dest/SKILL.md" | awk '{print $1}')
    new_hash=$(shasum -a 256 "$src/SKILL.md" | awk '{print $1}')
    if [[ "$old_hash" == "$new_hash" ]]; then
      printf "  ✓ %-30s unchanged\n" "$skill"
      UNCHANGED=$((UNCHANGED+1))
      continue
    fi
    if [[ $DRY_RUN -eq 1 ]]; then
      printf "  ↻ %-30s WOULD update\n" "$skill"
    else
      rm -rf "$dest"
      cp -r "$src" "$dest"
      printf "  ↻ %-30s updated\n" "$skill"
    fi
    UPDATED=$((UPDATED+1))
  else
    if [[ $DRY_RUN -eq 1 ]]; then
      printf "  + %-30s WOULD install\n" "$skill"
    else
      cp -r "$src" "$dest"
      printf "  + %-30s installed\n" "$skill"
    fi
    INSTALLED=$((INSTALLED+1))
  fi
done < <(python3 -c "
import json
with open('$MANIFEST') as f: data = json.load(f)
for skill, meta in data['skills'].items():
    print(f\"{skill}|{meta.get('upstream', '')}|{meta.get('source', '')}\")
")

echo
echo "✅ done — installed: $INSTALLED · updated: $UPDATED · unchanged: $UNCHANGED · skipped: $SKIPPED · failed: $FAILED"
[[ $FAILED -gt 0 ]] && exit 2
exit 0
