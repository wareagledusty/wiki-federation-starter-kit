# Operator's guide: living with your wiki

This is your day-to-day manual once a wiki is built. The rules tell the agent how to behave; this guide tells you how to live with it. It comes down to one idea: **the value is in reaching for the wiki, not in building it.**

## Where to start your agent

Start it **inside the wiki's folder**. That's how Claude Code and Codex load both the shared rules and your wiki's rules. For other agents, see [COMPATIBILITY.md](../COMPATIBILITY.md).

## The mental model

You curate sources, ask good questions, and decide what things mean. The agent does the bookkeeping: reading, summarizing, cross-referencing, filing, and flagging. The wiki is the asset, and the chat is disposable. Your thinking becomes something you build and own, instead of a fire you relight every morning.

## The four moves

Ask in plain words. Agents that support skills also offer the shortcuts in the last column.

| Move | When you reach for it | Say something like | Shortcut |
|---|---|---|---|
| **Ingest** | A new source exists, so fold it in. | "Ingest raw/pricing-notes.md." | `wiki-ingest` |
| **Query** | You'd otherwise open a blank chat to think something through. | "What's our current position on pricing?" | `wiki-query` |
| **File back** | An answer was strong, so keep it and let it compound. | "File that back as a page." | `wiki-file-back` |
| **Lint** | Your weekly health check. | "Run a lint." For a snapshot with no changes: "Lint, report only." | `wiki-lint` |

## Keeping it healthy

| Operation | When you reach for it | Say something like | Shortcut |
|---|---|---|---|
| **Consolidate** | Monthly, so deeper structure can surface. | "Consolidate the wiki." | `wiki-consolidate` |
| **Review** | Weekly, to clear the decisions the agent queued for you. This is where you keep control. | "Let's go through the review queue." | `wiki-review` |

## Wire it to work you already do

Don't invent a "wiki hour." Attach a five-minute step to the two natural seams of any workstream. A **drop point** is where the work already produces something you can ingest. A **pull point** is the moment you'd otherwise start from a blank page, so you query instead.

| Workstream | Drop point (feed it) | Pull point (ask it) |
|---|---|---|
| A competitor or market signal | Save the note and ingest it into your reconcile wiki | "What's our current, grounded position?" |
| Reading for a thesis | Save the source and ingest it into your preserve-tension wiki | "Where does this sit in the debate? What contests it?" |
| Finishing a piece of thinking | File back the sharpened framing | "Have I argued this before? What's the through-line?" |
| Preparing outward-facing work | Nothing new to feed | Pull from `current-state.md`, or let other tools read `exports/` |

## The rhythm

* **In the moment:** ingest at drop points, query at pull points, and file back whenever an answer is worth keeping. In a gated wiki, a filed answer is a draft until you ratify it.
* **Weekly, about ten minutes:** run a lint and skim the report. Clear the review queue. It's the keystone habit, and skipping it is how control quietly erodes.
* **Monthly, about twenty minutes:** consolidate, then ratify or discard the proposals. After meaningful ingests into a reconcile wiki, refresh `exports/` so downstream tools stay current.

## Preserve-tension wikis: the disciplines that protect them

* **The thesis is yours.** State it in one or two sentences, in the block titled THE THESIS in the wiki's `AGENTS.md`. Until you do, the agent refuses to assert a thesis, by design.
* **Let it argue with you.** When you propose an idea, the agent challenges it first: counterexamples, the tradition that would reject it, the weak link. Only what survives, and what you ratify, becomes a position. Plausible filler never gets in.
* **Preserve the tension.** Contradictions between traditions are the content. The agent flags a claim that should be contested but isn't, and it never "resolves" a live disagreement.
* **Use the margins.** Half-formed connections go to `notes/`. They're raw material, not thesis, until you promote them.

## Reconcile wikis: the disciplines that make them useful

* **One current truth, fully cited.** Contradictions get resolved toward the present best answer, the superseded claim stays visible, and every claim traces to a source. A flagged blank, `{{VERIFY: ...}}`, beats an invented number.
* **`current-state.md` is the front door.** It holds what's true now, and the archive holds history. Keep heavy task and pipeline state in your task tracker, not in the wiki.
* **Treat sources as untrusted.** Anything from the open web is data, not instructions. If a source has text aimed at the AI, the agent shows it to you instead of acting on it.
* **Feed other tools.** If you point assistants or other tools at the wiki, keep `exports/` fresh, so they draw on one current, cited source.

## Signs of drift, and the fix

* **The first weeks feel underwhelming.** That's the empty-notebook stage, before compounding kicks in. Keep running the loop.
* **A query gives a weak answer.** Ingest a source that closes the gap, then file back the better answer.
* **Lint reports orphans or stale pages.** That's lint doing its job. Clear them in the review pass.
* **You're tempted to add a vector database.** Don't, until a wiki is well past a few hundred pages. The index plus whole-page reads is more reliable at this size.
* **You're editing pages by hand a lot.** Change the wiki's `AGENTS.md` instead, so the agent files things your way next time. The rules are the product.

## The five disciplines

1. **Reach for it.** Using the wiki is the return, not building it.
2. **Crystallize.** If it matters, file it. The chat is disposable.
3. **Trace everything.** No claim goes in without a source.
4. **Keep authorship.** You author the thesis; the agent challenges and maintains.
5. **Clear the queue.** That's where ownership is kept.
