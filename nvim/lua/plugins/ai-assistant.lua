return {
	"nickjvandyke/opencode.nvim",
	version = "*", -- Latest stable release
	dependencies = {
		{
			-- `snacks.nvim` integration is recommended, but optional
			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {}, -- Enhances `ask()`
				picker = { -- Enhances `select()`
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		vim.api.nvim_create_autocmd("FileChangedShell", {
			group = vim.api.nvim_create_augroup("OpencodeConflictResolver", { clear = true }),
			pattern = "*",
			callback = function()
				if vim.v.fcs_reason == "conflict" then
					-- Suppress the default Neovim "Load/Write" dialog
					vim.v.fcs_choice = ""

					vim.schedule(function()
						local choice = vim.fn.confirm(
							"File changed on disk (AI) & modified in buffer (You)!\nChoose how to resolve:",
							"&Merge (Side-by-Side)\n&Load AI Changes (Discard Mine)\n&Keep Mine (Overwrite AI)",
							1
						)

						if choice == 1 then
							-- Store the buffer and path of the file we are editing
							local orig_buf = vim.api.nvim_get_current_buf()
							local file_path = vim.api.nvim_buf_get_name(orig_buf)

							-- Open a new vertical split for the AI's disk changes
							vim.cmd("vert new")
							local temp_buf = vim.api.nvim_get_current_buf()
							vim.bo[temp_buf].buftype = "nofile"
							vim.bo[temp_buf].bufhidden = "wipe"
							vim.bo[temp_buf].swapfile = false

							-- Read the AI's disk file into this temporary buffer
							vim.cmd("r " .. vim.fn.fnameescape(file_path))
							vim.cmd("0d_") -- Remove the blank first line

							-- Set both windows to diff mode
							vim.cmd("diffthis")
							vim.cmd("wincmd p")
							vim.cmd("diffthis")

							vim.notify(
								"Merge mode active!\nLeft: AI edits on disk.\nRight: Your unsaved edits.\nUse dp/do to merge, then save (:w) the right window.",
								vim.log.levels.WARN,
								{ title = "OpenCode Merge" }
							)
						elseif choice == 2 then
							-- Reload from disk, losing your manual buffer edits
							vim.cmd("edit!")
							vim.notify("Discarded your manual changes and loaded AI edits.", vim.log.levels.INFO)
						elseif choice == 3 then
							-- Force write your buffer edits, overwriting the AI disk changes
							vim.cmd("write!")
							vim.notify("Overwrote AI changes with your buffer edits.", vim.log.levels.INFO)
						end
					end)
				end
			end,
		})

		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any; goto definition on the type or field for details
		}

		vim.o.autoread = true -- Required for `opts.events.reload`

		-- Recommended/example keymaps
		vim.keymap.set({ "n", "x" }, "<C-a>", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set({ "n", "x" }, "<C-x>", function()
			require("opencode").select()
		end, { desc = "Select opencode…" })
		vim.keymap.set({ "n", "t" }, "<C-.>", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })

		vim.keymap.set({ "n", "x" }, "go", function()
			return require("opencode").operator("@this ")
		end, { desc = "Add range to opencode", expr = true })
		vim.keymap.set("n", "goo", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Add line to opencode", expr = true })

		vim.keymap.set("n", "<S-C-u>", function()
			require("opencode").command("session.half.page.up")
		end, { desc = "Scroll opencode up" })
		vim.keymap.set("n", "<S-C-d>", function()
			require("opencode").command("session.half.page.down")
		end, { desc = "Scroll opencode down" })

		-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
	end,
}
