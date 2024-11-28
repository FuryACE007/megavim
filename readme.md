# Neovim IDE Configuration

A modern Neovim configuration for full-stack development with focus on Rust and MERN stack.

## ⚡️ Requirements

- Neovim >= 0.9.0
- Git >= 2.19.0 (for partial clones support)
- A Nerd Font (optional, for icons)
- gcc (for treesitter)
- ripgrep (for telescope)
- lazygit (optional, for git integration)
- Node.js >= 16.x (for LSP servers)
- Rust toolchain (for Rust development)
- LLDB (for Rust debugging)

## 🛠️ Installation

```bash
# Backup existing Neovim configuration
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone the repository
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

# Start Neovim (plugins will be installed automatically)
nvim
```

# Neovim IDE Keybindings Cheatsheet

## 🔍 Search and Navigation

### Telescope

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fs` - Find string under cursor
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fk` - Keymaps
- `<leader>fr` - Recent files
- `<leader>fc` - Find word under cursor
- `<leader>fC` - Find word under cursor (root dir)
- `<leader>fd` - Find diagnostics
- `<C-k>` - Move to previous result
- `<C-j>` - Move to next result
- `<C-q>` - Send to quickfix list

### LSP Navigation

- `gR` - Show LSP references
- `gD` - Go to declaration
- `gd` - Show LSP definitions
- `gi` - Show LSP implementations
- `gt` - Show LSP type definitions
- `K` - Show documentation
- `<leader>rs` - Restart LSP

### Todo Comments

- `]t` - Next todo comment
- `[t` - Previous todo comment
- `<leader>xt` - List all todo comments

## 💻 Code Actions and Refactoring

- `<leader>ca` - See available code actions
- `<leader>rn` - Smart rename
- `<leader>mp` - Format file or selection (works in visual mode)
- `<leader>D` - Show buffer diagnostics
- `<leader>d` - Show line diagnostics

## 🔄 Text Manipulation

### Word Operations

- `viw` - Visually select inner word
- `yiw` - Yank (copy) inner word

### Substitute

- `s{motion}` - Substitute with motion (e.g., `siw` to substitute word)
- `ss` - Substitute line
- `S` - Substitute to end of line
- `s` - Substitute selection (in visual mode)

### Surround

- `ys{motion}{char}` - Add surround (e.g., `ysiw"` to surround word with quotes)
- `ds{char}` - Delete surround (e.g., `ds"` to delete surrounding quotes)
- `cs{target}{replacement}` - Change surround (e.g., `cs"'` to change quotes to single quotes)
- `S{char}` - Surround selection (in visual mode)

Common Examples:

- `viw` then `S"` - Select word and surround with quotes
- `ysiw"` - Surround word under cursor with quotes (without visual selection)
- `viws` - Select word and substitute it
- `cs"'` - Change surrounding double quotes to single quotes

## 🔧 Diagnostics and Troubleshooting

### Trouble

- `<leader>xw` - Toggle workspace diagnostics
- `<leader>xd` - Toggle document diagnostics
- `<leader>xq` - Toggle quickfix list
- `<leader>xl` - Toggle location list
- `<leader>xt` - Toggle TODOs

### Linting

- `<leader>l` - Trigger linting for current file

## 📝 Code Completion

### nvim-cmp

- `<C-k>` - Select previous suggestion
- `<C-j>` - Select next suggestion
- `<C-b>` - Scroll docs backward
- `<C-f>` - Scroll docs forward
- `<C-Space>` - Show completion suggestions
- `<C-e>` - Close completion window
- `<CR>` - Confirm selection

### GitHub Copilot

- `<Tab>` - Accept suggestion
- `<M-]>` - Next suggestion
- `<M-[>` - Previous suggestion
- `<C-]>` - Dismiss suggestion

## 🦀 Rust-Specific

- `<C-space>` - Hover actions
- `<leader>ca` - Code action groups
- `]d` - Next error/warning
- `[d` - Previous error/warning

## 🎨 UI and Window Management

### Window Navigation

- `<C-h>` - Navigate left
- `<C-j>` - Navigate down
- `<C-k>` - Navigate up
- `<C-l>` - Navigate right

### Window Management

- `<leader>sm` - Toggle maximize/restore current window
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split

## 💾 Session Management

### Auto Session

- `<leader>ws` - Save session
- `<leader>wr` - Restore session

### Session Tips

- Sessions are automatically saved when exiting Neovim
- Sessions store:
  - Open buffers and their layout
  - Window positions
  - Working directory
  - Terminal states
- Use `<leader>ql` to switch between different project sessions

## 🔄 Git Integration

- `]c` - Next hunk
- `[c` - Previous hunk
- `<leader>gh` - Preview hunk
- `<leader>gH` - Preview hunk inline
- `<leader>gs` - Stage hunk
- `<leader>gu` - Undo stage hunk
- `<leader>gr` - Reset hunk
- `<leader>gR` - Reset buffer
- `<leader>gb` - Blame line
- `<leader>gd` - Diff this

## 🐛 Debugging

### Breakpoints

- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Set conditional breakpoint

### Control

- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dr` - Toggle REPL
- `<leader>dl` - Run last
- `<leader>dx` - Terminate

### UI

- `<leader>du` - Toggle debug UI
- `<leader>dh` - Hover variables
- `<leader>dp` - Preview (evaluate expression)

## 📌 Notes

- `<leader>` key is set to space
- Most commands work in normal mode unless specified
- Some commands have visual mode variants
- LSP commands are buffer-specific and only work when LSP is active

## 🔄 Common Operations

- Format on save is enabled with a timeout of 1000ms
- Linting runs on buffer enter, write, and insert leave
- LSP features are automatically enabled for supported file types
- Copilot suggestions appear automatically while typing

## 🎯 Pro Tips

1. Use `K` to quickly view documentation
2. Combine `<leader>ca` with visual selection for bulk actions
3. Use Telescope with `<C-q>` to build quickfix lists
4. Trouble (`<leader>x`) provides a better view of diagnostics
5. Format code with `<leader>mp` when automatic formatting fails
6. Use `<leader>fg` for project-wide search
7. Git blame with `<leader>gb` shows commit information
8. Debug UI (`<leader>du`) shows all variables and breakpoints

