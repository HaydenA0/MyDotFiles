return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		-- "nvim-tree/nvim-web-devicons",  -- or 'echasnovski/mini.icons'
	},
	cmd = "Spectre",
	keys = {
		{
			"<leader>S",
			function()
				require("spectre").toggle()
			end,
			desc = "Toggle Spectre",
		},
		{
			"<leader>sw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Search current word (visual or normal mode)",
		},
		{
			"<leader>sp",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "Search in current file",
		},
	},
	opts = {
		-- example custom config
		-- default = {
		--   replace = { cmd = "oxi" },
		-- }
	},
}
