vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.keymap.set("i", "jk", "<ESC>")

vim.keymap.set("n", "<space>xx", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<C-t>h", ":tabprev<CR>", { desc = "Previous tab", silent = true })
vim.keymap.set("n", "<C-t>l", ":tabnext<CR>", { desc = "Next tab", silent = true })
vim.keymap.set("n", "<C-t>q", ":tabclose<CR>", { desc = "Close tab", silent = true })
vim.keymap.set("n", "<C-t>n", ":tabnew<CR>", { desc = "New tab", silent = true })
