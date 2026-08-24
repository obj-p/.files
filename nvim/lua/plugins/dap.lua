return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug conditional breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Debug continue/start",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Debug step into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Debug step over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Debug step out",
			},
			{
				"<leader>dx",
				function()
					require("dap").terminate()
				end,
				desc = "Debug terminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug toggle UI",
			},
			{
				"<leader>dt",
				function()
					require("dap-go").debug_test()
				end,
				desc = "Debug nearest Go test",
			},
			{
				"<leader>dl",
				function()
					require("dap-go").debug_last_test()
				end,
				desc = "Debug last Go test",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dap-go").setup()
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
