return {
	"stevearc/oil.nvim",
	opts = {
		columns = { "permissions", "size", "ctime" },
		keymaps = {
			["<M-h>"] = "actions.parent",
			["<M-l>"] = "actions.select",
		},
		skip_confirm_for_simple_edits = true,
		default_file_explorer = true,
		view_options = {
			show_hidden = true, -- initially hidden
			is_hidden_file = function(name, bufnr)
				return name:match("^%.") ~= nil
			end,
		},
	},
	dependencies = {},
	lazy = false,
	config = function(_, opts)
		local oil = require("oil")
		oil.setup(opts)

		-- Keybinding to toggle hidden files
		vim.keymap.set("n", "zh", function()
			oil.toggle_hidden()
		end, { desc = "Toggle hidden files in Oil" })
		vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open Oil file explorer" })
	end,
}
