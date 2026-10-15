#!/usr/bin/env bash
# Copies the Claude Code setup (template/) into a Unity project.
# Usage: ./install.sh /path/to/UnityProject [--force]
set -euo pipefail

target="${1:?Usage: ./install.sh /path/to/UnityProject [--force]}"
force="${2:-}"
src="$(cd "$(dirname "$0")" && pwd)/template"
target="$(cd "$target" && pwd)"

[[ -d "$target/Assets" && -d "$target/ProjectSettings" ]] \
  || { echo "Not a Unity project (missing Assets/ or ProjectSettings/): $target" >&2; exit 1; }

copied=0; skipped=()
while IFS= read -r -d '' f; do
  rel="${f#"$src"/}"
  dst="$target/$rel"
  if [[ -e "$dst" && "$force" != "--force" ]]; then skipped+=("$rel"); continue; fi
  mkdir -p "$(dirname "$dst")"
  cp "$f" "$dst"
  copied=$((copied + 1))
done < <(find "$src" -type f -print0)

# Ignore dump/ contents (except its README) and personal settings
gi="$target/.gitignore"
add=()
for p in '/dump/*' '!/dump/README.md' .claude/settings.local.json CLAUDE.local.md; do
  grep -qF -- "$p" "$gi" 2>/dev/null || add+=("$p")
done
if (( ${#add[@]} )); then printf '\n# Claude Code\n'; printf '%s\n' "${add[@]}"; fi >> "$gi"

echo "Copied $copied file(s) -> $target"
if (( ${#skipped[@]} )); then
  echo "Skipped (already exists; use --force to overwrite):"
  printf '  %s\n' "${skipped[@]}"
fi
echo
echo "Next: run the setup-unity-project skill in this project (or type /setup-unity-project in Claude Code)"
