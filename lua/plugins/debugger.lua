if true then
	return {}
end

return {
	"mfussenegger/nvim-dap",
	keys = function()
		local dap = require("dap")
		return {
			{ "<leader>db", mode = "n", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
			{ "<leader>dc", mode = "n", dap.continue, desc = "Continue executing" },
			{ "<leader>dC", dap.run_to_cursor, desc = "Run to Cursor" },
			{ "<leader>di", dap.step_into, desc = "Step Into" },
			{ "<leader>do", dap.step_out, desc = "Step Out" },
			{ "<leader>dl", dap.run_last, desc = "Run Last" },
			{ "<leader>dO", dap.step_over, desc = "Step Over" },
			{ "<leader>dr", dap.repl.toggle, desc = "Toggle REPL" },
			{ "<leader>dt", dap.terminate, desc = "Terminate" },
		}
	end,
	dependencies = {
		{ "nvim-neotest/nvim-nio" },
		{ "askerdev/debugjs.nvim", opts = {} },
		{ "leoluz/nvim-dap-go", opts = {} },
		{
			"rcarriga/nvim-dap-ui",
			keys = function()
				local dapui = require("dapui")
				return {
					{ "<leader>du", dapui.toggle, desc = "Dap UI" },
					{ "<leader>de", dapui.eval, desc = "Eval", mode = { "n", "v" } },
				}
			end,
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				dapui.setup(opts)
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({})
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close({})
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close({})
				end
			end,
		},
	},
}
