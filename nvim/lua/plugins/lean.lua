return {
	{
		"Julian/lean.nvim",
		ft = "lean",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			mappings = true,
			infoview = {
				autoopen = true,
			},
		},
	},
}
