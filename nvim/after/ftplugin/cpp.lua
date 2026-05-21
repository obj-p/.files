vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.commentstring = "// %s"

vim.keymap.set(
	"n",
	"<leader>ch",
	"<Cmd>LspClangdSwitchSourceHeader<CR>",
	{ buffer = 0, desc = "Clangd: switch source/header" }
)
