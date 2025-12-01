return {
	"szw/vim-maximizer",
	config = function()
		vim.keymap.set("n", "<leader><leader>", "<cmd>MaximizerToggle<CR>")
	end,
}
