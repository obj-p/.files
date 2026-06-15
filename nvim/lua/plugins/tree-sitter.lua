return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install({
				"c",
				"cpp",
				"go",
				"kotlin",
				"lean",
				"lua",
				"python",
				"starlark",
				"swift",
			})

			vim.treesitter.language.register("starlark", "bzl")

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
}
