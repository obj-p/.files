return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				auto_install = true,
				ensure_installed = {
					"go",
					"kotlin",
					"lua",
					"python",
					"swift",
				},
				highlight = { enable = true },
				sync_install = false,
			})
		end,
	},
}
