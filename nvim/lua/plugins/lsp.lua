return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()

		local to_install = { "lua_ls", "clangd", "ty", "gopls", "rust_analyzer", "gdscript" }
		local keymap = vim.keymap.set
		keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_filter(function(v)
				return v ~= "gdscript"
			end, to_install),
		})

		vim.lsp.config("gdscript", {
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			filetypes = { "gd", "gdscript", "gdscript3" },
			root_markers = { "project.godot", ".git" },
			flags = {
				debounce_text_changes = 150,
			},
		})

		vim.lsp.config("lua_ls", {
			settings = { Lua = { diagnostics = { globals = { "vim" } } } },
		})

		vim.lsp.enable(to_install)

		if vim.fn.filereadable("project.godot") == 1 then
			vim.fn.serverstart("./godot.pipe")
		end
	end,
}
