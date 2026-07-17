---
description: Answer a question from this wiki, with citations
argument-hint: [your question]
---

You are running the **QUERY** operation. Authority: `wiki-base.md` §3 (Query) and this wiki's overlay.

**Question:** $ARGUMENTS

Steps:

1. Read `index.md` to locate the relevant pages, then **read those whole pages.** Do not vector-search or chunk — this is a read-the-right-files operation.
2. Answer concisely and directly, grounded in the pages, with citations back to pages and their sources `[src: ...]`. Clearly distinguish **sourced fact** from **synthesis** from **inference**.
3. If this wiki has a `notes/` sidecar, surface any margin notes that bear on the question.
4. If the answer is a durable artifact — a comparison, a newly drawn connection, a sharpened framing — offer to preserve it with `/file-back`. In a reconcile wiki, if this changes the present best answer, offer to update `current-state.md`.

Do not fabricate. If the wiki cannot support part of the answer, say so plainly and offer to ingest a source that would close the gap.
