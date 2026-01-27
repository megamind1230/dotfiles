--keymaps
local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "esc" }) --esc
map("n", "<leader>x", ":bd<Cr>", { desc = "delete current buffer" })
map("n", "<leader>pv", ":Ex<Cr>", { desc = "Netrw" }) --netrw
map("n", "-", ":Ex<Cr>", { desc = "Netrw" }) --netrw
map("n", "=", ":Vex<Cr>", { desc = "Netrw" }) --netrw
map("n", "<leader>e", ":Oil<Cr>", { desc = "Netrw" }) --oilnvim
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "no highlight" })
map("n", "H", "g^", { desc = "start of line" })
map("n", "L", "g$", { desc = "end of line" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down (visual)" }) -- Move selected lines DOWN (J)
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up (visual)" }) -- Move selected lines UP (K)

-- map({ "n", "x" }, "gy", '"+y', { desc = "Copy to clipboard" })
-- map({ "n", "x" }, "gp", '"+p', { desc = "Paste clipboard text" })
-- map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
-- map("n", "<leader>q", "<cmd>quitall<cr>", { desc = "Exit vim" })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map('i', '<C-Del>', '<C-o>dw', { noremap = true, silent = true, desc = "del word after..insert mode"}) --oppo of: ctrl w
map('i', '<C-l>', '<C-o>x', { noremap = true, silent = true, desc = "del word after..insert mode"}) --oppo of: ctrl h
map("n","YK", "va{OVy", {desc = "yank func on KnR indenting style"}) --yank knr func
-- map("n","YA", "va{OjVy", {desc = "yank func on Allman indenting style"}) -- yank allman func --doesnt work somehow, just J on func to convert to KnR
map("n","<leader>nv", ":e $HOME/.config/nvim<Cr>", {desc = "go config"}) --go config default nvim
-- map("n","<leader>nv", ":e $HOME/.config/one<Cr>", {desc = "go config"}) --go config one
-- map("n","<leader>nv", ":e $HOME/.config/two<Cr>", {desc = "go config"}) --go config two


    -- -- Center screen when jumping
-- vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
--
    -- -- Better paste behavior
-- vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
--
    -- -- Delete without yanking
-- vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
--
    -- -- Buffer navigation
-- vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
--
    -- -- Better window navigation
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
--
    -- -- Splitting & Resizing
-- vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
-- vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
-- vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })
--
    -- -- Move lines up/down
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
--
    -- -- Better indenting in visual mode
-- vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
-- vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
--
    -- -- Quick file navigation
-- vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
-- vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })
--
    -- -- Better J behavior
-- vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

