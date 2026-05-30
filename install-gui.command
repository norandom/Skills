#!/usr/bin/env bash
# install-gui.command — point-and-click installer for Linux and macOS.
#
# Double-click it (macOS: opens in Terminal; Linux: mark executable / "Run").
# Wraps the same lib.sh logic install.sh uses, behind a native wizard:
#   1. choose Install or Uninstall
#   2. tick which tools to target (existing ones pre-checked)
#   3. tick which skills to link (all pre-checked)
#   4. preview the changes (dry run), then confirm
#   5. apply, then show a summary
#
# GUI backend, in order of preference: zenity (GTK), osascript (macOS native),
# then a plain-terminal fallback so it still works over SSH or without a GUI.
set -uo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "$HERE/lib.sh"

# ---- target table: label | parent dir | human description -------------------
# Keep these paths in lockstep with install.sh.
TARGET_LABELS=(claude hermes opencode deepseek agy)
target_dir() {
  case "$1" in
    claude)   echo "$HOME/.claude" ;;
    hermes)   echo "$HOME/.hermes" ;;
    opencode) echo "$HOME/.config/opencode" ;;
    deepseek) echo "$HOME/.deepseek" ;;
    agy)      echo "$HOME/.gemini/antigravity-cli" ;;
  esac
}
target_desc() {
  case "$1" in
    claude)   echo "Claude Code" ;;
    hermes)   echo "Hermes" ;;
    opencode) echo "opencode" ;;
    deepseek) echo "DeepSeek TUI" ;;
    agy)      echo "Antigravity CLI" ;;
  esac
}

# ---- pick a UI backend ------------------------------------------------------
# Override with SKILLS_UI=zenity|osascript|terminal (handy for testing / SSH).
UI="${SKILLS_UI:-}"
if [ -z "$UI" ]; then
  UI=terminal
  if command -v zenity >/dev/null 2>&1; then
    UI=zenity
  elif [ "$(uname -s)" = "Darwin" ] && command -v osascript >/dev/null 2>&1; then
    UI=osascript
  fi
fi

TITLE="Skills Installer"

die_cancel() { echo "Cancelled."; exit 0; }

# ui_choose_one PROMPT opt1 opt2 ...   -> echoes the chosen option
ui_choose_one() {
  local prompt="$1"; shift
  case "$UI" in
    zenity)
      local rows=() o
      for o in "$@"; do rows+=("$o"); done
      zenity --list --title="$TITLE" --text="$prompt" --column="Option" "${rows[@]}" \
        --height=240 --width=360 2>/dev/null
      ;;
    osascript)
      local list="" o
      for o in "$@"; do list+="\"$o\","; done
      list="${list%,}"
      osascript -e "set r to choose from list {$list} with prompt \"$prompt\" with title \"$TITLE\"" \
                 -e 'if r is false then' \
                 -e 'return ""' \
                 -e 'else' \
                 -e 'return item 1 of r' \
                 -e 'end if' 2>/dev/null
      ;;
    *)
      local i=1 o
      echo "== $prompt ==" >&2
      for o in "$@"; do echo "  $i) $o" >&2; i=$((i+1)); done
      local n; read -r -p "Choose [1]: " n; n="${n:-1}"
      eval "echo \${$n}"
      ;;
  esac
}

# ui_choose_many PROMPT "state:value:label" ...   -> echoes chosen values, one per line
#   state is "on" or "off" for the default check state.
ui_choose_many() {
  local prompt="$1"; shift
  case "$UI" in
    zenity)
      local rows=() spec st val lbl
      for spec in "$@"; do
        st="${spec%%:*}"; val="${spec#*:}"; lbl="${val#*:}"; val="${val%%:*}"
        [ "$st" = on ] && rows+=("TRUE") || rows+=("FALSE")
        rows+=("$val" "$lbl")
      done
      zenity --list --checklist --title="$TITLE" --text="$prompt" \
        --column="Use" --column="Name" --column="Detail" \
        --separator=$'\n' --height=420 --width=520 "${rows[@]}" 2>/dev/null
      ;;
    osascript)
      local items="" sel="" spec st val lbl
      for spec in "$@"; do
        st="${spec%%:*}"; val="${spec#*:}"; lbl="${val#*:}"; val="${val%%:*}"
        items+="\"$val — $lbl\","
        [ "$st" = on ] && sel+="\"$val — $lbl\","
      done
      items="${items%,}"; sel="${sel%,}"
      local def=""; [ -n "$sel" ] && def="default items {$sel}"
      osascript \
        -e "set r to choose from list {$items} with prompt \"$prompt\" with title \"$TITLE\" with multiple selections allowed $def" \
        -e 'if r is false then' \
        -e 'return ""' \
        -e 'end if' \
        -e "set AppleScript's text item delimiters to linefeed" \
        -e 'return r as text' 2>/dev/null \
        | sed 's/ — .*$//'
      ;;
    *)
      local spec st val lbl
      echo "== $prompt ==" >&2
      echo "(enter space-separated names to use, or blank for the defaults marked *)" >&2
      local defaults=()
      for spec in "$@"; do
        st="${spec%%:*}"; val="${spec#*:}"; lbl="${val#*:}"; val="${val%%:*}"
        [ "$st" = on ] && { echo "  * $val — $lbl" >&2; defaults+=("$val"); } || echo "    $val — $lbl" >&2
      done
      local ans; read -r -p "Names: " ans
      if [ -z "$ans" ]; then printf '%s\n' "${defaults[@]}"; else printf '%s\n' $ans; fi
      ;;
  esac
}

# ui_preview FILE   -> show file contents, return 0 to proceed / non-zero to abort
ui_preview() {
  local file="$1"
  case "$UI" in
    zenity)
      zenity --text-info --title="$TITLE — preview (dry run)" \
        --filename="$file" --width=760 --height=560 \
        --ok-label="Apply" --cancel-label="Cancel" 2>/dev/null
      ;;
    osascript)
      open -e "$file" 2>/dev/null || true
      osascript -e "display dialog \"Review the preview that just opened.\n\nApply these changes?\" with title \"$TITLE\" buttons {\"Cancel\",\"Apply\"} default button \"Apply\"" \
        >/dev/null 2>&1
      ;;
    *)
      echo; echo "----- preview (dry run) -----"; cat "$file"; echo "-----------------------------"
      local a; read -r -p "Apply these changes? [y/N]: " a; [ "$a" = y ] || [ "$a" = Y ]
      ;;
  esac
}

# ui_info FILE_OR_TEXT  -> show a final summary
ui_info() {
  local file="$1"
  case "$UI" in
    zenity)    zenity --text-info --title="$TITLE — done" --filename="$file" --width=760 --height=560 2>/dev/null || true ;;
    osascript) open -e "$file" 2>/dev/null || true ;;
    *)         echo; echo "----- result -----"; cat "$file"; echo "------------------" ;;
  esac
}

# ---- wizard -----------------------------------------------------------------
mode="$(ui_choose_one "What would you like to do?" "Install" "Uninstall")"
[ -n "$mode" ] || die_cancel

# Tools: pre-check the ones whose parent dir already exists.
tool_specs=()
for t in "${TARGET_LABELS[@]}"; do
  dir="$(target_dir "$t")"
  if [ -d "$dir" ]; then
    tool_specs+=("on:$t:$(target_desc "$t")  (${dir/#$HOME/~})")
  else
    tool_specs+=("off:$t:$(target_desc "$t")  (not detected: ${dir/#$HOME/~})")
  fi
done
chosen_tools="$(ui_choose_many "Which tools should receive the skills?" "${tool_specs[@]}")"
[ -n "$chosen_tools" ] || die_cancel

# Skills: list every skill, all pre-checked.
skill_specs=()
while read -r s; do
  [ -n "$s" ] || continue
  skill_specs+=("on:$s:skill")
done < <(lib_list_skills)
chosen_skills="$(ui_choose_many "Which skills should be linked?" "${skill_specs[@]}")"
[ -n "$chosen_skills" ] || die_cancel

# Restrict lib.sh to the chosen skills for the rest of the run.
export LIB_SKILLS="$(printf '%s ' $chosen_skills)"

action=lib_link_target
[ "$mode" = Uninstall ] && action=lib_unlink_target

run_targets() {  # $1 = dry(1/0)
  LIB_DRY_RUN="$1"
  local t dir
  if [ "$mode" = Install ]; then lib_validate_skills || true; fi
  for t in $chosen_tools; do
    dir="$(target_dir "$t")"
    "$action" "$t" "$dir"
  done
}

# 1) dry-run preview
preview="$(mktemp -t skills-install.XXXXXX)"
{
  echo "Mode:   $mode"
  echo "Tools:  $chosen_tools"
  echo "Skills: $chosen_skills"
  echo
  echo "Planned actions:"
  run_targets 1
} >"$preview" 2>&1

if ! ui_preview "$preview"; then
  rm -f "$preview"; die_cancel
fi

# 2) apply for real
result="$(mktemp -t skills-result.XXXXXX)"
{
  echo "$mode complete."
  echo
  run_targets 0
} >"$result" 2>&1

ui_info "$result"
rm -f "$preview" "$result"
echo "Done."
