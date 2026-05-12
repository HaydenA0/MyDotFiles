return {
	-- Using Lazy
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker",
			})
			require("onedark").load()
		end,
	},

	-- {
	-- 	"vague-theme/vague.nvim",
	-- 	config = function()
	-- 		vim.cmd.colorscheme("vague")
	-- 		require("vague").setup({
	-- 			transparent = true,
	-- 			bold = true,
	-- 			italic = false,
	-- 		})
	-- 	end,
	-- },

	{
		"xiyaowong/transparent.nvim",
	},
}
