local set = vim.opt

set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.autoindent = true

set.wrap = false

set.number = true
set.relativenumber = true

set.showmode = false
set.breakindent = true

set.ignorecase = true
set.smartcase = true

set.backspace = "indent,eol,start"

set.termguicolors = true
set.signcolumn = "yes:1"
set.background = "dark"

set.splitright = true
set.splitbelow = true

set.swapfile = false
set.scrolloff = 10

set.colorcolumn = "80"

vim.diagnostic.config({
	virtual_text = false,
	float = {
		border = "rounded",
	},
})
