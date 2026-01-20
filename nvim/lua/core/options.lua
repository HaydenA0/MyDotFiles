vim.o.swapfile = false
vim.opt.number = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.signcolumn = "no"
vim.opt.fillchars:append({ eob = " " })
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.diagnostic.config({ virtual_text = true, severity_sort = true, signs = true, underline = true })
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
	tab = "··",
	trail = " ",
	extends = ">",
	precedes = "<",
	space = "·",
}
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.opt_local.errorformat = "%f|%l col %c|%m"
-- 	end,
-- })
vim.opt.laststatus = 3
vim.opt.errorformat = [=[%f:%l:%c:%m,%f:%l:%m,%f:%l,%-G%.%]=]
vim.opt.errorformat:append([[ %f:%l:%c:%m ]])
vim.opt.errorformat:append([[ %f:%l:%m ]])
vim.opt.errorformat:append([[ %f:%l ]])
