local utils = require('utils')

-- Neotree
utils.map('i', [[<c-n>]], ':NvimTreeToggle<cr>')
utils.map('n', [[<c-n>]], ':NvimTreeToggle<cr>')

-- bufferline
utils.map('n', [[<leader>bl]], ':BufferLinePick<CR>')
-- ufo code folding
vim.keymap.set('n', 'zN', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- Neogit
-- utils.map('n', [[<leader>g]], ':Neogit kind=vsplit<CR>')

-- DiffviewFile
utils.map('n', [[<leader>df]], ':DiffviewFile %s<CR>')

-- Obsidian
utils.map('n', '<leader>oo', '<cmd>ObsidianOpen<cr>')
utils.map('n', '<leader>on', '<cmd>ObsidianNew<cr>')
utils.map('n', '<leader>oT', '<cmd>ObsidianTemplate<cr>')
utils.map('n', '<leader>ot', '<cmd>ObsidianToday<cr>')
utils.map('n', '<leader>oy', '<cmd>ObsidianYesterday<cr>')
utils.map('n', '<leader>ol', '<cmd>ObsidianLink<cr>')
utils.map('n', '<leader>oL', '<cmd>ObsidianLinkNew<cr>')
utils.map('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>')
utils.map('n', '<leader>os', '<cmd>ObsidianSearch<cr>')
utils.map('n', '<leader>oq', '<cmd>ObsidianQuickSwitch<cr>')

-- Open coc settings
vim.keymap.set('n', '<space>1', ":vsplit ~/.config/nvim/lua/coc.lua<cr>", { silent = true, nowait = true })

-- toggle term
function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
utils.map('i', [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>')
utils.map('n', [[<C-\>]], '<cmd>exe v:count1 . "ToggleTerm size=80 direction=vertical"<CR>')
-- local Terminal = require('toggleterm.terminal').Terminal
-- local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

-- function _lazygit_toggle()
--   lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- treesj
-- For use default preset and it work with dot
vim.keymap.set('n', '<leader>s', require('treesj').toggle)

--ssr
vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)

-- vim-vsnip
vim.cmd("imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'")
-- Jump forward or backward
vim.cmd("imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
vim.cmd("smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")

-- harpoon
vim.keymap.set('n', 'hx', require('harpoon.mark').add_file)
vim.keymap.set('n', 'hn', require('harpoon.ui').nav_next)
vim.keymap.set('n', 'hp', require('harpoon.ui').nav_prev)
utils.map('n', 'hm', ':telescope harpoon marks<cr>')

-- spectre
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word"
})
vim.keymap.set('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file"
})

-- gp (Chat GPT)
local wk = require('which-key')
wk.register({
  u = {
    name = "ChatGPT",
    c = { "<cmd>GpChatToggle vsplit<CR>", "Toggle Chat" },
    r = { "<cmd>GpChatRespond<CR>", "GpChatRespond with instruction" },
    n = { "<cmd>GpChatNew<CR>", "New Chat" },
  },
}, {
  prefix = "<leader>",
  mode = "n",
})

wk.register({
  u = {
    name = "ChatGPT",
    c = { ":<C-u>'<,'>GpChatToggle vsplit<CR>", "Toggle Chat" },
    r = { ":<C-u>'<,'>GpChatRespond<CR>", "GpChatRespond with instruction" },
    n = { ":<C-u>'<,'>GpChatNew<CR>", "New Chat" },
  },
}, {
  prefix = "<leader>",
  mode = "v",
})

-- Gitsigns
wk.register({
  g = {
    name = "Gitsigns",
    s = { "<cmd> require('gitsigns').stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd> require('gitsigns').undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    r = { "<cmd> require('gitsigns').reset_hunk()<cr>", "Reset Hunk" },
    p = { "<cmd> require('gitsigns').preview_hunk()<cr>", "Preview Hunk" },
    b = { "<cmd> require('gitsigns').blame_line()<cr>", "Blame Line" },
    f = { "<cmd> require('gitsigns').diffthis('~1')<cr>", "Diff This" },
    n = { "<cmd> require('gitsigns').next_hunk()<cr>", "Blame Line" },
  }
}, { prefix = "<leader>" })

-- LssagaA
wk.register({
  l = {
    name = "Lspsaga",
    c = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    o = { "<cmd>Lspsaga outline<cr>", "Outline" },
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },
    d = { "<cmd>Lspsaga goto_definition<cr>", "Lsp GoTo Definition" },
    f = { "<cmd>Lspsaga finder<cr>", "Lsp Finder" },
    p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
    s = { "<cmd>Lspsaga signature_help<cr>", "Signature Help" },
    w = { "<cmd>Lspsaga show_workspace_diagnostics<cr>", "Show Workspace Diagnostics" },
  }
}, { prefix = "<leader>" })

local function visual_cursors_with_delay()
  -- Execute the vm-visual-cursors command.
  vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
  -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
  vim.cmd('sleep 200m')
  -- Press 'A' in normal mode after the delay.
  vim.cmd('silent! execute "normal! A"')
end

-- visual-multi
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
