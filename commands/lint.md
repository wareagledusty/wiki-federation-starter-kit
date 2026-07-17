---
description: Health-check this wiki per its overlay's contradiction policy. Pass "report-only" for a snapshot with no edits.
argument-hint: [report-only | fix]
---

You are running the **LINT** operation. Authority: `wiki-base.md` §3 (Lint), §7 (lifecycle), §8 (review queue), and this wiki's overlay — which sets the contradiction policy.

**Mode:** $ARGUMENTS  *(if "report-only", produce the report and proposals but make no edits; this doubles as a status snapshot.)*

Run these checks:

1. **Orphans** — pages with no inbound links.
2. **Staleness** — compare each page's sources' current hashes (`_state/sources.md`) to what's recorded; mark drift `stale`. Apply this wiki's freshness windows if defined.
3. **Concept gaps** — concepts referenced across several pages with no page of their own; propose creating them.
4. **Contradictions — branch on THIS wiki's overlay policy:**
   - **Reconcile wiki:** find contradictions and propose resolutions toward one current truth; mark superseded claims (keep history); route any decision-reversal to the review queue.
   - **Preserve-tension wiki:** do **not** resolve existing contradictions. Instead flag **missing** expected tensions (a claim a major view would contest but that stands unchallenged), and ensure real contradictions are captured as typed edges, not erased.
5. **Lifecycle** — apply transitions (§7) and log each with when and why.
6. **Gaps** — note where a new source or search would fill a hole.

**Never silently overwrite.** Additive fixes may auto-apply; overwrites, decision-reversals, and protected-page edits go to `_state/review-queue.md`.

**Output a health report:** page counts, orphans, stale pages, contradictions (resolved or flagged per policy), concept-gap proposals, and current queue contents. Commit any auto-applied fixes with a clear message.
