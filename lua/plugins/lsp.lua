-- LSP configuration and related plugins

return {
  -- Mason: Portable package manager for LSP servers, DAP servers, linters, and formatters
  {
    "williamboman/mason.nvim",
    version = "v2.1.0",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      local wk = require("which-key")
      wk.add({
        { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason installer" },
      })
    end,
  },

  -- Mason-LSPConfig: Bridge between mason.nvim and nvim-lspconfig
  -- Automatically enables installed servers via vim.lsp.enable()
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = true,
    },
  },

  -- LSP Configuration using vim.lsp.config API (Neovim 0.11+)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Configure lua_ls using vim.lsp.config API
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Enable lua_ls
      vim.lsp.enable("lua_ls")

      -- Register LSP keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>l", group = "LSP" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code action" },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
        { "<leader>lf", vim.lsp.buf.format, desc = "Format" },
        { "<leader>ld", vim.lsp.buf.definition, desc = "Go to definition" },
        { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to declaration" },
        { "<leader>li", vim.lsp.buf.implementation, desc = "Go to implementation" },
        { "<leader>lt", vim.lsp.buf.type_definition, desc = "Type definition" },
        { "<leader>lR", vim.lsp.buf.references, desc = "References" },
        { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
        { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help", mode = "i" },
      })
    end,
  },
}

