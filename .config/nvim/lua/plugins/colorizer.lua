-- if true then return {} end --for turning off files .. so the following is not executed
vim.pack.add({ 'https://github.com/norcalli/nvim-colorizer.lua' })

-- highlights color codes (e.g. #ff0000) in buffers
require('colorizer').setup()