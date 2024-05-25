return {
  'savq/melange-nvim',
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
  },
  -- Vim Fugitive and other Git-related plugins
  'tpope/vim-fugitive',
  'shumphrey/fugitive-gitlab.vim',
  'tpope/vim-rhubarb',
  -- ToggleTerm
  'akinsho/toggleterm.nvim',
  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  'nvim-tree/nvim-tree.lua',
  -- 'neoclide/coc.nvim',
  'nvim-lualine/lualine.nvim',
  'numToStr/Comment.nvim',
  'sindrets/diffview.nvim',
  'folke/flash.nvim',
  'tpope/vim-surround',
  'treatybreaker/neogit',
  -- 'SirVer/ultisnips',
  'honza/vim-snippets',
  'rafamadriz/friendly-snippets',
  'lukas-reineke/indent-blankline.nvim',
  {
    'Wansmer/treesj',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter', lazy = false },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
  },
  'sainnhe/gruvbox-material',
  'sainnhe/everforest',
  -- Structural search and replace
  'cshuaimin/ssr.nvim',
  -- Mason, LSP, LSPConfig
  {
    'williamboman/mason.nvim',
    lazy = false,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false
  },
  -- code completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  -- 'quangnguyen30192/cmp-nvim-ultisnips',
  'hrsh7th/vim-vsnip',
  'hrsh7th/cmp-vsnip',
  -- trouble
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- neodev
  'folke/neodev.nvim',
  --harpoon
  'ThePrimeagen/harpoon',
  -- spectre
  -- Depends on plenary, which we are already installing above.
  'nvim-pack/nvim-spectre',
  'MunifTanjim/nui.nvim',
  -- Chat GPT
  'robitx/gp.nvim',
  -- Database
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-ui',
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  -- {
  --   'git@gitlab.com:gitlab-org/editor-extensions/gitlab.vim.git',
  --   event = { 'BufReadPre', 'BufNewFile' },                           -- Activate when a file is created/opened
  --   -- ft = { 'lua', 'typescript', 'go', 'javascript', 'python', 'ruby' },                    -- Activate when a supported filetype is open
  --   -- cond = function()
  --   --   return vim.env.GITLAB_TOKEN ~= nil and
  --   --   vim.env.GITLAB_TOKEN ~=
  --   --   ''                                                              -- Only activate is token is present in environment variable (remove to use interactive workflow)
  --   -- end,
  --   -- opts = {
  --   --   statusline = {
  --   --     enabled = true, -- Hook into the builtin statusline to indicate the status of the GitLab Duo Code Suggestions integration
  --   --   },
  --   -- },
  -- },
  { 'github/copilot.vim' },
  { 'lewis6991/gitsigns.nvim' },
  { 'mbbill/undotree' },
  { 'stephpy/vim-yaml' },
  -- { 'jackMort/ChatGPT.nvim' },
  { 'mhartington/formatter.nvim' },
  { 'nvimdev/lspsaga.nvim' },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
    end,
  },
  {
    'mg979/vim-visual-multi',
    -- See https://github.com/mg979/vim-visual-multi/issues/241
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Find Under'] = ''
      }
    end,
  },
  { 'towolf/vim-helm' },
  { 'alextricity25/gcloudrun.nvim', dev = true },
}
