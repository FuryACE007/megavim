return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- Essential LSP servers for C++ DSA focus
      ensure_installed = {
        "clangd",        -- C++ LSP (PRIMARY for DSA problem solving)
        "lua_ls",        -- Lua LSP (for editing Neovim config)
        "bashls",        -- Bash LSP (for shell scripts)
        "rust_analyzer", -- Rust LSP (if you do Rust)
      },
      -- Optional: Add these back if you need them:
      -- "ts_ls", "html", "cssls", "eslint" (web dev)
      -- "gopls" (Go), "sqlls" (SQL)
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
        "rustfmt", -- rust formatter
        "codelldb",    -- For Rust debugging
        "js-debug-adapter",  -- For JavaScript/TypeScript debugging
        "clang-format", -- C++ formatter (for DSA)
        -- Python tools removed (not needed for C++ DSA focus):
        -- "isort", "black", "pylint"
      },
    })
  end,
}
