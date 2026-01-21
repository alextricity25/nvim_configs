-- Editor enhancement plugins (treesitter, autopairs, comments, etc.)

return {
  -- nvim-ufo: Better folding with LSP and treesitter support
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    config = function()
      require("ufo").setup({
        -- Use LSP as primary provider, fall back to treesitter, then indent
        -- Disable folding for terminal and special buffers
        provider_selector = function(bufnr, filetype, buftype)
          -- Disable for terminal buffers
          if buftype == "terminal" then
            return ""
          end
          -- Disable for special buffer types
          if buftype ~= "" then
            return "indent"
          end
          -- Disable for specific filetypes without treesitter support
          local disabled_fts = { "neo-tree", "toggleterm", "TelescopePrompt" }
          if vim.tbl_contains(disabled_fts, filetype) then
            return "indent"
          end
          return { "lsp", "treesitter" }
        end,
        -- Optional: Preview fold with peek
        preview = {
          win_config = {
            border = "rounded",
            winhighlight = "Normal:Folded",
            winblend = 0,
          },
          mappings = {
            scrollU = "<C-u>",
            scrollD = "<C-d>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
      })

      -- Register keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "zR", require("ufo").openAllFolds,         desc = "Open all folds" },
        { "zM", require("ufo").closeAllFolds,        desc = "Close all folds" },
        { "zr", require("ufo").openFoldsExceptKinds, desc = "Open folds except kinds" },
        { "zm", require("ufo").closeFoldsWith,       desc = "Close folds with level" },
        {
          "zK",
          function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
              vim.lsp.buf.hover()
            end
          end,
          desc = "Peek fold or hover"
        },
      })
    end,
  },


  -- Treesitter for syntax highlighting and code understanding
  {
    "nvim-treesitter/nvim-treesitter",
    version = "v0.10.0",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      -- Blade parser for Laravel Blade templates
      {
        "EmranMR/tree-sitter-blade",
        ft = "blade",
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages to ensure are installed
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "yaml",   -- For Kubernetes/Helm YAML files
          "helm",   -- Helm-specific patterns in templates/
          "gotmpl", -- Go template syntax
          "bash",
          "json",
          "markdown",
          "regex",
          -- PHP/Laravel development
          "blade",
          "php",        -- PHP syntax
          "phpdoc",     -- PHPDoc comments
          "html",       -- HTML (used in Blade)
          "css",        -- CSS (for Tailwind)
          "dockerfile", -- Docker files
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
}
