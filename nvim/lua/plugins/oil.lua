return {
	"stevearc/oil.nvim",
	opts = {
		columns = { "permissions", "size", "ctime" , "icon"},
                keymaps = {
                  ["<M-h>"] = "actions.parent",
                  ["<M-l>"] = "actions.select",
                  ["<C-s>"] = {},
                  ["<C-h>"] = {},
                  ["<C-t>"] = {},
                  ["<C-p>"] = {},
                  ["<C-c>"] = {},
                  ["<C-l>"] = {},
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
	-- config = function()
	-- end,
        vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open Oil file explorer" })
}
