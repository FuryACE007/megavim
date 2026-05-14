return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    local map = function(lhs, fn, desc)
      return { lhs, fn, desc = desc, mode = "n" }
    end
    return {
      map("<leader>Ha", function() harpoon:list():add() end,          "Harpoon: add file"),
      map("<leader>Hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Harpoon: toggle menu"),
      map("<leader>H1", function() harpoon:list():select(1) end,      "Harpoon: jump 1"),
      map("<leader>H2", function() harpoon:list():select(2) end,      "Harpoon: jump 2"),
      map("<leader>H3", function() harpoon:list():select(3) end,      "Harpoon: jump 3"),
      map("<leader>H4", function() harpoon:list():select(4) end,      "Harpoon: jump 4"),
      map("<leader>Hn", function() harpoon:list():next() end,         "Harpoon: next"),
      map("<leader>Hp", function() harpoon:list():prev() end,         "Harpoon: prev"),
      map("<leader>Hc", function() harpoon:list():clear() end,        "Harpoon: clear list"),
    }
  end,
  config = function()
    require("harpoon"):setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })
  end,
}
