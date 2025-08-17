-- remap
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- requires
require("lazy-config")
require("line-numbers")

-- options
vim.opt.autoread = true
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.wrap = false

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
