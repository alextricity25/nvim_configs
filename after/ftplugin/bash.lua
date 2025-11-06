-- Bash-specific configuration
-- This file is automatically loaded when editing bash files

-- Set local options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true

-- Enable spell checking for comments
vim.opt_local.spell = false

-- Set comment string for bash
vim.opt_local.commentstring = "# %s"

-- Folding based on syntax
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldenable = false -- Start with folds open

-- Buffer-local keymaps for bash
local map = vim.keymap.set
local opts = { buffer = 0, silent = true }

-- Quick execute current file
map("n", "<leader>rx", "<cmd>!chmod +x %<CR><cmd>!./%<CR>", vim.tbl_extend("force", opts, { desc = "Make executable and run" }))
map("n", "<leader>rr", "<cmd>!bash %<CR>", vim.tbl_extend("force", opts, { desc = "Run with bash" }))

-- Quick shellcheck
map("n", "<leader>rs", "<cmd>!shellcheck %<CR>", vim.tbl_extend("force", opts, { desc = "Run shellcheck" }))

-- Register buffer-local keymaps with which-key
local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>r", group = "Run", buffer = 0 },
    { "<leader>rx", desc = "Make executable and run", buffer = 0 },
    { "<leader>rr", desc = "Run with bash", buffer = 0 },
    { "<leader>rs", desc = "Run shellcheck", buffer = 0 },
  })
end