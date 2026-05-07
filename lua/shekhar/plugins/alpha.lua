return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")

    -----------------------------------------------------------------------
    -- Highlight groups (tokyonight-compatible gradient)
    -----------------------------------------------------------------------
    local function set_highlights()
      vim.api.nvim_set_hl(0, "AlphaHeader1",  { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "AlphaHeader2",  { fg = "#7dcfff", bold = true })
      vim.api.nvim_set_hl(0, "AlphaHeader3",  { fg = "#2ac3de", bold = true })
      vim.api.nvim_set_hl(0, "AlphaHeader4",  { fg = "#bb9af7", bold = true })
      vim.api.nvim_set_hl(0, "AlphaHeader5",  { fg = "#9d7cd8", bold = true })
      vim.api.nvim_set_hl(0, "AlphaHeader6",  { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "AlphaTagline",  { fg = "#565f89", italic = true })
      vim.api.nvim_set_hl(0, "AlphaButton",   { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "AlphaButtonKey",{ fg = "#e0af68", bold = true })
      vim.api.nvim_set_hl(0, "AlphaSeparator",{ fg = "#24283b" })
      vim.api.nvim_set_hl(0, "AlphaFooter",   { fg = "#414868", italic = true })
      vim.api.nvim_set_hl(0, "AlphaVersion",  { fg = "#3d59a1", italic = true })
      vim.api.nvim_set_hl(0, "AlphaSectionHl",{ fg = "#565f89" })
      vim.api.nvim_set_hl(0, "AlphaStacks",   { fg = "#1abc9c", bold = false })
    end
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

    -----------------------------------------------------------------------
    -- Header — each line has its own hl for a gradient sweep
    -----------------------------------------------------------------------
    local header_lines = {
      { [[  ███╗   ███╗███████╗ ██████╗  █████╗ ██╗   ██╗██╗███╗   ███╗  ]], "AlphaHeader1" },
      { [[  ████╗ ████║██╔════╝██╔════╝ ██╔══██╗██║   ██║██║████╗ ████║  ]], "AlphaHeader2" },
      { [[  ██╔████╔██║█████╗  ██║  ███╗███████║██║   ██║██║██╔████╔██║  ]], "AlphaHeader3" },
      { [[  ██║╚██╔╝██║██╔══╝  ██║   ██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║  ]], "AlphaHeader4" },
      { [[  ██║ ╚═╝ ██║███████╗╚██████╔╝██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║  ]], "AlphaHeader5" },
      { [[  ╚═╝     ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ]], "AlphaHeader6" },
    }

    local header_text = {}
    local header_hl   = {}
    for _, line in ipairs(header_lines) do
      table.insert(header_text, line[1])
      table.insert(header_hl, { { line[2], 0, -1 } })
    end

    local header_section = {
      type = "text",
      val = header_text,
      opts = {
        hl = header_hl,
        shrink_margin = false,
        position = "center",
      },
    }

    -----------------------------------------------------------------------
    -- Tagline
    -----------------------------------------------------------------------
    local tagline = {
      type = "text",
      val = "  personal development environment  ·  craft · ship · repeat  ",
      opts = { hl = "AlphaTagline", position = "center" },
    }

    -----------------------------------------------------------------------
    -- Separator
    -----------------------------------------------------------------------
    local sep_char = "─"
    local function make_sep(width)
      return {
        type = "text",
        val = string.rep(sep_char, width or 58),
        opts = { hl = "AlphaSeparator", position = "center" },
      }
    end

    -----------------------------------------------------------------------
    -- Buttons
    -----------------------------------------------------------------------
    local function btn(key, icon, label, cmd)
      local b = {
        type = "button",
        val = string.format("  %s  %s", icon, label),
        on_press = function() vim.cmd(cmd) end,
        opts = {
          position = "center",
          shortcut = "  " .. key,
          cursor = 4,
          width = 52,
          align_shortcut = "right",
          hl = "AlphaButton",
          hl_shortcut = "AlphaButtonKey",
          keymap = { "n", key, "<cmd>" .. cmd .. "<CR>", { noremap = true, silent = true } },
        },
      }
      return b
    end

    local buttons = {
      type = "group",
      val = {
        btn("e",       "",  "New File",                    "ene"),
        btn("<Space>ff","󰱼", "Find File",                  "Telescope find_files"),
        btn("<Space>fr","󰙰", "Recent Files",               "Telescope oldfiles"),
        btn("<Space>fs","󰍉", "Live Grep",                  "Telescope live_grep"),
        btn("<Space>ee","󰙅", "File Explorer",              "NvimTreeToggle"),
        btn("<Space>wr","󰁯", "Restore Session",            "SessionRestore"),
        btn("<Space>?",  "󰋖", "PDE Help  (keymaps & more)", "PDEHelp"),
        btn("<Space>gH", "󰊢", "Git & GitHub Guide",        "GitHelp"),
        btn("q",        "󰈆", "Quit",                      "qa"),
      },
      opts = { spacing = 1 },
    }

    -----------------------------------------------------------------------
    -- Stats footer (plugins loaded + neovim version)
    -----------------------------------------------------------------------
    local function footer_val()
      local stats = require("lazy").stats()
      local loaded = stats.loaded or 0
      local total  = stats.count  or 0
      local ver    = vim.version()
      local ver_str = string.format("v%d.%d.%d", ver.major, ver.minor, ver.patch)
      local date   = os.date("%a %d %b %Y")
      return string.format(
        " neovim %s  ·  󰒲 %d/%d plugins  ·   %s ",
        ver_str, loaded, total, date
      )
    end

    local footer_section = {
      type = "text",
      val = footer_val,
      opts = { hl = "AlphaFooter", position = "center" },
    }

    -----------------------------------------------------------------------
    -- Stacks label
    -----------------------------------------------------------------------
    local stacks = {
      type = "text",
      val = "  Web · Rust · C++ · Solidity · Solana · Python · AI  ",
      opts = { hl = "AlphaStacks", position = "center" },
    }

    -----------------------------------------------------------------------
    -- Layout
    -----------------------------------------------------------------------
    local layout = {
      { type = "padding", val = 3 },
      header_section,
      { type = "padding", val = 1 },
      tagline,
      { type = "padding", val = 1 },
      make_sep(58),
      { type = "padding", val = 1 },
      buttons,
      { type = "padding", val = 1 },
      make_sep(58),
      { type = "padding", val = 1 },
      stacks,
      { type = "padding", val = 1 },
      footer_section,
      { type = "padding", val = 1 },
    }

    alpha.setup({ layout = layout, opts = { margin = 5 } })

    -- Disable folding on the dashboard buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.foldenable = false
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statusline = " "
      end,
    })
  end,
}
