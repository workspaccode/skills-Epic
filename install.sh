#!/usr/bin/env bash
set -euo pipefail

REPO="workspaccode/skills-Epic"
BRANCH="${SKILLS_BRANCH:-main}"
RAW_BASE="https://raw.githubusercontent.com/$REPO/$BRANCH"
API_BASE="https://api.github.com/repos/$REPO"

install_banner() {
  echo ""
  echo "  ╔══════════════════════════════════════╗"
  echo "  ║     skills-Epic Installer            ║"
  echo "  ╚══════════════════════════════════════╝"
  echo ""
}

detect_targets() {
  local targets=()
  if [[ -d "$HOME/.config/opencode/skills" ]]; then
    targets+=("$HOME/.config/opencode/skills")
  fi
  if [[ -d "$HOME/.claude/skills" ]]; then
    targets+=("$HOME/.claude/skills")
  fi
  if [[ -d "$HOME/.cursor/agent-skills" ]]; then
    targets+=("$HOME/.cursor/agent-skills")
  fi
  if [[ ${#targets[@]} -eq 0 ]]; then
    targets+=("$HOME/.config/opencode/skills")
  fi
  printf '%s\n' "${targets[@]}"
}

install_skills() {
  local target_dir="$1"
  mkdir -p "$target_dir"

  echo "  → Downloading skills to $target_dir"

  local skills=(
    flutter-anti-tamper
    flutter-arch-selector
    flutter-perf-guardian
    flutter-security-guardian
    flutter-uix-architect
    gh-actions-guardian
    gradle-doctor
    ios-build-doctor
    project-scope-guard
  )

  local count=0
  for skill in "${skills[@]}"; do
    local url="$RAW_BASE/$skill.skill"
    local out="$target_dir/$skill.skill"
    if command -v curl &>/dev/null; then
      if curl -fsSL "$url" -o "$out" 2>/dev/null; then
        count=$((count + 1))
        printf "  [OK]    %s\n" "$skill"
      else
        printf "  [FAIL]  %s\n" "$skill"
      fi
    elif command -v wget &>/dev/null; then
      if wget -q "$url" -O "$out" 2>/dev/null; then
        count=$((count + 1))
        printf "  [OK]    %s\n" "$skill"
      else
        printf "  [FAIL]  %s\n" "$skill"
      fi
    fi
  done

  echo "  Installed $count skills to $target_dir"
}

install_cli() {
  local bin_dir="${1:-/usr/local/bin}"
  mkdir -p "$bin_dir"

  local url="$RAW_BASE/skills"
  local out="$bin_dir/skills"

  echo "  → Installing CLI to $bin_dir/skills"

  if command -v curl &>/dev/null; then
    curl -fsSL "$url" -o "$out"
  elif command -v wget &>/dev/null; then
    wget -q "$url" -O "$out"
  fi

  chmod +x "$out"
  echo "  [OK]    skills CLI -> $bin_dir/skills"
}

main() {
  install_banner

  # Parse flags
  local bin_dir="/usr/local/bin"
  local skip_cli=false
  local explicit_targets=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --target|-t)
        explicit_targets+=("$2")
        shift 2
        ;;
      --bin-dir)
        bin_dir="$2"
        shift 2
        ;;
      --skip-cli)
        skip_cli=true
        shift
        ;;
      --help|-h)
        echo "Usage: curl -fsSL https://raw.githubusercontent.com/$REPO/$BRANCH/install.sh | bash"
        echo ""
        echo "Options (set via env vars):"
        echo "  SKILLS_BRANCH       Branch to install from (default: main)"
        echo ""
        echo "Or download and run:"
        echo "  bash install.sh [--target path] [--bin-dir path] [--skip-cli]"
        exit 0
        ;;
      *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
  done

  # Detect or use explicit targets
  local targets=()
  if [[ ${#explicit_targets[@]} -gt 0 ]]; then
    targets=("${explicit_targets[@]}")
  else
    mapfile -t targets < <(detect_targets)
  fi

  for t in "${targets[@]}"; do
    install_skills "$t"
  done

  if [[ "$skip_cli" == false ]]; then
    install_cli "$bin_dir"
  fi

  echo ""
  echo "  Done! Run 'skills list' to see available skills."
  echo "  Run 'skills install all' to re-install or update."
  echo ""
}

main "$@"
