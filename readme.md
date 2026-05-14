# MEGAVIM — A Polyglot PDE

A modern, IDE-on-par **Personal Development Environment** for Neovim covering:

- **Solidity / Solana / EVM** smart-contract development
- **AI / Python** workstreams
- **C++ DSA** & competitive programming
- **Rust** (systems + Anchor / Solana programs)
- **Web / MERN stack** (TypeScript, React, Node, MongoDB via Prisma)

Designed so you can stay inside Neovim for the entire dev loop — no need to drop back to VS Code.

> **Quick help inside Neovim:** press `<Space>?` or run `:PDEHelp`.

---

## ✨ Highlights

| Area | Tooling |
|---|---|
| LSPs | clangd, rust_analyzer, ts_ls, eslint, html, cssls, tailwindcss, emmet, jsonls, prismals, pyright, ruff, solidity_ls_nomicfoundation, taplo, yamlls, dockerls, marksman, lua_ls, bashls |
| Formatters | prettierd/prettier, stylua, rustfmt, clang-format, black, isort, taplo, shfmt, sql-formatter |
| Linters | eslint_d, ruff, shellcheck, hadolint, markdownlint, solhint |
| Completion | **blink.cmp** (Rust-backed) + LuaSnip + GitHub Copilot (via blink-copilot) |
| AI Agent | **CodeCompanion.nvim** — chat & inline edits via Copilot or Anthropic (Claude) adapters |
| Debugging | nvim-dap (Rust via codelldb, JS/TS via js-debug-adapter, debugpy for Python) |
| UI | tokyonight (+ catppuccin, rose-pine, kanagawa), lualine, bufferline, **snacks.nvim** (dashboard / notifier / input / statuscolumn / scroll / indent / image / bigfile) |
| Editing | flash.nvim motion, snacks.words, mini.ai, mini.move, dial.nvim, yanky.nvim, surround, substitute, autopairs, ts_context_commentstring, nvim-ufo folds, treesitter-context |
| Navigation | telescope (fzf-native + ui-select), **harpoon** (file pinning), **aerial** (symbol outline), nvim-tree |
| Search & Replace | **grug-far.nvim** (project-wide) |
| Testing | competitest.nvim (C++ test cases) |
| Git | gitsigns, lazygit, diffview, git-conflict, gitlinker, octo |
| Sessions | auto-session · **undotree** for visual undo history |

---

## ⚡ Requirements

Hard:
- **Neovim ≥ 0.11** (uses `vim.lsp.config`/`vim.lsp.enable`)
- **git ≥ 2.19**
- **ripgrep** (`rg`) — telescope live grep
- **fd** — telescope file finder
- **A Nerd Font** — for icons
- **gcc / make** — treesitter compilation
- **Node.js ≥ 18** — most LSPs are Node-based

Per-stack (install only what you need):
- **C++ DSA**: g++/clang++, clang-format
- **Rust**: rustup, lldb (for debugging)
- **Python / AI**: python ≥ 3.10
- **Web**: bun or pnpm/npm
- **Solidity**: forge / hardhat (optional)
- **Solana**: solana CLI, anchor CLI

External tools (Mason auto-installs LSPs/formatters/linters/DAP adapters listed under `mason.lua`).

---

## 🛠 Installation

```bash
# Backup any existing config
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null

# Clone
git clone https://github.com/<your-username>/nvim-config.git ~/.config/nvim

# First launch — lazy.nvim & Mason install everything (let it finish)
nvim
```

Inside Neovim: run `:Lazy sync`, then `:Mason` and verify all servers/tools show as installed.

GitHub Copilot: run `:Copilot auth` (then follow device-code flow). Disable with `:Copilot disable` if you don't want AI completion.

---

## 🚀 Getting Started

1. Open a file — LSP, treesitter, formatter, completion all wire up automatically per filetype.
2. Press `<Space>?` to see every keymap in a floating help window. (Also `:PDEHelp`.)
3. Press `<Space>ff` to fuzzy-find files, `<Space>fs` to grep the project.

> **Tip:** Leader is `<Space>`. The help reference is the source of truth — this README is a tour.

---

## 🪟 IDE-like Workflow

### Buffers (VSCode-style tabs)
- `<Tab>` / `<S-Tab>` — cycle next/prev buffer
- `<Space>1..9` — jump directly to buffer N
- `<Space>bd` — close buffer · `<Space>bD` — close others
- `<Space>bb` — pick buffer by label
- `<Space>bP` — pin · `<Space>bh` / `<Space>bl` — close left/right of current

### Splits
- `<Space>sv` / `<Space>sh` — vertical / horizontal split
- `<Ctrl-h/j/k/l>` — navigate splits (also jumps across tmux panes)
- `<Ctrl-Arrow>` — resize (smart-splits, tmux-aware)
- `<Space>sH/sJ/sK/sL` — swap buffers between splits
- `<Space>se` — equalize · `<Space>sm` — maximize/restore · `<Space>so` — close others

### Tabs (full-screen workspaces)
- `<Space>to` / `<Space>tx` — open / close · `<Space>tn` / `<Space>tp` — next/prev
- `<Space>tf` — move current buffer to its own tab

---

## 💻 Per-Language Notes

### Web / MERN
- `ts_ls` for TS/JS, `eslint` LSP auto-fixes on save, `tailwindcss` LSP for class completion + previews, `emmet` for HTML/JSX expansion, `prismals` for `schema.prisma`.
- `prettierd` runs on save.
- Linting via `eslint_d` only kicks in if a project-level ESLint config is present.
- Debug Node/Chrome with `<Space>db` then `<Space>dc`.

### Python / AI
- `pyright` for types, `ruff` LSP for diagnostics + fix-ons, `black` + `isort` on save.
- DAP adapter: `debugpy` (installed via Mason).

### C++ / DSA
- F4 = compile, F5 = compile + run, F6 = run with `<name>_input.txt`.
- `dsa<Tab>` snippet inserts a competitive template. See `QUICK_REFERENCE.md`.
- CompetiTest for multi-test workflow: `<Space>cr`, `<Space>ca`, `<Space>cra`.
- `.clangd` at the repo root pins flags for clangd.

### Rust (incl. Solana / Anchor)
- `rust-tools` drives rust-analyzer with inlay hints + clippy on save.
- `taplo` LSP handles `Cargo.toml` and `Anchor.toml`.
- `<C-Space>` hover actions, `<Space>ca` code-action group.
- Debug with codelldb: `<Space>db` then `<Space>dc`.
- `<Space>rt` runs `cargo run` in a persistent terminal.

### Solidity / EVM
- `solidity_ls_nomicfoundation` LSP — diagnostics, definitions, hover.
- `solhint` linting (uses your project's `.solhint.json` if present).
- Format with `prettier` (install `prettier-plugin-solidity` in your project).
- Treesitter solidity parser pre-installed.

### Lua / Shell / Markdown / Docker / YAML / SQL
- `lua_ls` (vim-aware), `bashls` + `shellcheck`, `marksman` + `markdownlint`, `dockerls` + `hadolint`, `yamlls` (schemastore), `sql-formatter`.

---

## 🧠 Completion & AI

**Completion — blink.cmp (Rust-backed, sub-ms fuzzy matching):**

- `<Tab>` / `<S-Tab>` — accept / next or prev item, expand or jump in snippets (super-tab preset)
- `<C-Space>` — trigger completion explicitly
- `<C-n>` / `<C-p>` — cycle items
- `<C-b>` / `<C-f>` — scroll docs · `<C-e>` — abort · `<CR>` — confirm
- Sources: `copilot` → `lsp` → `snippets` → `buffer` → `path`. Copilot suggestions appear inline as cmp items.
- Run `:Copilot status` to verify Copilot is authenticated.

**AI Agent — CodeCompanion (chat with Copilot or Claude):**

- `<Space>aa` — toggle chat buffer
- `<Space>ac` — new chat
- `<Space>ae` — inline edit on visual selection
- `<Space>ap` — action palette
- `<Space>aq` — add visual selection to chat
- `<Space>aA` — switch adapter (copilot ↔ anthropic)
- Default adapter is **`claude_code`** — uses the `claude` CLI from your Claude Code subscription. No API key required; just needs `claude` in your `PATH` and `claude auth` to be done.
- `<Space>aA` cycles: `claude_code` → `copilot` → `anthropic` → back. `anthropic` requires `ANTHROPIC_API_KEY` in env.

---

## 🩺 Diagnostics

- `<Space>d` line float · `<Space>D` buffer list (telescope) · `[d` / `]d` jump
- `<Space>x{w,d,q,l,t}` — Trouble panels: workspace / document / quickfix / loclist / todos
- `[[` / `]]` — jump between references of symbol under cursor (snacks.words)

---

## 🗒 Git

- `<Space>lg` — full LazyGit
- `]h` / `[h` — next/prev hunk · `<Space>hs` stage · `<Space>hr` reset · `<Space>hp` preview
- `<Space>hb` blame line · `<Space>hB` toggle inline blame · `<Space>hd` diff this

---

## 🐛 Debug

`<Space>db` toggle breakpoint · `<Space>dc` continue · `<Space>di/do/dO` step in/over/out · `<Space>du` toggle UI · `<Space>dx` terminate · `<Space>dl` re-run last.

---

## 🧩 Customizing

- Plugins live in `lua/shekhar/plugins/` — one file per concern.
- LSPs: edit `lua/shekhar/plugins/lsp/lspconfig.lua` and `lua/shekhar/plugins/lsp/mason.lua`.
- Formatters/linters: `formatting.lua` and `linting.lua`.
- Snippets: drop `.lua` files into `lua/shekhar/snippets/`.
- Help text: `lua/shekhar/core/help.lua`.

To temporarily disable autoformat-on-save: `:FormatDisable` (global) or `:FormatDisable!` (current buffer). Re-enable with `:FormatEnable`.

---

## 🛟 Troubleshooting

- An LSP is missing? `:Mason` → search → press `i`.
- A formatter/linter doesn't run? `:checkhealth conform` or `:checkhealth lint`.
- Treesitter parser issues? `:TSUpdate`.
- A plugin fails on startup? `:Lazy log` and check the offending entry.
- Copilot not suggesting? `:Copilot status` and `:Copilot auth`.
- Stale plugin lock causing breakage? `rm lazy-lock.json && nvim +Lazy! sync`.

---

## 📚 Files in this repo

```
init.lua                        — entry; loads core + lazy
install.sh                      — bootstrap (optional)
lazy-lock.json                  — pinned plugin versions
.clangd                         — clangd flags for C++
readme.md                       — this file
QUICK_REFERENCE.md              — C++ DSA workflow cheatsheet
lua/shekhar/
  core/
    init.lua                    — loads options/keymaps/help
    options.lua                 — vim options
    keymaps.lua                 — global keymaps
    help.lua                    — :PDEHelp floating reference
  lazy.lua                      — lazy.nvim bootstrap
  snippets/                     — custom snippets (e.g. cpp.lua)
  plugins/                      — one file per plugin
    lsp/
      mason.lua                 — Mason + tool installer
      lspconfig.lua             — server configs (vim.lsp.config)
    nvim-cmp.lua / copilot.lua  — completion + AI
    treesitter*.lua / illuminate.lua / flash.lua / ufo.lua
    bufferline.lua / lualine.lua / nvim-tree.lua / smart-splits.lua
    formatting.lua / linting.lua
    debugger.lua / rust-tools.lua / cpp-dsa.lua
    gitsigns.lua / lazygit.lua / trouble.lua / todo-comments.lua
    auto-session.lua / alpha.lua / dressing.lua / noice.lua
    surround.lua / substitute.lua / autopairs.lua / comment.lua
    indent-blankline.lua / vim-maximizer.lua / which-key.lua / toggleterm.lua
```
