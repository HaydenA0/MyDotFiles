return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.api.nvim_set_hl(0, "OilDir", { fg = "#ebcb8b", bold = true })

		require("oil").setup({
			columns = { "permissions", "size", "ctime", "icon" },
			win_options = {
				winbar = "%#OilDir# %{v:lua.require('oil').get_current_dir()}",
			},
			keymaps = {
				["<M-h>"] = "actions.parent",
				["<M-l>"] = "actions.select",
				["!"] = {
					desc = "Run shell command",
					callback = function()
						local dir = require("oil").get_current_dir()
						vim.ui.input({ prompt = "Shell Command: " }, function(input)
							if input and input ~= "" then
								-- Run command synchronously
								vim.fn.system(string.format("cd %s && %s", vim.fn.shellescape(dir), input))
								-- Force refresh by re-editing the buffer
								vim.cmd("edit")
								print("Command executed and Oil refreshed")
							end
						end)
					end,
				},
			},
			view_options = { show_hidden = true },
		})
	end,
}
