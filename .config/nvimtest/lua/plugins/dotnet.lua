vim.pack.add({
  "https://github.com/GustavEikaas/easy-dotnet.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("easy-dotnet").setup({
  lsp = {
    enabled = true,
  },
  debugger = {
    enabled = false,
  },
  test_runner = {
    auto_start_testrunner = false,
  },
})
