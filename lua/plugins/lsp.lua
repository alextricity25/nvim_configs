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
    "mason-org/mason-lspconfig.nvim",
    tag = "v2.1.0",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "lua_ls", "ts_ls" },
      automatic_installation = true,
    },
  },

  -- LSP Configuration using vim.lsp.config API (Neovim 0.11+)
  {
    "neovim/nvim-lspconfig",
    tag = "v2.5.0",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp", -- Add blink.cmp as dependency for LSP capabilities
    },
    config = function()
      -- Get blink.cmp capabilities for LSP servers
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Configure lua_ls using vim.lsp.config API
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
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

      -- Configure ts_ls (TypeScript/JavaScript) using vim.lsp.config API
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Enable ts_ls
      vim.lsp.enable("ts_ls")

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



