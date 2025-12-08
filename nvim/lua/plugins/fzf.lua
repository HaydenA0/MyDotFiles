return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	---@module "fzf-lua"
	---@type fzf-lua.Config|{}
	---@diagnostics disable: missing-fields
	opts = {},
	---@diagnostics enable: missing-fields
	config = function()
		require("fzf-lua").setup({
			{ "skim" },
			winopts = {
				split = "belowright new",
				border = "none",
				preview = {
					hidden = true,
				},
			},
			-- actions = {},
			fzf_opts = {},
			fzf_colors = {},
			hls = {},
			keymap = {},
		})
		local keymap = vim.keymap.set
		keymap("n", "<C-p>", "<cmd>FzfLua files<CR>")
		keymap("n", "<leader>r", "<cmd>FzfLua oldfiles<CR>")
		keymap("n", "<leader>g", "<cmd>FzfLua live_grep<CR>")
		keymap("n", "<leader>\\", "<cmd>FzfLua buffers<CR>")
		keymap("n", "<leader>fr", "<cmd>FzfLua registers<CR>")
		keymap("n", "<leader>fc", "<cmd>FzfLua files cwd=~/.config<CR>")
	end,
}
