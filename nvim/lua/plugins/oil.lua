return {
	"stevearc/oil.nvim",
	opts = {
		columns = { "permissions", "size", "icon" },
		keymaps = {
			["<M-h>"] = "actions.parent",
			["<M-l>"] = "actions.select",
			-- CHANGE THIS LINE: from "<A-CR>" to "<T-CR>"
		},
		skip_confirm_for_simple_edits = true,
		default_file_explorer = true,
		view_options = {
			show_hidden = false, -- initially hidden
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

		vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open Oil file explorer" })

		-- Keybinding to toggle hidden files
		vim.keymap.set("n", "zh", function()
			oil.toggle_hidden()
		end, { desc = "Toggle hidden files in Oil" })
	end,
}
