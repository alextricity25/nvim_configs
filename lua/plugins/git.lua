-- Git integration plugins

return {
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
          { "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk", buffer = bufnr, mode = { "n", "v" } },
          { "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk", buffer = bufnr, mode = { "n", "v" } },
          { "<leader>gS", gs.stage_buffer, desc = "Stage buffer", buffer = bufnr },
          { "<leader>gu", gs.undo_stage_hunk, desc = "Undo stage hunk", buffer = bufnr },
          { "<leader>gR", gs.reset_buffer, desc = "Reset buffer", buffer = bufnr },
          { "<leader>gp", gs.preview_hunk, desc = "Preview hunk", buffer = bufnr },
          { "<leader>gP", gs.preview_hunk_inline, desc = "Preview hunk inline", buffer = bufnr },
          { "<leader>gb", function() gs.blame_line({ full = true }) end, desc = "Blame line", buffer = bufnr },
          { "<leader>gB", gs.toggle_current_line_blame, desc = "Toggle line blame", buffer = bufnr },
          { "<leader>gd", gs.diffthis, desc = "Diff this", buffer = bufnr },
          { "<leader>gD", function() gs.diffthis("~") end, desc = "Diff this ~", buffer = bufnr },
          { "<leader>gw", gs.toggle_word_diff, desc = "Toggle word diff", buffer = bufnr },
          { "<leader>gl", gs.toggle_linehl, desc = "Toggle line highlight", buffer = bufnr },
          { "<leader>gn", gs.toggle_numhl, desc = "Toggle number highlight", buffer = bufnr },

          -- Text object for hunks
          { "ih", ":<C-U>Gitsigns select_hunk<CR>", desc = "Select git hunk", buffer = bufnr, mode = { "o", "x" } },
        })
      end,
    },
  },

  -- Gitlinker: Generate and open git remote URLs (lightweight GBrowse alternative)
  {
    "linrongbin16/gitlinker.nvim",
    config = function()
      require("gitlinker").setup({
        message = false, -- Don't print message after copying
      })

      local wk = require("which-key")
      wk.add({
        { "<leader>gy", "<cmd>GitLink<CR>", desc = "Copy git link", mode = { "n", "v" } },
        { "<leader>gY", "<cmd>GitLink!<CR>", desc = "Open git link in browser", mode = { "n", "v" } },
      })
    end,
  },
}
