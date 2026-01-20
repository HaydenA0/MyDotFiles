return {
	-- {
	-- 	"zenbones-theme/zenbones.nvim",
	-- 	dependencies = "rktjmp/lush.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.zenbones_darken_comments = 45
	-- 		vim.cmd.colorscheme("zenbones")
	-- 	end,
	-- },
	{
		"aktersnurra/no-clown-fiesta.nvim",
		opts = {
			styles = {
				keywords = { bold = true },
				functions = { bold = true },
				variables = {},
			},
		},

		config = function()
			require("no-clown-fiesta").setup({
				theme = "dark", -- supported themes are: dark, dim, light
				transparent = true,
			})
			vim.cmd([[colorscheme no-clown-fiesta]])
		end,
	},
	-- {
	-- 	"vague-theme/vague.nvim",
	-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	-- 	priority = 1000, -- make sure to load this before all the other plugins
	-- 	config = function()
	-- 		require("vague").setup({
	-- 			-- optional configuration here
	-- 		})
	-- 		vim.cmd("colorscheme vague")
	-- 	end,
	-- },
	{
		"xiyaowong/transparent.nvim",
	},
}


