return {
	"stevearc/overseer.nvim",
	opts = {
		strategy = {
			"jobstart",
			use_terminal = false,
		},
		task_list = {
			direction = "bottom",
			min_height = 10,
			max_height = 10,
			default_detail = 1,
		},
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		local function get_python_cmd(cmd)
			local venv_path = vim.fn.getcwd() .. "/.venv/bin/activate"
			if vim.fn.filereadable(venv_path) == 1 then
				return string.format("source .venv/bin/activate && %s", cmd)
			else
				return cmd
			end
		end

		local function restart_last_task()
			local tasks = overseer.list_tasks({ recent_first = true })
			if tasks[1] then
				local task = tasks[1]

				-- 1. Explicitly stop the previous command if it's still running
				task:stop()

				-- 2. Restart the task
				task:restart(true)

				-- 3. Re-open the task list buffer (without stealing window focus)
				overseer.open({ enter = false })
			else
				print("No recent task found to restart")
			end
		end

		vim.api.nvim_create_user_command("Run", function()
			vim.ui.input({ prompt = "Run Command: ", completion = "shellcmd" }, function(input)
				if not input or input == "" then
					return
				end

				local final_cmd = get_python_cmd(input)

				local task = overseer.new_task({
					cmd = { "zsh", "-ic", final_cmd },
					components = {
						{ "on_exit_set_status" },
						{ "on_complete_notify" },
						{ "on_output_quickfix", open = false },
					},
				})
				task:start()
				overseer.open({ enter = false })
			end)
		end, {})

		local keymap = vim.keymap.set
		keymap("n", "<leader>x", "<cmd>Run<CR>", { desc = "Run Command (Venv + Alias aware)" })
		keymap("n", "<leader>r", restart_last_task, { desc = "Restart last task" })
		keymap("n", "<leader>o", "<cmd>OverseerToggle<CR>", { desc = "Toggle Task List" })
		keymap("n", "<leader><leader>", "<cmd>OverseerClose<CR>", { desc = "Hide Task List" })
	end,
}
