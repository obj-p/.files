return {
	{
		"stevearc/oil.nvim",
		dependencies = { "echasnovski/mini.icons" },
		lazy = false, -- so `nvim <dir>` opens in oil instead of netrw
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
		},
		opts = {
			view_options = { show_hidden = true },
		},
	},
}
