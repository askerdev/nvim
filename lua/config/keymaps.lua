local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local dmap = vim.keymap.del

map("i", "jk", "<ESC>", opts)
dmap("t", "<C-h>")
dmap("t", "<C-j>")
dmap("t", "<C-k>")
dmap("t", "<C-l>")
