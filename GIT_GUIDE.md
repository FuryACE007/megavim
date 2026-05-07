# Git & GitHub Tools Guide

Everything you already know about git works exactly the same. These tools are just
**Neovim interfaces** on top of commands you already run in the terminal — no new
concepts, just faster access without leaving your editor.

---

## 1. LazyGit  (`<leader>lg`)

**What it is:** A full terminal git UI inside a floating window. Think of it as
running `git status`, `git log`, `git diff`, `git add`, `git commit`, `git push`
all in one place — but with a keyboard-driven UI.

**Open it:** `<leader>lg` from any buffer.

### Layout

```
┌─────────────────────────────────────────────────────┐
│ Status    │ Files (staged / unstaged)               │
│ Branches  │                                         │
│ Commits   │  Diff preview of selected file / commit │
│ Stash     │                                         │
└─────────────────────────────────────────────────────┘
```

Press `?` inside LazyGit to see all keymaps. The ones you'll use most:

| Key | What it does |
|-----|-------------|
| `space` | Stage / unstage file (equivalent to `git add`) |
| `a` | Stage all files (equivalent to `git add -A`) |
| `c` | Commit staged changes (opens commit message prompt) |
| `P` | Push to remote (`git push`) |
| `p` | Pull from remote (`git pull`) |
| `f` | Fetch from remote |
| `b` | View / switch branches |
| `n` | New branch |
| `d` | Delete branch |
| `enter` | Open file diff in full screen |
| `tab` | Switch between panels |
| `[` / `]` | Previous / next tab panel |
| `e` | Edit selected file in Neovim |
| `q` | Close LazyGit |
| `?` | Show all keymaps |

### Common workflows

**Stage and commit:**
1. `<leader>lg` to open
2. Navigate to "Files" panel
3. `space` on each file to stage (or `a` for all)
4. `c` to write commit message
5. `P` to push

**View commit history:**
1. Navigate to "Commits" panel (press `]` or `tab`)
2. Arrow keys to browse commits
3. `enter` to see full diff of that commit

**Switch branches:**
1. Navigate to "Branches" panel
2. Arrow keys to select branch
3. `space` to check it out

**More keymaps for current file log / filter:**
- `<leader>lf` — open LazyGit scoped to the current file's history
- `<leader>ll` — project-wide log view

---

## 2. gitsigns  (always active in git repos)

**What it is:** Signs in the left gutter (the `▎` marks) that show what changed
since the last commit. Each changed section is called a **hunk**.

```
  1  ▎ fn hello() {          ← this line is unchanged but near a hunk
  2  ▎   println!("hi");     ← modified (yellow ▎)
  3    }
  4  ▎ fn new_fn() {         ← added (green ▎)
  5  ▎   // ...
  6  ▎ }
```

### Navigating hunks

| Key | Action |
|-----|--------|
| `]h` | Jump to **next** changed hunk |
| `[h` | Jump to **previous** changed hunk |

### Inspecting a hunk

| Key | Action |
|-----|--------|
| `<leader>hp` | Floating popup showing the original vs current |
| `<leader>hP` | Inline diff (shows deleted lines right in the buffer) |
| `<leader>hb` | Full git blame popup for this line |
| `<leader>hB` | Toggle always-visible blame at end of each line |
| `<leader>hw` | Toggle **word-level** diff (highlights individual words that changed) |
| `<leader>hd` | Open a proper diff split (current vs index) |
| `<leader>hD` | Diff vs the commit before HEAD |

### Staging hunks (without leaving the file)

This is the killer feature — you can stage individual hunks without opening LazyGit.

| Key | Action |
|-----|--------|
| `<leader>hs` | Stage the hunk under cursor |
| `<leader>hr` | Discard the hunk (restore to last commit) |
| `<leader>hu` | Un-stage a hunk you just staged |
| `<leader>hS` | Stage the entire file |
| `<leader>hR` | Discard all changes in the file |

**Visual mode staging** — select lines with `v`, then `<leader>hs` to stage only
those lines. This lets you do partial-hunk staging (equivalent to `git add -p`).

### Hunks as text objects

In operator-pending mode (`d`, `y`, `c`, etc.) use `ih` to target a hunk:
- `dih` — delete the entire hunk
- `yih` — yank a hunk
- `vih` — visually select a hunk

---

## 3. diffview  (`<leader>gd`)

**What it is:** A full-screen diff viewer. Think of it as `git diff` or
`git log -p` but visual, navigable, and interactive.

### Opening a diff

| Key | What you see |
|-----|-------------|
| `<leader>gd` | All uncommitted changes (equivalent to `git diff HEAD`) |
| `<leader>gD` | Changes since the commit before HEAD (`git diff HEAD~1`) |
| `<leader>gf` | Full history of the **current file** (every commit that touched it) |
| `<leader>gF` | Full history of the **whole repo** |

Press `<leader>gx` or `q` to close.

### Inside the diff view

The screen splits into:
- **Left panel** — file list (which files changed)
- **Right panel** — side-by-side diff of selected file

Navigation inside the file list:
| Key | Action |
|-----|--------|
| `j / k` | Move between files |
| `enter` | Open that file's diff |
| `<tab>` | Focus between file panel and diff |
| `[x / ]x` | Previous / next conflict marker |
| `q` | Close |

Inside the diff panels:
| Key | Action |
|-----|--------|
| `]c / [c` | Next / previous change in this file |
| `<leader>gx` or `q` | Close diffview |

### Viewing file history

`<leader>gf` opens a log of every commit that touched the current file.
Arrow keys to browse, `enter` to see the full diff for that commit. This is
extremely useful for understanding *why* a line is the way it is.

### Merge conflict resolution (3-way merge)

When you hit a merge conflict, open diffview and it automatically shows the
**3-way merge tool**:
- Left pane: **your** changes (ours / current branch)
- Middle pane: the file you're editing with conflict markers
- Right pane: **incoming** changes (theirs / the branch being merged)

You edit the middle pane to produce the final result, then save and commit.

---

## 4. git-conflict  (auto-activates on conflict files)

**What it is:** When a file has conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`),
this plugin highlights the sections with colour and gives you keymaps to resolve
each conflict with one key.

```
  <<<<<<< HEAD (ours — highlighted blue)
    const x = 1;
  =======
    const x = 2;
  >>>>>>> feature-branch (theirs — highlighted green)
```

### Resolving conflicts

Position your cursor anywhere inside a conflict block, then:

| Key | Action |
|-----|--------|
| `<leader>co` | Keep **ours** (delete theirs) |
| `<leader>ct` | Keep **theirs** (delete ours) |
| `<leader>cb` | Keep **both** (ours on top, theirs below) |
| `<leader>cn` | Keep **neither** (delete the entire block) |
| `]x` | Jump to next conflict in the file |
| `[x` | Jump to previous conflict |
| `<leader>cx` | List every conflict across the repo in the quickfix list |

### Typical merge conflict workflow

1. Run `git merge feature-branch` or `git rebase` in terminal (or LazyGit)
2. Open each conflicted file in Neovim
3. Press `]x` to jump to the first conflict
4. Press `<leader>co` / `<leader>ct` / `<leader>cb` to resolve
5. Press `]x` for the next one, repeat
6. Save the file
7. Go to LazyGit (`<leader>lg`) to stage and commit

---

## 5. octo.nvim  (GitHub PRs & issues)

**What it is:** GitHub's PR and issue interface inside Neovim. You can read,
comment on, review, and merge PRs without opening a browser.

### One-time setup (required)

```bash
# In your terminal (outside Neovim):
gh auth login
# Follow the prompts — choose GitHub.com, HTTPS, and authenticate via browser
```

After that, octo works automatically.

### Working with Pull Requests

| Command / Key | Action |
|--------------|--------|
| `<leader>op` | List all open PRs in the repo |
| `<leader>oc` | Create a new PR from current branch |
| `<leader>or` | Start a review on the current PR |
| `<leader>om` | Merge the current PR |

**Reading a PR:**
1. `<leader>op` opens a telescope picker of all open PRs
2. Select one with `enter`
3. The PR opens as a special buffer — you see the description, comments, files

Inside a PR buffer you can:
- Read the description and all comments
- Add a comment: position cursor where you want, then `:Octo comment add`
- React to comments: `:Octo reaction add`
- View changed files: `:Octo pr files`

**Reviewing a PR:**
1. Open the PR (`<leader>op` → select)
2. `<leader>or` to start a review
3. diffview opens the changed files
4. Navigate to a line you want to comment on
5. `:Octo review comment` to leave an inline comment
6. `<leader>or` again to submit the review

### Working with Issues

| Command / Key | Action |
|--------------|--------|
| `<leader>oi` | List open issues |
| `:Octo issue create` | Create a new issue |
| `:Octo issue close` | Close current issue |
| `<leader>oA` | Add an assignee |
| `<leader>oL` | Add a label |

### Useful Octo commands (run from the PR/issue buffer)

```
:Octo pr list              — list PRs
:Octo pr checkout          — git checkout this PR's branch
:Octo pr diff              — open diffview for this PR
:Octo pr browser           — open PR in browser
:Octo issue list           — list issues
:Octo comment add          — add a comment
:Octo reaction add         — react to something
:Octo assignee add         — assign someone
:Octo label add            — add a label
:Octo review start         — start a review
:Octo review submit        — submit your review
```

---

## 6. gitlinker  (share lines from GitHub)

**What it is:** Generates the GitHub URL for the exact line (or lines) you're
looking at, either copying it to clipboard or opening the browser.

### Usage

1. Go to any line in any tracked file
2. `<leader>gy` — copies the GitHub permalink to your clipboard
3. `<leader>go` — opens that line on GitHub in your browser

For a **range of lines**, visually select them first (`v` then arrow keys), then
`<leader>gy` or `<leader>go`.

The URL format is:
`https://github.com/<owner>/<repo>/blob/<commit-sha>/path/to/file.rs#L42`

This is the **exact commit SHA**, not `main` — so the link always points to that
specific version of the code even after future commits.

---

## Quick Reference Card

```
LazyGit
  <leader>lg   Full git UI
  <leader>lf   Current file history in LazyGit
  <leader>ll   Project log

Hunks (gitsigns)
  ]h / [h      Next / prev hunk
  <leader>hp   Preview hunk popup
  <leader>hs   Stage hunk (v = partial)
  <leader>hr   Discard hunk
  <leader>hb   Blame popup
  <leader>hB   Toggle inline blame
  <leader>hw   Toggle word diff

Diffs & History (diffview)
  <leader>gd   Diff working tree
  <leader>gf   File history (current file)
  <leader>gF   Repo history
  <leader>gx   Close

Conflicts (git-conflict)
  ]x / [x      Jump between conflicts
  <leader>co   Keep ours
  <leader>ct   Keep theirs
  <leader>cb   Keep both
  <leader>cn   Keep neither

GitHub (octo — needs: gh auth login)
  <leader>op   List PRs
  <leader>oi   List issues
  <leader>or   Start review
  <leader>oc   Create PR
  <leader>om   Merge PR

GitHub links (gitlinker)
  <leader>gy   Copy permalink (n / v)
  <leader>go   Open on GitHub  (n / v)
```
