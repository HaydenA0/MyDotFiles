return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local open_in_oil = function(prompt_bufnr)
			local entry = action_state.get_selected_entry()
			actions.close(prompt_bufnr)
			local path = entry.path or entry.filename
			local dir = vim.fn.fnamemodify(path, ":h")
			require("oil").open(dir)
		end

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<M-e>"] = open_in_oil,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<M-e>"] = open_in_oil,
					},
				},
			},
		})

		pcall(telescope.load_extension, "fzf")

		local keymap = vim.keymap.set

		keymap("n", "<C-p>", function()
			local ok = pcall(require("telescope.builtin").git_files)
			if not ok then
				require("telescope.builtin").find_files()
			end
		end, { desc = "Find Project Files" })

		keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find Recent Files" })

		keymap("n", "<leader>fc", function()
			require("telescope.builtin").find_files({
				prompt_title = "Config Files",
				cwd = vim.fn.expand("~/.config"),
			})
		end, { desc = "Find Config Files" })

		keymap("n", "<leader>j", function()
			local results = vim.fn.systemlist("zoxide query -l")
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Teleport (Zoxide)",
					finder = require("telescope.finders").new_table({ results = results }),
					sorter = require("telescope.config").values.generic_sorter({}),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							require("oil").open(selection[1])
						end)
						return true
					end,
				})
				:find()
		end, { desc = "Zoxide Teleport" })

		keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find by Grep" })
		keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
	end,
}
