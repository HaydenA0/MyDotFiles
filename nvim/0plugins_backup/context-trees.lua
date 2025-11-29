return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			max_lines = 3, -- How many lines of context to show
			min_window_height = 20, -- Don't show context in small windows
		},
	},
}
