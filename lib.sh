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

# ---------- MCP server management ----------------------------------------
# Each lib_mcp_<tool>_add / _remove function returns 0 even when it skips, so
# callers can chain across tools that aren't installed without aborting.
#
# Add helpers take: <name> <command> [args...]   (stdio launch line)
# Remove helpers take: <name>

# Echo a JSON array built from the positional args via jq.
lib__args_json() {
  if [ $# -eq 0 ]; then echo '[]'; return; fi
  printf '%s\n' "$@" | jq -R . | jq -s .
}

# Ensure a JSON file exists with a given top-level key as an empty object.
lib__ensure_json() {
  local path="$1" key="$2"
  [ -f "$path" ] && return 0
  lib_run mkdir -p "$(dirname "$path")"
  if [ "$LIB_DRY_RUN" -eq 1 ]; then
    printf 'DRY: create %s with {%s: {}}\n' "$path" "$key"
  else
    jq -n --arg k "$key" '{($k): {}}' > "$path"
  fi
}

# In-place jq edit with safe temp-file write.
lib__jq_inplace() {
  local path="$1"; shift
  if [ "$LIB_DRY_RUN" -eq 1 ]; then
    printf 'DRY: jq %s on %s\n' "$*" "$path"
    return 0
  fi
  local tmp; tmp="$(mktemp)"
  jq "$@" "$path" > "$tmp" && mv "$tmp" "$path"
}

# Claude Code
lib_mcp_claude_add() {
  local name="$1"; shift
  command -v claude >/dev/null || { printf 'skip   %-10s  (claude CLI missing)\n' claude; return 0; }
  printf 'mcp+   %-10s  %s -- %s\n' claude "$name" "$*"
  lib_run claude mcp add "$name" -- "$@"
}
lib_mcp_claude_remove() {
  command -v claude >/dev/null || { printf 'skip   %-10s  (claude CLI missing)\n' claude; return 0; }
  printf 'mcp-   %-10s  %s\n' claude "$1"
  lib_run claude mcp remove "$1"
}

# Gemini CLI  (user scope so it persists outside any project)
lib_mcp_gemini_add() {
  local name="$1"; shift
  command -v gemini >/dev/null || { printf 'skip   %-10s  (gemini CLI missing)\n' gemini; return 0; }
  printf 'mcp+   %-10s  %s %s\n' gemini "$name" "$*"
  lib_run gemini mcp add -s user "$name" "$@"
}
lib_mcp_gemini_remove() {
  command -v gemini >/dev/null || { printf 'skip   %-10s  (gemini CLI missing)\n' gemini; return 0; }
  printf 'mcp-   %-10s  %s\n' gemini "$1"
  lib_run gemini mcp remove "$1"
}

# Codex CLI
lib_mcp_codex_add() {
  local name="$1"; shift
  command -v codex >/dev/null || { printf 'skip   %-10s  (codex CLI missing)\n' codex; return 0; }
  printf 'mcp+   %-10s  %s -- %s\n' codex "$name" "$*"
  lib_run codex mcp add "$name" -- "$@"
}
lib_mcp_codex_remove() {
  command -v codex >/dev/null || { printf 'skip   %-10s  (codex CLI missing)\n' codex; return 0; }
  printf 'mcp-   %-10s  %s\n' codex "$1"
  lib_run codex mcp remove "$1"
}

# DeepSeek TUI — official CLI (writes ~/.deepseek/mcp.json under the hood).
lib_mcp_deepseek_add() {
  local name="$1" cmd="$2"; shift 2
  command -v deepseek >/dev/null || { printf 'skip   %-10s  (deepseek CLI missing)\n' deepseek; return 0; }
  # Use --arg=value form so values starting with '-' (e.g. "-y") aren't parsed as flags.
  local args=() a
  for a in "$@"; do args+=("--arg=$a"); done
  printf 'mcp+   %-10s  %s -- %s %s\n' deepseek "$name" "$cmd" "$*"
  lib_run deepseek mcp add "$name" "--command=$cmd" "${args[@]}"
}
lib_mcp_deepseek_remove() {
  command -v deepseek >/dev/null || { printf 'skip   %-10s  (deepseek CLI missing)\n' deepseek; return 0; }
  printf 'mcp-   %-10s  %s\n' deepseek "$1"
  lib_run deepseek mcp remove "$1"
}

# opencode — ~/.config/opencode/opencode.json, top-level "mcp",
# entries shaped { command:[array], enabled:true, type:"local", environment:{} }.
lib_mcp_opencode_add() {
  local name="$1" cmd="$2"; shift 2
  local path="$HOME/.config/opencode/opencode.json"
  [ -d "$(dirname "$path")" ] || { printf 'skip   %-10s  (~/.config/opencode missing)\n' opencode; return 0; }
  lib_require jq
  lib__ensure_json "$path" mcp
  local cmd_arr; cmd_arr="$(lib__args_json "$cmd" "$@")"
  local entry; entry="$(jq -n --argjson c "$cmd_arr" '{command:$c, enabled:true, type:"local"}')"
  printf 'mcp+   %-10s  %s -> %s\n' opencode "$name" "$path"
  lib__jq_inplace "$path" --arg n "$name" --argjson e "$entry" '.mcp[$n] = $e'
}
lib_mcp_opencode_remove() {
  local path="$HOME/.config/opencode/opencode.json"
  [ -f "$path" ] || { printf 'skip   %-10s  (no opencode.json)\n' opencode; return 0; }
  printf 'mcp-   %-10s  %s\n' opencode "$1"
  lib__jq_inplace "$path" --arg n "$1" 'del(.mcp[$n])'
}

# Hermes — ~/.hermes/config.yaml, top-level "mcp_servers". Needs yq (mikefarah).
lib_mcp_hermes_add() {
  local name="$1" cmd="$2"; shift 2
  [ -d "$HOME/.hermes" ] || { printf 'skip   %-10s  (~/.hermes missing)\n' hermes; return 0; }
  if ! command -v yq >/dev/null; then
    printf 'skip   %-10s  (needs yq: brew install yq)\n' hermes; return 0
  fi
  local path="$HOME/.hermes/config.yaml"
  if [ ! -f "$path" ]; then
    if [ "$LIB_DRY_RUN" -eq 1 ]; then
      printf 'DRY: create %s with mcp_servers: {}\n' "$path"
    else
      printf 'mcp_servers: {}\n' > "$path"
    fi
  fi
  local args_json; args_json="$(lib__args_json "$@")"
  printf 'mcp+   %-10s  %s -> %s\n' hermes "$name" "$path"
  if [ "$LIB_DRY_RUN" -eq 1 ]; then
    printf 'DRY: yq -i ".mcp_servers.\"%s\" = {command:\"%s\", args:%s}" %s\n' "$name" "$cmd" "$args_json" "$path"
  else
    NAME="$name" CMD="$cmd" ARGS_JSON="$args_json" \
      yq -i '.mcp_servers[strenv(NAME)] = {"command": strenv(CMD), "args": strenv(ARGS_JSON) | from_yaml}' "$path"
  fi
}
lib_mcp_hermes_remove() {
  local path="$HOME/.hermes/config.yaml"
  [ -f "$path" ] || { printf 'skip   %-10s  (no config.yaml)\n' hermes; return 0; }
  if ! command -v yq >/dev/null; then
    printf 'skip   %-10s  (needs yq)\n' hermes; return 0
  fi
  printf 'mcp-   %-10s  %s\n' hermes "$1"
  if [ "$LIB_DRY_RUN" -eq 1 ]; then
    printf 'DRY: yq -i "del(.mcp_servers.\"%s\")" %s\n' "$1" "$path"
  else
    NAME="$1" yq -i 'del(.mcp_servers[strenv(NAME)])' "$path"
  fi
}
