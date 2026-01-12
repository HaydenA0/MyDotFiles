vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "oil://*",
	callback = function()
		local dir = require("oil").get_current_dir()
		if dir then
			vim.fn.chdir(dir)
		end
	end,
})
