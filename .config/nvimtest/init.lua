vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("colorscheme")

vim.api.nvim_create_autocmd("PackChanged", { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "nvim-treesitter" and kind == "update" then
    if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
    vim.cmd("TSUpdate")
  end
end })

require("plugins.orgmode")
require("plugins.telescope")
require("plugins.dotnet")

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- floating terminal
local floaty = require("plugins.floaty.lua.floaty")
vim.keymap.set('n', '<C-`>', function() floaty.toggle() end, { desc = 'Toggle floating terminal' })
vim.keymap.set('n', '<leader>tt', function() floaty.toggle() end, { desc = 'Toggle floating terminal' })
vim.keymap.set('n', '<F12>', function() floaty.toggle() end, { desc = 'Toggle floating terminal' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
