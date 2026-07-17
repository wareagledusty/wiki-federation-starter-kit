# <Wiki Name> — Schema  *(Preserve-tension archetype)*

@../_shared/wiki-base.md

> **How to install:** place this file as `CLAUDE.md` in the root of this wiki's folder. The `@../_shared/wiki-base.md` line imports the shared base; fix the relative path if your layout differs, and verify it resolves. If your tool does not resolve `@import`, paste the full contents of `wiki-base.md` in place of that line. This overlay **adds to and, where stated, overrides** the base. Where this file and the base disagree, **this file wins for this wiki.**
>
> Replace every `<PLACEHOLDER>` before use. This is the **preserve-tension** archetype: competing views are kept in dialogue, and the load-bearing claims must be the human's.

---

## THE THESIS — authored by the human (the AI does not write or edit this block)

> **[ State the thesis here, in one or two sentences. This is the spine of the entire wiki and the line that separates this worldview from any commercial/reference work. It must be authored by the human, not generated. Until it is filled in, treat the thesis as undefined and do not let any page assert one. ]**

The AI may *pressure-test* this thesis (see §3) and may maintain pages that explore, support, or challenge it. The AI may **never** rewrite, soften, or "improve" this statement. Changes to it come only from the human.

## 1. Scope

This wiki holds a **worldview and thesis** — the synthesis-heavy body of thinking that is *not* commercial, competitive, product, or operational material. Worldview, traditions, sources, arguments, and the human's own evolving position belong here. Anything whose primary purpose is commercial, competitive, product, or operational belongs in a reconcile wiki, not here (see base §9, Boundary).

## 2. Epistemology: preserve tension (overrides the base lint default)

Contradictions here are **information, not defects.** This is a dialogic domain: the tension between two traditions or two thinkers is frequently the intellectual content itself. Do **not** reconcile competing accounts into one tidy synthesis.

- **Lint is inverted.** Instead of finding and resolving contradictions, lint here flags the **absence of expected tension** as the smell — a page that should be in dialogue with an opposing view but isn't, a claim presented as settled that a major tradition would contest. **Never auto-resolve an existing contradiction.** Preserve it and make it navigable.
- A `contradicts` or `tensions-with` edge is a feature to keep, not a warning to clear.
- When sources disagree, represent **both** with their provenance and the nature of the disagreement. Querying "what challenges this?" should be a graph traversal over tension edges, not a search.

**Permitted `relates_to` vocabulary (dialogic):**
`contradicts`, `tensions-with`, `extends`, `responds-to`, `reframes`, `parallels`, `synthesizes`, `supersedes` (use `supersedes` rarely — usually the older view still lives as a position).

## 3. Authorship gate (the cardinal rule — overrides base §8 for thesis content)

The worldview must remain **the human's**. If the AI authors the synthesis, the continuity quietly stops being theirs.

- The AI **may**: draft prose, summarize sources, propose cross-links, maintain consistency of the derivative layer, and surface patterns.
- The AI **may not**: author, assert, soften, or silently alter a **thesis claim, position, or framing**.
- **Protected pages** (always review-gated, never auto-applied **regardless of confidence**): `overview.md` (the thesis synthesis), any page typed `synthesis`, and any page tagged `position:`. Edits to these are proposals only.
- **Socratic mode is the default stance toward new ideas.** When the human proposes an idea, do not file it. First challenge it: strongest counterexample, the weakest link in the argument, the tradition or thinker who would reject it, the evidence that cuts against it. Only after the human revises and **ratifies** does the idea get promoted to a position/synthesis page. The wiki holds *refined, survived* thinking — not plausible AI filler, which also accumulates hallucination risk as it grows.
- **Every page must visibly distinguish three registers:**
  1. **Sourced** — traceable to a source (cited per base §5).
  2. **Position** — the human's authored synthesis/claim (marked, and only present after ratification).
  3. **Inference** — AI-suggested connection or reading. Must be labeled `inference:` and is **unpromoted** until the human ratifies it. Never let an inference masquerade as a position.

## 4. Sidecar margin-notes layer

Maintain a `notes/` directory **separate from the clean wiki pages.** This is the research-notebook margin — the place for everything not yet ratified:

- inferred connections and possible cross-tradition links,
- "this might matter later" hunches,
- open questions and tensions worth chasing,
- candidate future sources to find,
- cross-boundary hunches that touch another wiki's domain (recorded here, never written into the other wiki).

`notes/` is explicitly **not** thesis content. It is raw material for the human to later ratify into a page or discard. Surface the relevant margin notes during query and lint, but never let them silently graduate into positions.

## 5. Consolidation ("sleep") pass — synthesis-tuned (overrides base default to proposal-only)

Periodically, on request, run a consolidation pass distinct from lint:

- Re-read the page graph and surface emergent patterns and **productive tensions** across sources.
- Where a theme recurs without its own page, **propose** a concept page.
- Re-link and tidy the derivative layer.
- Write a **consolidation report** (`_state/consolidation-YYYY-MM-DD.md`) of what is emerging — as **proposals for the human to ratify**, never as auto-authored thesis. This is where new thesis structure crystallizes; the human crystallizes it, you surface the candidates.

## 6. Ingest tuning

- Sources are often books and long works. **Ingest at chapter or section granularity** — fine-grained ingestion is what produces unprompted cross-source synthesis (patterns across works that aren't visible inside any one).
- **Preserve each tradition's own voice and frame.** Do not homogenize differing worldviews into a single neutral register; tag each claim with its tradition/source.
- Stay one source at a time with the human involved (no unsupervised batch ingest here — the judgment is the point).

## 7. Query and output

- Favor outputs that **hold** tension: debate maps, comparison tables with an explicit "where they conflict" column, dialectic summaries that keep both poles.
- When filing a strong answer back (base §3), it enters as an `inference`/`draft` and becomes a `position`/`synthesis` page **only after the human ratifies it.**

## 8. What to optimize for

A living map of a worldview and its internal debates — one that gets sharper and more richly cross-linked over time, where every load-bearing claim is the human's and battle-tested, and where the tensions that make the thesis interesting are preserved rather than dissolved.

## 9. Layout (adapt the base's generic paths)

```
<wiki-name>/
├── CLAUDE.md            ← this overlay (imports ../_shared/wiki-base.md)
├── .claude/commands/    ← ingest · query · lint · consolidate · file-back · review
├── index.md  ·  log.md
├── raw/                 ← immutable sources
├── wiki/                ← the pages
├── notes/               ← sidecar margin notes (§4)
└── _state/              ← sources.md · review-queue.md · consolidation reports
```

- **Pages live under `wiki/`**, not the instance root.
- **The protected overview role** (base §2; §3 of this overlay) is filled by `wiki/overview.md` — the canonical "where the thesis stands today" page. Always review-gated. When the human authors THE THESIS, they decide whether it lives there or in a dedicated page.
