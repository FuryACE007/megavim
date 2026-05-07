return {
  "mrjones2014/smart-splits.nvim",
  event = "VeryLazy",
  config = function()
    require("smart-splits").setup({
      ignored_filetypes = { "nofile", "quickfix", "prompt" },
      ignored_buftypes = { "NvimTree" },
      default_amount = 3,
      at_edge = "wrap",
      multiplexer_integration = "tmux",
    })

    local ss = require("smart-splits")
    local keymap = vim.keymap

    -- Resize splits (overrides previous arrow-key resize for nicer behavior)
    keymap.set("n", "<C-Left>", ss.resize_left, { desc = "Resize split left" })
    keymap.set("n", "<C-Down>", ss.resize_down, { desc = "Resize split down" })
    keymap.set("n", "<C-Up>", ss.resize_up, { desc = "Resize split up" })
    keymap.set("n", "<C-Right>", ss.resize_right, { desc = "Resize split right" })

    -- Swap buffers between splits
    keymap.set("n", "<leader>sH", ss.swap_buf_left, { desc = "Swap buffer with left split" })
    keymap.set("n", "<leader>sJ", ss.swap_buf_down, { desc = "Swap buffer with bottom split" })
    keymap.set("n", "<leader>sK", ss.swap_buf_up, { desc = "Swap buffer with top split" })
    keymap.set("n", "<leader>sL", ss.swap_buf_right, { desc = "Swap buffer with right split" })
  end,
}
