-- Snacks.nvim - Collection of QoL plugins for Neovim

return {
  {
    "folke/snacks.nvim",
    version = "v2.30.0",
    lazy = false,
    priority = 1000,
    opts = {
      -- Enable gitbrowse for opening git URLs in browser
      gitbrowse = {
        enabled = true,
        -- Automatically open URLs in browser (can be overridden per keymap)
        open = function(url)
          vim.ui.open(url)
        end,
        -- Notify after copying URL to clipboard
        notify = true,
        -- URL patterns for different git hosts (defaults are good for GitHub, GitLab, Bitbucket)
        url_patterns = {
          -- GitHub
          ["github%.com"] = {
            branch = "/tree/{branch}",
            file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/commit/{commit}",
          },
          -- GitLab
          ["gitlab%.com"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-{line_end}",
            commit = "/-/commit/{commit}",
          },
        },
      },
      -- Enable bufdelete for better buffer deletion
      bufdelete = {
        enabled = true,
      },
      -- Enable terminal with floating popup
      terminal = {
        enabled = true,
        win = {
          style = "terminal",
          border = "rounded",
          width = 0.8,
          height = 0.8,
        },
      },
      -- Enable smooth scrolling
      scroll = {
        enabled = true,
        -- Primary scroll animation settings
        animate = {
          duration = { step = 10, total = 200 }, -- 200ms total animation time
          easing = "linear",
        },
        -- Faster animation for repeated scroll actions
        animate_repeat = {
          duration = { step = 5, total = 50 }, -- 50ms for repeated scrolls
          easing = "linear",
        },
      },
      -- Enable indent guides
      indent = {
        enabled = true,
        char = "│",
        only_scope = false,   -- Show all indent guides, not just scope
        only_current = false, -- Show guides in all windows
        priority = 1,
        -- Scope highlighting configuration
        scope = {
          enabled = true,
          char = "│",
          underline = false,
          hl = "SnacksIndentScope", -- Highlight group for current scope
        },
        -- Animation configuration
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 20,   -- ms per step
            total = 500, -- ms total
          },
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      -- Register keymaps with which-key
      local wk = require("which-key")
      local Snacks = require("snacks")

      wk.add({
        -- Buffer deletion under <leader>b
        {
          "<leader>bd",
          function()
            Snacks.bufdelete()
          end,
          desc = "Delete buffer",
        },
        {
          "<leader>bD",
          function()
            Snacks.bufdelete.other()
          end,
          desc = "Delete other buffers",
        },
        {
          "<leader>ba",
          function()
            Snacks.bufdelete.all()
          end,
          desc = "Delete all buffers",
        },
        -- Terminal popup under <leader>t
        {
          "<leader>tp",
          function()
            Snacks.terminal.toggle()
          end,
          desc = "Toggle floating terminal",
        },
        -- Git browse under <leader>g (replacing gitlinker)
        {
          "<leader>gy",
          function()
            Snacks.gitbrowse({
              open = function(url)
                vim.fn.setreg("+", url)
                vim.notify("Git URL copied to clipboard", vim.log.levels.INFO)
              end,
            })
          end,
          desc = "Copy git link",
          mode = { "n", "v" },
        },
        {
          "<leader>gY",
          function()
            Snacks.gitbrowse() -- Uses default open behavior (browser)
          end,
          desc = "Open git link in browser",
          mode = { "n", "v" },
        },
      })
    end,
  },
}
