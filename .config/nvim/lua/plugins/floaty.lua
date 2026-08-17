-- if true then return {} end --for turning off files .. so the following is not executed
-- floaty is a LOCAL plugin (lives in this repo) .. no vim.pack.add() needed
local floaty = require('plugins.floaty.lua.floaty')

-- keymaps
vim.keymap.set('n', '<leader>tt', function()
  floaty.toggle()
end, { desc = 'Toggle floating terminal' })

vim.keymap.set('n', '<C-`>', function()
  floaty.toggle()
end, { desc = 'Toggle floating terminal' })

vim.keymap.set('n', '<F12>', function()
  floaty.toggle()
end, { desc = 'Toggle floating terminal' })

-- Double Esc (safer - first Esc goes to the program, second exits terminal mode)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Or Ctrl-o (like in insert mode)
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })