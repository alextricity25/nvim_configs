-- LSP configuration and related plugins

return {
  -- LSP Configuration
  -- Example:
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --   },
  --   config = function()
  --     require("mason").setup()
  --     require("mason-lspconfig").setup({
  --       ensure_installed = { "lua_ls", "ts_ls" },
  --     })
  --
  --     local lspconfig = require("lspconfig")
  --     local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --
  --     lspconfig.lua_ls.setup({ capabilities = capabilities })
  --     lspconfig.ts_ls.setup({ capabilities = capabilities })
  --   end,
  -- },
}
