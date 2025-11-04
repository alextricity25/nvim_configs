-- AI assistants and code generation plugins

return {
  {
    "olimorris/codecompanion.nvim",
    tag = "v17.29.0",
    opts = {
      display = {
        chat = {
          window = {
            position = "right",
          },
        },
      },
      strategies = {
        chat = {
          adapter = "claude_code",
        },
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim", tag = "v0.1.4" },
      { "j-hui/fidget.nvim", tag = "v1.6.1" },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- Register keymaps with which-key
      local wk = require("which-key")

      wk.add({
        -- AI group under <leader>a
        { "<leader>a", group = "AI" },

        -- Core commands
        { "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "Actions", mode = { "n", "v" } },
        { "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Chat toggle" },
        { "<leader>ai", "<cmd>CodeCompanion<CR>", desc = "Inline assistant", mode = { "n", "v" } },
        { "<leader>aA", "<cmd>CodeCompanionChat Add<CR>", desc = "Add to chat", mode = "v" },

        -- Prompt library shortcuts
        { "<leader>ap", group = "Prompts" },
        { "<leader>apc", "<cmd>CodeCompanion /commit<CR>", desc = "Generate commit message", mode = { "n", "v" } },
        { "<leader>ape", "<cmd>CodeCompanion /explain<CR>", desc = "Explain code", mode = "v" },
        { "<leader>apf", "<cmd>CodeCompanion /fix<CR>", desc = "Fix code", mode = "v" },
        { "<leader>apl", "<cmd>CodeCompanion /lsp<CR>", desc = "Explain LSP diagnostics" },
        { "<leader>apt", "<cmd>CodeCompanion /tests<CR>", desc = "Generate tests", mode = "v" },

        -- Additional utilities
        { "<leader>ar", "<cmd>CodeCompanionChat RefreshCache<CR>", desc = "Refresh chat cache" },
        { "<leader>am", "<cmd>CodeCompanionCmd<CR>", desc = "Generate command" },
      })
    end,
  },
}
