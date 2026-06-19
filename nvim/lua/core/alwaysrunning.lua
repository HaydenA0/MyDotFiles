vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "oil://*",
	callback = function()
		local dir = require("oil").get_current_dir()
		if dir then
			vim.fn.chdir(dir)
		end
	end,
})
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! update")
		end
	end,
})
