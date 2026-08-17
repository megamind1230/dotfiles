-- if true then return {} end --for turning off files .. so the following is not executed
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-orgmode/orgmode",
  "https://github.com/nvim-orgmode/org-bullets.nvim",
  "https://github.com/chipsenkbeil/org-roam.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("orgmode").setup({
  org_agenda_files = "~/orgfiles/**/*",
  org_default_notes_file = "~/orgfiles/refile.org",
})

require("org-bullets").setup()

require("org-roam").setup({
  directory = "~/orgfiles/roam",
  org_files = {
    "~/orgfiles/**/*",
  },
})