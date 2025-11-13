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
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "eslint",     -- ESLint language server
        "bashls",     -- Bash language server
        "helm_ls",    -- Helm language server
        "yamlls",     -- YAML language server (required for helm-ls integration)
        -- PHP/Laravel development
        "laravel_ls", -- Laravel-specific language server
        "intelephense",
        -- "tailwindcss",
        "html",   -- HTML language server (for Blade templates)
        "jsonls", -- JSON language server (for composer.json, package.json)
      },
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

      -- Configure ESLint Language Server
      vim.lsp.config("eslint", {
        capabilities = capabilities,
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
        settings = {
          -- Enable auto-fix on save
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
          format = true,
          -- Use flat config (eslint.config.js)
          useFlatConfig = true,
          experimental = {
            useFlatConfig = true,
          },
          run = "onType",
          -- Validate these languages
          validate = "probe",
          -- Work directory configuration
          workingDirectory = {
            mode = "auto",
          },
        },
        on_attach = function(client, bufnr)
          -- Enable format-on-save with ESLint
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.code_action({
                context = {
                  only = { "source.fixAll.eslint" },
                  diagnostics = {},
                },
                apply = true,
              })
            end,
          })
        end,
      })

      -- Enable eslint
      vim.lsp.enable("eslint")

      -- Configure bashls (Bash Language Server)
      vim.lsp.config("bashls", {
        capabilities = capabilities,
        filetypes = { "sh", "bash" },
        settings = {
          bashIde = {
            -- Enable/disable shellcheck integration
            shellcheckPath = "shellcheck",
            -- Glob pattern for ignored files
            globPattern = "*@(.sh|.inc|.bash|.command)",
          },
        },
      })

      -- Enable bashls
      vim.lsp.enable("bashls")

      -- Configure yamlls (YAML Language Server) with Kubernetes schemas
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            validate = true,
            hover = true,
            completion = true,
            format = {
              enable = true,
            },
            schemas = {
              -- Kubernetes schemas for different file patterns
              kubernetes = {
                "k8s*.yaml",
                "k8s*.yml",
                "kubernetes/*.yaml",
                "kubernetes/*.yml",
              },
              -- Helm Chart.yaml schema
              ["http://json.schemastore.org/chart"] = "Chart.{yaml,yml}",
              -- Helm values schema
              ["http://json.schemastore.org/helmfile"] = "helmfile.{yaml,yml}",
            },
            schemaStore = {
              -- Enable schema store for additional schemas
              enable = true,
              -- Use default schema store URL
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
          },
        },
      })

      -- Enable yamlls
      vim.lsp.enable("yamlls")

      -- Configure helm-ls (Helm Language Server)
      vim.lsp.config("helm_ls", {
        capabilities = capabilities,
        settings = {
          ["helm-ls"] = {
            -- Path to yaml-language-server for integration
            yamlls = {
              enabled = true,
              path = "yaml-language-server",
            },
            -- Lint configuration
            lint = {
              enabled = true,
              -- Add messages to ignore (e.g., {"icon is recommended"})
              ignoredMessages = {},
            },
            -- Additional values files glob pattern
            valuesFilesGlob = "values*.yaml",
          },
        },
      })

      -- Enable helm_ls
      vim.lsp.enable("helm_ls")

      -- ========================================
      -- PHP/Laravel Development LSP Configuration
      -- ========================================

      -- Configure Intelephense (PHP Language Server)
      vim.lsp.config("intelephense", {
        capabilities = capabilities,
        filetypes = { "php", "blade" },
        root_markers = { "artisan" },
        settings = {
          intelephense = {
            trace = {
              server = "messages",
            },
            environment = {
              includePaths = { "./_ide_helper.php", "_ide_helper_models.php" },
            },
            files = {
              maxSize = 10000000, -- Increase for larger Laravel projects (3MB)
              associations = { "*.php", "*.blade.php" },
              exclude = {
                "**/node_modules/**",
                "**/vendor/**/Tests/**",
                "**/vendor/**/tests/**",
                "**/storage/**",
                "**/bootstrap/cache/**",
              },
            },
            format = {
              enable = false, -- Use Laravel Pint for formatting instead
            },
            telemetry = {
              enabled = false,
            },
            stubs = {
              -- PHP built-in stubs
              "apache", "bcmath", "Core", "ctype", "curl", "date",
              "dom", "fileinfo", "filter", "ftp", "gd", "hash",
              "iconv", "json", "libxml", "mbstring", "mysqli",
              "openssl", "pcntl", "pcre", "PDO", "pdo_mysql", "pdo_pgsql",
              "Phar", "posix", "readline", "Reflection", "session",
              "SimpleXML", "soap", "sockets", "sodium", "SPL",
              "standard", "tokenizer", "xml", "xmlreader", "xmlwriter",
              "zip", "zlib",
              -- Laravel-specific stubs
              "laravel", "phpunit", "pest",
            },
          },
        },
      })

      -- Enable intelephense
      vim.lsp.enable("intelephense")

      -- Configure Laravel Language Server
      vim.lsp.config("laravel_ls", {
        capabilities = capabilities,
        cmd = { "/Users/alexcantu/.local/share/nvim/mason/bin/laravel-ls" },
        filetypes = { "php", "blade" },
      })

      -- Enable laravel_ls
      vim.lsp.enable("laravel_ls")

      -- Configure Tailwind CSS LSP (Critical for Filament)
      -- vim.lsp.config("tailwindcss", {
      --   capabilities = capabilities,
      --   filetypes = { "html", "blade", "php", "vue", "javascript", "typescript", "css" },
      --   settings = {
      --     tailwindCSS = {
      --       experimental = {
      --         classRegex = {
      --           -- Match Tailwind classes in PHP files
      --           "class: \"([^\"]*)\"",
      --           "class: '([^']*)'",
      --           "@class\\(\"([^\"]*)\"\\)",
      --           "@class\\('([^']*)'\\)",
      --           -- Livewire/Volt class attribute
      --           "\\bclass\\s*=\\s*[\"']([^\"']*)[\"']",
      --         },
      --       },
      --       validate = true,
      --       lint = {
      --         cssConflict = "warning",
      --         invalidApply = "error",
      --         invalidScreen = "error",
      --         invalidVariant = "error",
      --         invalidConfigPath = "error",
      --         invalidTailwindDirective = "error",
      --       },
      --     },
      --   },
      -- })

      -- Enable tailwindcss
      -- vim.lsp.enable("tailwindcss")

      -- Configure HTML LSP (for Blade templates)
      vim.lsp.config("html", {
        capabilities = capabilities,
        filetypes = { "html", "blade" },
      })

      -- Enable html
      vim.lsp.enable("html")

      -- Configure JSON LSP (for composer.json, package.json)
      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = {
              {
                fileMatch = { "composer.json" },
                url = "https://getcomposer.org/schema.json",
              },
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
              },
            },
          },
        },
      })

      -- Enable jsonls
      vim.lsp.enable("jsonls")

      -- Register LSP keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>l",  group = "LSP" },
        { "<leader>la", vim.lsp.buf.code_action,     desc = "Code action" },
        { "<leader>lr", vim.lsp.buf.rename,          desc = "Rename" },
        { "<leader>lf", vim.lsp.buf.format,          desc = "Format" },
        { "<leader>ld", vim.lsp.buf.definition,      desc = "Go to definition" },
        { "<leader>lD", vim.lsp.buf.declaration,     desc = "Go to declaration" },
        { "<leader>li", vim.lsp.buf.implementation,  desc = "Go to implementation" },
        { "<leader>lt", vim.lsp.buf.type_definition, desc = "Type definition" },
        { "<leader>lR", vim.lsp.buf.references,      desc = "References" },
        { "K",          vim.lsp.buf.hover,           desc = "Hover documentation" },
        { "<C-k>",      vim.lsp.buf.signature_help,  desc = "Signature help",      mode = "i" },
      })
    end,
  },
}
