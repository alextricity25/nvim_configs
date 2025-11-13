-- UI enhancement plugins (colorscheme, statusline, bufferline, etc.)

return {
  -- Which-key: displays available keybindings in popup
  {
    "folke/which-key.nvim",
    version = "*", -- Pin to latest stable version
    event = "VeryLazy",
    opts = {
      preset = "modern",
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register common leader key groups
      wk.add({
        { "<leader>a", group = "AI" },
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI" },
        { "<leader>w", group = "Window" },
        { "<leader>x", group = "Diagnostics" },
      })
    end,
  },
  -- Colorscheme
  -- Example:
  {
    "folke/tokyonight.nvim",
    tag = "v4.11.0",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    branch = "master", -- No formal releases, use master branch
    dependencies = { { "nvim-tree/nvim-web-devicons", tag = "v0.100" } },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", tag = "v0.100" },
      "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    opts = {
      options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          style = "underline",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)

      -- Register buffer keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<leader>b",  group = "Buffers" },
        { "<leader>bb", "<cmd>Telescope buffers<CR>",     desc = "Browse buffers (Telescope)" },
        { "<leader>bp", "<cmd>BufferLinePick<CR>",        desc = "Pick buffer" },
        { "<leader>bc", "<cmd>BufferLinePickClose<CR>",   desc = "Pick close" },
        { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>",   desc = "Close all to left" },
        { "<leader>bl", "<cmd>BufferLineCloseRight<CR>",  desc = "Close all to right" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close others" },
        { "[b",         "<cmd>BufferLineCyclePrev<CR>",   desc = "Previous buffer" },
        { "]b",         "<cmd>BufferLineCycleNext<CR>",   desc = "Next buffer" },
        { "[B",         "<cmd>BufferLineMovePrev<CR>",    desc = "Move buffer left" },
        { "]B",         "<cmd>BufferLineMoveNext<CR>",    desc = "Move buffer right" },
      })
    end,
  },
}
