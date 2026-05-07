return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    local function has_eslint_config()
      local eslint_files = {
        ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml",
        ".eslintrc.json", ".eslintrc", "eslint.config.js", "eslint.config.mjs",
        "eslint.config.cjs", "package.json",
      }
      local current_dir = vim.fn.getcwd()
      for _, file in ipairs(eslint_files) do
        if vim.fn.filereadable(current_dir .. "/" .. file) == 1 then
          if file == "package.json" then
            local content = vim.fn.readfile(current_dir .. "/" .. file)
            if table.concat(content, "\n"):find('"eslintConfig"') then
              return true
            end
          else
            return true
          end
        end
      end
      return false
    end

    local function setup_linters()
      local linters_by_ft = {
        python = { "ruff" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
        dockerfile = { "hadolint" },
        markdown = { "markdownlint" },
        solidity = { "solhint" },
      }

      if has_eslint_config() then
        local js_linters = { "eslint_d" }
        linters_by_ft.javascript = js_linters
        linters_by_ft.typescript = js_linters
        linters_by_ft.javascriptreact = js_linters
        linters_by_ft.typescriptreact = js_linters
        linters_by_ft.svelte = js_linters
        linters_by_ft.vue = js_linters
      end

      lint.linters_by_ft = linters_by_ft
    end

    setup_linters()

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        setup_linters()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      setup_linters()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
