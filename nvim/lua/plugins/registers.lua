return {
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			-- you'll need at least one of these
			{ "nvim-telescope/telescope.nvim" },
			-- {'ibhagwan/fzf-lua'},
		},
		config = function()
			require("neoclip").setup({
				history = 1000,
				enable_persistent_history = true,
				keys = {},
			})
			vim.keymap.set("n", "<leader><leader>r", "<cmd>Telescope neoclip<CR> ", { noremap = true })
		end,
	},

	-- SQLITE

	{
		"kkharji/sqlite.lua",
	},
}
