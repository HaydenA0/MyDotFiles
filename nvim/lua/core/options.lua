vim.o.swapfile = false
vim.opt.number = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
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
vim.opt.cmdheight = 0
vim.opt.guicursor = ""
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		-- Check if a treesitter parser exists for this filetype
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if lang then
			-- Start treesitter; pcall prevents errors on unsupported files
			pcall(vim.treesitter.start, bufnr, lang)
		end
	end,
})
