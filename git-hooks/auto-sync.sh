#!/bin/sh
#
# Optional safety net for the post-commit push. It pulls down changes from
# your remote and pushes up any local commits that haven't reached it, for
# example after you worked offline or on a second machine. Run it on a
# schedule: on macOS, with com.example.wikis-autosync.plist (see
# CONNECT-OBSIDIAN-AND-GITHUB.md); elsewhere, with cron.
#
# It finds the repository from its own location (git-hooks/ inside the
# repository), so there's nothing to edit here. Each run's output goes to
# whatever log the scheduler sets up.
#
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/homebrew/bin
export PATH
if [ -z "${HOME:-}" ]; then
  HOME=$(eval echo "~$(id -un)")
  export HOME
fi

cd "$(dirname "$0")/.." || exit 1
if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
  echo "auto-sync: $(pwd) is not a git repository" >&2
  exit 1
fi
cd "$root" || exit 1

if ! url=$(git remote get-url origin 2>/dev/null); then
  echo "auto-sync: no \"origin\" remote; connect your own repository first" >&2
  exit 1
fi
case "$url" in
  *wareagledusty/wiki-federation-starter-kit*)
    echo "auto-sync: origin is the public starter kit, not your copy; nothing synced" >&2
    exit 1 ;;
esac

gitdir=$(git rev-parse --git-dir)
if [ -d "$gitdir/rebase-merge" ] || [ -d "$gitdir/rebase-apply" ]; then
  echo "auto-sync: a rebase is in progress; skipping this run"
  exit 0
fi
branch=$(git symbolic-ref --quiet --short HEAD) || { echo "auto-sync: detached HEAD; skipping"; exit 0; }

GIT_TERMINAL_PROMPT=0
export GIT_TERMINAL_PROMPT

echo "auto-sync $(date '+%Y-%m-%d %H:%M:%S'): $branch"
git pull --rebase --autostash origin "$branch" || git rebase --abort
git push origin "$branch"
exit 0
