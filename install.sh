#!/usr/bin/env bash
# Symlink every skill folder into each selected tool's skills/ dir.
#
# targets (default --all; only dirs whose parent exists get touched):
#   --claude          ~/.claude/skills                                (Claude Code)
#   --claude-desktop  ~/Library/Application Support/Claude/skills  (macOS) | ~/.config/Claude/skills | %APPDATA%/Claude/skills
#   --hermes          ~/.hermes/skills
#   --opencode        ~/.config/opencode/skills
#   --deepseek        ~/.deepseek/skills                              (DeepSeek TUI)
#   --all             every target above
# flags:
#   -n, --dry-run     preview without changing anything
#   -f, --force       replace existing entries at the destination
#       --uninstall   remove symlinks instead of creating them
#   -h, --help        this message
set -euo pipefail

. "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

claude=0 cd_=0 hermes=0 oc=0 ds=0 explicit=0 uninstall=0

while [ $# -gt 0 ]; do
  case "$1" in
    --claude)         claude=1; explicit=1 ;;
    --claude-desktop) cd_=1;    explicit=1 ;;
    --hermes)         hermes=1; explicit=1 ;;
    --opencode)       oc=1;     explicit=1 ;;
    --deepseek)       ds=1;     explicit=1 ;;
    --all)            claude=1; cd_=1; hermes=1; oc=1; ds=1; explicit=1 ;;
    -n|--dry-run)     LIB_DRY_RUN=1 ;;
    -f|--force)       LIB_FORCE=1 ;;
    --uninstall)      uninstall=1 ;;
    -h|--help)        sed -n '2,17p' "$0"; exit 0 ;;
    *) echo "unknown flag: $1" >&2; sed -n '2,17p' "$0" >&2; exit 2 ;;
  esac
  shift
done

[ "$explicit" -eq 0 ] && { claude=1; cd_=1; hermes=1; oc=1; ds=1; }

action=lib_link_target
[ "$uninstall" -eq 1 ] && action=lib_unlink_target

[ "$claude" -eq 1 ] && $action "claude"         "$HOME/.claude"
[ "$cd_"    -eq 1 ] && $action "claude-desktop" "$(lib_claude_desktop_dir)"
[ "$hermes" -eq 1 ] && $action "hermes"         "$HOME/.hermes"
[ "$oc"     -eq 1 ] && $action "opencode"       "$HOME/.config/opencode"
[ "$ds"     -eq 1 ] && $action "deepseek"       "$HOME/.deepseek"
