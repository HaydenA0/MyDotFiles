return {

	{
		"vague-theme/vague.nvim",
		config = function()
			vim.cmd.colorscheme("vague")
			require("vague").setup({
				transparent = true,
				bold = true,
				italic = false,
			})
		end,
	},

	{
		"xiyaowong/transparent.nvim",
	},
}
