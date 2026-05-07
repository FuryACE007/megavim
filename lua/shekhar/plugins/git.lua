-- Consolidated git + GitHub tooling

return {

  -----------------------------------------------------------------------
  -- diffview — rich side-by-side diffs, file history, merge conflicts
  -----------------------------------------------------------------------
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
      "DiffviewFocusFiles", "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>",                    desc = "Diff view (working tree)" },
      { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<CR>",             desc = "Diff view (vs HEAD~1)" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>",           desc = "File history (current file)" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<CR>",             desc = "File history (whole repo)" },
      { "<leader>gx", "<cmd>DiffviewClose<CR>",                   desc = "Close diff view" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        show_help_hints = true,
        watch_index = true,
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff3_mixed",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        hooks = {
          diff_buf_read = function(bufnr)
            -- comfortable diff reading
            vim.opt_local.wrap = false
            vim.opt_local.list = false
            vim.opt_local.colorcolumn = ""
          end,
        },
        keymaps = {
          view = {
            { "n", "q",          "<cmd>DiffviewClose<CR>",  { desc = "Close diff view" } },
            { "n", "<leader>gx", "<cmd>DiffviewClose<CR>",  { desc = "Close diff view" } },
          },
          file_panel = {
            { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" } },
          },
          file_history_panel = {
            { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close file history" } },
          },
        },
      })
    end,
  },

  -----------------------------------------------------------------------
  -- git-conflict — in-buffer conflict resolution with smart keymaps
  -----------------------------------------------------------------------
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("git-conflict").setup({
        default_mappings = false,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
          ancestor = "DiffChange",
        },
      })

      local map = vim.keymap.set
      -- Choose which side to keep in a conflict
      map("n", "<leader>co", "<Plug>(git-conflict-ours)",          { desc = "Conflict: keep ours" })
      map("n", "<leader>ct", "<Plug>(git-conflict-theirs)",        { desc = "Conflict: keep theirs" })
      map("n", "<leader>cb", "<Plug>(git-conflict-both)",          { desc = "Conflict: keep both" })
      map("n", "<leader>cn", "<Plug>(git-conflict-none)",          { desc = "Conflict: keep none" })
      map("n", "]x",         "<Plug>(git-conflict-next-conflict)",  { desc = "Next conflict" })
      map("n", "[x",         "<Plug>(git-conflict-prev-conflict)",  { desc = "Prev conflict" })
      map("n", "<leader>cx", "<cmd>GitConflictListQf<CR>",         { desc = "List all conflicts" })
    end,
  },

  -----------------------------------------------------------------------
  -- gitlinker — copy / open GitHub permalink for current line/selection
  -----------------------------------------------------------------------
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>gy",
        function() require("gitlinker").get_buf_range_url("n") end,
        mode = "n",
        desc = "Copy GitHub permalink (line)",
      },
      {
        "<leader>gy",
        function() require("gitlinker").get_buf_range_url("v") end,
        mode = "v",
        desc = "Copy GitHub permalink (selection)",
      },
      {
        "<leader>go",
        function()
          require("gitlinker").get_buf_range_url("n", {
            action_callback = require("gitlinker.actions").open_in_browser,
          })
        end,
        mode = "n",
        desc = "Open line on GitHub",
      },
      {
        "<leader>go",
        function()
          require("gitlinker").get_buf_range_url("v", {
            action_callback = require("gitlinker.actions").open_in_browser,
          })
        end,
        mode = "v",
        desc = "Open selection on GitHub",
      },
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          add_current_line_on_normal_mode = true,
          action_callback = require("gitlinker.actions").copy_to_clipboard,
          print_url = true,
        },
      })
    end,
  },

  -----------------------------------------------------------------------
  -- octo — GitHub PRs, issues, reviews, comments inside Neovim
  -- Requires:  gh auth login   (run once in terminal)
  -----------------------------------------------------------------------
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
      { "<leader>op", "<cmd>Octo pr list<CR>",         desc = "GitHub: List PRs" },
      { "<leader>oi", "<cmd>Octo issue list<CR>",       desc = "GitHub: List issues" },
      { "<leader>or", "<cmd>Octo review start<CR>",     desc = "GitHub: Start PR review" },
      { "<leader>oc", "<cmd>Octo pr create<CR>",        desc = "GitHub: Create PR" },
      { "<leader>oA", "<cmd>Octo assignee add<CR>",     desc = "GitHub: Add assignee" },
      { "<leader>oL", "<cmd>Octo label add<CR>",        desc = "GitHub: Add label" },
      { "<leader>om", "<cmd>Octo pr merge<CR>",         desc = "GitHub: Merge PR" },
    },
    config = function()
      require("octo").setup({
        use_local_fs = false,
        enable_builtin = true,
        default_remote = { "upstream", "origin" },
        ssh_aliases = {},
        reaction_viewer_hint_icon = "",
        user_icon = " ",
        timeline_marker = "",
        timeline_indent = "2",
        right_bubble_delimiter = "",
        left_bubble_delimiter = "",
        github_hostname = "",
        snippet_context_lines = 4,
        gh_env = {},
        timeout = 5000,
        ui = {
          use_signcolumn = true,
        },
        issues = {
          order_by = { field = "CREATED_AT", direction = "DESC" },
        },
        pull_requests = {
          order_by = { field = "CREATED_AT", direction = "DESC" },
          always_select_remote_on_create = false,
        },
        file_panel = {
          size = 10,
          use_icons = true,
        },
        picker = "telescope",
        picker_config = {
          use_emojis = true,
        },
      })
    end,
  },

}
