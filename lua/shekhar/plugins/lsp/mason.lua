return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

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
      ensure_installed = {
        -- Systems / DSA
        "clangd",
        "rust_analyzer",
        -- Config / scripting
        "lua_ls",
        "bashls",
        -- Web / MERN
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "emmet_language_server",
        "jsonls",
        "eslint",
        "prismals",
        -- Python / AI
        "pyright",
        "ruff",
        -- Blockchain
        "solidity_ls_nomicfoundation",
        -- DevOps / data
        "taplo",
        "yamlls",
        "dockerls",
        "marksman",
      },
      automatic_installation = true,
    })

    mason_tool_installer.setup({
      ensure_installed = {
        -- Formatters
        "prettierd",
        "prettier",
        "stylua",
        "rustfmt",
        "clang-format",
        "shfmt",
        "sql-formatter",
        "black",
        -- isort removed: install via `pip install isort --user` or `brew install isort`
        -- Linters
        "eslint_d",
        "shellcheck",
        "hadolint",
        "markdownlint",
        "solhint",
        -- Debug adapters
        "codelldb",
        "js-debug-adapter",
        "debugpy",
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}
