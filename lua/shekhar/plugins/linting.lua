return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Function to check if eslint config exists in the project
    local function has_eslint_config()
      local eslint_files = {
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        '.eslintrc',
        'package.json'  -- package.json might contain eslintConfig
      }
      
      local current_dir = vim.fn.getcwd()
      for _, file in ipairs(eslint_files) do
        if vim.fn.filereadable(current_dir .. '/' .. file) == 1 then
          -- For package.json, check if it contains eslintConfig
          if file == 'package.json' then
            local content = vim.fn.readfile(current_dir .. '/' .. file)
            local json_content = table.concat(content, '\n')
            if json_content:find('"eslintConfig"') then
              return true
            end
          else
            return true
          end
        end
      end
      return false
    end

    -- Setup linters conditionally
    local function setup_linters()
      local linters_by_ft = {}
      
      -- Python linter removed (not needed for C++ DSA focus)
      
      -- Only add eslint_d if eslint config exists
      if has_eslint_config() then
        local js_linters = { "eslint_d" }
        linters_by_ft.javascript = js_linters
        linters_by_ft.typescript = js_linters
        linters_by_ft.javascriptreact = js_linters
        linters_by_ft.typescriptreact = js_linters
        linters_by_ft.svelte = js_linters
      end

      lint.linters_by_ft = linters_by_ft
    end

    -- Set up linters initially
    setup_linters()

    -- Create autocmd group
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Setup autocommands
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        -- Refresh linter setup when entering a buffer
        setup_linters()
        lint.try_lint()
      end,
    })

    -- Keymap to manually trigger linting
    vim.keymap.set("n", "<leader>l", function()
      setup_linters()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
