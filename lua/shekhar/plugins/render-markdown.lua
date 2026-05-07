return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "mdx", "gitcommit", "Avante" },
  opts = {
    enabled = true,
    render_modes = { "n", "c", "t" },
    max_file_size = 10.0,

    heading = {
      enabled = true,
      sign = true,
      position = "overlay",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      signs = { "󰫎 " },
      width = "full",
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = false,
      above = "▄",
      below = "▀",
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },

    code = {
      enabled = true,
      sign = false,
      style = "full",
      position = "left",
      language_pad = 1,
      disable_background = {},
      width = "full",
      left_pad = 1,
      right_pad = 1,
      min_width = 0,
      border = "thin",
      above = "▄",
      below = "▀",
      highlight = "RenderMarkdownCode",
      highlight_inline = "RenderMarkdownCodeInline",
      highlight_language = nil,
    },

    dash = {
      enabled = true,
      icon = "─",
      width = "full",
      highlight = "RenderMarkdownDash",
    },

    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      left_pad = 0,
      right_pad = 0,
      highlight = "RenderMarkdownBullet",
    },

    checkbox = {
      enabled = true,
      position = "inline",
      unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked", scope_highlight = nil },
      checked   = { icon = "󰱒 ", highlight = "RenderMarkdownChecked",   scope_highlight = nil },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
      },
    },

    quote = {
      enabled = true,
      icon = "▋",
      repeat_linebreak = false,
      highlight = "RenderMarkdownQuote",
    },

    pipe_table = {
      enabled = true,
      preset = "double",
      style = "full",
      cell = "padded",
      min_width = 0,
      border = {
        "┌", "┬", "┐",
        "├", "┼", "┤",
        "└", "┴", "┘",
        "│", "─",
      },
      head = "RenderMarkdownTableHead",
      row  = "RenderMarkdownTableRow",
      filler = "RenderMarkdownTableFill",
    },

    callout = {
      note    = { raw = "[!NOTE]",    rendered = "󰋽 Note",    highlight = "RenderMarkdownInfo"    },
      tip     = { raw = "[!TIP]",     rendered = "󰌶 Tip",     highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint"  },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn"    },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError"   },
    },

    link = {
      enabled = true,
      footnote = { superscript = true, prefix = "", suffix = "" },
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      custom = {},
    },

    sign = {
      enabled = false,
    },

    inject = {
      enabled = true,
    },

    overrides = {
      -- Apply to floating windows (help buffers) as well
      filetype = {
        gitcommit = {
          heading = { enabled = false },
          code = { enabled = false },
        },
      },
    },
  },
}
