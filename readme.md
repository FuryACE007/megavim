# Neovim IDE Configuration

A modern Neovim configuration for full-stack development with focus on Rust, MERN stack, and **C++ DSA problem solving**.

## 🎯 C++ DSA Problem Solving Setup

This configuration is optimized for competitive programming and DSA interview preparation! 

**Quick Start:**
1. Create a file: `nvim problem.cpp`
2. Type `dsa` + Tab for instant template
3. Press `F5` to compile and run

**📚 Documentation:**
- **Setup Instructions**: See `SETUP_INSTRUCTIONS.md` to get started
- **Quick Reference**: See `QUICK_REFERENCE.md` for essential keybindings
- **Complete Guide**: See `CPP_DSA_GUIDE.md` for detailed documentation
- **Sample Problem**: Check `sample_problem.cpp` for an example

**Key Features:**
- ✨ One-key compilation and execution (`F5`, `F6`)
- 🧪 Built-in test case management
- 📝 DSA-optimized code templates and snippets
- 🚀 Fast I/O setup
- 🎨 Auto-formatting with clang-format
- 🔍 Full LSP support (clangd)

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

### For C++ DSA:
- g++ or clang++ (C++ compiler)
- clangd (LSP server, install via `:Mason`)
- clang-format (code formatter): `brew install clang-format` (macOS) or `apt install clang-format` (Linux)

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

### Comments

- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` - Toggle line comment (visual mode)
- `gb` - Toggle block comment (visual mode)

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

## 💻 C++ DSA Problem Solving

### Quick Compile & Run
- `F4` - Compile only (check for errors)
- `F5` - Compile and run (interactive input)
- `F6` - Compile and run with input from `<filename>_input.txt`

### File Management
- `<leader>ci` - Create/open input file for current problem
- `<leader>co` - Create/open output file for current problem

### Test Case Management (CompetiTest)
- `<leader>cr` - Run all test cases
- `<leader>ca` - Add a new test case interactively
- `<leader>ce` - Edit existing test case
- `<leader>cd` - Delete a test case
- `<leader>cra` - Run all test cases
- `<leader>cst` - Show all test cases

### C++ Code Snippets
Type these and press Tab to expand:
- `dsa` - Full competitive programming template
- `cppmain` - Simple main function
- `fastio` - Fast I/O setup
- `vinput` - Vector input loop
- `vprint` - Vector print loop
- `binary_search` - Binary search implementation
- `sliding_window` - Sliding window template
- `two_pointers` - Two pointers pattern
- `dfs` - DFS graph traversal
- `bfs` - BFS graph traversal

### C++ Workflow Example
1. `nvim two_sum.cpp`
2. Type `dsa` + Tab (get template)
3. Write solution in `solve()` function
4. Press `<leader>ci` (create input file)
5. Add test input in split window
6. Press `F6` (run with input file)
7. Check results!

**See `CPP_DSA_GUIDE.md` for complete documentation**

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

## 📌️ Terminal Integration

### Toggle Terminal
- `<C-\>` - Toggle terminal (alternative method)
- `<leader>tt` - Toggle terminal
- `<leader>cr` - Run cargo run in terminal

### Terminal Navigation
- `<esc>` or `jk` - Exit terminal mode (return to normal mode)
- `i` - Enter terminal mode (when in normal mode)
- `<C-h>` - Move to left window
- `<C-j>` - Move to bottom window
- `<C-k>` - Move to top window
- `<C-l>` - Move to right window

### Terminal Tips
1. Use terminal mode for command input
2. Use normal mode for scrolling and copying
3. Terminal state is preserved across toggles
4. Multiple terminals can be created and managed

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

