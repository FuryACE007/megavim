return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { "<leader>b", group = "Buffers" },
      { "<leader>c", group = "Code / Conflict / C++" },
      { "<leader>d", group = "Debug / Diagnostics" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunks (gitsigns)" },
      { "<leader>H", group = "Harpoon", icon = "󱡅" },
      { "<leader>l", group = "LazyGit" },
      { "<leader>o", group = "Octo (GitHub)" },
      { "<leader>r", group = "Rename / LSP" },
      { "<leader>s", group = "Splits / Search" },
      { "<leader>t", group = "Tabs / Terminal" },
      { "<leader>u", group = "UI Toggles" },
      { "<leader>w", group = "Workspace / Session" },
      { "<leader>x", group = "Diagnostics (Trouble)" },
    },
  },
}
