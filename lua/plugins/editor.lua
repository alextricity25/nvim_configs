-- Editor enhancement plugins (treesitter, autopairs, comments, etc.)

return {
  -- Treesitter for syntax highlighting
  -- Example:
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function()
  --     require("nvim-treesitter.configs").setup({
  --       ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript" },
  --       auto_install = true,
  --       highlight = { enable = true },
  --       indent = { enable = true },
  --     })
  --   end,
  -- },

  -- Auto pairs
  -- Example:
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {},
  -- },

  -- Comments
  -- Example:
  -- {
  --   "numToStr/Comment.nvim",
  --   opts = {},
  -- },
}
