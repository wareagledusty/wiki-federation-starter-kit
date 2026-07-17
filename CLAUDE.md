# Wiki Federation — Root

> This file governs only what is true **across** wikis — identity, boundaries, and where things live. It never sets per-wiki policy; that lives in each wiki's `CLAUDE.md` overlay, which inherits `_shared/wiki-base.md`. An agent that loads `CLAUDE.md` files up the directory tree reads this file on every session *in addition to* the specific wiki's overlay.

---

## The wikis in this federation (canonical registry)

<!-- ADD A ROW here every time you stamp out a wiki. This table is the canonical list
     of what exists. Keep each scope line in sync with that wiki's overlay. Two example
     rows are shown — replace them with your real wikis. -->

| Wiki | Folder | Archetype | Scope (one line) |
|---|---|---|---|
| `<Wiki A Name>` | `wiki-a/` | **Preserve-tension** (worldview / thesis) | `<one sentence: what belongs here — the worldview/thesis domain>` |
| `<Wiki B Name>` | `wiki-b/` | **Reconcile** (competitive / reference) | `<one sentence: the factual/competitive/reference domain that feeds downstream work>` |

## Cardinal rule: one wiki at a time

- At the start of any operation, determine **which wiki you are operating in** — the folder whose `CLAUDE.md` is loaded — and apply that wiki's policy.
- Operate on **exactly one wiki per operation.** Do not read, write, or reason across two wikis in a single operation unless the human explicitly asks for a cross-wiki comparison — and such a comparison is **read-only** and never writes into either wiki.

## Boundaries (never bleed)

- **Never cross-link** a page in one wiki to a page in another. Clean separation is the federation's whole value.
- **Never ingest** a source into a wiki outside that wiki's scope. If a source spans two wikis, ask the human where it belongs or whether to split it.
- If you notice a connection to **another** wiki's domain, record it as a one-line hunch — in this wiki's sidecar (if it has one) or its review queue — **never** by writing into the other wiki.

## Where things live (federation map)

- `_shared/wiki-base.md` — the shared base every federation wiki inherits.
- `_shared/TEMPLATES.md` — shared page and state-file templates.
- `_shared/ADDING-A-WIKI.md` — the recipe for adding a new wiki.
- `_shared/OPERATORS-GUIDE.md` — the day-to-day operating manual.
- `<wiki>/CLAUDE.md` — that wiki's overlay (imports the base; wins for that wiki).
- `<wiki>/.claude/commands/` — the six operations: ingest, query, lint, consolidate, file-back, review.
- `<wiki>/_state/` — that wiki's source ledger, review queue, and consolidation reports.

## Git discipline

- **One commit, one wiki**, message prefixed with the wiki name — enforced by the pre-commit hook (`git-hooks/`). `_shared/` is exempt and may ride along or commit alone.
- **Every commit auto-pushes** to your remote (post-commit hook). Commit = published to the remote.

## Changing the shared base

The base is high-leverage: a change to `_shared/wiki-base.md` is inherited **instantly by every wiki.** Treat base edits as deliberate, versioned changes — commit them on their own with a clear message, and record material changes in the base's changelog section.

## Adding a wiki

Follow `_shared/ADDING-A-WIKI.md`. In short: copy the nearer of the two archetype overlays, set its scope, make the contradiction / authorship / vocabulary decisions, drop in the six commands, seed the state files, and **add a row to the registry table above.**
