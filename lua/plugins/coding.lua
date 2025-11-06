-- Coding tools (refactoring, testing, debugging, etc.)

return {
  -- conform.nvim: Formatter plugin
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" }, -- 2 space indent, indent switch cases
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Register keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer", mode = { "n", "v" } },
        { "<leader>ci", "<cmd>ConformInfo<CR>", desc = "Conform info" },
      })
    end,
  },

  -- nvim-lint: Linter plugin
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Configure linters by filetype
      lint.linters_by_ft = {
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      }

      -- Auto-lint on these events
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Register keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>cl", function() lint.try_lint() end, desc = "Lint buffer" },
      })
    end,
  },

  -- mason-tool-installer: Auto-install formatters and linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "shellcheck",  -- Bash linter
        "shfmt",       -- Bash formatter
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- kube-utils.nvim: Kubernetes and Helm operations from Neovim
  -- No setup required - works through commands
  {
    "h4ckm1n-dev/kube-utils-nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
      -- Register Helm and Kubernetes commands with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>h", group = "Helm" },
        { "<leader>hd", "<cmd>HelmDryRun<cr>", desc = "Helm dry run" },
        { "<leader>ht", "<cmd>HelmTemplate<cr>", desc = "Helm template" },
        { "<leader>hi", "<cmd>HelmInstall<cr>", desc = "Helm install" },
        { "<leader>hu", "<cmd>HelmUpgrade<cr>", desc = "Helm upgrade" },
        { "<leader>hr", "<cmd>HelmUninstall<cr>", desc = "Helm uninstall" },
        { "<leader>hD", "<cmd>HelmDepBuild<cr>", desc = "Helm dependency build" },
        { "<leader>hU", "<cmd>HelmDepUpdate<cr>", desc = "Helm dependency update" },
        { "<leader>hl", "<cmd>HelmList<cr>", desc = "Helm list" },
        
        { "<leader>k", group = "Kubernetes" },
        { "<leader>kk", "<cmd>OpenK9s<cr>", desc = "Open K9s" },
        { "<leader>kp", "<cmd>K8sPods<cr>", desc = "List pods" },
        { "<leader>kd", "<cmd>K8sDeployments<cr>", desc = "List deployments" },
        { "<leader>ks", "<cmd>K8sServices<cr>", desc = "List services" },
        { "<leader>kn", "<cmd>K8sNamespaces<cr>", desc = "List namespaces" },
      })
    end,
  },

  -- Refactoring
  -- Example:
  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   opts = {},
  -- },

  -- Testing
  -- Example:
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },
}
