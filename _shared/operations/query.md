# Operation: query

Answer a question from what this wiki already knows, with citations. Use this whenever the human asks the wiki a question, in any wording.

**Follow:** the shared rules (the top folder's `AGENTS.md`) and this wiki's `AGENTS.md`.

**The question:** what the human asked. If the question is unclear, ask before answering.

## Steps

1. **Find the pages.** Read `index.md` first, then read the relevant pages in full. Don't search in chunks or build an index of fragments. This is a read-the-right-files job.
2. **Answer** directly, grounded in those pages. Cite each point back to its page, and to the source behind it with `[src: ...]`. Mark what's **sourced**, what's **synthesis**, and what's **inference**.
3. **Surface margin notes.** If this wiki has a `notes/` folder, mention any notes that bear on the question.
4. **Say what's missing.** If the wiki can't support part of the answer, say so plainly, and offer to ingest a source that would close the gap. Never fill the gap with a guess.
5. **Offer to keep it.** If the answer is worth keeping (a comparison, a new connection, a sharper framing), offer to file it back as a page with the file-back operation. In a reconcile wiki, if the answer changes the present best answer, also offer to update `current-state.md`.

A query that changes nothing needs no log entry and no commit. If the human accepts an update, record it: a new page is a `file-back`, and a `current-state.md` update is logged as `query`, then committed as `<wiki-folder>: query <topic>`.
