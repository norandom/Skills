#!/usr/bin/env bash
# Rebuild .skill bundles and .mcpb bundles from source.
#
# usage:
#   ./build.sh                # all skills + all mcp bundles (default)
#   ./build.sh skill <name>   # one skill -> <name>/<name>.skill
#   ./build.sh mcpb  <name>   # one mcp   -> mcp_servers/<name>.mcpb
#   ./build.sh marketplace [ref]          # plugin packages + catalogs
#   ./build.sh marketplace-manifests      # plugin packages only
#   ./build.sh marketplace-release <tag>  # post-release catalog refs only
set -euo pipefail

. "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

case "${1:-all}" in
  all)
    lib_require zip
    echo "building skills:"
    while read -r s; do [ -n "$s" ] && lib_build_skill "$s"; done < <(lib_list_skills)
    echo "building mcp bundles:"
    while read -r m; do [ -n "$m" ] && lib_build_mcpb  "$m"; done < <(lib_list_mcpbs)
    ;;
  skill)
    [ $# -ge 2 ] || { echo "usage: $0 skill <name>" >&2; exit 2; }
    lib_require zip
    lib_build_skill "$2"
    ;;
  mcpb)
    [ $# -ge 2 ] || { echo "usage: $0 mcpb <name>" >&2; exit 2; }
    lib_require zip
    lib_build_mcpb "$2"
    ;;
  marketplace) lib_generate_marketplace "${2:-main}" ;;
  marketplace-manifests) lib_generate_plugin_packages ;;
  marketplace-release)
    [ $# -ge 2 ] || { echo "usage: $0 marketplace-release <tag>" >&2; exit 2; }
    lib_update_marketplace_release "$2"
    ;;
  -h|--help|help) sed -n '2,11p' "$0" ;;
  *) echo "unknown command: ${1:-}" >&2; sed -n '2,11p' "$0" >&2; exit 2 ;;
esac
