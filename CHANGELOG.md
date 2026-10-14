# Changelog

## v2.0.0

Version 2 makes the kit work in any capable AI coding agent, fixes the places where a first-timer got stuck, and adds a fully worked example. It's a breaking release if you built on v1; see "Moving from v1" below.

### Works in any agent, not just Claude Code

* **One tool-neutral rules file.** The shared rules, the wiki registry, and the boundary rules now live together in the top folder's `AGENTS.md`, and each wiki's rules live in its own `AGENTS.md`. Codex, Cursor, Copilot, and other agents read that file name. Claude Code reads it through a one-line `CLAUDE.md` beside each one. v1 depended on a relative import that only Claude Code resolved.
* **Plain-language operations.** The six operations are plain procedures in `_shared/operations/`. Ask in any words, like "ingest raw/notes.md," and the rules send the agent to the right procedure. v1's operations only worked as Claude Code slash commands, with a copy in every wiki.
* **Optional skills.** `wiki-*` skills give shortcuts in agents that support them, and they point at the same procedures.
* **A safety net.** Each wiki's rules tell the agent to read the shared rules whenever they aren't already loaded, for agents that load only the nearest `AGENTS.md`.
* **[COMPATIBILITY.md](COMPATIBILITY.md)** records what each agent's documentation says, with sources and the date each was checked.

### Fixes for the places a first-timer got stuck

* **Start inside the wiki's folder.** v1 said to open the agent at the vault root. From there, Claude Code wasn't documented to find the per-wiki commands, and agents that walk down from the git root never reached the wiki's own rules.
* **Get the kit with "Use this template."** A plain clone kept the public kit as its remote, so pushes failed silently while you thought you were backed up. START-HERE now disconnects it, and the hooks refuse to push there.
* **The manual setup works as written.** v1's copy commands pointed at folders that weren't there.
* **First pushes work.** Every first push runs `git branch -M main` first, because `git init` still names the first branch `master`.
* **Fresh machines work.** START-HERE turns a ZIP download into a git repository, and sets a git identity if the machine has none.

### Easier for a newcomer

* The README leads with what you need, then a six-step guide from download to a first cited answer: three ways to get the kit, how to open it in each agent, the one sentence to type ("Read START-HERE.md and build my first wiki."), what the agent will ask, and where to start it next time. Then come the four moves: ingest, query, file back, and lint.
* START-HERE builds one wiki first, on the reconcile archetype unless you're building a thesis or worldview.
* Both archetypes stand alone; neither assumes the other exists.
* A privacy note says where your sources go when the agent reads them.
* The companion primer ships in `docs/Arcqus-AI-LLM-Wiki-Primer.pdf`: a plain-language introduction to the idea, with a last page that points back to this kit.
* GitHub CLI over HTTPS is the recommended sign-in for backup. It was tested unattended, the way the hook uses it.

### Consistency fixes

* Six operations everywhere. v1's base said four, and its log only had prefixes for four.
* The pearls-page requirement is gone. No template or scaffold ever created that page, and source summaries and file back already keep sharp lines with their citations.
* The folder trees in START-HERE, SETUP, and ADDING-A-WIKI now match.
* The reconcile layout drops the per-wiki README that nothing created.
* Reconcile pages carry a `review_by` date, so the freshness rule has something to check.
* Unknown values are marked `{{VERIFY: ...}}`. v1's double-bracket marker drew a ghost node in Obsidian's graph for every unknown value.
* Pages link with relative markdown links, which work on GitHub and in any viewer. File names are lowercase with hyphens, which keeps colons out of them; Windows forbids colons in file names.
* The ledger records each source's full sha256.

### A worked example

`examples/sample-wiki/` is a small, fictional reconcile wiki, frozen after three ingests, a filed-back answer, and a lint. It shows citations on every claim, typed relationships, a resolved contradiction with the superseded claim still visible, a review queue, and a ledger with real hashes. Start with `examples/README.md`.

### Git hooks

* **pre-commit** counts a folder as a wiki only if it holds `AGENTS.md`, so the kit's own folders no longer count. It also catches a page moved between wikis.
* **post-commit**
  * does nothing when git re-runs it from inside its own rebase (v1 pushed half-rebased history from there: six pushes for three commits in testing, against three now);
  * pushes your current branch, not always `main`;
  * refuses to push to the public kit;
  * never waits for a password;
  * logs every attempt to `.git/auto-push.log`, with a one-line warning when a push fails.
* **install.sh and auto-sync.sh** check that you've connected your own repository. The background sync finds its folder by itself, and its instructions use `launchctl bootstrap`.
* **Line endings** are pinned, so a Windows checkout can't break the hooks or change a source's hash.

### For maintainers

* `scripts/check-kit.sh` runs the release checks. Each check is shown to fire by breaking what it checks.
* `MAINTAINERS.md` holds the estate's four lines, moved word for word from the README, and the release checklist.

### Breaking changes for v1 users

* **Files moved.** The shared base in `_shared/wiki-base.md` is now the top folder's `AGENTS.md`; the old file is a pointer. `commands/` is now `_shared/operations/`. Each wiki's v1 `CLAUDE.md` becomes its `AGENTS.md`, with a new one-line `CLAUDE.md` beside it.
* **The pre-commit rule changed.** A folder counts as a wiki only if it holds `AGENTS.md`. Until you migrate, the hook won't treat your v1 wikis as wikis.
* **New conventions.** New pages use `{{VERIFY: ...}}` markers, relative markdown links, and the full sha256. Lint looks for the new marker only.

### Moving from v1

GitHub creates template copies with unrelated history, so you can't merge v2 into your copy. Copy it in instead:

1. Commit everything first, so you can always go back.
2. Copy these from v2 into your top folder: `AGENTS.md`, `CLAUDE.md`, `_shared/`, `archetypes/`, `.agents/`, `.claude/skills/`, `git-hooks/`, `.gitattributes`, `.gitignore`, and `scripts/`. Then delete the old `commands/` folder.
3. Move your registry rows from your old top-level `CLAUDE.md` into the registry table in the new `AGENTS.md`.
4. In each wiki, rename `CLAUDE.md` to `AGENTS.md`, and replace its import line with the "Shared rules first" header from the matching archetype. Create a `CLAUDE.md` containing the single line `@AGENTS.md`. Delete the `commands` folder inside the wiki's `.claude/` folder.
5. Ask your agent to convert the old double-bracket VERIFY markers to `{{VERIFY: ...}}`, and, in reconcile wikis, to add `review_by` dates. A lint afterwards shows anything it missed.
6. Reinstall the hooks with `sh git-hooks/install.sh`.

## v1.0.0

The first public release: the shared base protocol, two archetype overlays, six Claude Code commands, templates, and git hooks.
