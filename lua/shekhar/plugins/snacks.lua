return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true, notify = true, size = 1.5 * 1024 * 1024 },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    scroll = { enabled = true },
    indent = {
      enabled = true,
      animate = { enabled = true, duration = { step = 20, total = 200 } },
      scope = { enabled = true, animate = { enabled = true } },
    },
    words = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "compact",
      top_down = false,
    },
    toggle = { enabled = true, map = vim.keymap.set },

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "e", desc = "New File",          action = ":ene | startinsert" },
          { icon = "󰱼 ", key = "f", desc = "Find File",         action = ":Telescope find_files" },
          { icon = "󰙰 ", key = "r", desc = "Recent Files",      action = ":Telescope oldfiles" },
          { icon = "󰍉 ", key = "g", desc = "Live Grep",         action = ":Telescope live_grep" },
          { icon = "󰙅 ", key = "x", desc = "File Explorer",     action = ":NvimTreeToggle" },
          { icon = "󰁯 ", key = "s", desc = "Restore Session",   action = ":SessionRestore" },
          { icon = "󰋖 ", key = "?", desc = "PDE Help",          action = ":PDEHelp" },
          { icon = "󰊢 ", key = "H", desc = "Git & GitHub Guide", action = ":GitHelp" },
          { icon = " ", key = "L", desc = "Lazy",              action = ":Lazy",            enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit",              action = ":qa" },
        },
      },
      sections = {
        {
          text = {
            { "  ███╗   ███╗███████╗ ██████╗  █████╗ ██╗   ██╗██╗███╗   ███╗\n", hl = "MegavimRGB1" },
            { "  ████╗ ████║██╔════╝██╔════╝ ██╔══██╗██║   ██║██║████╗ ████║\n", hl = "MegavimRGB2" },
            { "  ██╔████╔██║█████╗  ██║  ███╗███████║██║   ██║██║██╔████╔██║\n", hl = "MegavimRGB3" },
            { "  ██║╚██╔╝██║██╔══╝  ██║   ██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║\n", hl = "MegavimRGB4" },
            { "  ██║ ╚═╝ ██║███████╗╚██████╔╝██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║\n", hl = "MegavimRGB5" },
            { "  ╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝", hl = "MegavimRGB6" },
          },
          align = "center",
          padding = 1,
        },
        { pane = 1, text = { { "  personal development environment  ·  craft · ship · repeat  ", hl = "SnacksDashboardSpecial" } }, align = "center", padding = 1 },
        { pane = 1, text = { { string.rep("─", 58), hl = "SnacksDashboardDir" } }, align = "center", padding = 1 },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 1, text = { { string.rep("─", 58), hl = "SnacksDashboardDir" } }, align = "center", padding = 1 },
        { pane = 1, text = { { "  Web · Rust · C++ · Solidity · Solana · Python  ", hl = "SnacksDashboardKey" } }, align = "center", padding = 1 },
        function()
          local stats = require("lazy").stats()
          local ver = vim.version()
          return {
            align = "center",
            text = {
              {
                string.format(
                  " neovim v%d.%d.%d  ·  󰒲 %d/%d plugins  ·   %s ",
                  ver.major, ver.minor, ver.patch,
                  stats.loaded or 0, stats.count or 0,
                  os.date("%a %d %b %Y")
                ),
                hl = "SnacksDashboardFooter",
              },
            },
          }
        end,
      },
    },

    image = { enabled = true },
  },
  config = function(_, opts)
    local rgb = {
      MegavimRGB1 = "#FF6B6B",
      MegavimRGB2 = "#FF9F43",
      MegavimRGB3 = "#FECA57",
      MegavimRGB4 = "#48DBFB",
      MegavimRGB5 = "#54A0FF",
      MegavimRGB6 = "#C44DFF",
    }
    local function set_rgb_hls()
      for name, color in pairs(rgb) do
        vim.api.nvim_set_hl(0, name, { fg = color })
      end
    end
    set_rgb_hls()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_rgb_hls })
    require("snacks").setup(opts)
  end,
  keys = {
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss all notifications" },
    { "<leader>uN", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
    { "<leader>uw", function() Snacks.toggle.option("wrap"):toggle() end, desc = "Toggle wrap" },
    { "<leader>uL", function() Snacks.toggle.option("relativenumber"):toggle() end, desc = "Toggle relative number" },
    { "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle diagnostics" },
    { "<leader>ub", function() Snacks.toggle.option("background", { off = "light", on = "dark" }):toggle() end, desc = "Toggle dark background" },
  },
}
