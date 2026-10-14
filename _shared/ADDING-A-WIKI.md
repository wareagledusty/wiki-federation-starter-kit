# Adding a wiki

Once your first wiki is working, adding another takes about twenty minutes. A set of wikis that share one set of rules is a **federation**. The shared mechanics live in the top folder's `AGENTS.md`, and each wiki's own `AGENTS.md` sets its policy. The wikis never link to each other, because clean separation is the point.

Most new wikis are a variant of one of the two archetypes. Copy the closer one, and change only what differs.

## Step 1. Pick the archetype

* **Reconcile:** one current, cited answer per question. It fits competitive intelligence, reference material, and anything factual or operational, especially a wiki that takes in outside sources or feeds other tools. Use `archetypes/reconcile-overlay.md`.
* **Preserve-tension:** competing views stay in dialogue, and the load-bearing claims are yours. It fits a worldview, a thesis, or a research field. Use `archetypes/preserve-tension-overlay.md`.

If neither fits cleanly, start from the closer one and adjust. Don't invent a third archetype.

## Step 2. Create the folder

The easy way: start your agent in the top folder and say "Add a wiki, following _shared/ADDING-A-WIKI.md." To do it by hand, run the Step 3 commands in [SETUP.md](../SETUP.md), with your new folder name in place of `my-wiki`. Either way, you get:

```
<new-wiki>/
├── AGENTS.md   CLAUDE.md
├── index.md    log.md
├── raw/   wiki/sources/   _state/ (sources.md, review-queue.md)
└── reconcile: current-state.md  initiatives/  archive/  exports/       preserve-tension: notes/
```

## Step 3. Make the four decisions

Write these into the new wiki's `AGENTS.md`:

1. **Scope:** one paragraph on what belongs here and, by implication, what doesn't. This is the boundary.
2. **Contradiction policy:** reconcile, for one current answer, or preserve, to keep the tension. It sets how lint behaves, so it's the load-bearing choice. The archetype already sets it; leave it unless you know why you're changing it.
3. **Authorship:** gated, where you author and ratify positions and the agent challenges them, or maintained, where the agent maintains and you review positioning. Worldview wikis are gated. Reference wikis are usually maintained.
4. **Relationship vocabulary:** the `relates_to` edge types. Keep the archetype's set unless the domain needs different edges. Each wiki keeps its own vocabulary.

Then replace the remaining placeholders, delete the "Template note" paragraph, and keep the "Shared rules first" paragraph.

## Step 4. Register it

Add a row to the registry table in the top folder's `AGENTS.md`: the name, folder, archetype, and one-line scope. The registry is the canonical list of what's here, and it's how the agent applies the "one wiki at a time, never cross-link" rule.

## Step 5. Commit it, then prove the loop

Commit the new wiki on its own, with a message like `<new-wiki>: create wiki`. Then start your agent inside the new wiki's folder, and run the four moves with three or four sources: ingest, query, file back, and lint. Check that the contradiction policy behaves as intended. A reconcile wiki flags a contradiction to resolve; a preserve-tension wiki keeps it.

---

## Confidential wikis

Some wikis need rules the shared base doesn't cover: what may be ingested, what's walled off, who and what may read it, and whether anything may leave it. Client-confidential material, personal records, and anything under export limits all belong here.

**A word on privacy:** when your agent reads a source, that content goes to the AI provider under your account's terms. Check those terms before you ingest anything client-confidential.

Before you build one:

* Decide what's eligible to ingest, what gets redacted, and who may read the wiki. Write it into the scope section of the wiki's `AGENTS.md`, or create a separate `confidential-base.md` that only the sensitive wikis follow.
* Decide its export posture: does its synthesis flow out to other tools, or does it stay in the wiki? Record the decision in the wiki's `AGENTS.md` and in its registry row.
* Treat it as a deliberate addition with its own short charter, not a quick copy. Take the same care before pointing any automated ingest at sensitive material.

## Keeping several wikis coherent

* **A change to the shared rules reaches every wiki at once.** Change the top folder's `AGENTS.md` deliberately, commit it on its own, and note material changes in its changelog section.
* **Keep the registry current.** At three or more wikis, it's what keeps the boundaries clean.
* **Vocabularies stay per wiki.** Coherence comes from the shared mechanics, not from forcing one set of relationships onto different domains.
