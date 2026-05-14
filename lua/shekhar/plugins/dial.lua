return {
  "monaqa/dial.nvim",
  keys = {
    { "<C-a>",  function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
    { "<C-x>",  function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    { "<C-a>",  function() return require("dial.map").inc_visual() end, expr = true, mode = "v", desc = "Increment selection" },
    { "<C-x>",  function() return require("dial.map").dec_visual() end, expr = true, mode = "v", desc = "Decrement selection" },
    { "g<C-a>", function() return require("dial.map").inc_gvisual() end, expr = true, mode = "v", desc = "Increment cascading" },
    { "g<C-x>", function() return require("dial.map").dec_gvisual() end, expr = true, mode = "v", desc = "Decrement cascading" },
  },
  config = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.integer.alias.binary,
        augend.constant.alias.bool,
        augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
        augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
        augend.constant.new({ elements = { "let", "const" }, word = true, cyclic = true }),
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%H:%M"],
        augend.semver.alias.semver,
        augend.hexcolor.new({ case = "lower" }),
      },
    })
  end,
}
