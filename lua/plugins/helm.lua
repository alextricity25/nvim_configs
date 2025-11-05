-- Helm and Kubernetes development plugins

return {
  -- helm-ls.nvim: Companion plugin for helm-ls language server
  -- Provides filetype detection, virtual text overlays, and indent hints
  {
    "qvalentin/helm-ls.nvim",
    ft = { "helm", "yaml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Enable experimental features
      experimental = {
        -- Show current values as virtual text in templates
        show_values = true,
        -- Highlight effect of nindent and indent functions
        show_indent_hints = true,
      },
    },
    config = function(_, opts)
      require("helm-ls").setup(opts)
    end,
  },

  -- kubernetes.nvim: Automatic CRD schema support from cluster
  -- Fetches Custom Resource Definitions directly from your kubectl context
  {
    "diogo464/kubernetes.nvim",
    ft = { "yaml", "helm" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Generate schemas strictly (set additionalProperties to false)
      schema_strict = true,
      -- Always regenerate schemas (set to false to cache)
      schema_generate_always = false,
    },
    config = function(_, opts)
      -- Only load if kubectl is available
      if vim.fn.executable("kubectl") == 1 then
        require("kubernetes").setup(opts)
      else
        vim.notify(
          "kubectl not found. kubernetes.nvim disabled. Install kubectl for CRD schema support.",
          vim.log.levels.WARN
        )
      end
    end,
  },
}
