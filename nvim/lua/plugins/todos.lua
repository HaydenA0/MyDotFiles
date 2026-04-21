return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>"),
		vim.keymap.set("n", "<leader>tq", ":TodoQuickFix<CR>"),

		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
