return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				bzl = { "buildifier" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				swift = { "swift-format" },
			},
			-- Filetypes not listed above fall through to the language server.
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = { timeout_ms = 1000 },
		},
	},
}
