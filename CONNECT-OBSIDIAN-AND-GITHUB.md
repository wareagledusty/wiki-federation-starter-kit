# Connect Obsidian and GitHub

Your wiki is plain markdown in a git repository, and your AI agent can run it on its own. Two optional tools make it nicer to read and safer to keep:

* **Obsidian** is where you *read*: browse pages, follow links, and see the graph. It only reads the folder, and it never talks to GitHub.
* **GitHub** is where your wiki is *backed up*. With the kit's git hooks, every commit pushes there on its own.

| Window | What it's for | What it touches |
|---|---|---|
| Your AI agent, started **inside the wiki's folder** | Working: ingest, query, file back, lint | The files and git |
| Obsidian, with the wiki's folder as its vault | Reading and browsing | The files only |
| GitHub, a private repository | Backup, and sync across machines | Git, through the hooks |

All three look at the same files. Nothing gets imported or exported between them.

---

## Part A. Obsidian (for reading)

1. **Install Obsidian** from [obsidian.md](https://obsidian.md). It's free for all uses, including commercial use.
2. **Open your wiki as a vault.** In Obsidian, choose **Open folder as vault**, and pick your wiki's folder, for example `my-wiki/`. You'll get a clean graph of just that wiki. You can open the top folder instead to see every wiki at once, but you'll see the kit's own files too.
3. **Read here, and let the agent write.** If you find yourself editing pages by hand a lot, change the rules in the wiki's `AGENTS.md` instead, so the agent does it your way next time.
4. **The graph view** shows pages as dots and links as lines. A page's local graph shows just its neighborhood.
5. **Optional: the Dataview plugin** turns each page's typed `relates_to` edges into tables you can query. Go to Settings, Community plugins, Browse, find Dataview, then Install and Enable.
6. **Obsidian's own settings** live in a `.obsidian/` folder inside the vault. The kit's `.gitignore` already skips the parts that change on every machine.

---

## Part B. GitHub (for backup)

Run every command from the kit's top folder. On Windows, use Git Bash.

### 1. Sign in so pushes work unattended

The hooks push after every commit, with nobody there to type a password. So use a sign-in that works on its own.

**Recommended: GitHub CLI over HTTPS.** Install the GitHub CLI from [cli.github.com](https://cli.github.com), then run:

```sh
gh auth login
```

Choose **GitHub.com**, then **HTTPS**, and answer **yes** when it asks whether to authenticate Git with your GitHub credentials. GitHub CLI then stores your Git credentials, and pushes from the hook go through without a prompt. If you skipped that question, run `gh auth setup-git`. This sign-in can push to every repository your GitHub account can write to.

**Alternative: an SSH deploy key** that reaches only this one repository. Make a key just for this wiki, with no passphrase so the hook can use it unattended:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_mywiki -N "" -C "mywiki"
```

On GitHub, open your repository's **Settings**, then **Deploy keys**, then **Add deploy key**. Paste the contents of `~/.ssh/id_ed25519_mywiki.pub`, and check **Allow write access**. Then add this to `~/.ssh/config`, so git uses that key for this repository:

```
Host github-mywiki
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_mywiki
    IdentitiesOnly yes
```

With a deploy key, your remote's address looks like `git@github-mywiki:<you>/<repo>.git` instead of `https://github.com/<you>/<repo>.git`.

### 2. Connect your own private repository

First, see what's connected now:

```sh
git remote -v
```

**If it shows your own repository** (you used **Use this template** and cloned your copy), you're already connected. With a deploy key, point it at the key's address:

```sh
git remote set-url origin git@github-mywiki:<you>/<repo>.git
```

**If it shows nothing** (you downloaded the ZIP, or START-HERE disconnected the public kit), create a new **private** repository on GitHub with no README and no `.gitignore`. Then connect it and push for the first time:

```sh
git remote add origin https://github.com/<you>/<repo>.git
git branch -M main
git push -u origin main
```

With a deploy key, use `git@github-mywiki:<you>/<repo>.git` in the first line instead.

**If it shows `wareagledusty/wiki-federation-starter-kit`,** you're still connected to the public kit. Disconnect it with `git remote remove origin`, then follow the steps above.

Check that the first push worked by hand: your files should show up on GitHub. If you were already connected, run `git push` once to confirm.

### 3. Turn on the hooks

```sh
sh git-hooks/install.sh
```

* **pre-commit** blocks any commit that touches two wikis.
* **post-commit** pushes every commit to `origin`, so a commit means a backup. A failed push never blocks your work. It's recorded in `.git/auto-push.log`, and the hook prints a one-line warning.

Hooks aren't copied when you clone, so run this once on each computer.

### 4. Optional, macOS: background sync

`git-hooks/auto-sync.sh` pulls and pushes every 15 minutes, so the repository catches up after a push that failed offline, and picks up changes from another computer. To set it up, fill in your folder's path and load it:

```sh
sed "s#<REPO-PATH>#$(pwd)#g" git-hooks/com.example.wikis-autosync.plist > ~/Library/LaunchAgents/com.example.wikis-autosync.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.example.wikis-autosync.plist
```

Its output goes to `.git/auto-sync.log`. To stop it:

```sh
launchctl bootout gui/$(id -u)/com.example.wikis-autosync
```

---

## How it fits together

1. You start your agent **inside the wiki's folder**. That's how Claude Code and Codex load both the shared rules and your wiki's rules. For other agents, see [COMPATIBILITY.md](COMPATIBILITY.md).
2. You ingest, query, file back, and lint. The agent writes markdown pages and commits them.
3. The post-commit hook pushes each commit to GitHub, so your work is backed up within seconds.
4. You open Obsidian on the same folder to read and browse what the agent built.

One folder: the agent writes it, git and GitHub back it up, and Obsidian reads it.

---

## Working on a second computer

It's a normal git repository. On the second computer, sign in first (Part B, step 1), because the repository is private. Then clone it and install the hooks:

```sh
git clone https://github.com/<you>/<repo>.git my-wikis
cd my-wikis
sh git-hooks/install.sh
```

Then open the wiki's folder as a vault in Obsidian there, too. The optional background sync keeps both computers in step.

---

## Troubleshooting

* **"I committed, but nothing's on GitHub."** Read the log with `tail .git/auto-push.log`. Then run `git push` by hand and read its error. Most often the sign-in isn't set up (step 1), or the repository isn't connected (step 2).
* **"My agent works in a sandbox."** Some agents run commands in a sandbox with network access off, so the hook's push can't reach GitHub. Your commits are safe on your computer. Push by hand with `git push` from a normal terminal, or set up the background sync. See [COMPATIBILITY.md](COMPATIBILITY.md) for your agent.
* **"error: remote origin already exists."** You're already connected. Run `git remote -v` to see where. If it's the public kit, run `git remote remove origin` and connect your own repository.
* **"src refspec main does not match any."** Your branch has a different name. Run `git branch -M main`, then push again.
* **"The push failed with an authentication error."** The hook never waits for a password. Set up the GitHub CLI sign-in or a deploy key (step 1).
* **"Commit blocked: it touches more than one wiki."** That's working as designed. Commit one wiki at a time. If you mean to cross wikis, use `git commit --no-verify`.
* **"Obsidian shows `.obsidian/` or `_state/` as clutter."** Hide them under Settings, Files and links, Excluded files, or just ignore them. They're meant to be there.
