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
-- local lspconfig = require('lspconfig')
-- lspconfig.lua_ls.setup {}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local utils = require('utils')
local lsp_utils = require('lsp_utils')

vim.lsp.config('laravel_ls', {
  capabilities = capabilities,
  cmd = { "/Users/alexcantu/go/bin/laravel-ls" },
  filetypes = { "php" },
  -- root_markers = require('lspconfig').util.root_pattern("composer.json", "artisan", ".git"),
})

-- We may need this for IDP development
-- vim.lsp.enable('laravel_ls')


-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "php", "blade" },
--   callback = function()
--     vim.lsp.start({
--       name = "laravel-ls",
--
--       -- if laravel ls is in your $PATH
--       cmd = { '/Users/alexcantu/go/bin/laravel-ls' },
--
--       -- Absolute path
--       -- cmd = { '/path/to/laravel-ls/build/laravel-ls' },
--
--       -- if you want to recompile everytime
--       -- the language server is started.
--       -- cmd = { '/path/to/laravel-ls/start.sh' },
--
--       root_dir = require('lspconfig').util.root_pattern("composer.json", "artisan", ".git"),
--     })
--   end
-- })

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  root_dir = function(fname, on_dir)
    local root = lsp_utils.get_typescript_root_dir(fname, require('lspconfig').util.root_pattern)
    if root then
      on_dir(root)
    end
  end,
})

vim.lsp.config('denols', {
  capabilities = capabilities,
  root_dir = function(fname, on_dir)
    local root = lsp_utils.get_deno_root_dir(fname, require('lspconfig').util.root_pattern)
    if root then
      on_dir(root)
    end
  end,
  single_file_support = false,
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },
})

vim.lsp.config('helm_ls', {
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
})

vim.lsp.config('gopls', {
  capabilities = capabilities,
  cmd = { "gopls", "-vv", "-logfile=/Users/alexcantu/goplslogfile.txt" },
})

vim.lsp.config('eslint', {
  capabilities = capabilities,
  root_dir = function(fname, on_dir)
    local root = lsp_utils.get_eslint_root_dir(fname, require('lspconfig').util.root_pattern)
    if root then
      on_dir(root)
    end
  end,
})
-- Enable when needed for IDP development
vim.lsp.enable('laravel_ls')

require('mason-lspconfig').setup(
  {
    automatic_enable = true,
  }
)
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
require("telescope").load_extension("live_grep_args")

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
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
  install_info = {
    url = "https://github.com/EmranMR/tree-sitter-blade",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "blade"
}

vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  }
})
local bladeGrp
vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.blade.php",
  group = bladeGrp,
  callback = function()
    vim.opt.filetype = "blade"
  end,
})
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

require("claudecode").setup({
  terminal_cmd = '/Users/alexcantu/.claude/local/claude',
  terminal = {
    provider = 'snacks',
  },
})
