-- Alternate colorschemes (tokyonight remains default — see colorscheme.lua).
-- Each is lazy + installed-but-not-loaded; switch via `:colorscheme <name>`.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        nvim_tree = true,
        treesitter = true,
        telescope = true,
        which_key = true,
        noice = true,
        notify = false,
        snacks = { enabled = true, indent_scope_color = "lavender" },
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      variant = "main",
      styles = { transparency = true },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {
      transparent = true,
      theme = "wave",
    },
  },
}
