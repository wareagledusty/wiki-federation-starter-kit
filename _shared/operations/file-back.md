# Operation: file back

Save a strong answer or insight as a page, so it compounds instead of dying in the chat. Use this whenever the human asks to file back, save, or keep an answer, in any wording.

**Follow:** the shared rules (the top folder's `AGENTS.md`) and this wiki's `AGENTS.md`, especially its authorship rules.

**What to file:** what the human pointed at. If they didn't say, use the answer from the exchange just before.

## Steps

1. **Pick the page type** (comparison, synthesis, concept, or note) and start from its template in `_shared/TEMPLATES.md`. Name the file in lowercase with hyphens, under `wiki/`.
2. **Write it with citations** back to the pages and sources it draws on, using `[src: ...]`, and label each part **sourced**, **synthesis**, or **inference**. Keep every citation the answer had.
3. **Connect it.** Add typed `relates_to` edges (this wiki's vocabulary only), link to it from the pages it builds on where that helps a reader, and add it to `index.md`.
4. **Respect the authorship gate.** In a wiki that has one (preserve-tension wikis do), file the page as `status: draft`, register `inference`, and queue it in `_state/review-queue.md` for the human to ratify. Never present your synthesis as the human's position. In a reconcile wiki, a well-cited page that only adds may go in as `status: active`.
5. **Log** `## [YYYY-MM-DD] file-back | <page title>` in `log.md`.
6. **Commit** this wiki's folder only, with a message like `<wiki-folder>: file back <page title>`.

**Confirm** what you filed, where, its status, and whether it's waiting for the human's ratification.
