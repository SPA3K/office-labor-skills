#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
SKILLS_DIR="${CLAUDE_DIR}/skills"
RULES_DIR="${CLAUDE_DIR}/rules/ecc"
TOOLS_DIR="${SCRIPT_DIR}/tools"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[ok]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    local current
    current="$(readlink "$dst")"
    [ "$current" = "$src" ] && return 0
    rm "$dst"
  elif [ -e "$dst" ]; then
    mv "$dst" "${dst}.bak.$(date +%s)"
    warn "Backed up existing $dst"
  fi
  ln -s "$src" "$dst"
}

install_rules() {
  echo ""
  echo "=== Rules ==="
  for category_dir in "$SCRIPT_DIR/rules"/*/; do
    [ -d "$category_dir" ] || continue
    category="$(basename "$category_dir")"
    target_dir="${RULES_DIR}/${category}"
    mkdir -p "$target_dir"
    for rule_file in "$category_dir"*.md; do
      [ -f "$rule_file" ] || continue
      fname="$(basename "$rule_file")"
      link "$rule_file" "${target_dir}/${fname}"
      info "rules/${category}/${fname}"
    done
  done
}

install_skills() {
  echo ""
  echo "=== Skills ==="
  for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    [ "$skill_name" = "_local" ] && continue
    link "$skill_dir" "${SKILLS_DIR}/${skill_name}"
    info "skills/${skill_name}"
  done
}

install_tools() {
  echo ""
  echo "=== Standalone Tools (optional) ==="
  local tools=()
  for t in headroom openclacky codegraph autoresearch; do
    [ -d "$TOOLS_DIR/$t" ] && tools+=("$t")
  done
  for t in "${tools[@]}"; do echo "  - $t"; done
  echo ""
  read -rp "Install standalone tools? [y/N] " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    for tool in "${tools[@]}"; do
      echo "--- $tool ---"
      if [ -f "$TOOLS_DIR/$tool/install.sh" ]; then
        bash "$TOOLS_DIR/$tool/install.sh"
      elif [ "$tool" = "autoresearch" ]; then
        echo "  cd $TOOLS_DIR/autoresearch && uv sync && uv run python prepare.py"
      fi
    done
  fi
}

uninstall() {
  echo "=== Uninstalling symlinks ==="
  for f in "$SKILLS_DIR"/*; do
    [ -L "$f" ] || continue
    [[ "$(readlink -f "$f")" == "$SCRIPT_DIR/skills/"* ]] && rm "$f" && info "Removed $(basename "$f")"
  done
  for f in "$RULES_DIR"/*/*.md; do
    [ -L "$f" ] || continue
    [[ "$(readlink -f "$f")" == "$SCRIPT_DIR/rules/"* ]] && rm "$f" && info "Removed $(basename "$f")"
  done
}

case "${1:-install}" in
  uninstall) uninstall ;;
  install)
    echo "Claude Skills Sync"
    mkdir -p "$SKILLS_DIR" "$RULES_DIR"
    install_rules
    install_skills
    install_tools
    echo ""
    echo "Done. $(ls -d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l) skills linked."
    ;;
  *) echo "Usage: $0 [install|uninstall]"; exit 1 ;;
esac
