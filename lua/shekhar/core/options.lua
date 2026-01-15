vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- C++ specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- color scheme
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true
opt.splitbelow = true
