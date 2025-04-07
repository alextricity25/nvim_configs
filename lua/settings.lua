local utils = require('utils')

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'set shell=/bin/zsh'
cmd 'set number'
cmd 'let g:VM_add_cursor_at_pos_no_mappings = 1'
-- cmd 'set termguicolors'
utils.opt('b', 'expandtab', true)
utils.opt('b', 'shiftwidth', indent)
utils.opt('b', 'smartindent', true)
utils.opt('o', 'hidden', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 4)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'wildmode', 'list:longest')
-- utils.opt('w', 'relativenumber', true)
utils.opt('o', 'clipboard', 'unnamed,unnamedplus')
-- code folding
utils.opt('o', 'foldcolumn', '1')
utils.opt('o', 'foldlevel', 1)
utils.opt('o', 'foldlevelstart', 99)
utils.opt('o', 'foldenable', true)
utils.opt('o', 'foldclose', 'all')
utils.opt('o', 'fillchars', [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]])

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

-- Set author for snippet
vim.cmd 'let g:snips_author = "Alex Cantu"'

-- Indent blankline
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

-- undo
utils.opt('o', 'undofile', true)
