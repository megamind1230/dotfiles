-- if true then return {} end --for turning off files .. so the following is not executed
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require("mini.jump2d").setup() --ok .. trigger with enter
require("mini.ai").setup() -- ok .. works
require("mini.move").setup() -- ok .. works
require("mini.pairs").setup() -- ok .. works
require("mini.surround").setup() --ok ..works
-- require("mini.animate").setup() --ok ..works { gets me dizzy }