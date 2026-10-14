# Compatibility

This kit is plain markdown and git, so any AI coding agent that can read and edit files in a folder can run it. What differs between agents is how much loads on its own. This page records what each agent's official documentation says, with a numbered source and the date it was checked.

**Two levels of evidence:**

* **Docs checked:** the behavior comes from the vendor's current documentation.
* **Live tested:** someone ran the kit's live test in that agent: START-HERE, a first cited answer, a file back, and a lint pass.

As of 2026-10-14, Claude Code and Codex are **live tested**. Every other entry is **docs checked**.

## What the kit needs from an agent

1. It reads `AGENTS.md`, or it can be told to. Shared rules live in the top folder's `AGENTS.md`, and each wiki's rules live in that wiki's own `AGENTS.md`.
2. It can read and edit files, and run `git`, in your folder.

That's all. Skills and slash commands are shortcuts. A plain request like "ingest raw/notes.md" always works, because the rules tell the agent which procedure file to open.

**Where to start your agent:** inside one wiki's folder, for example `my-wiki/`. From there, Claude Code and Codex both load the shared rules and that wiki's rules. If an agent misses the shared rules, the wiki's own rules tell it to read the top folder's `AGENTS.md` first.

## At a glance

| Agent | Started in a wiki folder, loads both rule files? | What you set up | `wiki-*` skills | Evidence |
|---|---|---|---|---|
| Claude Code (terminal or desktop app) | Yes, through the one-line `CLAUDE.md` files. Allow the one-time import prompt. | Nothing | Yes, from `.claude/skills/` | Live tested 2026-10-14 |
| Codex (CLI, IDE extension, ChatGPT desktop app) | Yes, walking down from the git root. The top folder must be a git repository. | Nothing. Approve each commit when asked. | Yes, from `.agents/skills/` | Live tested 2026-10-14 |
| Gemini CLI | Yes, after one setting | `context.fileName` in `~/.gemini/settings.json`, plus `--include-directories` | Not from inside a wiki folder | Docs checked 2026-10-13 |
| Cursor | Open the top folder instead. It reads nested files. | Nothing | Yes, from `.agents/skills/` | Docs checked 2026-10-13 |
| GitHub Copilot in VS Code | With a setting | `chat.useNestedAgentsMdFiles`, or `chat.useCustomizationsInParentRepositories` | Yes, from `.agents/skills/` or `.claude/skills/` | Docs checked 2026-10-13 |

## Claude Code

* **Instruction files.** Claude Code loads `CLAUDE.md` from the folder you start in and every folder above it. It loads a subfolder's `CLAUDE.md` later, once it reads or edits a file there. [1]
* **Imports.** A `CLAUDE.md` can pull in another file with `@path`, and a relative path resolves from the file that contains it. The docs describe an `@AGENTS.md` import in a `CLAUDE.md` as the way to share one instruction file with other tools. That's why every `CLAUDE.md` in this kit is the single line `@AGENTS.md`. [1]
* **One-time prompt.** When you start inside a wiki folder, the top folder's import points outside the folder you started in. Claude Code asks once before loading imports like that, so allow it. If you decline, the docs say those imports stay off and the prompt doesn't come back. The wiki's own rules then tell the agent to read the top folder's `AGENTS.md` itself. *(The prompt is inferred from the docs' definition of an external import. The live test didn't record its wording.)* [1]
* **Reads above the wiki folder.** By default, Claude Code can read files in the folder you started in. The shared procedures live in the folder above it, in `../_shared/operations/`. The first time its file tools read a file outside the start folder, it may ask you. Allow it. Shell reads such as `cat` don't ask by default. [7] [8]
* **Reading `AGENTS.md` without an import.** Since version 2.1.277, Claude Code reads `AGENTS.md` on its own, but only when there's no `CLAUDE.md` in the folder or above it. This kit ships `CLAUDE.md` files, so the import is what loads the rules, in any version. [1] [2]
* **Skills.** Claude Code loads project skills from `.claude/skills/` in the folder you start in and in every parent up to the repository root. So the kit's top-level `wiki-*` skills show up when you start inside a wiki folder. The docs don't list `.agents/skills/` as a skills location, so the kit ships the same wrappers in both folders. [3]
* **Older custom commands** have been merged into skills. [3]
* **Plans.** "Claude Code requires a Pro, Max, Team, Enterprise, or Console account. The free claude.ai plan does not include Claude Code access." [4] The desktop quickstart lists Pro, Max, Team, or Enterprise. [5]
* **Desktop app.** The Claude desktop app's Code tab runs Claude Code on a folder on your computer, with no terminal. Click **Code**, choose **Local**, then click **Select folder**. It runs on macOS and Windows, with Linux in beta. [5] [6]
* **Permission prompts.** Whether Claude Code asks before it acts depends on its permission mode. Manual mode asks before most file edits and shell commands, except a built-in set of read-only commands. From version 2.1.283, terminal sessions start in auto mode by default when it's available, and in auto mode a second model reviews each action instead of asking you. In the desktop app, you pick the mode with the selector next to the send button. [7] [8]
* **Sandbox.** It's off by default. If you turn it on, network access goes through an allowlist that starts empty, so a push from the post-commit hook can be blocked or prompted until github.com is allowed. On macOS, pushes over SSH fail inside the sandbox even when the host is allowed. The docs don't say how git's own hooks behave inside the sandbox, so if a push doesn't arrive, push by hand. [9]

## Codex

* **Instruction files.** Codex finds the project root, which by default is the nearest folder above you that contains `.git`. Then it walks down to the folder you started in, takes at most one `AGENTS.md` from each folder, and joins them root first. So when you start inside a wiki folder, it loads the top folder's `AGENTS.md` first, then the wiki's. [10] [11]
* **The top folder must be a git repository.** "If Codex cannot find a project root, it only checks the current directory." A folder from a ZIP download has no `.git` until START-HERE creates one, which is why START-HERE runs `git init` before anything else. [10]
* **Size limit.** Codex stops adding instruction files "once the combined size reaches the limit defined by project_doc_max_bytes (32 KiB by default)." Its source code truncates the file that crosses the limit, and that file would be your wiki's rules. So the kit keeps the top `AGENTS.md` plus the largest wiki rules file at 24,000 bytes or less, and `scripts/check-kit.sh` enforces it. *(The truncation detail comes from the source code, not the docs.)* [10] [12]
* **No imports, no `CLAUDE.md`.** Codex documents no include syntax, and it ignores instruction file names it doesn't list, including `CLAUDE.md`. [10]
* **Skills.** "For repositories, Codex scans .agents/skills in every directory from your current working directory up to the repository root." It doesn't read `.claude/skills/`. To mention a skill, type `$`, or run `/skills`. [13]
* **Commits ask first.** In Codex's default sandbox, "<writable_root>/.git is protected as read-only," and network access is off. So `git commit` asks for your approval. Started inside a wiki folder, the `.git` folder sits above the area Codex can write in anyway. Approve the commit: an approved command runs outside the sandbox, so the post-commit hook's push can reach GitHub. *(The hook behavior is inferred from the sandbox rules, because the docs don't mention git hooks.)* [14] [15]
* **Where Codex lives now.** On July 9, 2026, the Codex app merged into the ChatGPT desktop app. In the app, click **Add new project** next to **Chats**, or press Cmd+O (Ctrl+O on Windows), and pick your wiki's folder. The app uses that folder "for Git operations and automatic discovery of AGENTS.md, skills, and config.toml." The IDE extension treats the folder open in your editor as the project, so open the wiki folder there too. [16] [17]
* **Plans.** "Codex is included across ChatGPT plans, including Free and Go." On Free and Go, OpenAI's pricing page lists the desktop app, subject to rollout, and Codex cloud isn't included. You can also sign in with an API key for the desktop app, the CLI, and the IDE extension. [18] [19] [20]

## Other agents

These agents follow the same `AGENTS.md` convention in different ways. The common thread: some load only the nearest `AGENTS.md`, and some can't read files above the folder you open without a setting or a prompt. The kit handles the first case on its own, because each wiki's `AGENTS.md` tells the agent to read the top folder's `AGENTS.md` whenever the shared rules aren't in its context. For the second case, use the step listed for your agent. A plain request like "ingest raw/notes.md" works in all of them. No agent's docs describe anything that would block it.

**Gemini CLI**

* It doesn't read `AGENTS.md` by default. Its default file is `GEMINI.md`. [21]
* To change that, add `"context": {"fileName": ["AGENTS.md", "GEMINI.md"]}` to `~/.gemini/settings.json`. Gemini reads project settings only from the folder you start in, so a setting in the kit's top folder won't apply inside a wiki folder. [21] [22]
* Once that's set, it loads `AGENTS.md` from the start folder and each parent up to the git root, and it also scans subfolders below the start folder. So start it inside the wiki folder. Started at the top folder, it would load every wiki's rules at once. [22]
* Its file tools are limited to the start folder. Add `--include-directories` with the path of the kit's top folder, so it can read the shared procedures. [22] [23]
* It finds skills in `.agents/skills/` in the current folder only, so the kit's top-level `wiki-*` skills won't appear inside a wiki folder. Plain requests still work. [24]

**Cursor**

* It reads `AGENTS.md` in the project root and in subfolders. A nested file combines with its parents, "with more specific instructions taking precedence." [25]
* So open the kit's top folder as your project, and name the wiki in your requests, for example "ingest my-wiki/raw/notes.md." Opened on a wiki folder alone, whether it reads the parent `AGENTS.md` isn't documented.
* There's nothing to set. It picks up `.agents/skills/` anywhere in the repository. [26]

**GitHub Copilot in VS Code**

* VS Code reads `AGENTS.md` by default (`chat.useAgentsMdFile`).
* Nested files need `chat.useNestedAgentsMdFiles`, which is experimental and off by default.
* If you open a wiki folder alone, set `chat.useCustomizationsInParentRepositories` to `true`. VS Code then walks up to the repository root, and that folder must be trusted. [27] [28]
* VS Code treats instruction files as additive, so the kit's wiki rules state outright where they override the shared rules. [27]
* Skills load from `.agents/skills/`, `.claude/skills/`, and `.github/skills/`. [29]
* VS Code now offers two agent harnesses, and the nested-file behavior above is documented for the older one. {{VERIFY: how the newer Copilot harness loads nested and parent `AGENTS.md` files.}}

**GitHub Copilot on github.com and in the terminal**

* The cloud agent reads `AGENTS.md` files anywhere in the repository, and the nearest one takes precedence. It finds skills in `.agents/skills/`. It works across the whole repository, so name the wiki's path in your task. Whether the kit's git hooks run there isn't documented. [30] [31]
* Copilot CLI loads `AGENTS.md` from the repository root, the current folder, and the folders between them. By default it can only access the current folder, so start it with `--add-dir` pointing at the kit's top folder. [32] [33]

**Also checked**

* **Devin Desktop**, formerly Windsurf, reads `AGENTS.md` by default. It loads root files at session start, and subfolder files as it reaches them. It finds skills in `.agents/skills/`. Its older Cascade agent caps workspace rule files at 12,000 characters each, and whether that cap covers `AGENTS.md` isn't documented. The kit's top `AGENTS.md` stays under 12,000 characters anyway. [34] [35]
* **Zed** reads only the first matching instruction file in the project folder. Opened on a wiki folder, that's the wiki's `AGENTS.md`, which sends it to the top folder's file. It loads skills only from the opened folder's `.agents/skills/`. [36] [37]
* **Amp** includes `AGENTS.md` from the current folder and every parent up to your home folder, and it reads skills from `.agents/skills/` in the project and in parent folders. There's nothing to set. [38] [39]
* **OpenCode** walks up from the current folder for `AGENTS.md`, but "the first matching file wins," so it may load only the wiki's file. The safety net covers that. It asks before reading above the start folder. [40] [41]

The kit's `wiki-*` skill folders follow the open Agent Skills format: a `name` of lowercase letters, digits, and single hyphens that matches its folder, plus a `description` of up to 1,024 characters. [42]

## Git, GitHub, and your computer

* **First branch name.** `git init` still names the first branch `master` unless you've set `init.defaultBranch`. The kit uses `git init -b main`, and `git branch -M main` before a first push. [43] [44]
* **Template copies.** Above the file list, click **Use this template**, then **Create a new repository**, and finish with **Create repository from template**. "Use this template" creates your repository with a single commit and unrelated history. You can't merge later kit updates into it, so you copy them in by hand. [45]
* **Forks.** A fork of a public repository is public, and you can't change a fork's visibility on its own. A template copy lets you choose **Private**, which is why the kit sends you to **Use this template** instead. [45] [58]
* **GitHub Desktop.** To put a repository on your computer without git commands, click **Code** above the file list, then **Open with GitHub Desktop**. GitHub Desktop asks where to keep the folder, and clones it when you click **Clone**. [56]
* **Download ZIP** gives you a snapshot of the files, without history. [46]
* **Hooks.** Clones don't copy hooks, and git ignores a hook file that isn't executable. `sh git-hooks/install.sh` copies the kit's hooks into `.git/hooks/` and marks them executable. [47] [48]
* **GitHub CLI sign-in.** In `gh auth login`, choose HTTPS and answer yes when it asks to authenticate Git with your GitHub credentials. GitHub CLI then stores your Git credentials for you. [49] In this release's testing on macOS, a dry-run push that used only GitHub CLI's credential, with no terminal attached and terminal prompts turned off, signed in without a prompt, as the hook needs. That credential can push to every repository your account can write to, while a deploy key reaches only the one repository you add it to. [50] [51]
* **Mac.** If git isn't installed yet, run `git --version` in Terminal. macOS then offers to install Apple's command line tools, which include git. [57]
* **Windows.** Git for Windows "provides a BASH emulation used to run Git from the command line." Run the kit's shell commands in Git Bash. The kit pins hooks and scripts to LF line endings, so a Windows checkout can't break their first line. [52] [53] {{VERIFY: that the full Git for Windows install runs the kit's `#!/bin/sh` hooks. Its docs state this only for the smaller MinGit build.}}
* **macOS background sync.** `launchctl load` is a legacy subcommand, and `bootstrap` is the recommended alternative, so the kit's instructions use `bootstrap`. [54]
* **Obsidian** is "free for all purposes, including personal, commercial, and non-profit use." [55]

## Sandboxed agents and auto-push

Some agents run commands in a sandbox with network access off. A commit made there still succeeds, but the post-commit hook's push can't reach GitHub. By design, the hook never blocks your work: it logs the failure to `.git/auto-push.log` and prints a one-line warning. If your commits aren't showing up on GitHub, read that log, then push by hand with `git push` from a normal terminal, or set up the optional background sync.

## Sources

Each source was checked on 2026-10-13, unless its line gives a later date.

1. Claude Code docs, How Claude remembers your project: https://code.claude.com/docs/en/memory
2. Claude Code changelog, version 2.1.277: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
3. Claude Code docs, Skills: https://code.claude.com/docs/en/skills
4. Claude Code docs, Set up Claude Code: https://code.claude.com/docs/en/setup
5. Claude Code docs, Desktop quickstart: https://code.claude.com/docs/en/desktop-quickstart
6. Claude Code docs, Desktop on Linux: https://code.claude.com/docs/en/desktop-linux
7. Claude Code docs, Permissions (checked again 2026-10-14): https://code.claude.com/docs/en/permissions
8. Claude Code docs, Permission modes (checked again 2026-10-14): https://code.claude.com/docs/en/permission-modes
9. Claude Code docs, Sandboxing: https://code.claude.com/docs/en/sandboxing
10. Codex docs, AGENTS.md: https://learn.chatgpt.com/docs/agent-configuration/agents-md
11. Codex docs, Advanced configuration: https://learn.chatgpt.com/docs/config-file/config-advanced
12. Codex source, agents_md.rs at tag rust-v0.162.1: https://github.com/openai/codex/blob/rust-v0.162.1/codex-rs/core/src/agents_md.rs
13. Codex docs, Build skills: https://learn.chatgpt.com/docs/build-skills
14. Codex docs, Approvals and security: https://learn.chatgpt.com/docs/agent-approvals-security
15. Codex docs, Sandboxing: https://learn.chatgpt.com/docs/sandboxing
16. Codex docs, What's new: https://learn.chatgpt.com/docs/whats-new
17. Codex docs, Projects: https://learn.chatgpt.com/docs/projects
18. OpenAI Help Center, Using Codex with your ChatGPT plan (page dated 2026-10-12): https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan
19. Codex docs, Pricing: https://learn.chatgpt.com/docs/pricing
20. Codex docs, Authentication: https://learn.chatgpt.com/docs/auth
21. Gemini CLI docs, GEMINI.md context files: https://geminicli.com/docs/cli/gemini-md/
22. Gemini CLI docs, Configuration: https://geminicli.com/docs/reference/configuration/
23. Gemini CLI docs, File system tools: https://geminicli.com/docs/tools/file-system/
24. Gemini CLI docs, Agent skills: https://geminicli.com/docs/cli/using-agent-skills/
25. Cursor docs, Rules: https://cursor.com/docs/rules
26. Cursor docs, Skills: https://cursor.com/docs/skills
27. VS Code docs, Custom instructions: https://code.visualstudio.com/docs/agent-customization/custom-instructions
28. VS Code docs, Customization overview: https://code.visualstudio.com/docs/agent-customization/overview
29. VS Code docs, Agent skills: https://code.visualstudio.com/docs/agent-customization/agent-skills
30. GitHub docs, Adding repository custom instructions: https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions
31. GitHub docs, About agent skills: https://docs.github.com/en/copilot/concepts/agents/about-agent-skills
32. GitHub docs, Copilot CLI custom instructions: https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions
33. GitHub docs, Configuring Copilot CLI: https://docs.github.com/en/copilot/how-tos/copilot-cli/set-up-copilot-cli/configure-copilot-cli
34. Devin docs, Rules: https://docs.devin.ai/cli/extensibility/rules
35. Devin docs, Cascade memories and rules: https://docs.devin.ai/desktop/cascade/memories
36. Zed docs, Instructions: https://zed.dev/docs/ai/instructions
37. Zed docs, Skills: https://zed.dev/docs/ai/skills
38. Amp docs, AGENTS.md: https://ampcode.com/docs/customize/agents-md
39. Amp docs, Skills: https://ampcode.com/docs/customize/skills
40. OpenCode docs, Rules: https://opencode.ai/docs/rules/
41. OpenCode docs, Permissions: https://opencode.ai/docs/permissions/
42. Agent Skills specification: https://agentskills.io/specification
43. Git docs, git init: https://git-scm.com/docs/git-init
44. Git docs, git branch: https://git-scm.com/docs/git-branch
45. GitHub docs, Creating a repository from a template (checked again 2026-10-14): https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template
46. GitHub docs, Downloading source code archives: https://docs.github.com/en/repositories/working-with-files/using-files/downloading-source-code-archives
47. Git docs, githooks: https://git-scm.com/docs/githooks
48. Pro Git, Git Hooks: https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
49. GitHub docs, Caching your GitHub credentials in Git: https://docs.github.com/en/get-started/git-basics/caching-your-github-credentials-in-git
50. GitHub docs, Scopes for OAuth apps: https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/scopes-for-oauth-apps
51. GitHub docs, Managing deploy keys: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys
52. Git for Windows: https://gitforwindows.org/
53. Git docs, gitattributes (eol): https://git-scm.com/docs/gitattributes
54. macOS `man launchctl`, LEGACY SUBCOMMANDS (macOS 26.6.2)
55. Obsidian license: https://obsidian.md/license
56. GitHub docs, Cloning a repository from GitHub to GitHub Desktop (checked 2026-10-14): https://docs.github.com/en/desktop/adding-and-cloning-repositories/cloning-a-repository-from-github-to-github-desktop
57. Pro Git, Installing Git (checked 2026-10-14): https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
58. GitHub docs, About permissions and visibility of forks (checked 2026-10-14): https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-permissions-and-visibility-of-forks
