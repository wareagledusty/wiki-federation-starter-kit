#!/bin/sh
#
# Install the kit's git hooks into this repository. Run it once per clone,
# from anywhere inside the repository:
#
#     sh git-hooks/install.sh
#
#   pre-commit   blocks a commit that touches two wikis
#   post-commit  pushes each commit to origin, logged in .git/auto-push.log
#
# It needs an "origin" remote that is your own repository, not the kit.
#
set -u

if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
  echo "install.sh: run this inside your wiki's git repository." >&2
  exit 1
fi

if ! url=$(git -C "$root" remote get-url origin 2>/dev/null); then
  echo "install.sh: this repository has no \"origin\" remote yet." >&2
  echo "Connect your own GitHub repository first (CONNECT-OBSIDIAN-AND-GITHUB.md, Part B), then run this again." >&2
  exit 1
fi

case "$url" in
  *wareagledusty/wiki-federation-starter-kit*)
    echo "install.sh: \"origin\" points at the public starter kit: $url" >&2
    echo "Run \"git remote remove origin\", connect your own repository, then run this again." >&2
    exit 1 ;;
esac

if hooks_path=$(git -C "$root" config --get core.hooksPath 2>/dev/null); then
  echo "install.sh: core.hooksPath is set to \"$hooks_path\", so git won't read .git/hooks." >&2
  echo "Unset it (git config --unset core.hooksPath) or copy git-hooks/pre-commit and post-commit there yourself." >&2
  exit 1
fi

hooks=$(cd "$root" && git rev-parse --git-path hooks)
case "$hooks" in
  /*) ;;
  *) hooks="$root/$hooks" ;;
esac
mkdir -p "$hooks"

for hook in pre-commit post-commit; do
  cp "$root/git-hooks/$hook" "$hooks/$hook" || exit 1
  chmod +x "$hooks/$hook" || exit 1
  echo "installed $hook"
done
echo "Done. Every commit now pushes to: $url"
