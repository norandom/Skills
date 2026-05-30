#!/usr/bin/env bash
# bootstrap.sh — one command to install *and* update the Skills repo. No git needed.
#
# Downloads the latest source tarball from GitHub, unpacks it to a managed
# location, then symlinks the skills into your tools. Because the install links
# point at this copy, re-running bootstrap updates everything: it re-downloads
# the latest and relinks. Install and update are the same command.
#
#   curl -fsSL https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.sh | bash
#   # pass install.sh flags after `--`:
#   curl -fsSL https://raw.githubusercontent.com/norandom/Skills/main/bootstrap.sh | bash -s -- --claude
#
# Env overrides:
#   SKILLS_HOME   where to unpack      (default: ~/.local/share/skills)
#   SKILLS_REPO   owner/name           (default: norandom/Skills)
#   SKILLS_REF    branch, tag, or SHA  (default: main)
set -euo pipefail

REPO="${SKILLS_REPO:-norandom/Skills}"
REF="${SKILLS_REF:-main}"
DEST="${SKILLS_HOME:-$HOME/.local/share/skills}"
URL="https://github.com/$REPO/archive/$REF.tar.gz"   # works for branch, tag, or SHA

fetch() {  # stream a URL to stdout using whatever's installed
  if   command -v curl >/dev/null 2>&1; then curl -fsSL "$1"
  elif command -v wget >/dev/null 2>&1; then wget -qO- "$1"
  else echo "bootstrap: need curl or wget to download." >&2; return 1; fi
}
command -v tar >/dev/null 2>&1 || { echo "bootstrap: need tar to extract." >&2; exit 1; }

echo "Downloading Skills ($REPO@$REF) → $DEST"
mkdir -p "$DEST"
# --strip-components=1 drops the "<repo>-<ref>/" top-level folder GitHub adds.
fetch "$URL" | tar -xz --strip-components=1 -C "$DEST"

echo
echo "Linking skills…"
exec bash "$DEST/install.sh" "$@"
