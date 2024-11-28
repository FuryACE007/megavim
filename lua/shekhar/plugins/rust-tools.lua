return {
  "simrat39/rust-tools.nvim",
  ft = { "rust" },
  dependencies = "neovim/nvim-lspconfig",
  config = function()
    local rt = require("rust-tools")

    rt.setup({
      server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(_, bufnr)
          local keymap = vim.keymap

          -- Hover actions
          keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          keymap.set("n", "<leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
          -- Move cursor to the next error/warning
          keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
          -- Move cursor to the previous error/warning
          keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
            cargo = {
              allFeatures = true,
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      tools = {
        hover_actions = {
          auto_focus = true,
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
        },
      },
    })
  end,
} 