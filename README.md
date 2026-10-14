# LLM Wiki Starter Kit

A knowledge base your AI keeps current. You feed it sources. It writes linked, cited pages and keeps them up to date. When an answer is worth keeping, you file it back, so your thinking compounds instead of starting over in every new chat.

It's plain markdown and git. There's no database, no server, and nothing to lock you in. It's built for any AI coding agent that reads `AGENTS.md`, including Claude Code and Codex. See [COMPATIBILITY.md](COMPATIBILITY.md) for what's been tested.

**New to the idea?** Read the [primer](docs/Arcqus-AI-LLM-Wiki-Primer.pdf) first. It takes about twenty minutes and assumes no background.

Built by Dusty Holcomb at Arcqus.AI. The core pattern comes from Andrej Karpathy's public [LLM Wiki idea](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).

## Before you start

**You'll need:**

* **An AI coding agent that can read and edit files in a folder.**
  * **Claude Code** requires a Pro, Max, Team, Enterprise, or Console account; the free plan doesn't include it. It also runs inside the Claude desktop app (on Pro, Max, Team, or Enterprise), so you don't need a terminal.
  * **Codex** is included in ChatGPT plans, including Free and Go. On Free and Go, OpenAI offers it in the ChatGPT desktop app, subject to rollout. You can also sign in with an API key.
* **Git.** On a Mac, if it isn't installed yet, open Terminal and type `git --version`, and macOS offers to install it. On Windows, install Git for Windows, which includes Git Bash, the shell you'll use for the kit's commands.
* **Optional:** Obsidian (free) to read your wiki, and a GitHub account to back it up. With a GitHub account, the GitHub Desktop app gets your copy onto your computer without any git commands.

**A word on privacy:** when your agent reads a source, that content goes to the AI provider under your account's terms. Check those terms before you ingest anything client-confidential.

## Get it running

Plan on an afternoon. You won't write any code. You'll type plain sentences to your agent, and it does the rest.

### 1. Get your own copy

Pick one:

* **With a GitHub account (recommended).** Click **Use this template**, above the file list on this page, then **Create a new repository**. Name it, choose **Private**, and click **Create repository from template**. Then put it on your computer: on your new repository's page, click **Code**, then **Open with GitHub Desktop**. GitHub Desktop asks where to keep it, so pick a place and click **Clone**. If you use git, you can clone it instead.
* **Without a GitHub account.** On this page, click **Code**, then **Download ZIP**, and unzip it wherever you keep your documents.
* **If you already use git.** A plain `git clone` of this repository works too. START-HERE disconnects your copy from this repository, so your work never lands here.

Whichever you pick, you end up with one folder on your computer. That folder is your copy of the kit.

### 2. Open that folder in your AI agent

* **Claude desktop app:** open the **Code** tab, choose **Local**, click **Select folder**, and pick the folder.
* **ChatGPT desktop app (Codex):** click **Add new project** next to **Chats**, and pick the folder.
* **A terminal:** go into the folder with `cd`, then run `claude` for Claude Code, or `codex` for Codex.
* **Another agent:** open the folder the way it opens a project. [COMPATIBILITY.md](COMPATIBILITY.md) covers Cursor, GitHub Copilot, Gemini CLI, and several more.

### 3. Type one sentence

**"Read START-HERE.md and build my first wiki."**

### 4. Answer a few questions

First, the agent checks your folder and sets up git if it needs to. Then it asks what the wiki is for, what to call it, and whether it will hold confidential material, and it recommends which kind of wiki to build. It sums up the plan and waits for your yes before it builds anything.

Depending on its settings, your agent may ask your permission before it runs a command, such as setting up git or saving a version of your wiki (a git commit). Read what it wants to run, and approve it when it matches what you asked for. Codex asks before every commit, because it keeps git's own files read-only by default.

### 5. Feed it your first sources

Once the wiki is built, the agent asks for three or four sources. Put them in your new wiki's `raw/` folder, for example `market-notes/raw/`. Notes, articles, and transcripts all make good sources, and markdown or plain text files are easiest. The agent then walks you through the four moves below, from your first ingest to a cited answer and a health check.

### 6. Next time, start inside your wiki's folder

From then on, open your **wiki's own folder** in your agent, not the kit's top folder. Do it the same way as in step 2, but pick the wiki's folder, for example `market-notes/`. That's how Claude Code and Codex pick up both the shared rules and your wiki's rules. The first time, Claude Code may ask before it loads or reads files from the folder above. Allow it. Using another agent? [COMPATIBILITY.md](COMPATIBILITY.md) says where to start it.

**Optional:** read your wiki in Obsidian, and back it up to a private GitHub repository. [CONNECT-OBSIDIAN-AND-GITHUB.md](CONNECT-OBSIDIAN-AND-GITHUB.md) walks you through both.

**Stuck?** Ask your agent. It can read every file in the kit and explain any step. Prefer to build by hand? Follow [SETUP.md](SETUP.md).

## The four moves

1. **Ingest.** Drop a source in `raw/` and ask the agent to ingest it. It updates every page the source touches.
2. **Query.** Ask your wiki a question. You get an answer with citations back to your sources.
3. **File back.** When an answer is worth keeping, save it as a page. This is the move that makes it compound.
4. **Lint.** Once a week, ask for a health check. It catches contradictions, stale claims, and orphan pages before they pile up.

You don't need special commands: ask in plain words, like "ingest raw/pricing-notes.md." Agents that support skills also offer shortcuts named `wiki-ingest`, `wiki-query`, and so on. Two more operations keep a wiki healthy over time, **consolidate** and **review**. The [operator's guide](_shared/OPERATORS-GUIDE.md) covers them, along with the weekly rhythm.

**See one before you build one:** the [sample wiki](examples/README.md) is small, fully worked, and fictional. You can browse it on GitHub in two minutes.

---

## Why you might want more than one wiki

Start with one. Once it's working, you may find a second domain that needs the opposite default on the most important question a wiki's rules answer: **is a contradiction something to resolve, or something to keep?**

* **Reconcile** wikis hold one current, cited answer per question. They suit competitive intelligence, reference material, and anything factual or operational. A contradiction is a defect to fix.
* **Preserve-tension** wikis keep competing views in dialogue. They suit a worldview, a thesis, or a research field, where the tension between views is the content. A contradiction is information to keep.

A set of wikis that shares one set of rules is a **federation**. The shared mechanics live in the top folder's `AGENTS.md`, and a short `AGENTS.md` in each wiki sets its policy. The wikis never link to each other, because clean separation is the point. To add a wiki, follow [ADDING-A-WIKI.md](_shared/ADDING-A-WIKI.md).

## The one idea

> A search system makes your documents **findable**. A wiki makes your thinking **cumulative**.

| | Search over your files (uploads, vector search) | This wiki |
|---|---|---|
| What it does | Finds fragments when you ask, answers, and forgets | Writes the synthesis once, then keeps it current |
| What builds up | Nothing: it re-reads the sources every time | Everything: links, contradictions, and the evolving picture |
| What you own | A search index | A body of synthesized thinking, in plain text |

Your raw sources are the record of what happened. The wiki is what you've made of it. The agent does the filing.

## What's in the kit

```
├── START-HERE.md                    the agent's build spec
├── SETUP.md                         the same build, by hand
├── CONNECT-OBSIDIAN-AND-GITHUB.md   reading in Obsidian, backup on GitHub
├── COMPATIBILITY.md                 what each AI agent loads, with sources
├── AGENTS.md                        the shared rules every wiki follows
├── CLAUDE.md                        one line that points Claude Code at AGENTS.md
├── _shared/
│   ├── operations/                  the six procedures: ingest, query, file back, lint, consolidate, review
│   ├── seed/                        empty starter files for a new wiki
│   ├── TEMPLATES.md                 page templates
│   ├── OPERATORS-GUIDE.md           the day-to-day manual
│   └── ADDING-A-WIKI.md             how to add another wiki
├── archetypes/                      the rules for the two kinds of wiki
├── examples/sample-wiki/            a small, fully worked, fictional wiki
├── .agents/skills/  .claude/skills/ optional wiki-* shortcuts
├── git-hooks/                       optional: one wiki per commit, and auto-push to your backup
├── scripts/check-kit.sh             the maintainer's release checks
└── docs/                            the companion primer
```

## License

MIT. See [LICENSE](LICENSE). Copy it, adapt it, and build your own wikis on it. Attribution is appreciated but not required.

---

Maintainers: the project's purpose, owner, recovery path, and retirement condition are in [MAINTAINERS.md](MAINTAINERS.md).
