return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      providers = { "lsp", "treesitter", "regex" },
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        "alpha", "NvimTree", "Trouble", "lazy", "mason",
        "noice", "notify", "toggleterm", "lazyterm",
      },
      under_cursor = true,
      large_file_cutoff = 2000,
      min_count_to_highlight = 1,
    })
    vim.keymap.set("n", "]r", function() require("illuminate").goto_next_reference(false) end,
      { desc = "Next reference" })
    vim.keymap.set("n", "[r", function() require("illuminate").goto_prev_reference(false) end,
      { desc = "Prev reference" })
  end,
}
