return {
  dir = "~/.config/nvimtest/lua/plugins/floaty/",
  config = function()
    vim.keymap.set('n', '<leader>tt', function()
      require('plugins.floaty.lua.floaty').toggle()
    end, { desc = 'Toggle floating terminal' })

    vim.keymap.set('n', '<C-`>', function()
      require('plugins.floaty.lua.floaty').toggle()
    end, { desc = 'Toggle floating terminal' })

    vim.keymap.set('n', '<F12>', function()
      require('plugins.floaty.lua.floaty').toggle()
    end, { desc = 'Toggle floating terminal' })
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  end
}
