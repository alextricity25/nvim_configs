-- UI enhancement plugins (colorscheme, statusline, bufferline, etc.)

return {
  -- Which-key: displays available keybindings in popup
  {
    "folke/which-key.nvim",
    version = "*", -- Pin to latest stable version
    event = "VeryLazy",
    opts = {
      preset = "modern",
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register common leader key groups
      wk.add({
        { "<leader>a", group = "AI" },
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Test" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics" },
      })
    end,
  },
  -- Colorscheme
  -- Example:
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Statusline
  -- Example:
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {
  --     theme = "auto",
  --   },
  -- },

  -- Bufferline
  -- Example:
  -- {
  --   "akinsho/bufferline.nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = {},
  -- },
}

