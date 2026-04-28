return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		config = function()
			require("luasnip").setup()
			require("luasnip.loaders.from_snipmate").load({ paths = "./snippets" })
		end,
	},
}
