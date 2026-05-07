return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers",
      themable = true,
      numbers = "ordinal",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        local icons = { error = " ", warning = " ", info = " ", hint = "󰠠 " }
        local ret = (diag.error and icons.error .. diag.error .. " " or "")
          .. (diag.warning and icons.warning .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "thin",
      always_show_bufferline = true,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    local keymap = vim.keymap
    -- VSCode-like tab cycling. Note: <Tab> and <C-i> are the same byte in many
    -- terminals, so binding <Tab> can shadow the jumplist-forward motion.
    -- Use <S-l>/<S-h> as an alternative that preserves <C-i>.
    keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
    keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
    keymap.set("n", "<leader>bD", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })
    keymap.set("n", "<leader>bP", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin buffer" })
    keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close buffers to the right" })
    keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close buffers to the left" })
    keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

    -- VSCode-like Ctrl+number jumps via leader
    for i = 1, 9 do
      keymap.set("n", "<leader>" .. i, function()
        require("bufferline").go_to(i, true)
      end, { desc = "Go to buffer " .. i })
    end
  end,
}
