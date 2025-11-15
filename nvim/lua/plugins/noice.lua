return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		cmdline = {
			enabled = true,
			view = "cmdline_popup",
			opts = {},
		},
		messages = {
			enabled = false,
		},
		presets = {
			bottom_search = false,
			command_palette = true,
		},
		views = {
			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					min_width = 60,
					width = "auto",
					height = "auto",
				},
				border = {
					style = "rounded",
					padding = { 1, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "None" },
				},
			},
		},
	},
}
