vim.g.mapleader = ' '
-- Initialize Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  "plugins_lazy",
  {
    dev = {
      path = "~/Development",
      patterns = {"gcloudrun.nvim"},
      fallback = false,
    },
  }
)

-- Apply general vim settings
require('settings')

-- Plugin Configs
require('pluginconfigs')

-- Key mappings
require('keymappings')

-- Colorscheme
vim.cmd 'colorscheme github_dark'
vim.cmd 'set termguicolors'

-- Create Reload Snippets Command
vim.api.nvim_create_user_command(
  "ReloadSnippets",
  function () vim.cmd("call UltiSnips#RefreshSnippets()") end,
  {}
)

