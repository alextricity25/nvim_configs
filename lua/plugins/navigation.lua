-- File navigation plugins (telescope, oil, harpoon, etc.)

return {
  -- Telescope: Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      -- FZF native for better performance
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      -- File pickers
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find all files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

      -- Search pickers
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fW", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
      { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },

      -- Buffer/window pickers
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },

      -- Git pickers (under <leader>g telescope subgroup)
      { "<leader>gtc", "<cmd>Telescope git_commits<cr>", desc = "Commits (all)" },
      { "<leader>gtC", "<cmd>Telescope git_bcommits<cr>", desc = "Commits (buffer)" },
      { "<leader>gtb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
      { "<leader>gtf", "<cmd>Telescope git_files<cr>", desc = "Git files" },
      { "<leader>gts", "<cmd>Telescope git_status<cr>", desc = "Status" },
      { "<leader>gtS", "<cmd>Telescope git_stash<cr>", desc = "Stash" },

      -- LSP pickers (using <leader>s for search/symbols)
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>sr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
      { "<leader>si", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP implementations" },
      { "<leader>sd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP definitions" },
      { "<leader>st", "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP type definitions" },
      { "<leader>se", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>sE", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },

      -- Vim pickers
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>fo", "<cmd>Telescope vim_options<cr>", desc = "Vim options" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix list" },
      { "<leader>fQ", "<cmd>Telescope loclist<cr>", desc = "Location list" },
      { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>fH", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<leader>fs", "<cmd>Telescope search_history<cr>", desc = "Search history" },
      { "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Colorschemes" },
      { "<leader>fT", "<cmd>Telescope filetypes<cr>", desc = "Filetypes" },
      { "<leader>fp", "<cmd>Telescope builtin<cr>", desc = "Telescope pickers" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "%.lock",
            "dist/",
            "build/",
            "target/",
          },
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-l>"] = actions.complete_tag,
              ["<C-_>"] = actions.which_key, -- <C-/> in terminal
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["H"] = actions.move_to_top,
              ["M"] = actions.move_to_middle,
              ["L"] = actions.move_to_bottom,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,
              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,
              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,
              ["?"] = actions.which_key,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
            hidden = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          git_files = {
            theme = "dropdown",
            previewer = false,
          },
          oldfiles = {
            theme = "dropdown",
            previewer = false,
          },
          current_buffer_fuzzy_find = {
            previewer = false,
            sorting_strategy = "ascending",
          },
          colorscheme = {
            enable_preview = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "fzf")

      -- Register keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>s", group = "Search/Symbols" },
        { "<leader>gt", group = "Telescope" },
      })
    end,
  },

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
          custom = {"node_modules", ".cache" },
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
