-- return {
-- 	"olimorris/codecompanion.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"nvim-treesitter/nvim-treesitter",
-- 	},
-- 	opts = {
-- 		adapters = {
-- 			http = {
-- 				opts = { show_presets = false },
-- 				-- 1. The Smart 70B Model (For complex logic)
-- 				groq_70b = function()
-- 					return require("codecompanion.adapters").extend("openai_compatible", {
-- 						name = "groq_70b",
-- 						env = {
-- 							url = "https://api.groq.com/openai",
-- 							api_key = "GROQ_API_KEY",
-- 							chat_url = "/v1/chat/completions",
-- 						},
-- 						schema = { model = { default = "llama-3.3-70b-versatile" } },
-- 					})
-- 				end,
--
-- 				-- 2. The 17B Scout Model (For large files - HIGH RATE LIMIT)
-- 				groq_scout_17b = function()
-- 					return require("codecompanion.adapters").extend("openai_compatible", {
-- 						name = "groq_scout_17b",
-- 						env = {
-- 							url = "https://api.groq.com/openai",
-- 							api_key = "GROQ_API_KEY",
-- 							chat_url = "/v1/chat/completions",
-- 						},
-- 						schema = { model = { default = "meta-llama/llama-4-scout-17b-16e-instruct" } },
-- 					})
-- 				end,
--
-- 				-- 3. The Qwen Coding Specialist (For small snippets)
-- 				groq_qwen_32b = function()
-- 					return require("codecompanion.adapters").extend("openai_compatible", {
-- 						name = "groq_qwen_32b",
-- 						env = {
-- 							url = "https://api.groq.com/openai",
-- 							api_key = "GROQ_API_KEY",
-- 							chat_url = "/v1/chat/completions",
-- 						},
-- 						schema = { model = { default = "qwen/qwen3-32b" } },
-- 					})
-- 				end,
-- 			},
-- 		},
-- 		display = {
-- 			action_palette = {
-- 				provider = "telescope",
-- 			},
-- 		},
-- 		interactions = {
-- 			-- Set Scout 17B as default so you don't accidentally burn your 70B daily limits
-- 			chat = { adapter = "groq_scout_17b" },
-- 			inline = { adapter = "groq_scout_17b" },
-- 		},
-- 	},
-- }
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
