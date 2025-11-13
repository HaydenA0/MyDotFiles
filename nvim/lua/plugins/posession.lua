return {
	"jedrzejboczar/possession.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local possession = require("possession")

		possession.setup({
			session_dir = vim.fn.stdpath("data") .. "/possession",
			autosave = {
				current = false,
				cwd = false,
				tmp = false,
				on_load = false,
				on_quit = false,
			},
			autoload = false,
			commands = {
				save = "PossessionSave",
				load = "PossessionLoad",
				save_cwd = "PossessionSaveCwd",
				load_cwd = "PossessionLoadCwd",
				rename = "PossessionRename",
				close = "PossessionClose",
				delete = "PossessionDelete",
				show = "PossessionShow",
				pick = "PossessionPick",
				list = "PossessionList",
				list_cwd = "PossessionListCwd",
			},
		})

		-- key mapping
		vim.keymap.set("n", "<leader>m", function()
			vim.cmd("PossessionPick")
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>s", function()
			vim.cmd("PossessionSave")
		end, { noremap = true, silent = true })
	end,
}
