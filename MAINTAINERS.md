# Maintainers

Notes for whoever maintains this kit. You don't need any of this to use it.

## The four lines

(estate maintenance protocol, ratified 2026-08-23)

- **Purpose:** the public, genericized starter kit for LLM-maintained wiki federations: the portable protocol, templates, archetypes, operations, and git plumbing, with no one's content in it.
- **Owner:** Dusty Holcomb.
- **Recovery path:** `git clone https://github.com/wareagledusty/wiki-federation-starter-kit.git`. That is the whole path: a public template holds no secrets, no worker, and no state, so `RECOVERY.md` is waived by ruling (2026-08-23). The shipped `git-hooks/` are payload for stamped federations, deliberately not installed in this repository.
- **Retirement condition:** retired only by Dusty's ruling, when the kit is superseded or archived; being public, retirement means archiving the repository, never deleting it, so existing clones and links keep resolving.

## Before a release

1. **Run the checks.** `sh scripts/check-kit.sh` must pass. It checks house style, the private denylist, tool-specific tokens, the instruction-size budget, the skill wrappers, links, and the sample wiki's ledger.
2. **Run the live test** in each agent the README names, on a fresh template copy: START-HERE through a first cited answer, a file back, and a lint pass. Mark an agent "live tested" in `COMPATIBILITY.md` only after it passes.
3. **Re-check `COMPATIBILITY.md`** against the vendors' current docs, and update the "checked" date on anything you re-verify.
4. **Add a `CHANGELOG.md` entry,** and bump the changelog in the top `AGENTS.md` if the shared rules changed.

## The private denylist

`scripts/check-kit.sh` reads a list of terms that must never appear in this public repository, such as private product names and client names. The list lives outside the repository, so the terms are never published. By default it's `~/.config/wiki-kit/denylist.txt`; set `KIT_DENYLIST` to use another path. Put one term per line. Lines starting with `#` are comments. Matching is whole-word and case-insensitive, and it covers every file, every file path, and this branch's commit messages. If the file is missing, the check fails, so a skipped check never looks like a pass.

## The primer PDF

The README links to `docs/Arcqus-AI-LLM-Wiki-Primer.pdf`. Export it from Word, so the fonts render correctly, and save it at exactly that path. The name has no version number, so the link never breaks. Until the file exists, `check-kit.sh` reports it as pending rather than failing.

## The GitHub settings

* **Template repository** is on (Settings, General). It makes **Use this template** appear.
* The repository description should match the README's opening line.
* **`main` is protected** (Settings, Branches). Every change arrives through a pull request, with no approvals required. Force pushes and deletion are blocked, and **Do not allow bypassing the above settings** is on, so the rules also bind admins, and any agent using an admin's credentials. No status checks are required, because the repository has no CI.

## Working on the kit with an agent

The top `AGENTS.md` is the shared rules for wikis, so it also loads when you open this repository in an agent. That's expected. For kit maintenance, give the agent the task directly; the rules only apply when it's asked to run a wiki operation.
