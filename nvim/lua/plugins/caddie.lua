return {
	{
		"obj-p/caddie.nvim",
		lazy = false,
		keys = {
			{ "<leader>cs", "<cmd>CaddieStart<cr>", desc = "Caddie start recording" },
			{ "<leader>cq", "<cmd>CaddieStop<cr>", desc = "Caddie stop recording" },
			{ "<leader>cr", "<cmd>CaddieReview<cr>", desc = "Caddie review session" },
		},
		opts = {
			agent = {
				provider = "claude-code",
			},
		},
	},
}
