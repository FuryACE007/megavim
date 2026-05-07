# Quick Reference

> Run `:PDEHelp` (or press `<Space>?`) inside Neovim for the full live keymap reference.

## 🚀 Daily Loop

```
<Space>?       → open full help
<Space>ff      → find files (telescope)
<Space>fs      → grep project
<Space>ee      → toggle file tree
<Tab>          → next buffer (VSCode-like tab)
<Space>1..9    → jump to buffer N
Ctrl-S         → save
<Space>mp      → format buffer
<Space>ca      → code action
<Space>rn      → rename symbol
gd / gR        → definition / references
K              → hover docs
<Ctrl-h/j/k/l> → move between splits (tmux-aware)
<Space>sv/sh   → vertical / horizontal split
<Space>lg      → LazyGit
```

## 💻 C++ DSA

```
F4   → compile
F5   → compile + run (interactive stdin)
F6   → run with <name>_input.txt as stdin

<Space>ci  → open <name>_input.txt
<Space>co  → open <name>_output.txt
<Space>cr  → CompetiTest run
<Space>ca  → CompetiTest add testcase
<Space>cra → CompetiTest run all
```

### Snippets (Tab to expand)

```
dsa            → full competitive template (fast I/O + macros)
cppmain        → simple main()
fastio         → fast I/O block
vinput / vprint → vector read / print
binary_search / two_pointers / sliding_window
dfs / bfs
```

### Template macros (inside `dsa`)

```
ll, vi, pb, all(x), sz(x), F, S
```

## 🦀 Rust / Solana

```
<C-Space>   → hover actions (rust-tools)
<Space>ca   → code action group
<Space>rt   → cargo run in floating term
<Space>db   → toggle breakpoint (DAP)
<Space>dc   → continue (DAP)
```

`Anchor.toml` / `Cargo.toml` get LSP via `taplo`.

## 🌐 Web / MERN

```
prettierd / eslint_d run on save (eslint only if config present)
tailwindcss class previews via LSP hover
emmet expansion in HTML/JSX (Tab inside an abbreviation)
prismals for schema.prisma
```

## 🐍 Python / AI

```
pyright (types) + ruff (diagnostics)
black + isort on save
debugpy DAP adapter installed
```

## 🛡 Solidity

```
solidity_ls_nomicfoundation LSP (diagnostics/hover/defs)
solhint linting
prettier formatting (install prettier-plugin-solidity in project)
```

## 🪟 Window Mastery

```
<Space>sv / sh   → split
<Space>se        → equalize · <Space>so → close others
<Space>sm        → maximize toggle
<C-arrow>        → resize
<Space>sH/J/K/L  → swap with neighbor
```

## 💡 Tips

- `:PDEHelp` is the canonical reference — keep it open in a split.
- `:FormatDisable` mutes autoformat-on-save when you need a dirty diff.
- Press `<Space>?` from the dashboard to discover keymaps without leaving Neovim.
