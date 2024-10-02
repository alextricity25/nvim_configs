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
wk.add({
  { "<leader>m", group = "Visual Multi" },
  { "<leader>mm", "<Plug>(VM-Find-Under)<Tab>", desc = "Start Multiple Cursors" },
  { "<leader>ma", "<Plug>(VM-Select-All)<Tab>", desc = "Select All" },
  { "<leader>mr", "<Plug>(VM-Start-Regex-Search)", desc = "Start Regex Search" },
  { "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", desc = "Add Cursor At Pos" },
  { "<leader>mu", "<Plug>(VM-Add-Cursor-Up)", desc = "Add Cursor Up" },
  { "<leader>md", "<Plug>(VM-Add-Cursor-Down)", desc = "Add Cursor Down" },
  { "<leader>mv", visual_cursors_with_delay(), desc = "Visual Cursors" },
  { "<leader>mt", "<Plug>(VM-Toggle-Multiline)", desc = "Toggle Multiline" },
  { "<leader>mo", "<Plug>(VM-Toggle-Mappings)", desc = "Toggle Mapping" },
})
