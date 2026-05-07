return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    require("ufo").setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })

    local keymap = vim.keymap
    keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds (kinds)" })
    keymap.set("n", "zp", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end, { desc = "Peek fold or hover" })
  end,
}
