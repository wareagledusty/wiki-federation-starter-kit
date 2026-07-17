# Wiki Templates & State-File Formats

> Shared templates for every wiki. Place at `_shared/TEMPLATES.md` (the commands reference it). The agent applies the matching template whenever it creates a page or seeds a state file. A few templates are archetype-specific and are marked. Replace `< … >` placeholders; never invent values — use `[[VERIFY: …]]` where a value is unknown.

---

## Frontmatter (every page)

```yaml
---
type: <entity|concept|source-summary|synthesis|overview|comparison|note>
status: <draft|active|stale|contradicted|archived>
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [<source-filename>, ...]
confidence: <high|medium|low>
relates_to:
  - page: "<Other Page>"
    rel: <permitted relationship type for this wiki>
---
```

Permitted `rel` vocabulary is set by the wiki's overlay. Two starter vocabularies:
- **Dialogic** (preserve-tension archetype): `contradicts`, `tensions-with`, `extends`, `responds-to`, `reframes`, `parallels`, `synthesizes`, `supersedes`.
- **Factual/competitive** (reconcile archetype): `supersedes`, `superseded-by`, `depends-on`, `supports`, `contradicts`, `implements`, `sourced-from`, `competes-with`.

---

## Entity page

```markdown
---
type: entity
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <Entity Name>

**What it is:** <one-line definition>.

## Summary
<Current, synthesized understanding — 2–5 sentences. Each non-obvious claim cited.> [src: <file>#<loc>]

## Key facts
- <fact> [src: <file>#<loc>]

## Open questions / to verify
- [[VERIFY: <what's missing>]]

## Related
<Narrative of how this connects to other pages; typed edges live in frontmatter.>
```

## Concept page

```markdown
---
type: concept
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <Concept>

**In one line:** <plain-language definition>.

## What it means
<Explanation in your own words, sourced where it draws on a specific source.> [src: ...]

## Where it shows up
- <page or source where this concept appears> [src: ...]

## Tensions / debates
<Preserve-tension archetype: where accounts of this concept conflict — keep both, with edges. Reconcile archetype: the current settled understanding, with superseded views noted.>
```

## Source-summary page

```markdown
---
type: source-summary
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: [<this-source-filename>]
confidence: high
relates_to: []
---

# Source: <Title>

- **Origin:** <author / outlet / where it came from>
- **Ingested:** YYYY-MM-DD
- **Trust tier (reconcile archetype):** <first-party | reputable | unverified>

## Key takeaways
- <takeaway> [src: <this-file>#<loc>]

## Pages this updated
- <page> — <what changed>

## Notable claims to track
- <claim worth watching for confirmation or contradiction> [src: <this-file>#<loc>]
```

## Synthesis / position page  *(authorship-gated in the preserve-tension archetype)*

```markdown
---
type: synthesis
status: draft        # stays draft/inference until the human ratifies (gated wikis)
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
- <supporting point> [src: ...]

## What cuts against it
- <strongest counterpoint / tradition that would reject it> [src: ...]

## Status
<Gated wiki: "Authored by <owner> / ratified on YYYY-MM-DD" OR "AI inference — awaiting ratification.">
```

## Comparison page  *(tension-aware)*

```markdown
---
type: comparison
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []
confidence: medium
relates_to: []
---

# <A> vs. <B>

| Dimension | <A> | <B> | Where they conflict |
|---|---|---|---|
| <dimension> | <…> [src: ...] | <…> [src: ...] | <the live tension, kept — not resolved> |

## Reading
<Synthesis. Preserve-tension archetype: preserve the tension. Reconcile archetype: state the current best answer.>
```

## Note  *(sidecar — preserve-tension `notes/`)*

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

<The half-formed connection, "this might matter later" observation, open question, or candidate source to find. Explicitly NOT thesis content until ratified into a page.>
```

## Initiative  *(reconcile `initiatives/`)*

```markdown
---
type: initiative
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources: []
confidence: high
relates_to: []
---

# Initiative: <name>

- **Start:** YYYY-MM-DD
- **End:** YYYY-MM-DD
- **Goal:** <the outcome>
- **Measure of success:** <how you'll know it worked>

## Current status
<one-line live status; keep heavy task state in your task tracker, not here>

## Notes
- <decision or update> [src: ...]
```

---

## State-file formats

### `index.md` (content catalog — read first on every query)

```markdown
# Index

_Updated: YYYY-MM-DD_

## Overview / syntheses
- [[overview]] — <one line>

## Entities
- [[<Entity>]] — <one line> (sources: N, updated: YYYY-MM-DD)

## Concepts
- [[<Concept>]] — <one line>

## Sources
- [[Source: <Title>]] — <one line>
```

### `log.md` (append-only diary — greppable)

```markdown
# Log

## [YYYY-MM-DD] ingest | <source title>
Touched N pages. <one-line note.>

## [YYYY-MM-DD] lint | <scope>
<counts; what was flagged/resolved.>

## [YYYY-MM-DD] consolidate | <scope>
<what emerged; report at _state/consolidation-YYYY-MM-DD.md.>
```

### `_state/sources.md` (provenance ledger)

```markdown
# Source Ledger

| Source file | Hash | Ingested | Trust tier | Pages informed |
|---|---|---|---|---|
| <file> | <sha256-short> | YYYY-MM-DD | <tier> | [[Page A]], [[Page B]] |
```

### `_state/review-queue.md` (pending human decisions)

```markdown
# Review Queue

## [QUEUED YYYY-MM-DD] <short title>
- **Page(s):** [[<page>]]
- **Why queued:** <overwrite | decision-reversal | protected-page edit | contradiction resolution | low confidence | unratified inference>
- **Proposed change:** <summary>
- **Sources:** [src: ...]
- **Decision:** <pending>
```
