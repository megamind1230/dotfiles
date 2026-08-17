-- if true then return {} end --for turning off files .. so the following is not executed
vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-orgmode/telescope-orgmode.nvim",
})

local telescope = require("telescope")
telescope.setup()
telescope.load_extension("orgmode")