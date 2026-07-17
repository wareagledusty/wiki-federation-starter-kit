# Connecting Obsidian and GitHub

Your federation is just **plain markdown in a git repo**. Nothing here is required to *run* the wikis — Claude Code alone can do everything. But two integrations make it pleasant and safe:

- **Obsidian** = where you *read* the wiki (browse, follow links, see the graph). It never talks to GitHub; it just opens the folder.
- **GitHub** = where the wiki is *backed up and synced* (and, via the git hooks, where every commit auto-pushes).

Think of it as **three windows onto one folder:**

| Window | Role | Talks to |
|---|---|---|
| **Claude Code** (opened at the vault root) | Where you *work* — ingest, query, file-back | The files + git |
| **Obsidian** (vault = the same folder) | Where you *read* — browse and navigate | The files only |
| **GitHub** (a private repo) | Backup + sync across machines | git (via the hooks) |

All three point at the **same folder**. There's no import/export between them — they're just different lenses on the same markdown.

---

## Part A — Obsidian (the reading surface)

1. **Install Obsidian** — free, from [obsidian.md](https://obsidian.md). Desktop (macOS/Windows/Linux).
2. **Open the vault** — Obsidian → *Open folder as vault* → select your **federation root** (the folder that contains `_shared/` and your wiki folders). The whole federation is one vault.
3. **Read here; don't edit here.** The operating model is that the *agent* writes pages and you *read* them. Browsing, following `[[links]]`, and the graph view are what Obsidian is for. (Editing by hand isn't forbidden, but if you find yourself doing it a lot, that's a signal to update the *schema* instead — see `_shared/OPERATORS-GUIDE.md`.)
4. **Graph view** — the icon in the left ribbon shows pages as nodes and `[[links]]` as edges. *Local Graph* shows one page's neighborhood. This is how the wiki's structure becomes visible.
5. **Recommended plugin — Dataview.** The page frontmatter uses typed `relates_to` edges (e.g. `contradicts`, `supersedes`). Dataview turns those into queryable tables/lists. *Settings → Community plugins → Browse → Dataview → Install → Enable.* Optional but it's what makes the typed edges pay off.
6. **Obsidian's own config** lives in a `.obsidian/` folder inside the vault. It's per-vault, not per-wiki. You can commit it (to share appearance/plugins across machines) or ignore it — the kit's `.gitignore` already ignores the per-machine bits (`workspace*`, `cache`).

> **Obsidian does not sync to GitHub.** Some people confuse the two. Obsidian just reads the folder; **git** is what moves your work to GitHub. That's Part B.

---

## Part B — GitHub (backup + sync)

This is what the `git-hooks/` push to. Do it once per vault.

### 1. Make it a git repo (if it isn't already)

```sh
cd <your-vault-root>
git init
git add . && git commit -m "initial federation"
```

### 2. Create a **private** repo on GitHub

On github.com → *New repository* → name it → **Private** → **do not** add a README/.gitignore (you already have files) → *Create*.

### 3. Connect your local vault to it — pick ONE auth method

**Option 1 — `gh` CLI (easiest, interactive).**
```sh
gh auth login                 # follow the browser prompt, once per machine
gh repo view                  # confirm you're authed
git remote add origin https://github.com/<you>/<repo>.git
git push -u origin main
```

**Option 2 — SSH (best for the auto-push hooks, which run unattended).**
The hooks push on *every commit* with no chance to type a password, so SSH-key auth is the reliable choice.
```sh
# generate a key dedicated to this vault (no passphrase, so hooks can push unattended)
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_mywiki -N "" -C "mywiki"
```
Add the **public** key (`~/.ssh/id_ed25519_mywiki.pub`) to GitHub as a **deploy key** with write access: repo → *Settings → Deploy keys → Add deploy key* → paste the `.pub` contents → check **Allow write access**. (A deploy key grants access to just this one repo — safer than an account-wide key.)

Then give it a host alias so git uses the right key non-interactively — add to `~/.ssh/config`:
```
Host github-mywiki
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_mywiki
    IdentitiesOnly yes
```
And point the remote at the alias:
```sh
git remote add origin git@github-mywiki:<you>/<repo>.git
git push -u origin main
```

**Option 3 — HTTPS + Personal Access Token.** Works, but for unattended hook pushes you must cache the token in a credential helper (macOS Keychain, etc.). If that sentence isn't obviously easy, use Option 1 or 2 instead.

### 4. Turn on the auto-push hooks

Once the remote pushes by hand, wire up the plumbing so you never push manually again:
```sh
sh git-hooks/install.sh       # installs pre-commit + post-commit into .git/hooks
```
- **pre-commit** blocks any commit that spans two wikis (keeps histories clean).
- **post-commit** pushes to your remote after every commit — *commit = backed up.*

The hooks push to `origin/main` by default; if your branch or remote differ, edit `git-hooks/post-commit`. Pushes are non-blocking (a failed push never blocks the commit; it's retried on the next one).

### 5. (Optional, macOS) Periodic self-healing sync

`git-hooks/auto-sync.sh` + `com.example.wikis-autosync.plist` run a pull+push every 15 minutes so the repo recovers from a push that failed while offline and pulls in edits from another machine. Edit the placeholder paths and the label, then:
```sh
cp git-hooks/com.example.wikis-autosync.plist ~/Library/LaunchAgents/
launchctl load -w ~/Library/LaunchAgents/com.example.wikis-autosync.plist
```

---

## How it all connects to "the LLM build"

1. You open **Claude Code at the vault root.** It auto-loads the `CLAUDE.md` files up the tree, so the agent behaves as the trained maintainer for whichever wiki you name.
2. You **ingest / query / file-back.** The agent writes markdown pages and **commits** them.
3. The **post-commit hook pushes** that commit to **GitHub** — automatically. Your synthesis is backed up within seconds.
4. You open **Obsidian on the same folder** to read and navigate what the agent built.

One folder. Claude Code writes it, git+GitHub back it up, Obsidian reads it. That's the whole loop.

---

## Working on more than one machine

Because it's a normal git repo, a second machine is just:
```sh
git clone <your-repo-url> my-wikis
cd my-wikis
sh git-hooks/install.sh        # hooks aren't cloned; reinstall once per machine
```
Then *Open folder as vault* in Obsidian on that machine too. The optional auto-sync agent (Part B §5) keeps both machines reconciled.

---

## Troubleshooting

- **"Committed, but nothing on GitHub."** The remote or auth isn't set. Run `git push` by hand and read the error; fix per Part B §3. The hook swallows push errors on purpose (so it never blocks your work), so a broken remote fails silently — always confirm the first push by hand.
- **Hook push asks for a password / hangs.** You're on HTTPS without a cached credential, or an SSH key with a passphrase. Switch to Option 2 with an empty-passphrase deploy key.
- **`git commit` blocked: "touches more than one wiki."** Working as designed — stage and commit one wiki folder at a time. Deliberate cross-cutting commit? `git commit --no-verify`.
- **Obsidian shows the `.obsidian`/`_state` folders as clutter.** *Settings → Files & Links → Excluded files*, or just ignore them; they're supposed to be there.
