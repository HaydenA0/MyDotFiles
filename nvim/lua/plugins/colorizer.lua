return {
	"brenoprata10/nvim-highlight-colors",
	event = "BufReadPre", -- or "VeryLazy"
	config = function()
		vim.opt.termguicolors = true
		require("nvim-highlight-colors").setup({
			render = "background", -- options: "background", "foreground", "virtual"
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_ansi = true,
			enable_var_usage = true,
			enable_named_colors = true,
			enable_tailwind = true,
			exclude_filetypes = {},
			exclude_buftypes = {},
		})
	end,
}
