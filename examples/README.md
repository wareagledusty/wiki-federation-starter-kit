# Sample wiki

A small, fully worked, **fictional** wiki, so you can see what the kit produces before you build your own. Kestrel Bay Roasters, a wholesale coffee roaster, uses it to keep track of competitors and customers. The company, the people, and every figure in it are invented.

It's a **reconcile** wiki: one current, cited answer per question. It's frozen on 2026-03-13, after three ingests, one filed-back answer, and a lint.

## Open these first

1. **[current-state.md](sample-wiki/current-state.md):** what's true now. It's the page you'd reach for first, and every answer on it is cited.
2. **[wiki/ironvale-coffee.md](sample-wiki/wiki/ironvale-coffee.md):** a resolved contradiction. Two sources disagreed on a competitor's price. The newer, more authoritative one won, and the old claim stays visible, struck through and cited, under "Superseded."
3. **[wiki/copperline-renewal-position.md](sample-wiki/wiki/copperline-renewal-position.md):** a filed-back answer. A question became a permanent comparison page, with a citation in every cell.
4. **[log.md](sample-wiki/log.md):** the wiki's diary, with one entry per operation.

## What each part shows

| Where | What it shows |
|---|---|
| [raw/](sample-wiki/raw/2026-03-02-leadership-meeting.md) | The three sources, as the human dropped them in. The agent never edits these. |
| [wiki/sources/](sample-wiki/wiki/sources/2026-03-09-ironvale-price-sheet.md) | One summary page per source, listing what it changed. |
| [Kestrel Bay Roasters](sample-wiki/wiki/kestrel-bay-roasters.md), [Ironvale Coffee](sample-wiki/wiki/ironvale-coffee.md), [Copperline Cafes](sample-wiki/wiki/copperline-cafes.md) | Entity pages, with typed `relates_to` edges in the frontmatter and a citation on every claim. |
| [Wholesale pricing](sample-wiki/wiki/wholesale-pricing.md), [Freshness guarantee](sample-wiki/wiki/freshness-guarantee.md) | Concept pages. |
| [initiatives/](sample-wiki/initiatives/freshness-guarantee-pilot.md) | An initiative with start and end dates and a goal, plus an open `{{VERIFY: ...}}` where the sources don't say. |
| [index.md](sample-wiki/index.md) | The catalog the agent reads first on every question. |
| [_state/sources.md](sample-wiki/_state/sources.md) | The source ledger, with each file's real sha256. |
| [_state/review-queue.md](sample-wiki/_state/review-queue.md) | One positioning question waiting for the human. |
| [AGENTS.md](sample-wiki/AGENTS.md), [CLAUDE.md](sample-wiki/CLAUDE.md) | The wiki's rules: the reconcile archetype, with its placeholders filled in. |

A citation looks like `[src: 2026-03-09-ironvale-price-sheet.md#pricing]`: a file in `raw/`, then the section of it that supports the claim.

## Try it

Start your AI agent inside `examples/sample-wiki/` and ask it a question, such as "What does Ironvale charge, and how sure are we?" You'll get a cited answer. Because the example is frozen in March 2026, a lint today will also flag every page as past its `review_by` date. That's the freshness rule doing its job.

The sample wiki isn't part of your own wikis, and you can delete `examples/` whenever you like.
