return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
					refresh_time = 16,
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"Filetype",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = {},
				lualine_z = {
					function()
						return os.date("%H:%M:%S")
					end,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})

		local uv = vim.uv or vim.loop
		local hide_timer = uv.new_timer()
		local is_hidden = false

		local function show_statusline()
			if is_hidden then
				require("lualine").hide({ place = { "statusline" }, unhide = true })
				is_hidden = false
			end
		end

		local function handle_activity()
			if not is_hidden then
				require("lualine").hide({ place = { "statusline" }, unhide = false })
				is_hidden = true
			end

			hide_timer:stop()
			hide_timer:start(4000, 0, vim.schedule_wrap(show_statusline))
		end

		local lualine_hide_group = vim.api.nvim_create_augroup("LualineAutoHide", { clear = true })
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "TextChanged", "TextChangedI" }, {
			group = lualine_hide_group,
			callback = handle_activity,
		})
	end,
}
