---
description: Work the review queue with me — the human-in-the-loop ritual
argument-hint: [optional: number of items to review]
---

You are running the **REVIEW** operation — clearing `_state/review-queue.md`. This is where authorship and positioning control actually live. Authority: `wiki-base.md` §8 and this wiki's overlay.

How many to review this pass: $ARGUMENTS *(default: all)*

Steps:

1. Read `_state/review-queue.md`. For each pending item, show me:
   - what it is and which page(s) it touches,
   - **why it was queued** (overwrite / decision-reversal / protected-page edit / contradiction resolution / low confidence / unratified inference),
   - the proposed change, with its sources.
2. Take my decision on each: **approve / edit / reject / defer.**
3. On approve: apply the change, set the right lifecycle/status (e.g., promote a ratified `inference` to a `position` or `synthesis`), update `index.md`, log it, commit. On reject: remove it from the queue and record why in `log.md`.
4. **Never decide on my behalf.** Protected-page and thesis edits require my explicit approval regardless of confidence.

Close with a summary: what was applied, what was rejected, and what remains in the queue.
