return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return vim.o.lines * 0.3  -- 30% of screen height
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.3
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
      })
  
      local keymap = vim.keymap
      
      -- Custom terminal for Cargo run
      local Terminal = require('toggleterm.terminal').Terminal
      local cargo_run = Terminal:new({ 
        cmd = "cargo run",
        hidden = true,
        direction = "horizontal",
        on_open = function(term)
          -- Terminal keymaps
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<C-\\><C-n>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "jk", "<C-\\><C-n>", {noremap = true, silent = true})
        end,
      })
  
      function _cargo_run()
        cargo_run:toggle()
      end
  
      -- Keymaps
      keymap.set("n", "<leader>cr", "<cmd>lua _cargo_run()<CR>", { desc = "Run cargo run in terminal" })
      keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
    
      -- Terminal navigation
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
  
      -- Auto-command to set terminal keymaps when terminal opens
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  }