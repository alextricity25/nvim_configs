---@diagnostic disable-next-line: missing-fields
-- which-key
require('which-key').setup({
  notify = false,
})
require("toggleterm").setup {
  close_on_exit = false,
  autochdir = true,
  shell = vim.o.shell,
  size = 20 }

-- Bufferline
require("bufferline").setup {
  options = {
    mode = 'buffers',
    separator_style = 'slant',
    -- diagnostics = 'coc',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      }
    },
  },
}
-- Lualine
require("lualine").setup {}
require('nvim-tree').setup({
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  auto_reload_on_write = true,
  view = {
    centralize_selection = false,
    cursorline = true,
    debounce_delay = 15,
    width = {},
    side = "left",
    preserve_window_proportions = false,
    number = true,
    relativenumber = true,
    signcolumn = "yes",
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "all",
    highlight_modified = "none",
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
  }
})

require('ufo').setup()

require('Comment').setup()

-- Trying out flash.nvim instead
-- require('leap').add_default_mappings()
--
-- require('flash').setup({
--   modes = {
--     search = {
--       enabled = true,
--     }
--   }
-- })

require('diffview').setup()

require('ibl').setup()

-- treesj
require('treesj').setup({
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = false,

  -- Node with syntax error will not be formatted
  check_syntax_error = false,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 120,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted
  cursor_behavior = 'hold',

  -- Notify about possible problems or not
  notify = true,
  langs = {
    lua = require('treesj.langs.lua'),
    typescript = require('treesj.langs.typescript'),
  },

  -- Use `dot` for repeat action
  dot_repeat = true,
})
-- ssr
require('ssr').setup({
  border = "rounded",
  min_width = 50,
  min_height = 5,
  max_width = 120,
  max_height = 25,
  keymaps = {
    close = "q",
    next_match = "n",
    prev_match = "N",
    replace_confirm = "<cr>",
    replace_all = "<leader><cr>",
  },
})
-- neodev
require('neodev').setup()
require("go").setup({
  verbose = true,
  lsp_config = false,
  null_ls = false,
  gopls_cmd = { "/Users/alexcantu/.local/share/nvim/mason/bin/gopls" },
  dap_debug = false,
  dap_debug_keymap = false,
})
-- Mason, LSPConfig
require('mason').setup()
require('mason-lspconfig').setup()
-- local lspconfig = require('lspconfig')
-- lspconfig.lua_ls.setup {}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- laravel ls
local lsp_config = require('lspconfig.configs')
if not lsp_config.laravel_ls then
  lsp_config.laravel_ls = {
    default_config = {
      cmd = { "laravel-dev-tools", "lsp" },
      filetypes = { 'blade' },
      root_dir = function(fname)
        return require('lspconfig').util.root_pattern("composer.json", ".git")(fname) or vim.fn.getcwd()
      end,
      settings = {},
    },
  }
end
require('lspconfig').laravel_ls.setup {
  capabilities = capabilities,
}

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
    }
  end,
  ["helm_ls"] = function()
    require("lspconfig").helm_ls.setup {
      capabilities = capabilities,
      settings = {
        ['helm-ls'] = {
          yamlls = {
            path = "yaml-language-server",
            config = {
              schemas = {
                -- kubernetes = "/*.yaml",
                -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.yml",
              },
            },
          },
        },
      },
    }
  end,
  ["gopls"] = function()
    require("lspconfig").gopls.setup {
      capabilities = capabilities,
      cmd = { "gopls", "-vv", "-logfile=/Users/alexcantu/goplslogfile.txt" },
    }
  end,
  -- ["yamlls"] = function()
  --   require("lspconfig").yamlls.setup {
  --     capabilities = capabilities,
  --     settings = {
  --       yaml = {
  --         schemas = {
  --           kubernetes = "/*.yaml",
  --           -- Add the schema for gitlab piplines
  --           -- Gotten from yaml sechema store
  --           -- https://www.schemastore.org/json/
  --           ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*.gitlab-ci.yml",
  --           -- ["https://json.schemastore.org/pulumi.json"] = "Pulumi.*.yaml",
  --         },
  --       },
  --     },
  --   }
  -- end,
}
-- gitlab_lsp so that gitlab duo works
-- local configs = require('lspconfig.configs')
-- local lspconfig = require('lspconfig')
-- if configs.gitlab_lsp then
--   print('Already set');
-- else
--   local settings = {
--     baseUrl = "https://gitlab.com",
--     token = vim.env.GITLAB_TOKEN,
--   }
--   configs.gitlab_lsp = {
--     default_config = {
--       name = "gitlab_lsp",
--       cmd = {"/Users/alexcantu/.local/share/nvim/lazy/gitlab.vim/node_modules/@gitlab-org/gitlab-lsp/out/node/main.js", "--stdio"},
--       filetypes = { "lua", "typescript" },
--       single_file_support = true,
--       root_dir = function(fname)
--         return lspconfig.util.find_git_ancestor(fname)
--       end,
--       settings = settings,
--     },
--     docs = {
--       description = "Gitlab code suggestions",
--     },
--   }
--   lspconfig.gitlab_lsp.setup({})
-- end
-- require('nvim-lspconfig').setup()
require('lspmappings')

-- completion
local cmp = require('cmp')
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For ultisnips users.
  }, {
    { name = 'buffer' },
  })
})
-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- pulumi
-- require('pulumi').setup()
-- Harpoon
require('harpoon').setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = false,

    -- enable tabline with harpoon marks
    tabline = false,
    tabline_prefix = "   ",
    tabline_suffix = "   ",
  }
})
require("telescope").load_extension('harpoon')

-- spectre
require('spectre').setup({
  result_padding = '',
  default = {
    replace = {
      cmd = "sed"
    }
  }
})

-- chat gpt
require('gp').setup({
  openai_api_key = os.getenv("OPENAI_API_KEY"),
  -- chat_model = {"gpt-4-1106-preview"},
})
-- require("chatgpt").setup({
--   openai_api_key = os.getenv("OPENAI_API_KEY"),
--   openai_params = {
--     model = "gpt-4-turbo-preview",
--     frequency_penalty = 0,
--     presence_penalty = 0,
--     max_tokens = 4000,
--     temperature = 0,
--     top_p = 1,
--     n = 1,
--   },
--   openai_edit_params = {
--     model = "gpt-4-0125-preview",
--     frequency_penalty = 0,
--     presence_penalty = 0,
--     temperature = 0,
--     top_p = 1,
--     n = 1,
--   },
-- })
require("aerial").setup({
  backends = { 'lsp' },
  filter_kind = false,
  show_guides = true,
});

require('gitsigns').setup();

-- formatter
require('formatter').setup({
  logging = true,
  log_level = vim.log.levels.DEBUG,
  filetype = {
    lua = {
      function()
        return {
          exe = "stylua",
          args = { "--config-path", vim.fn.stdpath('config') .. "/stylua.toml", "-" },
        }
      end
    },
    php = {
      function()
        return {
          exe = "php-cs-fixer",
          args = { "fix", "--config", vim.fn.stdpath('config') .. "/.php_cs.php", "-" },
          stdin = true
        }
      end
    },
    typescript = {
      function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
    javascript = {
      function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
          stdin = true
        }
      end
    },
  }
})

--lspsaga
require('lspsaga').setup({
  lightbulb = {
    enable = false,
  },
  use_saga_diagnostic_sign = true,
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  dianostic_header_icon = '   ',
  code_action_icon = ' ',
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  max_preview_lines = 10,
  finder_action_keys = {
    open = 'o', vsplit = 's', split = 'i', quit = 'q', scroll_down = '<C-f>', scroll_up = '<C-b>'
  },
  code_action_keys = {
    quit = 'q', exec = '<CR>'
  },
  rename_action_keys = {
    quit = '<C-c>', exec = '<CR>'
  },
  definition_preview_icon = '  ',
  border_style = "single",
  rename_prompt_prefix = '➤',
  server_filetype_map = {},
  outline = {
    win_width = 50,
  },

})

-- rest.nvim
-- require('rest-nvim').setup();
require('tsc').setup()

-- my plugins
require('gcloudrun').setup();

require("github-theme").setup()
require("nvim-treesitter.configs").setup({ highlight = { enable = true } })
require("scrollbar").setup({
  handle = {
    text = "  ",
  },
  marks = {
    Cursor = {
      text = "••",
    },
    Search = {
      text = { "--", "--" },
      highlight = "DiagnosticVirtualTextInfo"
    },
    GitAdd = {
      text = "++",
    },
    GitChange = {
      text = "||",
    },
    GitDelete = {
      text = "--",
    },
  },
  handlers = {
    gitsigns = true,
    search = true,
  },
})
require("hlslens").setup({
  calm_down = true,
})

local builtin = require("statuscol.builtin")
require('statuscol').setup({
  segments = {
    { text = { "%s" },             click = "v:lua.ScSa" },
    { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
    {
      text = { " ", builtin.foldfunc, " " },
      condition = { builtin.not_empty, true, builtin.not_empty },
      click = "v:lua.ScFa"
    },
  },
})
