-- Autocommands configuration

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = highlight_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Resize splits if window got resized
local resize_group = augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
  group = resize_group,
  pattern = "*",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
  desc = "Resize splits on window resize",
})

-- Close certain filetypes with 'q'
local close_with_q_group = augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
  group = close_with_q_group,
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "startuptime",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "Close certain filetypes with q",
})

-- Remove trailing whitespace on save
local trim_whitespace_group = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = trim_whitespace_group,
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Remove trailing whitespace on save",
})

-- Set wrap and spell for certain filetypes
local wrap_spell_group = augroup("WrapSpell", { clear = true })
autocmd("FileType", {
  group = wrap_spell_group,
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
  desc = "Enable wrap and spell for text filetypes",
})

-- Blade filetype detection for Laravel templates
vim.filetype.add({
  pattern = {
    [".*%.blade%.php"] = "blade",
  },
})
