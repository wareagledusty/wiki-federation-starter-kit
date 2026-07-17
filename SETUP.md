# Setup — Standing Up Your Federation

About 20–30 minutes to a working single wiki. Add more wikis in ~20 min each.

---

## Step 0 — Create the vault + repo

```sh
mkdir my-wikis && cd my-wikis
git init
```

Copy the kit's `CLAUDE.md`, `.gitignore`, and `_shared/` folder to the root of `my-wikis/`. Optionally copy `git-hooks/` to `_shared/git-hooks/` (or keep it wherever you like — the paths in it are placeholders you'll edit).

Your root should look like:

```
my-wikis/
├── CLAUDE.md          ← the federation registry (edit the table as you add wikis)
├── .gitignore         ← OS/editor cruft; keeps raw/ sources tracked (git is the backup)
├── _shared/
│   ├── wiki-base.md
│   ├── TEMPLATES.md
│   ├── ADDING-A-WIKI.md
│   └── OPERATORS-GUIDE.md
└── git-hooks/         ← optional plumbing
```

## Step 1 — Stamp out your first wiki

Pick the archetype that fits your first domain:

- **Reconcile** (competitive intel, reference, product, factual/operational) → `archetypes/reconcile-overlay.md`
- **Preserve-tension** (worldview, thesis, research, dialectic) → `archetypes/preserve-tension-overlay.md`

Then:

```sh
mkdir -p my-first-wiki/.claude/commands my-first-wiki/raw my-first-wiki/wiki my-first-wiki/_state
cp archetypes/<chosen>-overlay.md            my-first-wiki/CLAUDE.md
cp commands/*.md                             my-first-wiki/.claude/commands/
```

Add the archetype-specific folders:
- Preserve-tension: `mkdir my-first-wiki/notes` (the sidecar for un-ratified hunches)
- Reconcile: `mkdir my-first-wiki/initiatives my-first-wiki/archive my-first-wiki/exports`

## Step 2 — Fill in the overlay (the only real work)

Open `my-first-wiki/CLAUDE.md` and replace every `<PLACEHOLDER>`. The four decisions that matter:

1. **Scope** — one sentence: what belongs here, and by implication what doesn't. This is the boundary.
2. **Contradiction policy** — the archetype sets this (reconcile → resolve; preserve-tension → keep). Leave it as the archetype has it unless you know why you're changing it.
3. **Authorship posture** — *gated* (you author positions; the agent challenges and maintains) or *maintained* (the agent maintains; you review positioning). Worldview → gated; reference → usually maintained.
4. **Relationship vocabulary** — the permitted `relates_to` edge types. Keep the archetype's set unless your domain needs different edges. Vocabularies stay **per-wiki**.

## Step 3 — Seed the state files

From `_shared/TEMPLATES.md`, create in `my-first-wiki/`:
- `index.md` — the content catalog (read first on every query)
- `log.md` — the append-only diary
- `_state/sources.md` — the provenance ledger
- `_state/review-queue.md` — pending human decisions

Empty-but-present is correct; they fill as you work.

## Step 4 — Register it

Add a row to the registry table in the root `CLAUDE.md` (wiki name, folder, archetype, one-line scope). That table is the canonical list of what exists and where the "one wiki at a time, never cross-link" rule is enforced.

## Step 5 — Connect GitHub (backup) and install the git hooks

> The hooks auto-push to a GitHub remote, so **set the remote and its auth first.** The full walkthrough — create a private repo, choose SSH / `gh` / HTTPS auth, and the deploy-key setup the unattended hooks need — is in **[CONNECT-OBSIDIAN-AND-GITHUB.md](CONNECT-OBSIDIAN-AND-GITHUB.md)**. That guide also covers connecting **Obsidian** as your reading surface. Do it once, then come back here.

The hooks enforce **one commit, one wiki** and auto-push. Before installing, edit them:

- `git-hooks/post-commit` and `auto-sync.sh` push to `origin/main` — point them at your remote.
- `git-hooks/auto-sync.sh` and `com.example.wikis-autosync.plist` hardcode `<HOME>` and `<VAULT-PATH>` placeholders and a `com.example.wikis-autosync` label — replace them with your real paths and a label you own.
- The pre-commit examples name `wiki-a` / `wiki-b` — cosmetic; the guard itself works on any folder names.

Then:

```sh
sh git-hooks/install.sh    # copies pre-commit + post-commit into .git/hooks
```

macOS periodic sync (optional): edit the plist, then
```sh
cp git-hooks/com.example.wikis-autosync.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/com.example.wikis-autosync.plist
```

## Step 6 — Prove the loop before you lean on it

Open the vault in Claude Code (`cd my-wikis`) and, naming your wiki:

1. Drop 3–4 sources into `my-first-wiki/raw/` and `/ingest` them one at a time.
2. `/query` something the sources should answer — confirm you get a cited answer.
3. `/file-back` a strong answer and confirm it becomes a page.
4. `/lint` and confirm the contradiction policy behaves as the archetype intends (a reconcile wiki flags a contradiction for resolution; a preserve-tension wiki *keeps* one).

That's live. From here, read `_shared/OPERATORS-GUIDE.md` for the day-to-day rhythm, and `_shared/ADDING-A-WIKI.md` when you want a second wiki.

---

## Adapting this to a tool other than Claude Code

The kit assumes an agent that (a) auto-loads `CLAUDE.md` up the directory tree as a system instruction and (b) runs `.claude/commands/*.md` as slash-commands. If your tool differs:

- **No auto-loaded instruction file?** Paste `wiki-base.md` + the wiki's overlay into the system prompt at the start of each session.
- **No slash-commands?** The six `commands/*.md` files are just prompts — invoke them by pasting, or wire them into whatever macro system your tool has.
- The protocol itself is **model-agnostic by design** — nothing in it depends on a specific vendor.
