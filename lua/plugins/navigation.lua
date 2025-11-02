-- File navigation plugins (telescope, oil, harpoon, etc.)

return {
  -- Telescope
  -- Example:
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   branch = "0.1.x",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   keys = {
  --     { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  --     { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
  --     { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
  --     { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
  --   },
  -- },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        -- Disable netrw
        disable_netrw = true,
        hijack_netrw = true,

        -- Update focused file
        update_focused_file = {
          enable = true,
          update_root = false,
        },

        -- View settings
        view = {
          width = 30,
          side = "left",
        },

        -- Renderer settings
        renderer = {
          group_empty = true,
          highlight_git = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },

        -- Filters
        filters = {
          dotfiles = false,
          custom = { ".git", "node_modules", ".cache" },
        },

        -- Git integration
        git = {
          enable = true,
          ignore = false,
        },

        -- Actions
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = true,
            },
          },
        },
      })

      -- Register keymap with which-key
      local wk = require("which-key")
      wk.add({
        { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      })
    end,
  },
}
