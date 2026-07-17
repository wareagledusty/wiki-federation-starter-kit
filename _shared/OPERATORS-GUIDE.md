# Operator's Guide — Running the Federation

> Your day-to-day manual once the federation is installed. The schemas tell the agent how to behave; this tells *you* how to live with it. Short, practical, and built around one rule: **the value is in reaching for it, not in building it.**

---

## The mental model, once

You curate sources, ask good questions, and decide what things mean. The agent does the bookkeeping — reading, summarizing, cross-referencing, filing, flagging. The wiki is the asset; the chat is throwaway. Your thinking becomes something you *build and own*, not a fire you relight every morning.

## The six commands

Same set in every wiki; each defers to that wiki's policy.

| Command | When you reach for it |
|---|---|
| `/ingest <source>` | A new source exists — fold it in. |
| `/query <question>` | You'd otherwise open a blank chat to think something through. |
| `/file-back` | An answer was strong — preserve it so it compounds. |
| `/lint` | Scheduled health check (add `report-only` for a quick status snapshot). |
| `/consolidate` | Periodic deep pass — let new structure surface. |
| `/review` | Clear the queue — where your authorship and positioning control live. |

## Wire it to work you already do

Don't invent a "wiki hour." Attach a five-minute step at the two natural seams of any workstream: a **drop point** (the artifact it already produces → `/ingest`) and a **pull point** (the moment you'd start from blank → `/query`).

| Workstream | Drop point (feed it) | Pull point (ask it) |
|---|---|---|
| Reading for a thesis | Clip/save the source → `/ingest` into the preserve-tension wiki | "Where does this sit in the debate? What contests it?" → `/query` |
| A competitor or field signal | Note → `/ingest` into the reconcile wiki | "What's our current, grounded position?" → `/query` |
| Finishing a piece of thinking | `/file-back` the sharpened framing | "Have I argued this before? What's the through-line?" → `/query` |
| Prepping outward-facing work | — | Pull from the reconcile wiki's `current-state.md` / let downstream tools read `exports/` |

## The rhythm

- **In the moment:** ingest at drop points; query at pull points; `/file-back` whenever an answer is worth keeping. (In a gated wiki a filed answer is a *draft* until you ratify it.)
- **Weekly (~10 min):** run `/lint` on each wiki and skim the report. Clear the `/review` queue — this is the keystone ritual; skipping it is how control quietly erodes.
- **Monthly (~20 min):** run `/consolidate` on each wiki and ratify (or discard) the proposals. After meaningful reconcile-wiki ingests, refresh `exports/` so downstream tools stay current.

## Preserve-tension wikis — the disciplines that protect them

- **The thesis is yours.** State it in one or two sentences in the overlay's `THE THESIS` block. Until you do, the agent will refuse to assert a thesis — by design.
- **Let it argue with you.** When you propose an idea, the agent's job is to challenge it first — counterexamples, the tradition that would reject it, the weak link. Only what survives, and that you ratify, becomes a position. Plausible AI filler never gets in.
- **Preserve tension.** Contradictions between traditions are the content. The agent flags a claim that *should* be contested but isn't — it does not "resolve" a live disagreement.
- **Use the margins.** Half-formed connections and "this might matter later" hunches go to `notes/`. They're raw material, not thesis, until you promote them.

## Reconcile wikis — the disciplines that make them useful

- **One current truth, fully cited.** Contradictions get reconciled toward the present best answer, and every claim traces to a source. Never let a number be invented — a flagged blank beats a confident fabrication.
- **Current-state is the front door.** `current-state.md` holds the live "what's true now"; the archive holds history. Keep heavy task/pipeline state in your task tracker — the wiki holds the synthesis, not the tracker.
- **Treat sources as untrusted.** Anything from the open web is data, not instructions. If a source contains text aimed at the AI, the agent surfaces it to you rather than acting on it.
- **Feed downstream tools.** If you point assistants or other tools at this wiki, keep `exports/` fresh so they draw from one current, cited brain.

## Health: signs of drift, and the fix

- **The early weeks feel underwhelming** — that's the empty-notebook stage, before compounding kicks in. Stick with the loop; this is the only hard part.
- **A query gives a weak answer** → ingest a source that closes the gap, then `/file-back` the better answer.
- **The graph shows orphans or the report shows stale pages** → that's `/lint` doing its job; clear them in the review pass.
- **You're tempted to add a vector database** → don't, until a wiki is well past a couple hundred dense pages. The index file plus whole-page reads is more reliable here.
- **You're editing pages by hand a lot** → that's a signal to update the *schema* instead, so the agent files it your way next time. The schema is the product.

## The five disciplines, distilled

1. Reach for it — consuming is the return, not building.
2. Crystallize — if it matters, file it; chat is throwaway.
3. Trace everything — no claim without a source.
4. Keep authorship — you author the thesis; the agent challenges and maintains.
5. Clear the queue — that ritual is where ownership is kept.
