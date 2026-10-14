# Operation: ingest

Fold one new source into this wiki. Use this whenever the human asks to ingest, add, or process a source, in any wording.

**Follow:** the shared rules (the top folder's `AGENTS.md`) and this wiki's `AGENTS.md`. The wiki's file sets the contradiction policy, the authorship rules, and whether batch ingest is allowed. Where the two differ, the wiki's file wins.

**The source:** the file the human named. If they didn't name one, list the files in `raw/` that have no row in `_state/sources.md` (skip dotfiles such as `.gitkeep`), and ask which one to ingest.

## Steps

1. **Read** the source in `raw/`. Never change anything in `raw/`.
2. **Check its identity.** Compute its sha256 with `sha256sum <file>`, or `shasum -a 256 <file>` where `sha256sum` is missing. If `_state/sources.md` already lists this file with the same hash, stop and say so. If the hash changed, this is a re-ingest: update only what the change affects.
3. **Confirm the job.** A source is ingested for something, never "just in case." Confirm what this wiki needs from it. If part of it belongs to another wiki's scope, take only this wiki's part, and note the rest as a one-line hunch (shared rules, section 4).
4. **Propose; don't write yet.** Summarize the key takeaways. List the pages you'll create or update, and the claims you'll write. Wait for the human's go-ahead, unless this wiki's `AGENTS.md` explicitly allows batch mode.
5. **Integrate,** once the human says go:
   * Write the source-summary page at `wiki/sources/<source file name>.md`, from the template in `_shared/TEMPLATES.md`.
   * Update every entity and concept page the source touches. Create a concept page where a new concept earns one. One source usually touches several pages. If every source only ever touches one page, you've built a folder, not a wiki.
   * End every claim with a citation: `[src: <source-file>#<locator>]`.
   * Before you write a claim, search the wiki for its citation. If that claim is already there, update it in place. Never add a duplicate.
   * Add typed `relates_to` edges, using only this wiki's vocabulary, and link related pages with relative markdown links.
   * Handle each contradiction the way this wiki's `AGENTS.md` says. Never resolve one on a protected page on your own.
   * In a wiki with an authorship gate, anything that would state a position goes in as `inference`, with `status: draft`, and into the review queue.
   * If a value is unknown, write `{{VERIFY: what's missing}}`. Never invent it.
6. **Record it.**
   * `index.md`: add or update a line for every page you created or changed.
   * `_state/sources.md`: add or update the row with the source file, its full sha256, today's date, its trust tier if this wiki uses tiers, and links to the pages it informed.
   * `log.md`: append `## [YYYY-MM-DD] ingest | <source title>`, then a line on what changed and how many pages it touched.
7. **Queue** anything uncertain, and anything the shared rules send to review, in `_state/review-queue.md`.
8. **Commit** this wiki's folder only, with a message like `<wiki-folder>: ingest <source file>`.

**Report back:** what changed, what's queued, and every `{{VERIFY: ...}}` you left.
