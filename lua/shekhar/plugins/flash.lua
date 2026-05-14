return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = { enabled = false },
      char = { enabled = true, jump_labels = true },
    },
  },
  keys = {
    { "<leader>j", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
    { "<leader>J", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    { "<leader>jr", mode = "o", function() require("flash").remote() end, desc = "Remote flash" },
    { "<leader>jR", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter search" },
  },
}
