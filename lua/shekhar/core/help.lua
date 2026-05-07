-- Floating help reference for the PDE.
-- Open via :PDEHelp or <leader>?

local M = {}

local SECTIONS = {
  {
    title = "GENERAL",
    rows = {
      { "<leader>",      "Space (leader key)" },
      { "jk",            "Exit insert mode" },
      { "<C-s>",         "Save file" },
      { "<leader>nh",    "Clear search highlight" },
      { "<leader>qq",    "Quit all" },
      { "<leader>qw",    "Save all + quit" },
      { "<leader>?",     "Open this help" },
    },
  },
  {
    title = "FILE EXPLORER (nvim-tree)",
    rows = {
      { "<leader>ee",    "Toggle file explorer" },
      { "<leader>ef",    "Reveal current file in explorer" },
      { "<leader>ec",    "Collapse explorer" },
      { "<leader>er",    "Refresh explorer" },
    },
  },
  {
    title = "FUZZY FIND (telescope)",
    rows = {
      { "<leader>ff",    "Find files" },
      { "<leader>fr",    "Recent files" },
      { "<leader>fs",    "Live grep (project)" },
      { "<leader>fc",    "Grep word under cursor" },
      { "<leader>ft",    "Find todo comments" },
    },
  },
  {
    title = "BUFFERS (VSCode-like tabs)",
    rows = {
      { "<Tab> / <S-Tab>", "Next / prev buffer" },
      { "<S-l> / <S-h>", "Next / prev buffer (preserves <C-i>)" },
      { "<leader>1..9",  "Jump to buffer N" },
      { "<leader>bd",    "Close buffer" },
      { "<leader>bD",    "Close other buffers" },
      { "<leader>bP",    "Pin/unpin buffer" },
      { "<leader>bb",    "Pick buffer (label)" },
      { "<leader>bh/bl", "Close buffers left/right" },
    },
  },
  {
    title = "WINDOW SPLITS",
    rows = {
      { "<leader>sv",    "Vertical split" },
      { "<leader>sh",    "Horizontal split" },
      { "<leader>se",    "Equalize splits" },
      { "<leader>sx",    "Close split" },
      { "<leader>so",    "Close other splits" },
      { "<leader>sm",    "Maximize/restore split" },
      { "<C-h/j/k/l>",   "Navigate splits (tmux-aware)" },
      { "<C-arrow>",     "Resize split" },
      { "<leader>sH/J/K/L", "Swap buffer with neighbor" },
    },
  },
  {
    title = "TABS",
    rows = {
      { "<leader>to",    "New tab" },
      { "<leader>tx",    "Close tab" },
      { "<leader>tn/tp", "Next / prev tab" },
      { "<leader>tf",    "Move buffer to new tab" },
    },
  },
  {
    title = "LSP",
    rows = {
      { "gd / gD",       "Go to definition / declaration" },
      { "gi",            "Go to implementation" },
      { "gt",            "Go to type definition" },
      { "gR",            "Show references (telescope)" },
      { "K",             "Hover docs" },
      { "<C-k>",         "Signature help" },
      { "<leader>ca",    "Code action" },
      { "<leader>rn",    "Rename" },
      { "<leader>d",     "Line diagnostics float" },
      { "<leader>D",     "Buffer diagnostics" },
      { "[d / ]d",       "Prev / next diagnostic" },
      { "[r / ]r",       "Prev / next reference (illuminate)" },
      { "<leader>rs",    "Restart LSP" },
    },
  },
  {
    title = "COMPLETION (cmp + Copilot)",
    rows = {
      { "<Tab>",         "Next item / expand snippet" },
      { "<S-Tab>",       "Prev item / jump back snippet" },
      { "<C-n>/<C-p>",   "Next / prev item" },
      { "<C-Space>",     "Trigger completion" },
      { "<C-b>/<C-f>",   "Scroll docs" },
      { "<CR>",          "Confirm" },
      { "<C-e>",         "Abort" },
      { ":Copilot status", "Check Copilot auth" },
    },
  },
  {
    title = "FORMAT / LINT",
    rows = {
      { "<leader>mp",    "Format buffer/range" },
      { "<leader>l",     "Trigger lint" },
      { ":FormatDisable",  "Disable autoformat (global)" },
      { ":FormatDisable!", "Disable autoformat (buffer)" },
      { ":FormatEnable",   "Re-enable autoformat" },
    },
  },
  {
    title = "DIAGNOSTICS / TROUBLE",
    rows = {
      { "<leader>xw",    "Workspace diagnostics" },
      { "<leader>xd",    "Document diagnostics" },
      { "<leader>xq",    "Quickfix" },
      { "<leader>xl",    "Location list" },
      { "<leader>xt",    "Todos" },
    },
  },
  {
    title = "GIT (gitsigns + lazygit)",
    rows = {
      { "<leader>lg",    "Open LazyGit" },
      { "]h / [h",       "Next / prev hunk" },
      { "<leader>hs",    "Stage hunk" },
      { "<leader>hr",    "Reset hunk" },
      { "<leader>hp",    "Preview hunk" },
      { "<leader>hb",    "Blame line (full)" },
      { "<leader>hB",    "Toggle line blame" },
      { "<leader>hd",    "Diff this" },
    },
  },
  {
    title = "TERMINAL",
    rows = {
      { "<C-\\>",        "Toggle terminal" },
      { "<leader>tt",    "Toggle terminal" },
      { "<esc> / jk",    "Leave terminal mode" },
    },
  },
  {
    title = "C++ DSA",
    rows = {
      { "F4",            "Compile only" },
      { "F5",            "Compile + run" },
      { "F6",            "Run with <name>_input.txt" },
      { "<leader>ci",    "Open input file" },
      { "<leader>co",    "Open output file" },
      { "<leader>cr",    "CompetiTest run" },
      { "<leader>ca",    "CompetiTest add testcase" },
      { "<leader>cra",   "CompetiTest run all" },
      { "dsa<Tab>",      "Insert DSA template" },
    },
  },
  {
    title = "RUST",
    rows = {
      { "<C-space>",     "Hover actions (rust-tools)" },
      { "<leader>ca",    "Code action group" },
      { "<leader>cr",    "Run cargo run (terminal)" },
    },
  },
  {
    title = "DEBUG (nvim-dap)",
    rows = {
      { "<leader>db",    "Toggle breakpoint" },
      { "<leader>dc",    "Continue" },
      { "<leader>di",    "Step into" },
      { "<leader>do",    "Step over" },
      { "<leader>dO",    "Step out" },
      { "<leader>dr",    "Toggle REPL" },
      { "<leader>dl",    "Run last" },
      { "<leader>dx",    "Terminate" },
      { "<leader>du",    "Toggle debug UI" },
    },
  },
  {
    title = "MOTION / EDIT",
    rows = {
      { "<leader>j",     "Flash jump" },
      { "<leader>J",     "Flash treesitter" },
      { "s{motion}",     "Substitute (substitute.nvim)" },
      { "ss / S",        "Substitute line / to EOL" },
      { "ys/ds/cs",      "Surround add/delete/change" },
      { "gcc / gc",      "Toggle line comment / visual" },
      { "]t / [t",       "Next / prev TODO comment" },
      { "zR / zM",       "Open / close all folds" },
      { "zp",            "Peek folded lines" },
    },
  },
  {
    title = "SESSIONS",
    rows = {
      { "<leader>ws",    "Save session" },
      { "<leader>wr",    "Restore session" },
    },
  },
  {
    title = "LANGUAGES SUPPORTED",
    rows = {
      { "Web/MERN",  "ts_ls, eslint, html, cssls, tailwindcss, emmet, jsonls, prismals" },
      { "Python/AI", "pyright, ruff, black, isort" },
      { "C/C++",     "clangd, clang-format, F4/F5/F6 workflow" },
      { "Rust",      "rust_analyzer (rust-tools), rustfmt, clippy" },
      { "Solidity",  "solidity_ls_nomicfoundation, solhint, prettier" },
      { "Solana",    "rust_analyzer + taplo (Anchor.toml)" },
      { "DevOps",    "dockerls, yamlls, taplo, marksman" },
    },
  },
}

local function build_lines()
  local lines = {
    "  PDE Help — keymaps & features (q to close, j/k to scroll)",
    "",
  }
  for _, sec in ipairs(SECTIONS) do
    table.insert(lines, "▌ " .. sec.title)
    table.insert(lines, "")
    for _, row in ipairs(sec.rows) do
      table.insert(lines, string.format("  %-22s  %s", row[1], row[2]))
    end
    table.insert(lines, "")
  end
  return lines
end

function M.open()
  local lines = build_lines()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "pdehelp"

  local width = math.min(90, math.floor(vim.o.columns * 0.85))
  local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.85))
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " PDE Help ",
    title_pos = "center",
  })

  vim.wo[win].wrap = false
  vim.wo[win].cursorline = true
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false

  local close = function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end
  vim.keymap.set("n", "q", close, { buffer = buf, silent = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })
end

vim.api.nvim_create_user_command("PDEHelp", M.open, { desc = "Open PDE help reference" })
vim.keymap.set("n", "<leader>?", M.open, { desc = "Open PDE help" })

return M
