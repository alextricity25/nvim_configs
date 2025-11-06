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
      },
      -- Auto-focus terminal after sending content
      focus_after_send = false,
      -- Track selection for real-time context updates
      track_selection = true,
      -- Automatically detect git repository root
      git_repo_cwd = true,
    },
    config = function(_, opts)
      require("claudecode").setup(opts)

      -- Register keymaps with which-key
      local wk = require("which-key")

      wk.add({
        -- AI group under <leader>a
        { "<leader>a", group = "AI" },

        -- Core commands
        { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude terminal" },
        { "<leader>as", "<cmd>ClaudeCodeSend<CR>", desc = "Send selection to Claude", mode = "v" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "Focus Claude window" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Select Claude model" },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept diff" },
        { "<leader>add", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Reject diff" },
      })
    end,
  },
}
