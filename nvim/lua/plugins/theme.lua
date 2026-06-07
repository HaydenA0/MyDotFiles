return {

	--
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine")
			require("rose-pine").setup({
				variant = "moon",
				dark_variant = "moon",
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true,
					migrations = true,
				},

				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
	},
}
