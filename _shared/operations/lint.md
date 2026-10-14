# Operation: lint

Health-check this wiki. Use this whenever the human asks for a lint, a health check, a status check, or a cleanup, in any wording. Lint keeps the wiki healthy. Consolidation, a separate operation, makes it deeper.

**Follow:** the shared rules (the top folder's `AGENTS.md`: page lifecycle and the review queue) and this wiki's `AGENTS.md`, which sets the contradiction policy.

**Mode:** if the human asks only for a report or a status snapshot, run every check but change nothing, not even the log. Otherwise, apply the safe fixes described below.

## Checks

1. **Orphans:** pages no other page links to.
2. **Broken links:** relative links that point at a file that doesn't exist.
3. **Staleness:** recompute each source's sha256 and compare it with `_state/sources.md`. Mark the pages that depend on a changed source `stale`. If this wiki sets freshness windows, also flag every page whose `review_by` date has passed.
4. **Open placeholders:** list every `{{VERIFY: ...}}` in the wiki, with its page.
5. **Concept gaps:** concepts mentioned across several pages with no page of their own. Propose creating them.
6. **Contradictions:** follow this wiki's policy.
   * **Reconcile:** find contradictions, and propose resolving each one toward a single current, cited answer. Mark the superseded claim instead of deleting it. Queue any resolution that reverses a decision.
   * **Preserve-tension:** never resolve an existing contradiction. Flag missing tension instead: a claim a major view would contest that stands unchallenged. Make sure real contradictions are captured as typed edges.
7. **Lifecycle:** apply status changes (shared rules, page lifecycle), noting when and why.
8. **Gaps:** note where a new source or a search would fill a hole.

**Never overwrite silently.** Additive fixes, like a missing link, an index line, or a `stale` flag, may apply directly. Overwrites, decision reversals, and edits to protected pages go to `_state/review-queue.md`.

## Report

Give a health report: page count, orphans, broken links, stale pages, open placeholders, contradictions (resolved or flagged), concept-gap proposals, and what's waiting in the review queue.

Unless this was report-only, log `## [YYYY-MM-DD] lint | <scope>` with the counts, and commit any fixes with a message like `<wiki-folder>: lint <scope>`.
