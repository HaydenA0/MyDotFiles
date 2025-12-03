return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = false,
		opts = {},
		config = function()
			require("refactoring").setup({

				prompt_func_return_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
				},

				prompt_func_param_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
				},
			})
			vim.keymap.set("x", "<leader>o", ":Refactor extract ")
		end,
	},
}
