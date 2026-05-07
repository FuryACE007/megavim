return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    enable = true,
    max_lines = 3,
    min_window_height = 20,
    multiline_threshold = 1,
    mode = "cursor",
    separator = nil,
  },
  keys = {
    { "<leader>uc", function() require("treesitter-context").toggle() end, desc = "Toggle treesitter context" },
  },
}
