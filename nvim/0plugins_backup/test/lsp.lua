return {
	{
		"junnplus/lsp-setup.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		opts = {

			inlay_hints = {
				enabled = true,
			},

			mappings = {

				-- ["grn"] = { cmd = vim.lsp.buf.rename, opts = { desc = "LSP Rename Symbol" } },

				["<C-s>"] = { cmd = vim.diagnostic.open_float, opts = { desc = "Show line diagnostics" } },

				["<leader>ca"] = { cmd = vim.lsp.buf.code_action, opts = { desc = "Code Action" } },

				["<leader>dl"] = { cmd = vim.diagnostic.setloclist, opts = { desc = "Show buffer diagnostics list" } },
			},

			servers = {
				lua_ls = {},
				pyright = {},
				clangd = {

					cmd = { "clangd", "--inlay-hints=true" },
				},
			},
		},
	},
}
