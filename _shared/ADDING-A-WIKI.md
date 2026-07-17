# Adding a Wiki to the Federation

> The repeatable recipe for stamping out a new wiki. The architecture is built so this is a short job — about twenty minutes — not a redesign. Most new wikis are a variant of one of the two archetypes: copy the closer one and change only what differs. Install at `_shared/ADDING-A-WIKI.md`.

---

## Step 0 — Pick the archetype

Two archetypes cover most cases:

- **Preserve-tension (worldview / thesis)** — copy `archetypes/preserve-tension-overlay.md`. Use for any synthesis, worldview, or intellectual wiki where contradictions between views are *content to keep* and the load-bearing claims must be **the human's**. *(Maps to: any thesis or philosophy wiki.)*
- **Reconcile (competitive / reference / factual)** — copy `archetypes/reconcile-overlay.md`. Use for any wiki that should hold **one current, cited best answer**, especially if it ingests outside sources or feeds downstream assistants. *(Maps to: competitive/positioning, and most reference wikis.)*

If neither fits cleanly, start from the closer one and adjust — don't invent a third base.

## Step 1 — Create the folder

```
<wiki-name>/
├── CLAUDE.md            (the copied archetype overlay)
├── .claude/commands/    (the same six command files as the other wikis)
├── raw/
├── _state/              (sources.md, review-queue.md — seed from TEMPLATES.md)
├── index.md             (seed from TEMPLATES.md)
└── log.md               (seed from TEMPLATES.md)
```

Then add the archetype-specific folders: `notes/` for a preserve-tension wiki (the sidecar), or `initiatives/`, `archive/`, and `exports/` for a reconcile wiki.

## Step 2 — Make the four decisions (the only real work)

Write these into the new `CLAUDE.md`:

1. **Scope** — one sentence stating what belongs here and, by implication, what doesn't. This is the boundary.
2. **Contradiction policy** — *preserve* (flag missing tensions, never resolve) or *reconcile* (one current truth). This is the load-bearing choice; it sets how lint behaves.
3. **Authorship posture** — *gated* (the human authors and ratifies positions; the AI challenges) or *maintained* (the AI maintains; the human reviews positioning). Worldview → gated; reference → usually maintained.
4. **Relationship vocabulary** — the permitted `relates_to` edge types. Reuse the archetype's set unless the domain needs different edges. Keep vocabularies **per-wiki**; don't try to unify them across the federation.

## Step 3 — Wire it in

- Confirm the overlay imports the shared base at the correct relative path (e.g. `@../_shared/wiki-base.md`), or inline the base into the overlay if your tool doesn't resolve imports — and confirm it loads.
- Copy the six command files into `<wiki-name>/.claude/commands/`.
- Seed `_state/sources.md`, `_state/review-queue.md`, `index.md`, and `log.md` from `_shared/TEMPLATES.md`.

## Step 4 — Register it

Add a row to the registry table in the root `CLAUDE.md` (name, folder, archetype, one-line scope). The root file is the canonical list of what's in the federation and the place the "one wiki at a time, never cross-link" rule is enforced.

## Step 5 — Prove the loop before you lean on it

Ingest three or four sources, run a query, file an answer back, and run lint. Confirm the contradiction policy behaves as the archetype intends — a preserve-tension wiki keeps a test contradiction; a reconcile wiki flags one for resolution. Then it's live.

---

## When the recipe is NOT enough: confidential wikis

Some wikis carry a **confidentiality dimension the shared base does not model** — what is eligible to ingest, what is walled off, who and what may read it, and whether its content may be exported to downstream tools. A wiki holding client-confidential material, personal/private material, or anything with export restrictions is one of these. Before building it:

- Extend the base with a confidentiality layer (eligibility, redaction, read-scope), **or** create a separate `confidential-base.md` that sensitive wikis inherit instead of the open base.
- Decide its export posture explicitly: does its synthesis flow into downstream assistants/exports, or is it walled to the wiki only? Mark this in the overlay and in the root registry.
- Give it its own short charter and treat it as a deliberate addition, not a stamp-out. Apply the same confidentiality thinking before pointing any automated ingestion at sensitive material.

## Keeping the federation coherent as it grows

- **Base edits are federation-wide.** Change `_shared/wiki-base.md` only deliberately; every wiki inherits it instantly. Version it and note material changes in its changelog.
- **At three or more wikis,** the root `CLAUDE.md` router is what keeps boundaries clean — keep its registry current.
- **Vocabularies stay per-wiki.** Coherence comes from the shared base mechanics, not from forcing one relationship ontology across different domains.
