# Start here: build your first wiki

**If you're a person:** open this folder in your AI agent (Claude Code, Codex, or similar) and type **"Read START-HERE.md and build my first wiki."** The agent takes it from there. It asks you a few questions, builds the wiki, and walks you through your first sources.

**If you're the agent:** this file is your build spec. Follow it in order. Before each step that writes files, say what you're about to do and get a yes. You build structure; the human supplies the substance. Never invent content.

---

## Step 1. Check where you are

You should be in the kit's top folder. It holds `START-HERE.md`, `AGENTS.md`, `_shared/`, and `archetypes/`. If you're somewhere else, ask the human to open that folder in their agent and start again.

## Step 2. Check git

Run these from the top folder. Fix what they find, and explain each fix to the human in one sentence.

1. **Is this a git repository?**

   ```sh
   git rev-parse --is-inside-work-tree
   ```

   If that fails (for example, the human downloaded a ZIP), run `git init -b main`. Some agents only see the shared rules inside a git repository, so this comes first.

2. **Is `origin` the public starter kit?**

   ```sh
   git remote get-url origin
   ```

   If it prints an address containing `wareagledusty/wiki-federation-starter-kit`, the human cloned the public kit. Run `git remote remove origin`, and tell them: "Your copy was still connected to the public starter kit, so I disconnected it. Your work can't go there by accident now. You'll connect your own private repository later, from CONNECT-OBSIDIAN-AND-GITHUB.md." If it prints the human's own repository (they used **Use this template**), or reports that there's no such remote, leave it alone.

3. **Can git sign commits?**

   ```sh
   git config user.name
   git config user.email
   ```

   If either prints nothing, ask the human what name and email to sign commits with. Then set them for this folder only, with `git config user.name "<name>"` and `git config user.email "<email>"`.

## Step 3. Ask a few questions

Ask a few at a time, in plain words. Then repeat back a short summary, and get a yes before you build anything.

1. **What's the wiki for?** One or two sentences. This becomes its scope: what belongs in it and, by implication, what doesn't.
2. **What should it be called?** A name, like "Market notes," and a folder name in lowercase with hyphens, like `market-notes`.
3. **Which kind of wiki?** Recommend **reconcile** (one current, cited answer per question) unless the human is deliberately building a thesis or worldview. Give the reason in one line: preserve-tension holds every position in draft until the human writes a thesis, which is right for that use and frustrating on day one.
4. **Will it hold confidential material,** such as client detail or private figures? If yes, say so in its scope. Remind them that whatever you read goes to the AI provider under their account's terms. Never set up an export without their explicit say-so. For more, see "Confidential wikis" in `_shared/ADDING-A-WIKI.md`.

Keep the archetype's defaults for everything else (authorship rules, relationship vocabulary) unless the human asks for changes. If they say "you decide," pick sensible defaults, say what you picked, and carry on.

## Step 4. Build the wiki

Run these from the top folder, with `<slug>` replaced by the folder name. This is the **reconcile** build:

```sh
mkdir -p <slug>/raw <slug>/wiki/sources <slug>/_state <slug>/initiatives <slug>/archive <slug>/exports
touch <slug>/raw/.gitkeep <slug>/wiki/sources/.gitkeep <slug>/initiatives/.gitkeep <slug>/archive/.gitkeep <slug>/exports/.gitkeep
cp archetypes/reconcile-overlay.md <slug>/AGENTS.md
printf '@AGENTS.md\n' > <slug>/CLAUDE.md
cp _shared/seed/index.md _shared/seed/log.md _shared/seed/current-state.md <slug>/
cp _shared/seed/sources.md _shared/seed/review-queue.md <slug>/_state/
```

For a **preserve-tension** wiki, run this instead:

```sh
mkdir -p <slug>/raw <slug>/wiki/sources <slug>/_state <slug>/notes
touch <slug>/raw/.gitkeep <slug>/wiki/sources/.gitkeep <slug>/notes/.gitkeep
cp archetypes/preserve-tension-overlay.md <slug>/AGENTS.md
printf '@AGENTS.md\n' > <slug>/CLAUDE.md
cp _shared/seed/index.md _shared/seed/log.md <slug>/
cp _shared/seed/sources.md _shared/seed/review-queue.md <slug>/_state/
```

Then edit `<slug>/AGENTS.md`:

* Replace every `<PLACEHOLDER>` with the interview answers: the name, the scope, and the confidentiality line.
* Delete the "Template note" paragraph at the top. Keep the "Shared rules first" paragraph.
* For preserve-tension, **leave THE THESIS block for the human.** Never write a thesis. Ask them to fill it in when they're ready. Until they do, no page may assert one.

## Step 5. Register it

In the top folder's `AGENTS.md`, add one row to the registry table (section 3): the wiki's name, its folder, its archetype, and its one-line scope.

## Step 6. Commit

```sh
git add -A
git commit -m "<slug>: create wiki"
```

A new wiki plus top-level files is a valid single commit. Some agents ask before every commit; Codex does. If yours asks, tell the human to approve it.

## Step 7. Walk through the first loop

Read `<slug>/AGENTS.md` in full now, and work under it for the rest of this session. Then walk the human through the four moves, one at a time:

1. **Ingest.** Ask them to put three or four real sources in `<slug>/raw/`: notes, articles, or transcripts, with markdown or plain text easiest. Ingest them one at a time, following `_shared/operations/ingest.md`.
2. **Query.** Have them ask a question the sources should answer, and follow `_shared/operations/query.md`. Point out the citations in your answer.
3. **File back.** Save the best answer as a page, following `_shared/operations/file-back.md`.
4. **Lint.** Run a health check, following `_shared/operations/lint.md`.

## Step 8. Hand off

Tell the human three things:

1. **From now on, start your agent inside the wiki's folder,** `<slug>/`. That's how Claude Code and Codex load both the shared rules and this wiki's rules. For other agents, see `COMPATIBILITY.md`.
   * Claude desktop app: open the Code tab, choose Local, click **Select folder**, and pick `<slug>`.
   * Claude Code in a terminal: `cd <slug>`, then `claude`.
   * Codex in the ChatGPT desktop app: click **Add new project** and pick `<slug>`.
   * Codex in a terminal: `cd <slug>`, then `codex`.
2. **The day-to-day rhythm** is in `_shared/OPERATORS-GUIDE.md`.
3. **Reading and backup are optional,** and both are covered in `CONNECT-OBSIDIAN-AND-GITHUB.md`: Obsidian for reading the wiki, and a private GitHub repository for backing it up. Offer to walk them through it now.

---

## Guardrails (the whole way through)

* **Never invent content.** You build structure, and the human supplies substance. An unknown value gets `{{VERIFY: what's missing}}`.
* **Confirm before writing,** especially the first scaffold.
* **One commit, one wiki.**
* **Never link one wiki to another,** and never ingest material outside a wiki's scope.
* **The thesis belongs to the human.** In a preserve-tension wiki, you challenge and maintain; you never author or soften a position.
* **Leave the kit's own files in place.** `_shared/`, `archetypes/`, and `examples/` are what the next wiki is built from. Ask before moving or deleting anything.
