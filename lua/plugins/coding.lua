-- Coding tools (refactoring, testing, debugging, etc.)

return {
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
