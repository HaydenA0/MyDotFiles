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
vim.opt.cmdheight = 0
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

-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	buffer = bufnr,
-- 	callback = function()
-- 		local opts = {
-- 			focusable = false,
-- 			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
-- 			border = "rounded",
-- 			source = "always",
-- 			prefix = " ",
-- 			scope = "cursor",
-- 		}
-- 		vim.diagnostic.open_float(nil, opts)
-- 	end,
-- })
--
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#5c6370", italic = true })
vim.opt.showmode = false
