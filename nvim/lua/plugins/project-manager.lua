return {
	{
		"DrKJeff16/project.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern" },
				patterns = { "^src", ">Projects", ".git", "Makefile", "package.json" },
			})
		end,
	},
}
