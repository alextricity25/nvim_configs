local utils = require('utils')
local wk = require('which-key')

-- NvimTree
wk.add({
  { "<c-n>", "<cmd>NvimTreeToggle<cr>", desc = "Code Action", mode = {"i", "n" }},
})

-- bufferline
wk.add({
  { "<leader>b", group = "BufferLine" },
  { "<leader>bl", "<cmd>BufferLinePick<cr>", mode = "n" },
})

-- DiffviewFile
wk.add({
  { "<leader>d", group = "Diffview" },
  {
    "<leader>df",
    "<cmd>DiffviewFileHistory % --no-merges<cr>",
    mode = "n",
    desc = "View the git history of the current buffer",
  },
  {
    "<leader>dq",
    "<cmd>DiffviewClose<cr>",
    mode = "n",
    desc = "Close DiffviewFileHistory view",
  },
})

-- Open coc settings
vim.keymap.set('n', '<space>1', ":vsplit ~/.config/nvim/lua/coc.lua<cr>", { silent = true, nowait = true })

-- toggle term
-- function _G.set_terminal_keymaps()
--   local opts = { noremap = true }
--   vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
--   vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
-- end

-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- utils.map('i', [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>')
-- utils.map('n', [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>')
-- local Terminal = require('toggleterm.terminal').Terminal
-- local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- function _lazygit_toggle()
--   lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- treesj
wk.add({
  { "<leader>s", require('treesj').toggle, mode = "n" },
})

-- ssr and spectre
wk.add({
  { "<leader>s", group = "Search and Replace" },
  { "<leader>S", require("spectre").toggle, mode = "n", desc = "Toggle Spectre"},
  { "<leader>sw", function() require("spectre").open_visual({select_word = true}) end, mode = "n", desc = "Search Current Word"},
  { "<leader>sw", require("spectre").open_visual, mode = "v", desc = "Search Current Word"},
  { "<leader>sf", function() require("spectre").open_file_search({select_word = true}) end, mode = "n", desc = "Search on current file"},
  {
    "<leader>sr",
    require("ssr").open,
    mode = { "n", "x" },
    desc = "Structural Search and Replace",
  },
})

-- vim-vsnip
vim.cmd("imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'")
-- Jump forward or backward
vim.cmd("imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
vim.cmd("smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")

-- gp (Chat GPT)
wk.add({
  { "<leader>u", group = "ChatGPT" },
  { "<leader>uc", "<cmd>GpChatToggle vsplit<CR>", desc = "Toggle Chat" },
  { "<leader>ur", "<cmd>GpChatRespond<CR>", desc = "GpChatRespond with instruction" },
  { "<leader>un", "<cmd>GpChatNew<CR>", desc = "New Chat" },
})

wk.add({
  { "<leader>u", group = "ChatGPT" },
  { "<leader>uc", ":<C-u>'<,'>GpChatToggle vsplit<CR>", desc = "Toggle Chat", mode = "v" },
  { "<leader>ur", ":<C-u>'<,'>GpChatRespond<CR>", desc = "GpChatRespond with instruction", mode = "v" },
  { "<leader>un", ":<C-u>'<,'>GpChatNew<CR>", desc = "New Chat", mode = "v" },
})

-- Gitsigns
wk.add({
  { "<leader>g", group = "Gitsigns" },
  { "<leader>gs", "<cmd>Gitsigns stage_hunk <CR>", desc = "Stage Hunk" },
  { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk <CR>", desc = "Undo Stage Hunk" },
  { "<leader>gr", "<cmd>Gitsigns reset_hunk <CR>", desc = "Reset Hunk" },
  { "<leader>gp", "<cmd>Gitsigns preview_hunk <CR>", desc = "Preview Hunk" },
  { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame <CR>", desc = "Blame Line" },
  { "<leader>gf", "<cmd>Gitsigns diffthis <CR>", desc = "Diff This" },
  { "<leader>gn", "<cmd>Gitsigns next_hunk <CR>", desc = "Next Hunk" },
});

-- Lspsaga
wk.add({
  { "<leader>l", group = "Lspsaga" },
  { "<leader>lc", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
  { "<leader>lo", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
  { "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
  { "<leader>ld", "<cmd>Lspsaga goto_definition<cr>", desc = "Lsp GoTo Definition" },
  { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lsp Finder" },
  { "<leader>lp", "<cmd>Lspsaga preview_definition<cr>", desc = "Preview Definition" },
  { "<leader>ls", "<cmd>Lspsaga signature_help<cr>", desc = "Signature Help" },
  { "<leader>lw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Show Workspace Diagnostics" },
})

local function visual_cursors_with_delay()
  -- Execute the vm-visual-cursors command.
  vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
  -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
  vim.cmd('sleep 200m')
  -- Press 'A' in normal mode after the delay.
  vim.cmd('silent! execute "normal! A"')
end

-- visual-multi
-- I need to figure out how to migrate this over to the wk.add method.
-- Since visual multi uses Plug instead of <cmd>, the invocation will
-- look a little different
-- Actually, the reason I need this is because I use the visual_cursors_with_delay
-- function as part of the <leader>mv mapping
wk.register({
  m = {
    name = "Visual Multi",
    m = { "<Plug>(VM-Find-Under)<Tab>", "Start Multiple Cursors", mode = { "n" } },
    a = { "<Plug>(VM-Select-All)<Tab>", "Select All", mode = { "n" } },
    r = { "<Plug>(VM-Start-Regex-Search)", "Start Regex Search", mode = { "n" } },
    p = { "<Plug>(VM-Add-Cursor-At-Pos)", "Add Cursor At Pos", mode = { "n" } },
    u = { "<Plug>(VM-Add-Cursor-Up)", "Add Cursor Up", mode = { "n" } },
    d = { "<Plug>(VM-Add-Cursor-Down)", "Add Cursor Down", mode = { "n" } },
    v = { visual_cursors_with_delay, "Visual Cursors", mode = { "v" } },
    t = { "<Plug>(VM-Toggle-Multiline)", "Toggle Multiline", mode = { "n" } },
    o = { "<Plug>(VM-Toggle-Mappings)", "Toggle Mapping", mode = { "n" } },
  }
}, { prefix = "<leader>" })
