-- In-editor help system.  :PDEHelp / <leader>?   and   :GitHelp / <leader>gH
-- Both open floating windows with filetype=markdown so render-markdown.nvim
-- renders headings, tables, code spans, and separators automatically.

local M = {}

-----------------------------------------------------------------------
-- Keymap data — each section becomes a markdown ## heading + table
-----------------------------------------------------------------------
local SECTIONS = {
  {
    title = "General",
    rows = {
      { "`<leader>`",        "Space bar (leader key)" },
      { "`jk`",              "Exit insert mode" },
      { "`<C-s>`",           "Save file" },
      { "`<leader>nh`",      "Clear search highlight" },
      { "`<leader>qq`",      "Quit all" },
      { "`<leader>qw`",      "Save all and quit" },
      { "`<leader>?`",       "Open PDE help (this window)" },
      { "`<leader>gH`",      "Open Git & GitHub guide" },
    },
  },
  {
    title = "File Explorer",
    rows = {
      { "`<leader>ee`",      "Toggle file explorer" },
      { "`<leader>ef`",      "Reveal current file in explorer" },
      { "`<leader>ec`",      "Collapse explorer" },
      { "`<leader>er`",      "Refresh explorer" },
    },
  },
  {
    title = "Fuzzy Find (Telescope)",
    rows = {
      { "`<leader>ff`",      "Find files" },
      { "`<leader>fr`",      "Recent files" },
      { "`<leader>fs`",      "Live grep (project)" },
      { "`<leader>fc`",      "Grep word under cursor" },
      { "`<leader>ft`",      "Find todo comments" },
    },
  },
  {
    title = "Buffers — VSCode-style tabs",
    rows = {
      { "`<Tab>` / `<S-Tab>`",  "Next / prev buffer" },
      { "`<S-l>` / `<S-h>`",   "Next / prev buffer (safe, preserves `<C-i>`)" },
      { "`<leader>1`..`9`",    "Jump directly to buffer N" },
      { "`<leader>bd`",         "Close buffer" },
      { "`<leader>bD`",         "Close all other buffers" },
      { "`<leader>bP`",         "Pin / unpin buffer" },
      { "`<leader>bb`",         "Pick buffer by label" },
      { "`<leader>bh` / `bl`",  "Close buffers to the left / right" },
    },
  },
  {
    title = "Window Splits",
    rows = {
      { "`<leader>sv`",         "Vertical split" },
      { "`<leader>sh`",         "Horizontal split" },
      { "`<leader>se`",         "Equalize split sizes" },
      { "`<leader>sx`",         "Close current split" },
      { "`<leader>so`",         "Close other splits" },
      { "`<leader>sm`",         "Maximize / restore split" },
      { "`<C-h/j/k/l>`",        "Navigate splits (tmux-aware)" },
      { "`<C-Arrow>`",           "Resize split" },
      { "`<leader>sH/J/K/L`",   "Swap buffer with neighbour split" },
    },
  },
  {
    title = "Tabs",
    rows = {
      { "`<leader>to`",         "New tab" },
      { "`<leader>tx`",         "Close tab" },
      { "`<leader>tn` / `tp`",  "Next / prev tab" },
      { "`<leader>tf`",         "Move current buffer to new tab" },
    },
  },
  {
    title = "LSP",
    rows = {
      { "`gd` / `gD`",          "Go to definition / declaration" },
      { "`gi`",                  "Go to implementation" },
      { "`gt`",                  "Go to type definition" },
      { "`gR`",                  "Show references (Telescope)" },
      { "`K`",                   "Hover documentation" },
      { "`<C-k>`",               "Signature help" },
      { "`<leader>ca`",          "Code action" },
      { "`<leader>rn`",          "Rename symbol" },
      { "`<leader>d`",           "Line diagnostics float" },
      { "`<leader>D`",           "Buffer diagnostics (Telescope)" },
      { "`[d` / `]d`",           "Prev / next diagnostic" },
      { "`[r` / `]r`",           "Prev / next reference (illuminate)" },
      { "`<leader>rs`",          "Restart LSP" },
    },
  },
  {
    title = "Completion (cmp + Copilot)",
    rows = {
      { "`<Tab>`",               "Next item / expand snippet" },
      { "`<S-Tab>`",             "Prev item / jump back in snippet" },
      { "`<C-n>` / `<C-p>`",    "Next / prev item" },
      { "`<C-Space>`",           "Trigger completion" },
      { "`<C-b>` / `<C-f>`",    "Scroll docs" },
      { "`<CR>`",                "Confirm selection" },
      { "`<C-e>`",               "Abort completion" },
      { "`:Copilot status`",     "Check Copilot authentication" },
      { "`:Copilot auth`",       "Authenticate Copilot" },
    },
  },
  {
    title = "Format and Lint",
    rows = {
      { "`<leader>mp`",          "Format buffer or visual range" },
      { "`<leader>l`",           "Trigger linter" },
      { "`:FormatDisable`",      "Disable auto-format globally" },
      { "`:FormatDisable!`",     "Disable auto-format for this buffer" },
      { "`:FormatEnable`",       "Re-enable auto-format" },
    },
  },
  {
    title = "Diagnostics and Trouble",
    rows = {
      { "`<leader>xw`",          "Workspace diagnostics" },
      { "`<leader>xd`",          "Document diagnostics" },
      { "`<leader>xq`",          "Quickfix list" },
      { "`<leader>xl`",          "Location list" },
      { "`<leader>xt`",          "Todo comments" },
    },
  },
  {
    title = "Git — LazyGit",
    rows = {
      { "`<leader>lg`",          "Open LazyGit (full TUI)" },
      { "`<leader>lf`",          "LazyGit — current file" },
      { "`<leader>ll`",          "LazyGit — project log" },
      { "`<leader>lL`",          "LazyGit — current file log" },
    },
  },
  {
    title = "Git — Hunks (gitsigns)",
    rows = {
      { "`]h` / `[h`",           "Next / prev hunk" },
      { "`<leader>hs`",          "Stage hunk (visual = partial stage)" },
      { "`<leader>hr`",          "Discard hunk" },
      { "`<leader>hS`",          "Stage whole buffer" },
      { "`<leader>hR`",          "Discard whole buffer" },
      { "`<leader>hu`",          "Undo staged hunk" },
      { "`<leader>hp`",          "Preview hunk popup" },
      { "`<leader>hP`",          "Preview hunk inline" },
      { "`<leader>hb`",          "Blame line (full popup)" },
      { "`<leader>hB`",          "Toggle always-on inline blame" },
      { "`<leader>hw`",          "Toggle word diff" },
      { "`<leader>hd`",          "Diff vs index" },
      { "`<leader>hD`",          "Diff vs HEAD~1" },
      { "`<leader>hq`",          "All hunks → quickfix" },
      { "`ih` / `ah`",           "Hunk text object (use with d/y/v)" },
    },
  },
  {
    title = "Git — Diffs and History (diffview)",
    rows = {
      { "`<leader>gd`",          "Diff working tree" },
      { "`<leader>gD`",          "Diff vs HEAD~1" },
      { "`<leader>gf`",          "File history (current file)" },
      { "`<leader>gF`",          "File history (whole repo)" },
      { "`<leader>gx`",          "Close diff view" },
    },
  },
  {
    title = "Git — Conflict Resolution",
    rows = {
      { "`]x` / `[x`",           "Next / prev conflict marker" },
      { "`<leader>co`",          "Keep ours" },
      { "`<leader>ct`",          "Keep theirs" },
      { "`<leader>cb`",          "Keep both" },
      { "`<leader>cn`",          "Keep neither (delete block)" },
      { "`<leader>cx`",          "List all conflicts in quickfix" },
    },
  },
  {
    title = "GitHub (Octo) — run `gh auth login` first",
    rows = {
      { "`<leader>op`",          "List open PRs" },
      { "`<leader>oi`",          "List open issues" },
      { "`<leader>or`",          "Start PR review" },
      { "`<leader>oc`",          "Create PR" },
      { "`<leader>om`",          "Merge PR" },
      { "`<leader>oA`",          "Add assignee" },
      { "`<leader>oL`",          "Add label" },
      { "`:Octo ...`",           "Full command palette (Tab to complete)" },
    },
  },
  {
    title = "GitHub — Links (gitlinker)",
    rows = {
      { "`<leader>gy`",          "Copy GitHub permalink (normal / visual)" },
      { "`<leader>go`",          "Open line / selection on GitHub in browser" },
    },
  },
  {
    title = "Terminal",
    rows = {
      { "`<C-\\>`",              "Toggle terminal" },
      { "`<leader>tt`",          "Toggle terminal" },
      { "`<esc>` or `jk`",       "Leave terminal mode" },
    },
  },
  {
    title = "C++ DSA",
    rows = {
      { "`F4`",                  "Compile only" },
      { "`F5`",                  "Compile and run (interactive stdin)" },
      { "`F6`",                  "Run with `<name>_input.txt` as stdin" },
      { "`<leader>ci`",          "Open / create input file" },
      { "`<leader>co`",          "Open / create output file" },
      { "`<leader>cr`",          "CompetiTest: run test cases" },
      { "`<leader>ca`",          "CompetiTest: add test case" },
      { "`<leader>cra`",         "CompetiTest: run all test cases" },
      { "`dsa<Tab>`",            "Insert full DSA template snippet" },
    },
  },
  {
    title = "Rust",
    rows = {
      { "`<C-Space>`",           "Hover actions (rust-tools)" },
      { "`<leader>ca`",          "Code action group" },
      { "`<leader>rt`",          "Run `cargo run` in terminal" },
    },
  },
  {
    title = "Debug (nvim-dap)",
    rows = {
      { "`<leader>db`",          "Toggle breakpoint" },
      { "`<leader>dc`",          "Continue" },
      { "`<leader>di`",          "Step into" },
      { "`<leader>do`",          "Step over" },
      { "`<leader>dO`",          "Step out" },
      { "`<leader>dr`",          "Toggle REPL" },
      { "`<leader>dl`",          "Run last debug session" },
      { "`<leader>dx`",          "Terminate" },
      { "`<leader>du`",          "Toggle debug UI" },
    },
  },
  {
    title = "Motion and Editing",
    rows = {
      { "`<leader>j`",           "Flash jump" },
      { "`<leader>J`",           "Flash treesitter selection" },
      { "`s{motion}`",           "Substitute with motion" },
      { "`ss` / `S`",            "Substitute line / to end of line" },
      { "`ys` / `ds` / `cs`",    "Surround: add / delete / change" },
      { "`gcc` / `gc`",          "Toggle line comment / visual comment" },
      { "`]t` / `[t`",           "Next / prev TODO comment" },
      { "`zR` / `zM`",           "Open / close all folds" },
      { "`zp`",                  "Peek folded lines under cursor" },
      { "`<C-d>` / `<C-u>`",     "Half-page down / up (centered)" },
    },
  },
  {
    title = "Sessions",
    rows = {
      { "`<leader>ws`",          "Save session" },
      { "`<leader>wr`",          "Restore session" },
    },
  },
  {
    title = "Languages Supported",
    rows = {
      { "Web / MERN",            "`ts_ls` `eslint` `html` `cssls` `tailwindcss` `emmet` `jsonls` `prismals`" },
      { "Python / AI",           "`pyright` `ruff` `black` — debugpy DAP adapter included" },
      { "C / C++",               "`clangd` `clang-format` — F4/F5/F6 compile workflow" },
      { "Rust",                  "`rust_analyzer` via rust-tools, `rustfmt`, clippy on save" },
      { "Solidity",              "`solidity_ls_nomicfoundation` `solhint` `prettier`" },
      { "Solana / Anchor",       "`rust_analyzer` + `taplo` for `Anchor.toml`" },
      { "DevOps",                "`dockerls` `yamlls` `taplo` `marksman` `hadolint` `shellcheck`" },
    },
  },
}

-----------------------------------------------------------------------
-- Build markdown string for PDEHelp
-----------------------------------------------------------------------
local function build_markdown()
  local lines = {
    "# PDE Help",
    "",
    "> Press `q` or `<Esc>` to close.  `j` / `k` to scroll.",
    "",
  }
  for _, sec in ipairs(SECTIONS) do
    table.insert(lines, "## " .. sec.title)
    table.insert(lines, "")
    table.insert(lines, "| Key | Action |")
    table.insert(lines, "|-----|--------|")
    for _, row in ipairs(sec.rows) do
      table.insert(lines, string.format("| %s | %s |", row[1], row[2]))
    end
    table.insert(lines, "")
  end
  return lines
end

-----------------------------------------------------------------------
-- Shared: open lines in a styled floating window
-----------------------------------------------------------------------
local function open_float(lines, title, opts)
  opts = opts or {}
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden  = "wipe"
  vim.bo[buf].filetype   = "markdown"

  local width  = math.min(opts.width  or 96,  math.floor(vim.o.columns * 0.92))
  local height = math.min(opts.height or #lines + 2, math.floor(vim.o.lines * 0.88))
  local row    = math.floor((vim.o.lines    - height) / 2)
  local col    = math.floor((vim.o.columns  - width)  / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative    = "editor",
    width       = width,
    height      = height,
    row         = row,
    col         = col,
    style       = "minimal",
    border      = "rounded",
    title       = " " .. title .. " ",
    title_pos   = "center",
  })

  vim.wo[win].wrap           = opts.wrap ~= false
  vim.wo[win].cursorline     = true
  vim.wo[win].number         = false
  vim.wo[win].relativenumber = false
  vim.wo[win].conceallevel   = 3
  vim.wo[win].concealcursor  = "n"
  vim.wo[win].foldlevel      = 99

  local close = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.keymap.set("n", "q",     close, { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })
end

-----------------------------------------------------------------------
-- PDEHelp
-----------------------------------------------------------------------
function M.open()
  open_float(build_markdown(), "PDE Help", { width = 96 })
end

vim.api.nvim_create_user_command("PDEHelp", M.open, { desc = "Open PDE help reference" })
vim.keymap.set("n", "<leader>?", M.open, { desc = "Open PDE help" })

-----------------------------------------------------------------------
-- GitHelp
-----------------------------------------------------------------------
function M.git_help()
  local guide = vim.fn.stdpath("config") .. "/GIT_GUIDE.md"
  local lines = vim.fn.filereadable(guide) == 1
    and vim.fn.readfile(guide)
    or { "# Error", "", "`GIT_GUIDE.md` not found at:", "", "    " .. guide }

  open_float(lines, "Git & GitHub Guide", { width = 100 })
end

vim.api.nvim_create_user_command("GitHelp", M.git_help, { desc = "Open Git & GitHub guide" })
vim.keymap.set("n", "<leader>gH", M.git_help, { desc = "Open Git & GitHub guide" })

return M
