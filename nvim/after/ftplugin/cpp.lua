vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.commentstring = "// %s"

vim.keymap.set("n", "<leader>ch", function()
	vim.lsp.buf.execute_command({
		command = "clangd.switchSourceHeader",
		arguments = { vim.uri_from_bufnr(0) },
	})
end, { buffer = 0, desc = "Clangd: switch source/header" })
