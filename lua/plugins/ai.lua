-- AI assistants and code generation plugins

return {
  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      -- Terminal configuration
      terminal = {
        split_side = "right",
        split_width_percentage = 0.30,
        -- Custom CWD provider to search for CLAUDE.md
        cwd_provider = function(ctx)
          -- Search upward for CLAUDE.md
          local function find_claude_md(start_path)
            local path = start_path
            while path ~= "/" and path ~= "" do
              local claude_file = path .. "/CLAUDE.md"
              if vim.fn.filereadable(claude_file) == 1 then
                return path
              end
              -- Move up one directory
              path = vim.fn.fnamemodify(path, ":h")
            end
            return nil
          end

          -- Try to find CLAUDE.md starting from file's directory, then cwd
          local start_dir = ctx.file_dir or ctx.cwd
          local claude_root = find_claude_md(start_dir)

          -- Fallback to git root, then file_dir, then cwd
          if claude_root then
            return claude_root
          else
            local git_root = require("claudecode.cwd").git_root(start_dir)
            return git_root or ctx.file_dir or ctx.cwd
          end
        end,
      },
      -- Auto-focus terminal after sending content
      focus_after_send = false,
      -- Track selection for real-time context updates
      track_selection = true,
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Register keymaps with which-key
      local wk = require("which-key")

      wk.add({
        -- AI group under <leader>a
        { "<leader>a",   group = "AI" },

        -- Core commands
        { "<leader>ac",  "<cmd>ClaudeCode<CR>",            desc = "Toggle Claude terminal" },
        { "<leader>as",  "<cmd>ClaudeCodeSend<CR>",        desc = "Send selection to Claude", mode = "v" },
        { "<leader>af",  "<cmd>ClaudeCodeFocus<CR>",       desc = "Focus Claude window" },
        { "<leader>am",  "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select Claude model" },
        { "<leader>aa",  "<cmd>ClaudeCodeDiffAccept<CR>",  desc = "Accept diff" },
        { "<leader>add", "<cmd>ClaudeCodeDiffDeny<CR>",    desc = "Reject diff" },
      })
    end,
  },
}
