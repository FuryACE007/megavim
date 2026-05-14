return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "*",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({
          paths = vim.fn.stdpath("config") .. "/lua/shekhar/snippets",
        })
      end,
    },
    {
      "fang2hou/blink-copilot",
      dependencies = { "zbirenbaum/copilot.lua" },
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },
    snippets = { preset = "luasnip" },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
      kind_icons = {
        Copilot     = "",
        Text        = "󰉿",
        Method      = "󰊕",
        Function    = "󰊕",
        Constructor = "󰒓",
        Field       = "󰜢",
        Variable    = "󰆦",
        Property    = "󰖷",
        Class       = "󱡠",
        Interface   = "󱡠",
        Struct      = "󱡠",
        Module      = "󰅩",
        Unit        = "󰪚",
        Value       = "󰦨",
        Enum        = "󰦨",
        EnumMember  = "󰦨",
        Keyword     = "󰻾",
        Constant    = "󰏿",
        Snippet     = "󱄽",
        Color       = "󰏘",
        File        = "󰈔",
        Reference   = "󰬲",
        Folder      = "󰉋",
        Event       = "󱐋",
        Operator    = "󰪚",
        TypeParameter = "󰬛",
      },
    },
    completion = {
      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "kind" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded" },
      },
      ghost_text = { enabled = false },
      list = { selection = { preselect = false, auto_insert = false } },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    sources = {
      default = { "copilot", "lsp", "snippets", "buffer", "path" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        lsp     = { score_offset = 90 },
        snippets = { score_offset = 80 },
        buffer  = { score_offset = 70 },
        path    = { score_offset = 60 },
      },
    },
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = { menu = { auto_show = true } },
    },
  },
  opts_extend = { "sources.default" },
}
