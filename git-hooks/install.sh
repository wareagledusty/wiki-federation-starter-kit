#!/bin/sh
# Install the federation git hooks into this repo's .git/hooks.
# Git hooks aren't version-controlled, so run this once per clone:
#     sh git-hooks/install.sh
#
#   pre-commit  — anti-conflation guard (blocks a commit spanning two wikis)
#   post-commit — auto-push to origin/main (no manual "Push origin" needed)
#
# Assumes the hook sources live at <repo-root>/git-hooks/. If you placed them
# elsewhere (e.g. _shared/git-hooks/), change HOOK_DIR below.
root=$(git rev-parse --show-toplevel) || { echo "not a git repo"; exit 1; }
HOOK_DIR="$root/git-hooks"
for hook in pre-commit post-commit; do
  cp "$HOOK_DIR/$hook" "$root/.git/hooks/$hook"
  chmod +x "$root/.git/hooks/$hook"
  echo "✓ installed $hook → $root/.git/hooks/$hook"
done
