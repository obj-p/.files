return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(buffer)
				local gs = require("gitsigns")
				local opts = { buffer = buffer }
				vim.keymap.set("n", "]c", function()
					gs.nav_hunk("next")
				end, opts)
				vim.keymap.set("n", "[c", function()
					gs.nav_hunk("prev")
				end, opts)
				vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
				vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
				vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
				vim.keymap.set("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, opts)
			end,
		},
	},
}
