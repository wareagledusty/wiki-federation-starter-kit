# Set up a wiki by hand

Your AI agent can do all of this for you. Open the kit's folder in your agent and type **"Read START-HERE.md and build my first wiki."** This page is the same build by hand, for when you want to see every step. It takes about 20 minutes.

You'll type commands in a terminal. On Windows, use **Git Bash**, which comes with Git for Windows. Run every command from the kit's top folder, the one that holds `README.md`.

## Step 1. Go to your copy of the kit

```sh
cd path/to/your-copy-of-the-kit
```

## Step 2. Make it your own git repository

```sh
git rev-parse --is-inside-work-tree 2>/dev/null || git init -b main
git remote -v
```

The first line turns a ZIP download into a git repository. For a copy that's already one, it just prints `true`. If the second line shows `wareagledusty/wiki-federation-starter-kit`, you cloned the public kit. Disconnect it, so your work never tries to push there:

```sh
git remote remove origin
```

You'll connect your own private repository later, in [CONNECT-OBSIDIAN-AND-GITHUB.md](CONNECT-OBSIDIAN-AND-GITHUB.md).

Check that git knows who you are:

```sh
git config user.name
git config user.email
```

If either prints nothing, set it for this folder:

```sh
git config user.name "Your Name"
git config user.email "you@example.com"
```

## Step 3. Create the wiki's folders and files

Pick a folder name in lowercase with hyphens. These commands use `my-wiki`. They build a **reconcile** wiki, which holds one current, cited answer per question. It's the right first wiki for most people.

```sh
mkdir -p my-wiki/raw my-wiki/wiki/sources my-wiki/_state my-wiki/initiatives my-wiki/archive my-wiki/exports
touch my-wiki/raw/.gitkeep my-wiki/wiki/sources/.gitkeep my-wiki/initiatives/.gitkeep my-wiki/archive/.gitkeep my-wiki/exports/.gitkeep
cp archetypes/reconcile-overlay.md my-wiki/AGENTS.md
printf '@AGENTS.md\n' > my-wiki/CLAUDE.md
cp _shared/seed/index.md _shared/seed/log.md _shared/seed/current-state.md my-wiki/
cp _shared/seed/sources.md _shared/seed/review-queue.md my-wiki/_state/
```

Building a thesis or worldview wiki instead? Run these, which use the **preserve-tension** rules and give it a `notes/` folder:

```sh
mkdir -p my-wiki/raw my-wiki/wiki/sources my-wiki/_state my-wiki/notes
touch my-wiki/raw/.gitkeep my-wiki/wiki/sources/.gitkeep my-wiki/notes/.gitkeep
cp archetypes/preserve-tension-overlay.md my-wiki/AGENTS.md
printf '@AGENTS.md\n' > my-wiki/CLAUDE.md
cp _shared/seed/index.md _shared/seed/log.md my-wiki/
cp _shared/seed/sources.md _shared/seed/review-queue.md my-wiki/_state/
```

You now have:

```
my-wiki/
├── AGENTS.md            the wiki's rules (you fill these in next)
├── CLAUDE.md            one line, @AGENTS.md, so Claude Code loads the rules
├── index.md   log.md
├── current-state.md     reconcile only: what's true now
├── raw/                 your sources go here
├── wiki/sources/        the agent writes pages here
├── _state/              sources.md (the source ledger) and review-queue.md
└── initiatives/  archive/  exports/     reconcile only        notes/  preserve-tension only
```

## Step 4. Fill in the wiki's rules

Open `my-wiki/AGENTS.md` in any text editor:

1. Replace every `<PLACEHOLDER>`: the wiki's name, its scope (one paragraph on what belongs here and, by implication, what doesn't), and whether it holds confidential material.
2. Delete the "Template note" paragraph at the top. Keep the "Shared rules first" paragraph.
3. Leave the contradiction policy, the authorship rules, and the vocabulary as they are, unless you know why you're changing them.

In a preserve-tension wiki, the block titled THE THESIS is yours to write, in your own words, whenever you're ready.

## Step 5. Register it

Open the top folder's `AGENTS.md`. In the registry table (section 3), add one row: the wiki's name, its folder (`my-wiki/`), its archetype, and its one-line scope.

## Step 6. Commit

```sh
git add -A
git commit -m "my-wiki: create wiki"
```

## Step 7. Start your agent inside the wiki, and prove the loop

Start your AI agent **inside `my-wiki/`**. That's how Claude Code and Codex load both the shared rules and your wiki's rules. For other agents, see [COMPATIBILITY.md](COMPATIBILITY.md). Then:

1. Put three or four sources in `my-wiki/raw/`, and ask: "ingest raw/<file>." Do them one at a time.
2. Ask a question the sources should answer. Check that the answer cites them.
3. Ask the agent to file the best answer back as a page.
4. Ask for a lint.

That's a working wiki. For the day-to-day rhythm, read [the operator's guide](_shared/OPERATORS-GUIDE.md). To back it up on GitHub and read it in Obsidian, see [CONNECT-OBSIDIAN-AND-GITHUB.md](CONNECT-OBSIDIAN-AND-GITHUB.md). When you want a second wiki, see [ADDING-A-WIKI.md](_shared/ADDING-A-WIKI.md).
