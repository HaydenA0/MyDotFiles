return {
	"echasnovski/mini.surround",
	config = function()
		require("mini.surround").setup({
			mappings = {
				add = "sr", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sc", -- Replace surrounding (change)
				update_n_lines = "sn", -- Update `n_lines`
			},
		})
	end,
}
