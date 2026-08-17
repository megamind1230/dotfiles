-- ==================================================
-- JOURNAL nvim config  (plugin manager: builtin vim.pack)
-- ==================================================
-- to disable any plugin .. just open its file in lua/plugins/ ..
-- and uncomment the `if true then return {} end` line at the top of that file
-- (or comment out its require() line here in init.lua)
--
-- plugins are declared + configured in lua/plugins/*.lua
-- (vim.pack.add() + require(...).setup(...)) .. every file is one feature block

vim.g.mapleader = " " -- <leader> as space
vim.g.maplocalleader = " "

require("options")     -- all nvim options live here
require("keymaps")     -- keymaps
require("colorscheme") -- colorscheme

-- plugins (features) .. each file = one feature block, toggleable
require("plugins.orgmode")   -- org-mode: agenda, bullets, roam
require("plugins.telescope") -- fuzzy finder in nvim
require("plugins.dotnet")    -- easy-dotnet: build/test/run for C#
require("plugins.twilight")  -- dim everything except current code
require("plugins.lualine")   -- statusline
require("plugins.oilnvim")   -- file explorer in a floating window
require("plugins.floaty")    -- floating terminal + its keymaps
require("plugins.mini-nvim") -- mini.nvim modules: jump2d/ai/move/pairs/surround
require("plugins.colorizer") -- highlight color codes

-- extras.lua is a documentation/archive file (all commented) .. not a plugin, intentionally not required

-- auto-update nvim-treesitter right after a pack update
vim.api.nvim_create_autocmd("PackChanged", { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "nvim-treesitter" and kind == "update" then
    if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
    vim.cmd("TSUpdate")
  end
end })

-- start treesitter on every buffer (parsers we have)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})