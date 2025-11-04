-- Completion engines and snippets

return {
  -- blink.cmp: Modern completion engine with built-in LSP, snippets, and fuzzy matching
  {
    "saghen/blink.cmp",
    version = "1.*", -- Use v1.x releases for stability
    dependencies = {
      { "rafamadriz/friendly-snippets", branch = "main" }, -- Provides snippet collection (no releases, use main branch)
    },

    -- Lazy loading configuration
    event = { "InsertEnter", "CmdlineEnter" },

    -- Optional: Build from source if you need latest features
    -- build = "cargo build --release",

    opts = {
      -- Keymap configuration
      keymap = {
        preset = "default", -- Uses <C-space>, <C-e>, <C-y>, <Up>/<Down>, <C-p>/<C-n>, Tab/S-Tab
        -- Customizations (merged with preset)
        ["<CR>"] = { "accept", "fallback" }, -- Enter to accept completion
        ["<C-k>"] = { "show_documentation", "fallback" },
        ["<C-l>"] = { "accept", "fallback" },
      },

      -- Appearance and behavior
      appearance = {
        use_nvim_cmp_as_default = true, -- Use nvim-cmp style highlighting
        nerd_font_variant = "mono", -- 'mono' or 'normal'
      },

      -- Completion sources
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- Command line completion
      cmdline = {
        enabled = false, -- Disable cmdline completion by default
      },

      -- Completion behavior
      completion = {
        accept = {
          auto_brackets = {
            enabled = true, -- Auto-insert brackets for functions/methods
          },
        },
        menu = {
          auto_show = true, -- Show menu automatically
          border = "rounded",
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = false, -- Disable inline ghost text (can be distracting)
        },
      },

      -- Signature help configuration
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },

      -- Fuzzy matching configuration
      fuzzy = {
        frecency = {
          enabled = true,
        },
        use_proximity = true,
      },
    },

    config = function(_, opts)
      local blink = require("blink.cmp")
      blink.setup(opts)

      -- Register keymaps with which-key
      local wk = require("which-key")
      wk.add({
        { "<C-space>", desc = "Show completion", mode = "i" },
        { "<C-e>", desc = "Hide completion", mode = "i" },
        { "<CR>", desc = "Accept completion", mode = "i" },
        { "<C-y>", desc = "Accept completion (alt)", mode = "i" },
        { "<C-l>", desc = "Accept completion (alt)", mode = "i" },
        { "<C-k>", desc = "Show documentation", mode = "i" },
        { "<C-p>", desc = "Previous item", mode = "i" },
        { "<C-n>", desc = "Next item", mode = "i" },
        { "<C-b>", desc = "Scroll docs up", mode = "i" },
        { "<C-f>", desc = "Scroll docs down", mode = "i" },
      })
    end,
  },
}
