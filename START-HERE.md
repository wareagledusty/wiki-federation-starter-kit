# START HERE — Build a Wiki Federation (agent build spec)

> **Who this file is for:** an AI coding agent (e.g. Claude Code) that a human has just pointed at this folder. If you are that agent, this document *is your instructions*. Execute it. If you are a human reading it, the short version is: open this folder in Claude Code and say **"Read START-HERE.md and build my federation."** The agent will take it from here.

---

## What you are about to build

An **LLM wiki federation**: one or more markdown wikis that an agent maintains, sharing a common protocol but each running its own contradiction/authorship policy. The full concept is in [README.md](README.md); the manual form of these steps is in [SETUP.md](SETUP.md). Read both before you start building — this file is the executable checklist that ties them together.

The kit you're standing in contains the **source templates** you will copy from:

- `_shared/` — the base protocol, page templates, recipe, operator guide (these move into the federation as-is).
- `archetypes/` — two overlay templates (`reconcile-overlay.md`, `preserve-tension-overlay.md`). You copy the right one to each wiki's `CLAUDE.md` and fill its placeholders.
- `commands/` — the six slash-commands. You copy all six into each wiki's `.claude/commands/`.
- `CLAUDE.md` — the root registry template. You fill its table.
- `git-hooks/` — optional plumbing.

---

## Step 1 — Interview the human (do NOT assume; ask, then confirm)

Gather these decisions before writing anything. Ask them conversationally, in one or two batches, and echo back a summary for confirmation before you build.

**About the federation:**
1. **Where should it live?** Either *"build it in place — this folder becomes the vault"* or a target path (e.g. `~/my-wikis`). Default: build in place.
2. **Git:** initialize a repo? Is there a remote to push to? (Optional — the hooks need a remote only if they want auto-push.)
3. **How many wikis to start with?** Recommend **one**. More can be stamped out later via `_shared/ADDING-A-WIKI.md`.

**For each wiki (repeat):**
4. **Display name** (e.g. "Field Notes") and **folder slug** (e.g. `field-notes`).
5. **Archetype** — *reconcile* (one current cited best answer; competitive/reference/factual) or *preserve-tension* (keeps competing views in dialogue; worldview/thesis/research). If unsure, ask what the wiki is *for* and pick: "one right answer that stays current" → reconcile; "a body of thinking where disagreement is the point" → preserve-tension.
6. **Scope** — one sentence: what belongs here and, by implication, what doesn't.
7. **Authorship posture** — *gated* (the human authors positions; you challenge and maintain) or *maintained* (you maintain; the human reviews positioning). Preserve-tension → usually gated; reconcile → usually maintained.
8. **Confidential?** Does it hold client-private or personal material with export limits? If yes, flag it — you'll note the confidentiality posture in its overlay and root registry, and NOT wire any export/downstream feed without explicit instruction (see `ADDING-A-WIKI.md` → confidential wikis).
9. **Relationship vocabulary** — default to the archetype's built-in set unless they want custom edges.

> If the human just says "you decide" — pick sensible defaults, state them explicitly, and proceed. Never invent *content*; do invent reasonable *structure* and label it as your choice.

---

## Step 2 — Scaffold the federation root

Working at the chosen location (in place, or the target path):

1. If not already a git repo and they want one: `git init`.
2. Ensure `_shared/` is at the root (it already is if building in place; otherwise copy the kit's `_shared/` there).
3. Place the root `CLAUDE.md` at the root (copy the kit's `CLAUDE.md` template if building at a new path).
4. Ensure the kit's `.gitignore` is at the root (already present if building in place; otherwise copy it over). It ignores OS cruft and Obsidian's per-machine state — and, by design, leaves `raw/` sources *tracked*, since git is the backup. To keep heavy binary media out of history, opt in per-type via the commented block inside it.

---

## Step 3 — Build each wiki

For every wiki from the interview, create:

```
<slug>/
├── CLAUDE.md            ← copied from the chosen archetype overlay, placeholders filled
├── .claude/commands/    ← all six files from commands/
├── raw/                 ← empty; the human's immutable sources land here
├── wiki/                ← empty; the pages you'll create live here
├── index.md             ← seeded from _shared/TEMPLATES.md (state-file formats)
├── log.md               ← seeded from _shared/TEMPLATES.md
└── _state/
    ├── sources.md       ← seeded from _shared/TEMPLATES.md
    └── review-queue.md  ← seeded from _shared/TEMPLATES.md
```

Then the archetype-specific folders:
- **preserve-tension:** add `notes/` (the sidecar for un-ratified hunches).
- **reconcile:** add `initiatives/`, `archive/`, `exports/`, and a `current-state.md` (living "what's true now" brief).

**Filling the overlay (`<slug>/CLAUDE.md`):**
- Copy `archetypes/reconcile-overlay.md` or `archetypes/preserve-tension-overlay.md`.
- Replace every `<PLACEHOLDER>` with the interview answers (name, scope, authorship, confidentiality, vocabulary).
- For a preserve-tension wiki, **leave the `THE THESIS` block for the human to author** — do not write a thesis. Prompt them to fill it, and until they do, never let a page assert one.
- **The shared base:** the overlay's first line is `@../_shared/wiki-base.md`. Verify your tool resolves that relative import (from `<slug>/CLAUDE.md` to `_shared/wiki-base.md`). If you cannot confirm it resolves, **inline the full contents of `_shared/wiki-base.md`** in place of that line, wrapped in clear `<!-- SHARED BASE (inlined mirror; canonical: _shared/wiki-base.md) -->` … `<!-- END SHARED BASE -->` markers, so the wiki still behaves correctly. Note in the overlay which approach you used.

---

## Step 4 — Wire the root registry

Open the root `CLAUDE.md` and replace the two example rows with one row per wiki you built: name, folder slug, archetype, one-line scope. This table is the canonical list of what exists and where the "one wiki at a time, never cross-link" boundary is enforced. Keep each scope line in sync with that wiki's overlay.

---

## Step 5 — Connect GitHub + Obsidian (offer to walk them through it)

Two integrations make the build safe and pleasant; **offer both**, and follow **[CONNECT-OBSIDIAN-AND-GITHUB.md](CONNECT-OBSIDIAN-AND-GITHUB.md)** for the exact steps — read it before guiding them.

- **GitHub (backup + auto-push).** If they want a remote, help them: create a private repo, set the remote, and choose an auth method — **prefer SSH with a no-passphrase deploy key** because the post-commit hook pushes unattended (a passphrase or uncached HTTPS token will hang the hook). Confirm the *first* push works by hand (the hook swallows push errors on purpose, so a broken remote fails silently). Then edit the hook placeholders (`<HOME>`, `<VAULT-PATH>`, the `com.example.wikis-autosync` label, the `origin/main` remote) and run `sh git-hooks/install.sh`. The optional launchd agent (macOS) is periodic background sync — skip unless they want it.
- **Obsidian (reading surface).** Point them to install Obsidian and *Open folder as vault* at the federation root, and to enable the **Dataview** plugin so the typed `relates_to` edges become queryable. Obsidian only reads the folder — it does not sync to GitHub; git does.

If they don't want git/GitHub or Obsidian right now, that's fine — the wikis run on Claude Code alone. Note it and move on; they can add either later from the connect guide.

---

## Step 6 — Prove the loop, then hand off

Don't declare done until the loop works end to end. Walk the human through:

1. Drop 3–4 real sources into `<slug>/raw/`, then run `/ingest` on each (one at a time).
2. Run `/query` on something the sources should answer — confirm a **cited** answer.
3. `/file-back` a strong answer — confirm it becomes a page (a draft awaiting ratification in a gated wiki).
4. `/lint` — confirm the contradiction policy behaves per archetype (reconcile flags a contradiction to resolve; preserve-tension *keeps* one).

Then point them at `_shared/OPERATORS-GUIDE.md` for the daily rhythm, and `_shared/ADDING-A-WIKI.md` for stamping out the next wiki.

**Optional cleanup:** once built, `archetypes/`, `commands/`, `START-HERE.md`, `README.md`, and `SETUP.md` are reference material — they can stay (harmless) or be moved into a `_kit/` folder to keep the vault tidy. `_shared/` must stay. Ask before deleting anything.

---

## Guardrails (hold these the whole way)

- **Never invent content.** You build *structure*; the human supplies *substance*. Where a value is unknown, use a visible `[[VERIFY: …]]` placeholder — never a confident fabrication.
- **Confirm before writing** at each major step, especially the first time you scaffold. Show the plan, get the go-ahead.
- **One commit, one wiki.** If you commit as you build, commit each wiki's folder separately with a wiki-name-prefixed message; `_shared/` and root files may commit on their own. (The pre-commit hook enforces this once installed.)
- **Respect the boundary from the start.** Never cross-link one wiki to another; never ingest out-of-scope material. Clean separation is the whole value.
- **The thesis is the human's.** In a gated/preserve-tension wiki you may challenge and maintain, never author or soften a position.
