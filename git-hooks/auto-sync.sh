#!/bin/sh
#
# Optional periodic safety-net sync (belt-and-suspenders to the post-commit
# auto-push hook). Pulls DOWN remote changes and pushes UP any local commits,
# reconciling all threads. Intended to run on a schedule (e.g. a launchd agent
# on macOS — see com.example.wikis-autosync.plist — or a cron job).
#
# Safe by construction: the wikis never share files across folders, so the rebase
# can't conflict; --autostash protects any in-progress uncommitted work; every
# step is non-fatal so a transient failure just retries next cycle.
#
# EDIT THESE before use:
export HOME=<HOME>                 # e.g. /Users/you
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/homebrew/bin
cd "<VAULT-PATH>" || exit 0        # e.g. "$HOME/my-wikis"

# Pull down + reconcile (abort cleanly if a rebase ever can't proceed).
git pull --rebase --autostash origin main >/dev/null 2>&1 || git rebase --abort >/dev/null 2>&1
# Push up anything committed locally but not yet on the remote.
git push origin main >/dev/null 2>&1
exit 0
