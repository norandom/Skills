#!/usr/bin/env bash
# Install (or uninstall) the drawio MCP server entry across every tool that
# supports it. Each target uses its own native mechanism: CLI when one
# exists, otherwise a surgical jq/yq edit of the tool's config file.
#
# targets (default --all; only tools whose home dir/CLI exist get touched):
#   --claude     Claude Code        (claude mcp add ...)
#   --gemini     Gemini CLI         (gemini mcp add -s user ...)
#   --codex      Codex CLI          (codex mcp add ...)
#   --hermes     Hermes             (~/.hermes/config.yaml via yq)
#   --opencode   opencode           (~/.config/opencode/opencode.json via jq)
#   --deepseek   DeepSeek TUI       (~/.deepseek/mcp.json via jq)
#   --all        every target above
# flags:
#   --url URL    point at a different drawio MCP endpoint
#   -n, --dry-run    preview without changing anything
#       --uninstall  remove the entry instead of adding it
#   -h, --help       this message
set -euo pipefail

. "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib.sh"

NAME=drawio
URL=https://drawmcp.because-security.com/mcp

claude=0 gemini=0 codex=0 hermes=0 oc=0 ds=0 explicit=0 uninstall=0

while [ $# -gt 0 ]; do
  case "$1" in
    --claude)    claude=1; explicit=1 ;;
    --gemini)    gemini=1; explicit=1 ;;
    --codex)     codex=1;  explicit=1 ;;
    --hermes)    hermes=1; explicit=1 ;;
    --opencode)  oc=1;     explicit=1 ;;
    --deepseek)  ds=1;     explicit=1 ;;
    --all)       claude=1; gemini=1; codex=1; hermes=1; oc=1; ds=1; explicit=1 ;;
    --url)       [ $# -ge 2 ] || { echo "--url needs an argument" >&2; exit 2; }; URL="$2"; shift ;;
    -n|--dry-run) LIB_DRY_RUN=1 ;;
    --uninstall) uninstall=1 ;;
    -h|--help)   sed -n '2,19p' "$0"; exit 0 ;;
    *) echo "unknown flag: $1" >&2; sed -n '2,19p' "$0" >&2; exit 2 ;;
  esac
  shift
done

[ "$explicit" -eq 0 ] && { claude=1; gemini=1; codex=1; hermes=1; oc=1; ds=1; }

ARGS=(-y mcp-remote "$URL")

if [ "$uninstall" -eq 1 ]; then
  [ "$claude" -eq 1 ] && lib_mcp_claude_remove   "$NAME"
  [ "$gemini" -eq 1 ] && lib_mcp_gemini_remove   "$NAME"
  [ "$codex"  -eq 1 ] && lib_mcp_codex_remove    "$NAME"
  [ "$hermes" -eq 1 ] && lib_mcp_hermes_remove   "$NAME"
  [ "$oc"     -eq 1 ] && lib_mcp_opencode_remove "$NAME"
  [ "$ds"     -eq 1 ] && lib_mcp_deepseek_remove "$NAME"
else
  [ "$claude" -eq 1 ] && lib_mcp_claude_add   "$NAME" npx "${ARGS[@]}"
  [ "$gemini" -eq 1 ] && lib_mcp_gemini_add   "$NAME" npx "${ARGS[@]}"
  [ "$codex"  -eq 1 ] && lib_mcp_codex_add    "$NAME" npx "${ARGS[@]}"
  [ "$hermes" -eq 1 ] && lib_mcp_hermes_add   "$NAME" npx "${ARGS[@]}"
  [ "$oc"     -eq 1 ] && lib_mcp_opencode_add "$NAME" npx "${ARGS[@]}"
  [ "$ds"     -eq 1 ] && lib_mcp_deepseek_add "$NAME" npx "${ARGS[@]}"

  # mcp-remote does an OAuth discovery handshake against the remote endpoint
  # that exceeds the short default connect_timeout some clients ship with.
  # Patch the per-server override so first-time `connect` succeeds out of the box.
  if [ "$ds" -eq 1 ] && command -v jq >/dev/null && [ -f "$HOME/.deepseek/mcp.json" ]; then
    lib__jq_inplace "$HOME/.deepseek/mcp.json" --arg n "$NAME" '.servers[$n].connect_timeout = 60'
    printf 'mcp~   %-10s  %s.connect_timeout = 60\n' deepseek "$NAME"
  fi
  if [ "$hermes" -eq 1 ] && command -v yq >/dev/null && [ -f "$HOME/.hermes/config.yaml" ]; then
    NAME_ENV="$NAME" yq -i '.mcp_servers[strenv(NAME_ENV)].connect_timeout = 30' "$HOME/.hermes/config.yaml"
    printf 'mcp~   %-10s  %s.connect_timeout = 30\n' hermes "$NAME"
  fi
fi
