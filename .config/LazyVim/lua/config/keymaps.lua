-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local floaty = require("floaty")

vim.keymap.set("n", "<C-`>", floaty.toggle, { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<leader>tt", floaty.toggle, { desc = "Toggle floating terminal" })
vim.keymap.set("n", "<F12>", floaty.toggle, { desc = "Toggle floating terminal" })

-- Double Esc (safer - first Esc goes to the program, second exits terminal mode)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Or Ctrl-o (like in insert mode)
vim.keymap.set("t", "<C-o>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
