vim.o.swapfile = false
vim.opt.number = true
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 10
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
-- vim.opt.signcolumn = "no"
vim.opt.fillchars:append({ eob = " " })
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.diagnostic.config({ virtual_text = true, severity_sort = true, signs = true, underline = true })
vim.lsp.inlay_hint.enable(true, { bufnr = 0 })

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.cmdheight = 0
-- vim.opt.guicursor = ""
vim.opt.undofile = true -- BIG ONE solves a lot of my problems

vim.api.nvim_create_autocmd("FileType", {
	-- If you have a specific pattern here, you can remove it or keep it as "*"
	callback = function(args)
		-- 1. Resolve the filetype to its associated Tree-sitter language name
		local lang = vim.treesitter.language.get_lang(args.match)

		-- 2. Verify if the parser actually exists and is loadable
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
		end
	end,
})
