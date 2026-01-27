return {
  -- {
    dir = "~/.config/nvim/lua/plugins/floaty/"
  -- },
  ,
  config = function()
    -- Create a keymap to toggle the floating terminal
    vim.keymap.set('n', '<leader>tt', function()
      require('plugins.floaty.lua.floaty').toggle()
    end, { desc = 'Toggle floating terminal' })

    -- Or use a simpler key like Ctrl+`
    vim.keymap.set('n', '<C-`>', function()
      require('plugins.floaty.lua.floaty').toggle()
    end, { desc = 'Toggle floating terminal' })

    -- Alternative: F12
    vim.keymap.set('n', '<F12>', function()
      require('plugins.floaty.lua.floaty').toggle()
    end, { desc = 'Toggle floating terminal' })
    -- Double Esc (safer - first Esc goes to the program, second exits terminal mode)
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

    -- Or Ctrl-o (like in insert mode)
    vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  end
}
