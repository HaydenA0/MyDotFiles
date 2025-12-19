return {
	"kylechui/nvim-surround",
	version = "*",
	config = function()
		require("nvim-surround").setup({})

		vim.keymap.set("v", "w", "<Plug>(nvim-surround-visual)", {
			desc = "Surround selection with 'w'",
		})
	end,
}
