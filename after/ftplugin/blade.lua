-- Blade-specific configuration
-- This file is automatically loaded when editing Blade template files

-- Set local options - match common Laravel/Blade conventions
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Enable spell checking for text content in templates
vim.opt_local.spell = false

-- Set comment string for Blade templates
-- Blade uses {{-- --}} for comments
vim.opt_local.commentstring = "{{-- %s --}}"

-- Folding based on treesitter
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldenable = false -- Start with folds open

-- Match HTML-like pairs
vim.opt_local.matchpairs = "(:),{:},[:],<:>"

-- Enable auto-indenting
vim.opt_local.autoindent = true
vim.opt_local.smartindent = true

-- Buffer-local keymaps for Blade files
local map = vim.keymap.set
local opts = { buffer = 0, silent = true }

-- Quick format current buffer
map("n", "<leader>cf", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

-- Register buffer-local keymaps with which-key
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>c",  group = "Code",         buffer = 0 },
    { "<leader>cf", desc = "Format buffer", buffer = 0 },
  })
end

