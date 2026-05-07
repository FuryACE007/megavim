return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "LazyGit", "LazyGitConfig", "LazyGitCurrentFile",
    "LazyGitFilter", "LazyGitFilterCurrentFile",
  },
  keys = {
    { "<leader>lg",  "<cmd>LazyGit<CR>",                  desc = "LazyGit" },
    { "<leader>lf",  "<cmd>LazyGitCurrentFile<CR>",        desc = "LazyGit (current file)" },
    { "<leader>ll",  "<cmd>LazyGitFilter<CR>",             desc = "LazyGit log (project)" },
    { "<leader>lL",  "<cmd>LazyGitFilterCurrentFile<CR>",  desc = "LazyGit log (current file)" },
  },
  init = function()
    vim.g.lazygit_floating_window_winblend = 0
    vim.g.lazygit_floating_window_scaling_factor = 0.92
    vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
    vim.g.lazygit_floating_window_use_plenary = 1
    vim.g.lazygit_use_neovim_remote = 1
  end,
}
