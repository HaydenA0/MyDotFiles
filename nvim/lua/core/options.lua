vim.g.mapleader = " "
vim.o.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.signcolumn = "no"
vim.opt.fillchars:append({ eob = " " })
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	signs = true,
	underline = true,
})
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.sta = true -- tabs
vim.opt.smoothscroll = true -- scroll
