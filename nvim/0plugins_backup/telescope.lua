return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				pickers = {
					find_files = { theme = "ivy" },
					buffers = { theme = "ivy" },
					oldfiles = { theme = "ivy" },
				},
			})

			vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files in current directory" })

			vim.keymap.set("n", "<leader>fh", function()
				builtin.find_files({ cwd = vim.env.HOME })
			end, { desc = "Find files in home" })

			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({ cwd = vim.env.HOME .. "/.config" })
			end, { desc = "Find files in ~/.config/" })

			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })

			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open buffers" })

			vim.keymap.set("n", "<leader>fg", function()
				builtin.live_grep({ cwd = vim.loop.cwd() })
			end, { desc = "Live grep in current directory" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- Calling setup should be inside the config function.
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						-- The get_dropdown function already returns a table,
						-- so you don't need to wrap it in another one.
						-- You also had a typo here ("themes" was missing the 's')
						require("telescope.themes").get_dropdown({
							-- You can add options for the dropdown theme here
						}),
					},
				},
			})

			-- Loading the extension must also be inside the config function.
			require("telescope").load_extension("ui-select")
		end,
	},
}
