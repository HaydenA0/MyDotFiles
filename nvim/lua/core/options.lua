-- General editor options
vim.o.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.signcolumn = "no"
vim.opt.fillchars:append({ eob = " " })
vim.opt.guicursor = "n-v-c-i:block"
vim.opt.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 250
vim.o.conceallevel = 2
vim.o.concealcursor = "nc"
vim.opt.cmdheight = 0 -- Hide command line unless in use
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- Diagnostic configuration
vim.diagnostic.config({
	virtual_text = {
		severity_min = vim.diagnostic.severity.WARN,
	},
	severity_sort = true,
})
vim.opt.numberwidth = #tostring(vim.fn.line("$")) + 1
