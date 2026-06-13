return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.api.nvim_set_hl(0, "OilDir", { fg = "#ebcb8b", bold = true })

		require("oil").setup({
			-- columns = { "permissions", "size", "ctime", "icon" },
			columns = { "size" },
			win_options = {
				winbar = "%#OilDir# %{v:lua.require('oil').get_current_dir()}",
			},
			-- Automatically save buffers updated with LSP willRenameFiles (e.g. updating imports)
			lsp_file_methods = {
				autosave_changes = "unmodified", -- Or true to save regardless of status
			},
			keymaps = {
				["<C-p>"] = false,
				["<M-h>"] = "actions.parent",
				["<M-l>"] = "actions.select",
				["!"] = {
					desc = "Run shell command",
					callback = function()
						local dir = require("oil").get_current_dir()
						vim.ui.input({ prompt = "Shell Command: " }, function(input)
							if input and input ~= "" then
								vim.fn.system(string.format("cd %s && %s", vim.fn.shellescape(dir), input))
								vim.cmd("edit")
								print("Command executed and Oil refreshed")
							end
						end)
					end,
				},
			},
			view_options = { show_hidden = true },
		})
		vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open Oil in float" })
	end,
}
