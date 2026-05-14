return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeFocus" },
  keys = {
    { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Toggle undo tree" },
  },
  init = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_SplitWidth = 35
  end,
}
