# <WIKI NAME>: wiki rules (preserve-tension archetype)

> **Shared rules first.** This file adds to the shared rules in the top folder's `AGENTS.md`, titled "Shared rules for every wiki here." If those rules aren't in your context, read that file in full before doing anything else. For a wiki in the top folder, it's `../AGENTS.md`. Where this file and the shared rules differ, **this file wins for this wiki.**
>
> **Template note (delete this paragraph after setup):** copy this file to `<wiki-folder>/AGENTS.md`, replace every `<PLACEHOLDER>`, and put a `CLAUDE.md` beside it containing the single line `@AGENTS.md`. Leave THE THESIS block for the human. This is the **preserve-tension** archetype: competing views stay in dialogue, and the load-bearing claims must be the human's.

## THE THESIS (written by the human; you never write or edit this block)

> **[ The human states the thesis here, in one or two sentences. It's the spine of the whole wiki. Until it's filled in, treat the thesis as undefined, and don't let any page assert one. ]**

You may pressure-test this thesis (section 3), and maintain pages that explore, support, or challenge it. You may **never** rewrite, soften, or "improve" this statement. Only the human changes it.

## 1. Scope

<SCOPE: one paragraph on what this wiki holds and, by implication, what it doesn't. Example: "A worldview and thesis: the synthesis-heavy body of thinking that isn't commercial, competitive, product, or operational material. Traditions, sources, arguments, and the human's own evolving position belong here.">

<CONFIDENTIALITY: say whether this wiki holds personal or confidential material, and whether anything may leave it (see "Confidential wikis" in `_shared/ADDING-A-WIKI.md`). Or write "No confidential material.">

Material whose main purpose is commercial, competitive, product, or operational doesn't belong here. If this top folder has a reconcile wiki, it goes there; otherwise, leave it out.

## 2. Epistemology: preserve tension (this sets the lint direction)

Contradictions here are **information, not defects**. This is a dialogic domain: the tension between two traditions or two thinkers is often the content itself. **Don't** reconcile competing accounts into one tidy synthesis.

* **Lint is inverted.** Instead of resolving contradictions, flag the **absence of expected tension**: a page that should be in dialogue with an opposing view but isn't, or a claim presented as settled that a major tradition would contest. **Never resolve an existing contradiction on your own.** Preserve it, and make it easy to navigate.
* A `contradicts` or `tensions-with` edge is a feature to keep, not a warning to clear.
* When sources disagree, represent **both**, with their provenance and the nature of the disagreement. "What challenges this?" should be answerable by following tension edges.

**Permitted `relates_to` vocabulary:** `contradicts`, `tensions-with`, `extends`, `responds-to`, `reframes`, `parallels`, `synthesizes`, `supersedes` (rarely; usually the older view still lives on as a position).

## 3. Authorship gate (the cardinal rule; for thesis content it overrides the shared review rules)

The worldview must stay **the human's**. If you author the synthesis, the thinking quietly stops being theirs.

* You **may** draft prose, summarize sources, propose links, keep the derivative layer consistent, and surface patterns.
* You **may not** author, assert, soften, or silently change a **thesis claim, position, or framing**.
* **Protected pages** always go to review and are never applied directly, **whatever your confidence**: `wiki/overview.md` (the thesis synthesis), any page typed `synthesis`, and any page tagged `position:`. Edits to these are proposals only.
* **Socratic by default.** When the human proposes an idea, don't file it yet. Challenge it first: the strongest counterexample, the weakest link, the tradition or thinker who would reject it, the evidence against it. Only after the human revises it and **ratifies** it does it become a position or synthesis page. The wiki holds refined thinking that survived challenge, not plausible filler.
* **Every page shows three registers:**
  1. **Sourced:** traceable to a source, and cited.
  2. **Position:** the human's ratified claim, marked, and present only after ratification.
  3. **Inference:** your suggested connection or reading, labeled `inference:`, and unpromoted until the human ratifies it. An inference never poses as a position.

## 4. Margin notes (`notes/`)

Keep a `notes/` folder, **separate from the clean pages**, as the margin of the research notebook. It's for anything not yet ratified:

* inferred connections and possible links across traditions;
* "this might matter later" hunches;
* open questions and tensions worth chasing;
* sources to find later;
* hunches that touch another wiki's domain, recorded here and never written into the other wiki.

`notes/` is **not** thesis content. It's raw material the human may later ratify into a page, or discard. Surface relevant notes during query and lint, but never let them quietly become positions.

## 5. Consolidation (proposal-only here)

When asked, run a consolidation pass, separate from lint:

* Re-read the page graph, and surface emerging patterns and **productive tensions** across sources.
* Where a theme recurs without its own page, **propose** one.
* Re-link and tidy the derivative layer.
* Write the report, `_state/consolidation-YYYY-MM-DD.md`, as **proposals for the human to ratify**, never as authored thesis. The human crystallizes new structure; you surface the candidates.

## 6. Ingest tuning

* Sources are often books and long works. **Ingest a chapter or section at a time.** Fine grain is what surfaces patterns across works that no single work shows.
* **Keep each tradition's own voice and frame.** Don't flatten different worldviews into one neutral register. Tag each claim with its tradition and its source.
* Ingest one source at a time, with the human involved. There's no unsupervised batch ingest here: the judgment is the point.

## 7. Query and output

* Favor outputs that **hold** tension: debate maps, comparison tables with a "where they conflict" column, and summaries that keep both poles.
* A filed-back answer goes in as `inference` with `status: draft`. It becomes a position or synthesis page **only after the human ratifies it.**

## 8. What to optimize for

A living map of a worldview and its internal debates that gets sharper and better connected over time. Every load-bearing claim is the human's and has been tested, and the tensions that make the thesis interesting are kept, not dissolved.

## 9. Layout

```
<wiki-folder>/
├── AGENTS.md            this file, placeholders filled
├── CLAUDE.md            one line: @AGENTS.md
├── index.md   log.md
├── raw/                 immutable sources
├── wiki/                the pages, including wiki/overview.md
│   └── sources/         one summary page per ingested source
├── notes/               margin notes (section 4)
└── _state/              sources.md, review-queue.md, consolidation reports
```

Pages live under `wiki/`. The protected overview role (section 3) belongs to `wiki/overview.md`, the canonical "where the thesis stands today" page. When the human writes THE THESIS, they decide whether it stays in this file or gets its own page.
