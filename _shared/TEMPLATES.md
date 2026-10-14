# Page templates and state-file entries

The agent uses these whenever it creates a page or adds to a state file. Fill each `<placeholder>`. Never invent a value: write `{{VERIFY: what's missing}}` instead. The empty starter files for a new wiki live in `_shared/seed/`.

**File names:** lowercase and hyphenated, under `wiki/`, like `wiki/pricing-model.md`. Source summaries go in `wiki/sources/`, named after the source file: `raw/2026-03-02-call.md` becomes `wiki/sources/2026-03-02-call.md`.

**Links:** relative markdown links, written from the page's own folder. From `wiki/sources/a.md` to `wiki/b.md`, write `[B](../b.md)`. From `index.md` to `wiki/b.md`, write `[B](wiki/b.md)`.

---

## Frontmatter (every page)

```yaml
---
type: <entity|concept|source-summary|synthesis|overview|comparison|note|initiative>
status: <draft|active|stale|contradicted|archived>
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD   # reconcile wikis only, and not on source summaries
sources: [<source-file>, ...]
confidence: <high|medium|low>
relates_to:
  - page: <the other page's path from the wiki's folder, like wiki/other-page.md>
    rel: <a relationship from this wiki's vocabulary>
---
```

Starter vocabularies (each wiki's `AGENTS.md` sets its own):

* **Preserve-tension:** `contradicts`, `tensions-with`, `extends`, `responds-to`, `reframes`, `parallels`, `synthesizes`, `supersedes`.
* **Reconcile:** `supersedes`, `superseded-by`, `depends-on`, `supports`, `contradicts`, `implements`, `sourced-from`, `competes-with`.

---

## Entity page

```markdown
---
type: entity
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <Entity name>

**What it is:** <one-line definition>.

## Summary

<The current, synthesized understanding, in two to five sentences, each non-obvious claim cited.> [src: <file>#<locator>]

## Key facts

* <fact> [src: <file>#<locator>]

## Superseded

* ~~<old claim>~~ Superseded YYYY-MM-DD by <the newer claim, linked>: <why>. [src: <old-file>#<locator>]

## Open questions

* {{VERIFY: <what's missing>}}

## Related

<How this connects to other pages, with relative links. Typed edges live in the frontmatter.>
```

Leave out the "Superseded" section until a claim is superseded. In a reconcile wiki it keeps the lineage visible.

## Concept page

```markdown
---
type: concept
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <Concept>

**In one line:** <plain-language definition>.

## What it means

<An explanation in your own words, cited where it draws on a source.> [src: ...]

## Where it shows up

* <the page or source where this concept appears, linked> [src: ...]

## Tensions or settled view

<Preserve-tension: where accounts of this concept conflict; keep both, with edges. Reconcile: the current settled understanding, with superseded views noted.>
```

## Source-summary page

```markdown
---
type: source-summary
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [<this-source-file>]
confidence: high
relates_to: []
---

# Source: <title>

* **File:** `raw/<this-source-file>`
* **Origin:** <author, outlet, or where it came from>
* **Ingested:** YYYY-MM-DD
* **Trust tier (reconcile):** <first-party | reputable | unverified>

## Key takeaways

* <takeaway> [src: <this-source-file>#<locator>]

## Pages this updated

* [<Page>](../<page>.md): <what changed>

## Claims to watch

* <a claim worth watching for confirmation or contradiction> [src: <this-source-file>#<locator>]
```

## Synthesis or position page (authorship-gated in preserve-tension wikis)

```markdown
---
type: synthesis
status: draft        # stays draft until the human ratifies it, in gated wikis
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <Synthesis title>

> **Register:** <SOURCED summary | HUMAN POSITION (ratified) | AI INFERENCE (unratified)>

## The claim

<The synthesized position, stated plainly.>

## What supports it

* <supporting point> [src: ...]

## What cuts against it

* <the strongest counterpoint, or the tradition that would reject it> [src: ...]

## Status

<Gated wiki: "Ratified by the human on YYYY-MM-DD," or "AI inference, awaiting ratification.">
```

## Comparison page

```markdown
---
type: comparison
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <A> vs. <B>

| Dimension | <A> | <B> | Where they differ |
|---|---|---|---|
| <dimension> | <...> [src: ...] | <...> [src: ...] | <the live difference> |

## Reading

<Preserve-tension: keep the tension. Reconcile: state the current best answer.>
```

## Note (preserve-tension `notes/`)

```markdown
---
type: note
status: draft
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []
confidence: low
relates_to: []
---

# Hunch: <short label>

<The half-formed connection, open question, or source to find later. This is not thesis content until the human ratifies it into a page.>
```

## Initiative (reconcile `initiatives/`)

```markdown
---
type: initiative
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
review_by: YYYY-MM-DD
sources: []
confidence: high
relates_to: []
---

# Initiative: <name>

* **Start:** YYYY-MM-DD
* **End:** YYYY-MM-DD
* **Goal:** <the outcome>
* **Measure of success:** <how you'll know it worked>

## Current status

<A one-line live status. Heavy task state belongs in your task tracker, not here.>

## Notes

* <a decision or update> [src: ...]
```

---

## State-file entries

The empty starter files are in `_shared/seed/`. These are the formats for what gets added to them.

**`log.md` entry** (append at the bottom):

```markdown
## [YYYY-MM-DD] <ingest|query|file-back|lint|consolidate|review> | <title>

<One or two lines: what changed, and how many pages it touched.>
```

**`_state/sources.md` row:**

```markdown
| <source-file> | <full sha256> | YYYY-MM-DD | <first-party, reputable, or unverified> | [<Page>](../wiki/<page>.md), [<Page>](../wiki/<page>.md) |
```

**`_state/review-queue.md` item:**

```markdown
## [QUEUED YYYY-MM-DD] <short title>

* **Pages:** [<Page>](../wiki/<page>.md)
* **Why queued:** <overwrite, decision reversal, protected-page edit, contradiction resolution, low confidence, or unratified inference>
* **Proposed change:** <summary>
* **Sources:** [src: ...]
* **Decision:** pending
```

When the human decides, change "pending" to the decision and its date, for example "approved 2026-03-14," and add the reason for a rejection.

**`index.md` line:**

```markdown
* [<Page title>](wiki/<page>.md): <one-line summary> (<type>, sources: <N>, updated YYYY-MM-DD)
```
