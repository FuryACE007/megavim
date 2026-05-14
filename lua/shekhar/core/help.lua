-- In-editor help system.  :PDEHelp / <leader>?   and   :GitHelp / <leader>gH
-- Both open floating windows with filetype=markdown so render-markdown.nvim
-- renders headings, tables, code spans, and separators automatically.

local M = {}

-----------------------------------------------------------------------
-- "When to use which tool" — context guide shown first
-----------------------------------------------------------------------
local TOOL_GUIDE = {
  "# When to Use Which Tool",
  "",
  "> Press `q` or `<Esc>` to close.  `j` / `k` to scroll.",
  "",
  "## Navigation",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Jump anywhere on screen in 2–3 keystrokes | `<leader>j` — Flash jump |",
  "| Select a syntax node (function, block…) | `<leader>J` — Flash treesitter |",
  "| Open any file by name / fuzzy | `<leader>ff` — Telescope |",
  "| Re-open a file you had open before | `<leader>fr` — Telescope recent |",
  "| Pin 3–4 files you're actively editing | `<leader>Ha` — Harpoon add, `<leader>Hh` — menu |",
  "| Find a symbol (function, type) anywhere | `<leader>fs` + symbol name — Telescope live grep |",
  "| See all symbols in the current file | `<leader>o` — Aerial outline |",
  "",
  "## Editing",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Toggle comment on line / selection | `gcc` / `gc` — Comment.nvim |",
  "| Wrap text in quotes / parens / tags | `ys{motion}{char}` — nvim-surround |",
  "| Change surrounding delimiter | `cs{old}{new}` — nvim-surround |",
  "| Move a line or block up / down | `<A-j>` / `<A-k>` — mini.move |",
  "| Select inner function / class / block | `vif` / `vic` / `vio` — mini.ai text objects |",
  "| Smart increment (bool, hex, semver, date) | `<C-a>` / `<C-x>` — dial.nvim |",
  "",
  "## Search & Replace",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Search for text across the project (read-only) | `<leader>fs` — Telescope live grep |",
  "| Replace text across multiple files | `<leader>sr` — grug-far (opens panel; edit & save) |",
  "| Replace word under cursor in whole project | `<leader>sw` — grug-far prefilled |",
  "| Rename a symbol (code-aware) | `<leader>rn` — LSP rename |",
  "",
  "## Git",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Stage, commit, push, manage branches | `<leader>lg` — LazyGit (full TUI) |",
  "| Stage/discard just a few lines (hunk) | `<leader>hs` / `<leader>hr` — gitsigns |",
  "| Blame this line, see who changed it | `<leader>hb` — gitsigns blame popup |",
  "| See a diff of the whole working tree | `<leader>gd` — diffview |",
  "| See history for one file | `<leader>gf` — diffview file history |",
  "| Review / create / merge a GitHub PR | `<leader>op` / `oc` / `om` — Octo |",
  "| Copy a GitHub permalink for a line | `<leader>gy` — gitlinker |",
  "",
  "## Diagnostics & Errors",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Hover over an error / see details | `K` — LSP hover; `<leader>d` — float |",
  "| Browse all errors in the file | `<leader>xd` — Trouble document diagnostics |",
  "| Browse all errors in the workspace | `<leader>xw` — Trouble workspace diagnostics |",
  "| Go to next / prev error | `]d` / `[d` |",
  "",
  "## AI & Completion",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Inline code suggestion while typing | Copilot — automatic via blink.cmp |",
  "| Accept Copilot suggestion | `<Tab>` in completion menu |",
  "| AI chat / code generation | Open `claude` in a separate terminal |",
  "",
  "## Debugging",
  "",
  "| Situation | Tool |",
  "|-----------|------|",
  "| Set / clear a breakpoint | `<leader>db` — DAP |",
  "| Start / continue | `<leader>dc` |",
  "| Step into / over / out | `<leader>di` / `do` / `dO` |",
  "| Open debug UI | `<leader>du` |",
  "",
}

-----------------------------------------------------------------------
-- Keymap reference — each section becomes a markdown ## heading + table
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
      { "`[[` / `]]`",           "Prev / next reference under cursor (snacks.words)" },
      { "`<leader>rs`",          "Restart LSP" },
    },
  },
  {
    title = "Completion (blink.cmp + Copilot)",
    rows = {
      { "`<Tab>`",               "Accept / next item / expand snippet (super-tab)" },
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
    title = "Harpoon — quick file pinning",
    rows = {
      { "`<leader>Ha`",          "Add current file" },
      { "`<leader>Hh`",          "Toggle quick menu" },
      { "`<leader>H1` .. `H4`",  "Jump to pinned file N" },
      { "`<leader>Hn` / `Hp`",   "Next / prev in list" },
      { "`<leader>Hc`",          "Clear list" },
    },
  },
  {
    title = "Symbol Outline (aerial)",
    rows = {
      { "`<leader>o`",           "Toggle outline panel" },
      { "`{` / `}`",             "Prev / next symbol (inside aerial buffer)" },
    },
  },
  {
    title = "Project Search & Replace (grug-far)",
    rows = {
      { "`<leader>sr`",          "Open project search panel" },
      { "`<leader>sw`",          "Search word under cursor" },
      { "`<leader>r`",           "Apply replace (inside grug-far buffer)" },
      { "`<leader>q`",           "Send results to quickfix (inside grug-far buffer)" },
    },
  },
  {
    title = "Undo Tree",
    rows = {
      { "`<leader>U`",           "Toggle visual undo tree" },
    },
  },
  {
    title = "Smart Increment / Decrement (dial.nvim)",
    rows = {
      { "`<C-a>` / `<C-x>`",     "Increment / decrement — numbers, booleans, dates, hex colors, semver" },
      { "`g<C-a>` / `g<C-x>`",   "Cascading on visual selection" },
    },
  },
  {
    title = "Move Lines / Blocks (mini.move)",
    rows = {
      { "`<A-j>` / `<A-k>`",     "Move line / block down / up" },
      { "`<A-h>` / `<A-l>`",     "Move line / block left / right" },
    },
  },
  {
    title = "UI Toggles (snacks)",
    rows = {
      { "`<leader>uw`",          "Toggle line wrap" },
      { "`<leader>uL`",          "Toggle relative line numbers" },
      { "`<leader>ud`",          "Toggle diagnostics" },
      { "`<leader>ub`",          "Toggle dark / light background" },
      { "`<leader>un`",          "Dismiss all notifications" },
      { "`<leader>uN`",          "Show notification history" },
      { "`<leader>.`",           "Toggle scratch buffer" },
    },
  },
  {
    title = "Motion and Editing",
    rows = {
      { "`<leader>j`",           "Flash jump — hop anywhere on screen in 2–3 keystrokes" },
      { "`<leader>J`",           "Flash treesitter — select a syntax node visually" },
      { "`ys` / `ds` / `cs`",    "Surround: add / delete / change" },
      { "`vif` / `vic` / `vio`", "mini.ai: select inner function / class / block" },
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
-- Build markdown string for PDEHelp (tool guide + keymap reference)
-----------------------------------------------------------------------
local function build_markdown()
  local lines = vim.list_extend({}, TOOL_GUIDE)

  table.insert(lines, "")
  table.insert(lines, "---")
  table.insert(lines, "")
  table.insert(lines, "# Keymap Reference")
  table.insert(lines, "")

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
  open_float(build_markdown(), "PDE Help", { width = 100 })
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
