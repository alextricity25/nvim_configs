-- Editor enhancement plugins (treesitter, autopairs, comments, etc.)

return {
  -- Treesitter for syntax highlighting and code understanding
  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.9.3",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages to ensure are installed
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "yaml",      -- For Kubernetes/Helm YAML files
          "helm",      -- Helm-specific patterns in templates/
          "gotmpl",    -- Go template syntax
          "bash",
          "json",
          "markdown",
          "regex",
        },
        
        -- Auto install missing parsers when entering buffer
        auto_install = true,
        
        -- Enable syntax highlighting
        highlight = {
          enable = true,
          -- Disable for very large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        
        -- Enable indentation
        indent = {
          enable = true,
          -- Disable for YAML as it can be problematic
          disable = { "yaml" },
        },
        
        -- Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
      })
    end,
  },

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
