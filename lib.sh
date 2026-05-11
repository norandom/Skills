#!/usr/bin/env bash
# lib.sh — shared helpers for build.sh and install.sh.
# Source this file; do not execute it directly.
#
# State knobs (set in the caller before invoking helpers):
#   LIB_DRY_RUN=1   print actions, don't run them
#   LIB_FORCE=1     replace existing symlinks/files when linking

LIB_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DRY_RUN="${LIB_DRY_RUN:-0}"
LIB_FORCE="${LIB_FORCE:-0}"

lib_require() {
  command -v "$1" >/dev/null || { echo "missing dependency: $1" >&2; exit 1; }
}

lib_run() {
  if [ "$LIB_DRY_RUN" -eq 1 ]; then
    printf 'DRY: %s\n' "$*"
  else
    "$@"
  fi
}

# Skills: top-level dirs containing a SKILL.md.
lib_list_skills() {
  local d
  for d in "$LIB_ROOT"/*/; do
    [ -f "${d}SKILL.md" ] || continue
    basename "$d"
  done
}

# MCP bundles: subdirs of mcp_servers/ containing a manifest.json.
lib_list_mcpbs() {
  local d
  [ -d "$LIB_ROOT/mcp_servers" ] || return 0
  for d in "$LIB_ROOT/mcp_servers"/*/; do
    [ -f "${d}manifest.json" ] || continue
    basename "$d"
  done
}

# <skill>/ -> <skill>/<skill>.skill   (zip rooted at <skill>/)
lib_build_skill() {
  local name="$1"
  local src="$LIB_ROOT/$name"
  local out="$src/$name.skill"
  [ -d "$src" ]            || { echo "no such skill: $name"        >&2; return 1; }
  [ -f "$src/SKILL.md" ]   || { echo "$name/ missing SKILL.md"     >&2; return 1; }

  local tmp; tmp="$(mktemp -t "${name}.skill.XXXXXX")"; rm -f "$tmp"
  ( cd "$LIB_ROOT" && zip -rq "$tmp" "$name" \
      -x "$name/$name.skill" \
      -x "$name/.DS_Store" \
      -x "$name/**/.DS_Store" )
  mv "$tmp" "$out"
  printf '  skill  %-24s -> %s\n' "$name" "${out#$LIB_ROOT/}"
}

# mcp_servers/<name>/ -> mcp_servers/<name>.mcpb   (zip rooted inside <name>/)
lib_build_mcpb() {
  local name="$1"
  local src="$LIB_ROOT/mcp_servers/$name"
  local out="$LIB_ROOT/mcp_servers/$name.mcpb"
  [ -d "$src" ]               || { echo "no such mcp server: $name"   >&2; return 1; }
  [ -f "$src/manifest.json" ] || { echo "$name/ missing manifest.json" >&2; return 1; }

  local tmp; tmp="$(mktemp -t "${name}.mcpb.XXXXXX")"; rm -f "$tmp"
  ( cd "$src" && zip -rq "$tmp" . \
      -x ".DS_Store" \
      -x "**/.DS_Store" \
      -x "node_modules/*" )
  mv "$tmp" "$out"
  printf '  mcpb   %-24s -> %s\n' "$name" "${out#$LIB_ROOT/}"
}

# Per-OS parent dir for Claude Desktop. Empty when unsupported.
lib_claude_desktop_dir() {
  case "$(uname -s)" in
    Darwin)               echo "$HOME/Library/Application Support/Claude" ;;
    Linux)                echo "$HOME/.config/Claude" ;;
    MINGW*|MSYS*|CYGWIN*) echo "${APPDATA:-$HOME/AppData/Roaming}/Claude" ;;
    *)                    echo "" ;;
  esac
}

# Symlink every skill folder into <parent>/skills/.
# Honors LIB_DRY_RUN and LIB_FORCE.
lib_link_target() {
  local label="$1" parent="$2"
  if [ -z "$parent" ]; then
    printf 'skip   %-16s  (no path for this platform)\n' "$label"; return 0
  fi
  if [ ! -d "$parent" ]; then
    printf 'skip   %-16s  (parent missing: %s)\n' "$label" "$parent"; return 0
  fi

  local dst_dir="$parent/skills"
  [ -d "$dst_dir" ] || lib_run mkdir -p "$dst_dir"
  printf 'link   %-16s  -> %s\n' "$label" "$dst_dir"

  local name link target cur
  while read -r name; do
    [ -n "$name" ] || continue
    link="$dst_dir/$name"; target="$LIB_ROOT/$name"

    if [ -L "$link" ]; then
      cur="$(readlink "$link")"
      if [ "$cur" = "$target" ]; then
        printf '         = %s (already linked)\n' "$name"; continue
      fi
      if [ "$LIB_FORCE" -eq 1 ]; then
        lib_run rm "$link"
      else
        printf '         ! %s (exists -> %s; --force to replace)\n' "$name" "$cur" >&2
        continue
      fi
    elif [ -e "$link" ]; then
      if [ "$LIB_FORCE" -eq 1 ]; then
        lib_run rm -rf "$link"
      else
        printf '         ! %s (exists, not a symlink; --force to replace)\n' "$name" >&2
        continue
      fi
    fi

    lib_run ln -s "$target" "$link"
    printf '         + %s\n' "$name"
  done < <(lib_list_skills)
}

# Remove repo-managed symlinks from <parent>/skills/. Leaves other files alone.
lib_unlink_target() {
  local label="$1" parent="$2"
  if [ -z "$parent" ] || [ ! -d "$parent/skills" ]; then
    printf 'skip   %-16s  (nothing installed)\n' "$label"; return 0
  fi
  local dst_dir="$parent/skills"
  printf 'uninst %-16s  -> %s\n' "$label" "$dst_dir"
  local name link
  while read -r name; do
    [ -n "$name" ] || continue
    link="$dst_dir/$name"
    if [ -L "$link" ]; then
      lib_run rm "$link"
      printf '         - %s\n' "$name"
    fi
  done < <(lib_list_skills)
}
