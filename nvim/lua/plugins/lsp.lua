return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		vim.filetype.add({
			extension = {
				hlsl = "hlsl",
			},
		})

		require("mason").setup()

		local to_install = { "lua_ls", "clangd", "pyright", "gopls", "rust_analyzer", "gdscript" }
		local keymap = vim.keymap.set

		keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local opts = { buffer = args.buf }
				keymap("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "LSP Definition" })
				keymap("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf, desc = "LSP Declaration" })
				keymap("n", "gi", vim.lsp.buf.implementation, { buffer = args.buf, desc = "LSP Implementation" })
				keymap("n", "grn", function()
					vim.lsp.buf.rename()
					-- Wait briefly for the LSP to apply changes, then write all modified buffers
					vim.defer_fn(function()
						vim.cmd("silent! wa")
					end, 100)
				end, { buffer = args.buf, desc = "LSP Rename & Save All" })
			end,
		})

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_filter(function(v)
				return v ~= "gdscript"
			end, to_install),
		})

		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			filetypes = { "gd", "gdscript", "gdscript3", "gdshader" },
			root_markers = { "project.godot", ".git" },
		})

		vim.lsp.config("lua_ls", {
			settings = { Lua = { diagnostics = { globals = { "vim" } } } },
		})

		vim.lsp.enable(to_install)
		-- vim.lsp.enable("gdshader_lsp")
		vim.lsp.enable("glasgow")
		vim.lsp.enable("slangd")

		-- if vim.fn.filereadable("project.godot") == 1 then
		-- 	vim.fn.serverstart("./godot.pipe")
		-- end
	end,
}
