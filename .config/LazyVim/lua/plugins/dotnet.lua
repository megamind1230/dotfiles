return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("easy-dotnet").setup({
        lsp = { enabled = true },
      })
    end,
  },
}
