-- Git integration plugins

return {
  -- Diffview: Enhanced diff and merge tool
  {
    "sindrets/diffview.nvim",
    opts = {
      use_icons = true,
      enhanced_diff_hl = false,
      git_cmd = { "git" },
      show_help_hints = true,
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
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {},
        },
      },
      keymaps = {
        disable_defaults = false,
      },
    },
    config = function(_, opts)
      require("diffview").setup(opts)

      -- Register top-level keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>gv",  group = "Diffview" },
        { "<leader>gvo", "<cmd>DiffviewOpen<CR>",                    desc = "Open diffview" },
        { "<leader>gvc", "<cmd>DiffviewClose<CR>",                   desc = "Close diffview" },
        { "<leader>gvh", "<cmd>DiffviewFileHistory<CR>",             desc = "File history (all)" },
        { "<leader>gvf", "<cmd>DiffviewFileHistory %<CR>",           desc = "File history (current)" },
        { "<leader>gvt", "<cmd>DiffviewToggleFiles<CR>",             desc = "Toggle files panel" },
        { "<leader>gvr", "<cmd>DiffviewRefresh<CR>",                 desc = "Refresh" },
        { "<leader>gvm", "<cmd>DiffviewOpen origin/main...HEAD<CR>", desc = "Diff with main" },
        -- Visual mode for line history
        { "<leader>gvf", ":'<,'>DiffviewFileHistory<CR>",            desc = "File history (selection)", mode = "v" },
      })
    end,
  },

  -- Gitsigns: Git integration for buffers
  {
    "lewis6991/gitsigns.nvim",
    tag = "v1.0.2",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      signs_staged = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      update_debounce = 100,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local wk = require("which-key")

        -- Register keymaps with which-key
        wk.add({
          -- Navigation between hunks
          {
            "]c",
            function()
              if vim.wo.diff then
                return "]c"
              end
              vim.schedule(function()
                gs.next_hunk()
              end)
              return "<Ignore>"
            end,
            desc = "Next git hunk",
            buffer = bufnr,
            expr = true,
          },
          {
            "[c",
            function()
              if vim.wo.diff then
                return "[c"
              end
              vim.schedule(function()
                gs.prev_hunk()
              end)
              return "<Ignore>"
            end,
            desc = "Previous git hunk",
            buffer = bufnr,
            expr = true,
          },

          -- Git operations under <leader>g
          { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>",                desc = "Stage hunk",              buffer = bufnr, mode = { "n", "v" } },
          { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>",                desc = "Reset hunk",              buffer = bufnr, mode = { "n", "v" } },
          { "<leader>gS", gs.stage_buffer,                               desc = "Stage buffer",            buffer = bufnr },
          { "<leader>gu", gs.undo_stage_hunk,                            desc = "Undo stage hunk",         buffer = bufnr },
          { "<leader>gR", gs.reset_buffer,                               desc = "Reset buffer",            buffer = bufnr },
          { "<leader>gp", gs.preview_hunk,                               desc = "Preview hunk",            buffer = bufnr },
          { "<leader>gP", gs.preview_hunk_inline,                        desc = "Preview hunk inline",     buffer = bufnr },
          { "<leader>gb", function() gs.blame_line({ full = true }) end, desc = "Blame line",              buffer = bufnr },
          { "<leader>gB", gs.toggle_current_line_blame,                  desc = "Toggle line blame",       buffer = bufnr },
          { "<leader>gd", gs.diffthis,                                   desc = "Diff this",               buffer = bufnr },
          { "<leader>gD", function() gs.diffthis("~") end,               desc = "Diff this ~",             buffer = bufnr },
          { "<leader>gw", gs.toggle_word_diff,                           desc = "Toggle word diff",        buffer = bufnr },
          { "<leader>gl", gs.toggle_linehl,                              desc = "Toggle line highlight",   buffer = bufnr },
          { "<leader>gn", gs.toggle_numhl,                               desc = "Toggle number highlight", buffer = bufnr },

          -- Text object for hunks
          { "ih",         ":<C-U>Gitsigns select_hunk<CR>",              desc = "Select git hunk",         buffer = bufnr, mode = { "o", "x" } },
        })
      end,
    },
  },
}
