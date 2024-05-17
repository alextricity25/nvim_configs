return require('packer').startup(function()
  -- On 09/16/2023 I switched to using the lazy plugin manager.
  -- see the file plugins_lazy for plugin definitions.
  --

  -- Packer can manage itself as an optional plugin use { 'wbthomason/packer.nvim', opt = true }
  -- use { 'wbthomason/packer.nvim', opt = true }

  -- Color scheme
  -- use { 'sainnhe/gruvbox-material' }
  -- use { 'sainnhe/everforest' }

  -- ufo, for code folding
  -- use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
  -- use {
  --   "kevinhwang91/nvim-ufo",
  --   requires = {
  --     "kevinhwang91/promise-async",
  --     {
  --       "luukvbaal/statuscol.nvim",
  --       config = function()
  --         local builtin = require("statuscol.builtin")
  --         require("statuscol").setup(
  --           {
  --             relculright = true,
  --             segments = {
  --               { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
  --               { text = { "%s" },                  click = "v:lua.ScSa" },
  --               { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }
  --             }
  --           }
  --         )
  --       end
  --     }
  --   }
  -- }
  -- Fuzzy finder
  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } }
  -- }


  -- Fugitive for Git
  -- use { 'tpope/vim-fugitive' }
  -- use { 'shumphrey/fugitive-gitlab.vim' }
  -- use { 'tpope/vim-rhubarb' }


  -- use { "akinsho/toggleterm.nvim", tag = '*', config = function()
  --   require("toggleterm").setup()
  -- end }

  -- bufferline
  -- use { '/Users/alexcantu/.config/nvim/nvim_plugins/bufferline.nvim-3.1.0' }
  -- use { 'akinsho/bufferline.nvim', requires = '/Users/alexcantu/.config/nvim/nvim_plugins/nvim-web-devicons-master' }

  -- neotree
  -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  -- use { 'nvim-tree/nvim-tree.lua' }

  -- nvim.coc
  -- use { 'neoclide/coc.nvim', branch = 'release' }

  -- lualine
  -- use {
  --   'nvim-lualine/lualine.nvim',
  --   requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  -- }
  -- comment
  -- use {
  --   'numToStr/Comment.nvim',
  --   config = function()
  --     require('Comment').setup()
  --   end
  -- }
  --
  -- diffview
  -- use { "sindrets/diffview.nvim" }

  -- flash.nvim
  -- use { "folke/flash.nvim" }

  -- vim-surrounding
  -- use { "tpope/vim-surround" }

  -- neogit
  -- use { 'treatybreaker/neogit', branch = 'feat/author-column-recent-commits', requires = 'nvim-lua/plenary.nvim' }

  -- obsidian
  -- use { "epwalsh/obsidian.nvim" }

  -- snippy snip
  -- use { 'SirVer/ultisnips' }
  -- use { 'honza/vim-snippets' }

  -- Indent blankline
  -- use { "lukas-reineke/indent-blankline.nvim" }

  -- treesj
  -- use({
  --   'Wansmer/treesj',
  --   -- Treesitter functions depending on what 'parsers' are installed.
  --   -- For more info, see:
  --   -- https://github.com/nvim-treesitter/nvim-treesitter#language-parsers
  --   -- 2023-08-05 16:26
  --   requires = { 'nvim-treesitter/nvim-treesitter' },
  -- })

  -- pulumi
  -- use({ '~/Development/pulumi.nvim', requires = { 'MunifTanjim/nui.nvim' } })

  -- which-key
  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  --     require("which-key").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }
end)
