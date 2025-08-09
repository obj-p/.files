return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "echasnovski/mini.icons" },
		keys = {
			{
				"<leader>ff",
				function()
					require("fzf-lua").files()
				end,
				desc = "Find files in cwd",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "Find by grepping cwd",
			},
			{
				"<leader>fr",
				function()
					require("fzf-lua").lsp_live_workspace_symbols()
				end,
				desc = "Find by LSP references",
			},
		},
	},
}
