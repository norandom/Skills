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
LIB_MARKETPLACE_ROOT="$LIB_ROOT/.marketplace"
LIB_MARKETPLACE_CONFIG="$LIB_MARKETPLACE_ROOT/skills.json"
LIB_MARKETPLACE_TEMPLATES="$LIB_MARKETPLACE_ROOT/templates"

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
# If LIB_SKILLS is set (space/newline-separated names), only those are emitted,
# letting a caller install/uninstall a chosen subset instead of everything.
lib_list_skills() {
  local d name
  for d in "$LIB_ROOT"/*/; do
    [ -f "${d}SKILL.md" ] || continue
    name="$(basename "$d")"
    if [ -n "${LIB_SKILLS:-}" ]; then
      case " $LIB_SKILLS " in *" $name "*) ;; *) continue ;; esac
    fi
    printf '%s\n' "$name"
  done
}

# Skill description char-limit (Claude Desktop / Claude Code spec).
LIB_DESC_MAX="${LIB_DESC_MAX:-1024}"

# Extract the YAML `description:` value from a SKILL.md and print its length.
# Handles plain, quoted, and `>` / `|` folded-block scalar forms.
lib_skill_desc_len() {
  local file="$1"
  awk '
    /^description:[[:space:]]*/ {
      sub(/^description:[[:space:]]*/, "")
      sub(/^[>|][-+]?[[:space:]]*/, "")
      gsub(/^"|"$/, "")
      gsub(/^'\''|'\''$/, "")
      buf = $0
      in_block = (buf == "")
      next
    }
    in_block && /^---[[:space:]]*$/ { exit }
    in_block && /^[^[:space:]]/      { exit }
    in_block {
      sub(/^[[:space:]]+/, "")
      buf = (buf == "" ? $0 : buf " " $0)
    }
    END { printf "%d", length(buf) }
  ' "$file"
}

# Validate every skill's description against LIB_DESC_MAX.
# Prints one WARN line per oversize skill and returns 1 if any were found.
lib_validate_skills() {
  local name file len bad=0
  while read -r name; do
    [ -n "$name" ] || continue
    file="$LIB_ROOT/$name/SKILL.md"
    len="$(lib_skill_desc_len "$file")"
    if [ "$len" -gt "$LIB_DESC_MAX" ]; then
      printf 'WARN   %-24s  description %s chars > %s — Claude Desktop / Code will silently drop this skill\n' \
        "$name" "$len" "$LIB_DESC_MAX" >&2
      bad=1
    fi
  done < <(lib_list_skills)
  return "$bad"
}

# Read one scalar from SKILL.md frontmatter. Folded/block values are returned
# as one line so they can be safely passed to the JSON template renderer.
lib_skill_field() {
  local file="$1" key="$2"
  awk -v key="$key" '
    $0 ~ ("^" key ":[[:space:]]*") {
      sub("^" key ":[[:space:]]*", "")
      sub(/^[>|][-+]?[[:space:]]*/, "")
      value = $0
      in_block = (value == "")
      if (!in_block) {
        sub(/^"/, "", value); sub(/"[[:space:]]*$/, "", value)
        sub(/^\047/, "", value); sub(/\047[[:space:]]*$/, "", value)
        print value
        exit
      }
      next
    }
    in_block && /^---[[:space:]]*$/ { print value; in_block = 0; exit }
    in_block && /^[^[:space:]]/      { print value; in_block = 0; exit }
    in_block {
      sub(/^[[:space:]]+/, "")
      value = (value == "" ? $0 : value " " $0)
    }
    END { if (in_block) print value }
  ' "$file"
}

lib__json_string() {
  jq -Rn --arg value "$1" '$value'
}

# Render a shared template. Arguments after the output path are KEY VALUE
# pairs; template tokens use {{KEY}}. jq performs literal replacement so JSON
# strings containing quotes, ampersands, or backslashes remain intact.
lib__render_template() {
  local template="$1" output="$2"; shift 2
  [ $(( $# % 2 )) -eq 0 ] || { echo "template substitutions must be KEY VALUE pairs" >&2; return 2; }
  local text key value token
  text="$(cat "$template")"
  while [ $# -gt 0 ]; do
    key="$1"; value="$2"; shift 2
    token="{{$key}}"
    text="$(printf '%s' "$text" | jq -Rrs --arg token "$token" --arg value "$value" 'split($token) | join($value)')"
  done
  if printf '%s' "$text" | grep -q '{{[A-Z_][A-Z_]*}}'; then
    echo "unresolved token in template: $template" >&2
    return 1
  fi
  mkdir -p "$(dirname "$output")"
  printf '%s\n' "$text" > "$output"
}

lib__marketplace_plugins() {
  [ -f "$LIB_MARKETPLACE_CONFIG" ] || { echo "missing marketplace config: $LIB_MARKETPLACE_CONFIG" >&2; return 1; }
  jq -c '.plugins[]' "$LIB_MARKETPLACE_CONFIG"
}

# Generate installable plugin packages from the canonical top-level skill
# directories. Generated packages are committed so release tags contain the
# exact subdirectories referenced by both marketplaces.
lib_generate_plugin_packages() {
  lib_require jq
  local plugin name display short category prompt keywords src skill_file version description manifest_name
  local plugin_root skill_dst
  while IFS= read -r plugin; do
    [ -n "$plugin" ] || continue
    name="$(jq -r '.name' <<<"$plugin")"
    display="$(jq -r '.displayName' <<<"$plugin")"
    short="$(jq -r '.shortDescription' <<<"$plugin")"
    category="$(jq -r '.category' <<<"$plugin")"
    prompt="$(jq -r '.defaultPrompt' <<<"$plugin")"
    keywords="$(jq -c '.keywords // []' <<<"$plugin")"
    case "$name" in *[!A-Za-z0-9_-]*|'') echo "invalid marketplace plugin name: $name" >&2; return 1 ;; esac

    src="$LIB_ROOT/$name"
    skill_file="$src/SKILL.md"
    [ -f "$skill_file" ] || { echo "marketplace skill missing: $skill_file" >&2; return 1; }
    manifest_name="$(lib_skill_field "$skill_file" name)"
    version="$(lib_skill_field "$skill_file" version)"
    description="$(lib_skill_field "$skill_file" description)"
    [ "$manifest_name" = "$name" ] || { echo "$name folder/frontmatter name mismatch: $manifest_name" >&2; return 1; }
    printf '%s' "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+([+-][0-9A-Za-z.-]+)?$' || {
      echo "$name has invalid semver: $version" >&2; return 1;
    }

    plugin_root="$LIB_ROOT/plugins/$name"
    skill_dst="$plugin_root/skills/$name"
    rm -rf "$plugin_root"
    mkdir -p "$(dirname "$skill_dst")"
    cp -R "$src" "$skill_dst"
    rm -f "$skill_dst/$name.skill" "$skill_dst/.norandom-skills-managed.json"
    find "$skill_dst" -name .DS_Store -type f -delete

    lib__render_template "$LIB_MARKETPLACE_TEMPLATES/codex-plugin.json.tpl" \
      "$plugin_root/.codex-plugin/plugin.json" \
      NAME_JSON "$(lib__json_string "$name")" \
      VERSION_JSON "$(lib__json_string "$version")" \
      DESCRIPTION_JSON "$(lib__json_string "$description")" \
      DISPLAY_NAME_JSON "$(lib__json_string "$display")" \
      SHORT_DESCRIPTION_JSON "$(lib__json_string "$short")" \
      CATEGORY_JSON "$(lib__json_string "$category")" \
      KEYWORDS_JSON "$keywords" \
      DEFAULT_PROMPT_JSON "$(lib__json_string "$prompt")" \
      SOURCE_PATH "$name"

    lib__render_template "$LIB_MARKETPLACE_TEMPLATES/claude-plugin.json.tpl" \
      "$plugin_root/.claude-plugin/plugin.json" \
      NAME_JSON "$(lib__json_string "$name")" \
      VERSION_JSON "$(lib__json_string "$version")" \
      DESCRIPTION_JSON "$(lib__json_string "$description")" \
      SOURCE_PATH "$name"

    jq empty "$plugin_root/.codex-plugin/plugin.json"
    jq empty "$plugin_root/.claude-plugin/plugin.json"

    printf '  plugin %-24s -> plugins/%s\n' "$name" "$name"
  done < <(lib__marketplace_plugins)
}

lib__validate_marketplace_ref() {
  [ -n "$1" ] || { echo "marketplace ref cannot be empty" >&2; return 1; }
  case "$1" in *[[:space:]]*) echo "marketplace ref cannot contain whitespace: $1" >&2; return 1 ;; esac
}

# Generate the two catalogs from the same plugin allowlist and release ref.
lib_generate_marketplace_catalogs() {
  lib_require jq
  local ref="$1" plugin name category keywords entry codex_entries='' claude_entries='' sep=''
  local tmp_dir codex_entry_file claude_entry_file
  lib__validate_marketplace_ref "$ref"
  tmp_dir="$(mktemp -d)"
  codex_entry_file="$tmp_dir/codex.json"
  claude_entry_file="$tmp_dir/claude.json"

  while IFS= read -r plugin; do
    [ -n "$plugin" ] || continue
    name="$(jq -r '.name' <<<"$plugin")"
    category="$(jq -r '.category' <<<"$plugin")"
    keywords="$(jq -c '.keywords // []' <<<"$plugin")"

    lib__render_template "$LIB_MARKETPLACE_TEMPLATES/codex-marketplace-entry.json.tpl" \
      "$codex_entry_file" \
      NAME_JSON "$(lib__json_string "$name")" \
      CATEGORY_JSON "$(lib__json_string "$category")" \
      REF_JSON "$(lib__json_string "$ref")" \
      SOURCE_PATH "$name"
    entry="$(sed 's/^/    /' "$codex_entry_file")"
    codex_entries="${codex_entries}${sep}${entry}"

    lib__render_template "$LIB_MARKETPLACE_TEMPLATES/claude-marketplace-entry.json.tpl" \
      "$claude_entry_file" \
      NAME_JSON "$(lib__json_string "$name")" \
      CATEGORY_JSON "$(lib__json_string "$category")" \
      KEYWORDS_JSON "$keywords" \
      REF_JSON "$(lib__json_string "$ref")" \
      SOURCE_PATH "$name"
    entry="$(sed 's/^/    /' "$claude_entry_file")"
    claude_entries="${claude_entries}${sep}${entry}"
    sep=$',\n'
  done < <(lib__marketplace_plugins)

  lib__render_template "$LIB_MARKETPLACE_TEMPLATES/codex-marketplace.json.tpl" \
    "$LIB_ROOT/.agents/plugins/marketplace.json" PLUGIN_ENTRIES "$codex_entries"
  lib__render_template "$LIB_MARKETPLACE_TEMPLATES/claude-marketplace.json.tpl" \
    "$LIB_ROOT/.claude-plugin/marketplace.json" PLUGIN_ENTRIES "$claude_entries"
  jq empty "$LIB_ROOT/.agents/plugins/marketplace.json"
  jq empty "$LIB_ROOT/.claude-plugin/marketplace.json"
  rm -rf "$tmp_dir"
  printf '  catalogs -> %s (%s)\n' "$ref" 'Codex, Claude Code'
}

lib_generate_marketplace() {
  lib_generate_plugin_packages
  lib_generate_marketplace_catalogs "$1"
}

# Post-release operation: refuse to advertise a tag unless every configured
# plugin package and both vendor manifests are actually present in that tag.
lib_update_marketplace_release() {
  local ref="$1" plugin name
  lib_require jq
  lib__validate_marketplace_ref "$ref"
  git -C "$LIB_ROOT" rev-parse --verify --quiet "$ref^{commit}" >/dev/null || {
    echo "unknown release ref: $ref" >&2; return 1;
  }
  while IFS= read -r plugin; do
    name="$(jq -r '.name' <<<"$plugin")"
    git -C "$LIB_ROOT" cat-file -e "$ref:plugins/$name/.codex-plugin/plugin.json" || {
      echo "$ref does not contain the Codex manifest for $name" >&2; return 1;
    }
    git -C "$LIB_ROOT" cat-file -e "$ref:plugins/$name/.claude-plugin/plugin.json" || {
      echo "$ref does not contain the Claude manifest for $name" >&2; return 1;
    }
  done < <(lib__marketplace_plugins)
  lib_generate_marketplace_catalogs "$ref"
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

# Antigravity CLI — ~/.gemini/antigravity-cli/mcp_config.json, top-level "mcpServers",
# entries shaped { command: "cmd", args: [array] }.
lib_mcp_agy_add() {
  local name="$1" cmd="$2"; shift 2
  local path="$HOME/.gemini/antigravity-cli/mcp_config.json"
  [ -d "$(dirname "$path")" ] || { printf 'skip   %-10s  (~/.gemini/antigravity-cli missing)\n' agy; return 0; }
  lib_require jq
  lib__ensure_json "$path" mcpServers
  local args_arr; args_arr="$(lib__args_json "$@")"
  local entry; entry="$(jq -n --arg c "$cmd" --argjson a "$args_arr" '{command:$c, args:$a}')"
  printf 'mcp+   %-10s  %s -> %s\n' agy "$name" "$path"
  lib__jq_inplace "$path" --arg n "$name" --argjson e "$entry" '.mcpServers[$n] = $e'
}
lib_mcp_agy_remove() {
  local path="$HOME/.gemini/antigravity-cli/mcp_config.json"
  [ -f "$path" ] || { printf 'skip   %-10s  (no mcp_config.json)\n' agy; return 0; }
  printf 'mcp-   %-10s  %s\n' agy "$1"
  lib__jq_inplace "$path" --arg n "$1" 'del(.mcpServers[$n])'
}
