-- C++ DSA Problem Solving Setup
return {
  -- Competitive programming plugin
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("competitest").setup({
        local_config_file_name = ".competitest.lua",

        floating_border = "rounded",
        floating_border_highlight = "FloatBorder",
        picker_ui = {
          width = 0.2,
          height = 0.3,
          mappings = {
            focus_next = { "j", "<down>", "<Tab>" },
            focus_prev = { "k", "<up>", "<S-Tab>" },
            close = { "<esc>", "<C-c>", "q", "Q" },
            submit = { "<cr>" },
          },
        },
        editor_ui = {
          popup_width = 0.4,
          popup_height = 0.6,
          show_nu = true,
          show_rnu = false,
          normal_mode_mappings = {
            switch_window = { "<C-h>", "<C-l>", "<C-i>" },
            save_and_close = "<C-s>",
            cancel = { "q", "Q" },
          },
          insert_mode_mappings = {
            switch_window = { "<C-h>", "<C-l>", "<C-i>" },
            save_and_close = "<C-s>",
            cancel = "<C-q>",
          },
        },
        runner_ui = {
          interface = "popup",
          selector_show_nu = false,
          selector_show_rnu = false,
          show_nu = true,
          show_rnu = false,
          mappings = {
            run_again = "R",
            run_all_again = "<C-r>",
            kill = "K",
            kill_all = "<C-k>",
            view_input = { "i", "I" },
            view_output = { "a", "A" },
            view_stdout = { "o", "O" },
            view_stderr = { "e", "E" },
            toggle_diff = { "d", "D" },
            close = { "q", "Q" },
          },
          viewer = {
            width = 0.5,
            height = 0.5,
            show_nu = true,
            show_rnu = false,
          },
        },
        popup_ui = {
          total_width = 0.8,
          total_height = 0.8,
          layout = {
            { 4, "tc" },
            { 5, { { 1, "so" }, { 1, "si" } } },
            { 5, { { 1, "eo" }, { 1, "se" } } },
          },
        },
        split_ui = {
          position = "right",
          relative_to_editor = true,
          total_width = 0.4,
          vertical_layout = {
            { 1, "tc" },
            { 1, { { 1, "so" }, { 1, "eo" } } },
            { 1, { { 1, "si" }, { 1, "se" } } },
          },
          total_height = 0.4,
          horizontal_layout = {
            { 2, "tc" },
            { 3, { { 1, "so" }, { 1, "si" } } },
            { 3, { { 1, "eo" }, { 1, "se" } } },
          },
        },

        save_current_file = true,
        save_all_files = false,
        compile_directory = ".",
        compile_command = {
          c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
          cpp = { exec = "g++", args = { "-std=c++17", "-Wall", "-O2", "$(FNAME)", "-o", "$(FNOEXT)" } },
          rust = { exec = "rustc", args = { "$(FNAME)" } },
          java = { exec = "javac", args = { "$(FNAME)" } },
        },
        running_directory = ".",
        run_command = {
          c = { exec = "./$(FNOEXT)" },
          cpp = { exec = "./$(FNOEXT)" },
          rust = { exec = "./$(FNOEXT)" },
          python = { exec = "python", args = { "$(FNAME)" } },
          java = { exec = "java", args = { "$(FNOEXT)" } },
        },
        multiple_testing = -1,
        maximum_time = 5000,
        output_compare_method = "squish",
        view_output_diff = false,

        testcases_directory = ".",
        testcases_use_single_file = false,
        testcases_auto_detect_storage = true,
        testcases_single_file_format = "$(FNOEXT).testcases",
        testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
        testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",

        companion_port = 27121,
        receive_print_message = true,
        template_file = false,
        evaluate_template_modifiers = false,
        date_format = "%c",
        received_files_extension = "cpp",
        received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",
        received_problems_prompt_path = true,
        received_contests_directory = "$(CWD)",
        received_contests_problems_path = "$(PROBLEM).$(FEXT)",
        received_contests_prompt_directory = true,
        received_contests_prompt_extension = true,
        open_received_problems = true,
        open_received_contests = true,
        replace_received_testcases = false,
      })
    end,
  },

  -- Setup keymaps for C++ DSA
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local keymap = vim.keymap
      local Terminal = require('toggleterm.terminal').Terminal

      -- Create reusable terminal instances
      local cpp_run_term = Terminal:new({
        cmd = "",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "rounded",
          width = 120,
          height = 40,
        },
        close_on_exit = false, -- Keep terminal open to see output
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<C-\\><C-n>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<C-\\><C-n>:close<CR>", {noremap = true, silent = true})
        end,
      })

      local cpp_compile_term = Terminal:new({
        cmd = "",
        hidden = true,
        direction = "horizontal",
        close_on_exit = false,
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<C-\\><C-n>", {noremap = true, silent = true})
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<C-\\><C-n>:close<CR>", {noremap = true, silent = true})
        end,
      })

      -- Detect real GCC (Homebrew) vs system g++ (clang)
      local function get_gpp_command()
        -- Check if Homebrew GCC is available
        if vim.fn.executable("/opt/homebrew/bin/g++-15") == 1 then
          return "/opt/homebrew/bin/g++-15"
        elseif vim.fn.executable("/opt/homebrew/bin/g++-14") == 1 then
          return "/opt/homebrew/bin/g++-14"
        elseif vim.fn.executable("/opt/homebrew/bin/g++-13") == 1 then
          return "/opt/homebrew/bin/g++-13"
        else
          -- Fallback to system g++ (clang) with custom header
          return "g++"
        end
      end

      -- Quick compile and run for current C++ file
      keymap.set("n", "<F5>", function()
        vim.cmd("w") -- Save file
        local file = vim.fn.expand("%:p")
        local file_no_ext = vim.fn.expand("%:p:r")
        local dir = vim.fn.expand("%:p:h")
        local filename = vim.fn.fnamemodify(file, ":t")
        local exename = vim.fn.fnamemodify(file_no_ext, ":t")
        
        local gpp = get_gpp_command()
        local include_path = vim.fn.expand("~/.local/include")
        -- Only add include path if using system g++ (clang)
        local include_flag = ""
        if gpp == "g++" then
          include_flag = string.format("-I %s ", vim.fn.shellescape(include_path))
        end
        
        local cmd = string.format(
          "cd %s && rm -f '%s' && echo '=== Compiling ===' && %s -std=c++17 -Wall -O2 %s'%s' -o '%s' && echo '=== Running ===' && ./'%s' && echo '' && echo '=== Program finished ==='",
          vim.fn.shellescape(dir),
          exename,
          gpp,
          include_flag,
          filename,
          exename,
          exename
        )
        
        -- Set command and toggle terminal
        cpp_run_term.cmd = cmd
        cpp_run_term:toggle()
      end, { desc = "Compile and run C++ file", silent = true })

      -- Compile and run with input from file
      keymap.set("n", "<F6>", function()
        vim.cmd("w")
        local file = vim.fn.expand("%:p")
        local file_no_ext = vim.fn.expand("%:p:r")
        local dir = vim.fn.expand("%:p:h")
        local filename = vim.fn.fnamemodify(file, ":t")
        local exename = vim.fn.fnamemodify(file_no_ext, ":t")
        local input_file = vim.fn.fnamemodify(file_no_ext .. "_input.txt", ":t")
        
        local gpp = get_gpp_command()
        local include_path = vim.fn.expand("~/.local/include")
        local include_flag = ""
        if gpp == "g++" then
          include_flag = string.format("-I %s ", vim.fn.shellescape(include_path))
        end
        
        local cmd = string.format(
          "cd %s && rm -f '%s' && echo '=== Compiling ===' && %s -std=c++17 -Wall -O2 %s'%s' -o '%s' && echo '=== Running with input from %s ===' && ./'%s' < '%s' && echo '' && echo '=== Program finished ==='",
          vim.fn.shellescape(dir),
          exename,
          gpp,
          include_flag,
          filename,
          exename,
          input_file,
          exename,
          input_file
        )
        
        cpp_run_term.cmd = cmd
        cpp_run_term:toggle()
      end, { desc = "Compile and run C++ with input file", silent = true })

      -- Quick compile only (to check for errors)
      keymap.set("n", "<F4>", function()
        vim.cmd("w")
        local file = vim.fn.expand("%:p")
        local file_no_ext = vim.fn.expand("%:p:r")
        local dir = vim.fn.expand("%:p:h")
        local filename = vim.fn.fnamemodify(file, ":t")
        local exename = vim.fn.fnamemodify(file_no_ext, ":t")
        
        local gpp = get_gpp_command()
        local include_path = vim.fn.expand("~/.local/include")
        local include_flag = ""
        if gpp == "g++" then
          include_flag = string.format("-I %s ", vim.fn.shellescape(include_path))
        end
        
        local cmd = string.format(
          "cd %s && rm -f '%s' && echo '=== Compiling ===' && %s -std=c++17 -Wall -O2 %s'%s' -o '%s' && echo '=== Compilation successful ===' || echo '=== Compilation failed ==='",
          vim.fn.shellescape(dir),
          exename,
          gpp,
          include_flag,
          filename,
          exename
        )
        
        cpp_compile_term.cmd = cmd
        cpp_compile_term:toggle()
      end, { desc = "Compile C++ file", silent = true })

      -- Create input file for current problem
      keymap.set("n", "<leader>ci", function()
        local file_no_ext = vim.fn.expand("%:p:r")
        local input_file = file_no_ext .. "_input.txt"
        vim.cmd("vsplit " .. input_file)
      end, { desc = "Create/open input file for C++ problem" })

      -- Create output file for current problem
      keymap.set("n", "<leader>co", function()
        local file_no_ext = vim.fn.expand("%:p:r")
        local output_file = file_no_ext .. "_output.txt"
        vim.cmd("vsplit " .. output_file)
      end, { desc = "Create/open output file for C++ problem" })

      -- Competitive programming keymaps
      keymap.set("n", "<leader>cr", "<cmd>CompetiTest run<CR>", { desc = "CompetiTest: Run testcases" })
      keymap.set("n", "<leader>ca", "<cmd>CompetiTest add_testcase<CR>", { desc = "CompetiTest: Add testcase" })
      keymap.set("n", "<leader>ce", "<cmd>CompetiTest edit_testcase<CR>", { desc = "CompetiTest: Edit testcase" })
      keymap.set("n", "<leader>cd", "<cmd>CompetiTest delete_testcase<CR>", { desc = "CompetiTest: Delete testcase" })
      keymap.set(
        "n",
        "<leader>cra",
        "<cmd>CompetiTest run_all_testcases<CR>",
        { desc = "CompetiTest: Run all testcases" }
      )
      keymap.set(
        "n",
        "<leader>cst",
        "<cmd>CompetiTest show_testcases<CR>",
        { desc = "CompetiTest: Show all testcases" }
      )
    end,
  },
}
