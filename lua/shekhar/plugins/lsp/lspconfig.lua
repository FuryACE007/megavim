return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = "Signature help"
        keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    -- nvim-ufo: advertise folding range support
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
      virtual_text = { prefix = "●", spacing = 2 },
      severity_sort = true,
      float = { border = "rounded", source = "always" },
      update_in_insert = false,
    })

    -- C++ (DSA)
    local clangd_path = vim.fn.expand("~/.local/share/nvim/mason/bin/clangd")
    local clangd_cmd = vim.fn.executable(clangd_path) == 1 and clangd_path or "clangd"

    vim.lsp.config("clangd", {
      cmd = {
        clangd_cmd,
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--query-driver=/opt/homebrew/bin/g++-15,/opt/homebrew/bin/g++-14,/opt/homebrew/bin/g++-13,/usr/bin/g++",
      },
      capabilities = capabilities,
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        fallbackFlags = {
          "-std=c++17",
          "-I" .. vim.fn.expand("~/.local/include"),
        },
      },
    })

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
          workspace = { checkThirdParty = false },
        },
      },
    })

    -- Bash
    vim.lsp.config("bashls", { capabilities = capabilities })

    -- Rust (rust-tools handles main config; lspconfig still useful for non-cargo files)
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          cargo = { allFeatures = true, loadOutDirsFromCheck = true },
          procMacro = { enable = true },
          inlayHints = { enable = true },
        },
      },
    })

    -- TypeScript / JavaScript
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      init_options = {
        preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
    })

    -- ESLint
    vim.lsp.config("eslint", {
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })

    -- HTML / CSS / Tailwind / Emmet
    vim.lsp.config("html", { capabilities = capabilities, filetypes = { "html", "templ" } })
    vim.lsp.config("cssls", { capabilities = capabilities })
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
      filetypes = {
        "html", "css", "scss", "javascript", "javascriptreact",
        "typescript", "typescriptreact", "svelte", "vue", "astro",
      },
    })
    vim.lsp.config("emmet_language_server", {
      capabilities = capabilities,
      filetypes = {
        "css", "html", "javascriptreact", "less", "sass",
        "scss", "svelte", "vue", "typescriptreact",
      },
    })

    -- JSON
    vim.lsp.config("jsonls", {
      capabilities = capabilities,
      settings = {
        json = {
          validate = { enable = true },
        },
      },
    })

    -- Prisma (MERN DBs)
    vim.lsp.config("prismals", { capabilities = capabilities })

    -- Python
    vim.lsp.config("pyright", {
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })
    vim.lsp.config("ruff", {
      capabilities = capabilities,
      on_attach = function(client, _)
        -- Let pyright handle hover
        client.server_capabilities.hoverProvider = false
      end,
    })

    -- Solidity (Solana programs use Rust; this is for EVM chains)
    vim.lsp.config("solidity_ls_nomicfoundation", {
      capabilities = capabilities,
      filetypes = { "solidity" },
    })

    -- TOML (Cargo.toml, Anchor.toml, pyproject.toml)
    vim.lsp.config("taplo", { capabilities = capabilities })

    -- YAML
    vim.lsp.config("yamlls", {
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
        },
      },
    })

    -- Docker
    vim.lsp.config("dockerls", { capabilities = capabilities })

    -- Markdown
    vim.lsp.config("marksman", { capabilities = capabilities })

    -- Enable all
    local servers = {
      "clangd", "lua_ls", "bashls", "rust_analyzer",
      "ts_ls", "eslint", "html", "cssls", "tailwindcss",
      "emmet_language_server", "jsonls", "prismals",
      "pyright", "ruff", "solidity_ls_nomicfoundation",
      "taplo", "yamlls", "dockerls", "marksman",
    }
    for _, server in ipairs(servers) do
      vim.lsp.enable(server)
    end
  end,
}
