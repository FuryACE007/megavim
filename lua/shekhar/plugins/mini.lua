-- mini.nvim — only the modules that don't collide with existing plugins.
-- Skipped: mini.surround (using nvim-surround), mini.pairs (using nvim-autopairs),
-- mini.comment (using Comment.nvim), mini.indentscope (using snacks.indent).
return {
  {
    "echasnovski/mini.ai",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      })
    end,
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<A-h>", mode = { "n", "v" } },
      { "<A-j>", mode = { "n", "v" } },
      { "<A-k>", mode = { "n", "v" } },
      { "<A-l>", mode = { "n", "v" } },
    },
    opts = {
      mappings = {
        left = "<A-h>", right = "<A-l>", down = "<A-j>", up = "<A-k>",
        line_left = "<A-h>", line_right = "<A-l>", line_down = "<A-j>", line_up = "<A-k>",
      },
    },
  },
}
