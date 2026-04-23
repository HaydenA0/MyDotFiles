return {
	"jpalardy/vim-slime",
	vim.keymap.set({ "n", "x" }, "<leader>tt", ":SlimeSend<CR>", { desc = "Slime: Send to tmux" }),
	init = function()
		vim.g.slime_target = "tmux"
		vim.g.slime_default_config = {
			socket_name = "default",
			target_pane = "{last}",
		}

		vim.g.slime_no_mappings = true
	end,
}
