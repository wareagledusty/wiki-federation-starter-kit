# LLM Wiki Federation — Starter Kit

A portable framework for running **LLM-maintained markdown wikis** — knowledge bases that *compile and keep* your synthesis instead of re-deriving it on every question. An agent (e.g. Claude Code) maintains the pages; you curate sources and ask the questions.

This is a **clean, genericized kit** — the reusable protocol, templates, archetypes, commands, and git plumbing, with no one else's content in it. Everything is placeholder-driven; you supply the domains.

> **Fastest path:** open this folder in Claude Code and say **"Read `START-HERE.md` and build my federation."** The agent interviews you for a few decisions and scaffolds the whole thing. Prefer to do it by hand? Read [SETUP.md](SETUP.md).

> **Credit.** The core pattern — have an LLM *incrementally compile and maintain a persistent, interlinked wiki* between you and your raw sources, rather than retrieving-and-forgetting (RAG) — is adapted from Andrej Karpathy's public "LLM Wiki" idea ([gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), April 2026). This kit is one opinionated implementation of it.

---

## The one idea

> A search system makes your documents **findable**. A wiki makes your thinking **cumulative**.

| | RAG (uploads, NotebookLM, vector search) | This wiki |
|---|---|---|
| What it does | Retrieves fragments at query time, answers, forgets | Compiles synthesis once, then keeps it current |
| What accumulates | Nothing — re-pieces sources every time | Everything — cross-references, contradictions, the evolving picture |
| What you own | A search index | A body of synthesized thinking, in plain text, that's yours |

Raw sources are *episodic memory* (immutable experience). The wiki is *semantic memory* (the integrated web of what you actually know). The agent does the consolidation.

## Why a "federation" and not one wiki

You'll often want more than one wiki, and the wikis need **opposite defaults** on the single most important question a wiki schema governs: **is a contradiction something to _resolve_ or something to _preserve_?**

- **Reconcile archetype** — one current, cited best answer per question. For competitive intel, reference, product, or any factual/operational domain. *(Contradictions are defects to resolve.)*
- **Preserve-tension archetype** — keeps competing views in dialogue. For a worldview, thesis, or research domain where the tension between views *is* the content. *(Contradictions are information to keep.)*

A **federation** = one shared base of portable mechanics + a thin per-wiki overlay that sets the divergent policy. The wikis never cross-link; clean separation is the whole value.

## What's in this kit

```
wiki-federation-starter-kit/
├── START-HERE.md                   ← point Claude Code at this to auto-build
├── README.md                       ← you are here (the concept)
├── SETUP.md                        ← step-by-step manual install
├── CONNECT-OBSIDIAN-AND-GITHUB.md  ← wire up the reading surface + backup/sync
├── CLAUDE.md                       ← root federation registry + boundary rules (template)
├── LICENSE                         ← MIT
├── _shared/
│   ├── wiki-base.md                ← the shared protocol every wiki inherits
│   ├── TEMPLATES.md                ← page + state-file templates
│   ├── ADDING-A-WIKI.md            ← the recipe for stamping out a new wiki
│   └── OPERATORS-GUIDE.md          ← the day-to-day operating manual (for the human)
├── archetypes/
│   ├── reconcile-overlay.md        ← copy → <wiki>/CLAUDE.md for a reconcile wiki
│   └── preserve-tension-overlay.md ← copy → <wiki>/CLAUDE.md for a preserve-tension wiki
├── commands/                       ← the six operations (copy → <wiki>/.claude/commands/)
│   └── ingest.md · query.md · lint.md · consolidate.md · file-back.md · review.md
└── git-hooks/
    ├── pre-commit                  ← blocks a commit that spans two wikis
    ├── post-commit                 ← auto-push to your remote
    ├── install.sh                  ← installs the hooks (run once per clone)
    ├── auto-sync.sh                ← optional periodic pull/push safety net
    └── com.example.wikis-autosync.plist  ← optional launchd agent (macOS)
```

## The three verbs (the whole job)

1. **Feed it** — `/ingest` a source; the agent folds it into every page it touches.
2. **Ask it** — `/query`; get a cited answer synthesized from the pages.
3. **Never let a good answer die in a chat** — `/file-back` so it compounds.

Everything else (`/lint`, `/consolidate`, `/review`) keeps the loop reliable.

## Quick start

Read **`SETUP.md`**. In short: create a folder + git repo, drop `CLAUDE.md` and `_shared/` at the root, stamp out your first wiki from an archetype, install the git hooks, and prove the loop with a few sources.

## Requirements

- An agentic coding tool that reads `CLAUDE.md` files up the directory tree and supports slash-commands in `.claude/commands/` (this kit is written for **Claude Code**).
- `git`. A markdown reader with a graph view (e.g. **Obsidian**) is nice for browsing but not required.
- No vector database, no embedding pipeline, no server. Plain markdown + git is the entire stack.

To connect **Obsidian** (the reading surface) and **GitHub** (backup + auto-push sync) to your build, see **[CONNECT-OBSIDIAN-AND-GITHUB.md](CONNECT-OBSIDIAN-AND-GITHUB.md)** — it walks through both from zero, including the GitHub auth the git hooks need.

---

## License

MIT — see [LICENSE](LICENSE). Clone it, fork it, build your own federation on it. Attribution is appreciated but not required.
