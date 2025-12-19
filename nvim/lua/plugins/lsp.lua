return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = { "lua_ls", "clangd" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		config = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<C-s>", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Show buffer diagnostics list" })
			vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP Rename Symbol" })

			-- NOTE : this if for love2d

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "love" },
						},
						workspace = {
							library = {
								vim.fn.expand("~/.local/share/lua-love2d"),
							},
							checkThirdParty = false,
						},
					},
				},
			})
			-- tell Neovim how to *connect* to Godot’s built-in language server
			vim.lsp.config("gdscript", {
				cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
				filetypes = { "gd", "gdscript", "gdscript3" },
				root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
			})

			-- enable the config so it will attach automatically
			vim.lsp.enable("gdscript")

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("clangd")
			vim.lsp.enable("pyrefly")
		end,
	},
}
