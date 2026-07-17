---
description: Fold a new source into this wiki (per wiki-base.md + this wiki's overlay)
argument-hint: [path to source in raw/]
---

You are running the **INGEST** operation for this wiki. Authority: `wiki-base.md` §3 (Ingest), §5 (Provenance), §8 (Review queue), and this wiki's `CLAUDE.md` overlay — which sets the contradiction policy, the authorship rules, and whether unsupervised/batch ingest is allowed.

**Source to ingest:** $ARGUMENTS
*(If empty: ask which file in `raw/` to ingest, or list sources in `raw/` not yet recorded in `_state/sources.md`.)*

Do this, in order:

1. **Read** the source in `raw/`. Never modify `raw/`.
2. **Identity check.** Compute a content hash. Check `_state/sources.md`: if this source was already ingested and is unchanged, stop and say so. If it changed, switch to re-ingest mode and update only what the change affects.
3. **Propose, don't write.** Summarize the key takeaways, then list the pages you will create or update and the claims you will write. **Wait for my go-ahead** unless this wiki's overlay explicitly authorizes batch mode.
4. **Integrate** (on approval):
   - Create or update the source-summary page.
   - Update every affected entity and concept page; create a concept page where a new concept earns one. A single source usually touches several pages.
   - Attach a citation token `[src: <source-filename>#<locator>]` to every claim. **Before writing a claim, grep the wiki for that citation/claim identity; if present, update in place — never append a duplicate.**
   - Maintain typed `relates_to` edges using ONLY this wiki's permitted vocabulary.
   - Handle any contradiction per this wiki's overlay (preserve vs. reconcile). Never auto-resolve a protected page.
   - Respect the authorship rules: in an authorship-gated wiki, anything that would assert a position or thesis is written as `inference`/`draft`, not a ratified claim, and routed for ratification.
5. **Record.** Update `index.md`; append `## [YYYY-MM-DD] ingest | <source title>` to `log.md` with what changed and how many pages were touched; update `_state/sources.md` (hash, filename, date, pages informed).
6. **Commit** with a message naming the source. Route anything uncertain to `_state/review-queue.md`.

**Report back:** what changed, what's queued, and anything you could not source — flag it with `[[VERIFY]]`, never invent it.
