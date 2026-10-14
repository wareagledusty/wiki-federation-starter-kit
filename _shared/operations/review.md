# Operation: review

Work through the review queue with the human. This is where the human keeps control of authorship and positioning. Use this whenever the human asks to review, clear the queue, or go through pending decisions, in any wording.

**Follow:** the shared rules (the top folder's `AGENTS.md`: the review queue) and this wiki's `AGENTS.md`.

**How many:** what the human asked for, or every pending item.

## Steps

1. **Read** `_state/review-queue.md`. For each pending item, show the human:
   * what it is, and which pages it touches;
   * why it was queued: an overwrite, a decision reversal, a protected-page edit, a contradiction resolution, low confidence, or an unratified inference;
   * the proposed change, with its sources.
2. **Take the human's decision** on each: approve, edit, reject, or defer.
3. **Apply it.**
   * **Approve or edit:** make the change, set the right status (for example, a ratified `inference` becomes a `position` or `synthesis`), update `index.md`, and mark the item decided in the queue.
   * **Reject:** mark the item rejected in the queue, with the reason.
   * **Defer:** leave it pending, with a note.
4. **Never decide for the human.** Protected-page and thesis edits need the human's explicit approval, however confident you are.
5. **Log** `## [YYYY-MM-DD] review | <number> items` and commit with a message like `<wiki-folder>: review queue`.

**Close** with a summary: what was applied, what was rejected, and what's still pending.
