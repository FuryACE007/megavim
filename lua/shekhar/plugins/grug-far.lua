return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  keys = {
    { "<leader>sr", function() require("grug-far").open() end, mode = { "n", "v" }, desc = "Project search & replace (grug-far)" },
    { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "grug-far: word under cursor" },
  },
  opts = {
    headerMaxWidth = 80,
    keymaps = {
      replace = { n = "<leader>r" },
      qflist  = { n = "<leader>q" },
    },
  },
}
