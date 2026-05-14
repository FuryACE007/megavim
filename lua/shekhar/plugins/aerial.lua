return {
  "stevearc/aerial.nvim",
  cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
  keys = {
    { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle symbol outline (aerial)" },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
    layout = {
      default_direction = "right",
      min_width = 28,
      max_width = 40,
    },
    attach_mode = "global",
    show_guides = true,
    filter_kind = false,
    autojump = true,
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Prev symbol" })
      vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Next symbol" })
    end,
  },
}
