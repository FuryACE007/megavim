-- nvim-notify has been replaced by snacks.notifier (see snacks.lua).
-- snacks.notifier hooks vim.notify, so noice automatically routes through it.
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = { enabled = true },
      signature = { enabled = true },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    routes = {
      -- Mute "no information available" hover errors
      {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      },
    },
  },
}
