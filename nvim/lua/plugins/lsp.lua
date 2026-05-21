return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local skip_format = { ts_ls = true }

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP Actions",
				callback = function(args)
					local opts = { buffer = args.buf, noremap = true, silent = true }
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", function()
						require("fzf-lua").lsp_references()
					end, opts)

					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					if client:supports_method("textDocument/formatting") and not skip_format[client.name] then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, async = false, id = client.id })
							end,
						})
					end

					if client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
						vim.keymap.set("n", "<leader>ih", function()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
								{ bufnr = args.buf }
							)
						end, opts)
					end

					if client.name == "clangd" then
						vim.keymap.set("n", "<leader>ch", "<Cmd>LspClangdSwitchSourceHeader<CR>", opts)
					end
				end,
			})

			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
				},
				-- In SwiftPM packages, defer to sourcekit-lsp (it knows the
				-- package's cxxSettings and spawns its own clangd internally).
				root_dir = function(bufnr, on_dir)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local start = fname ~= "" and vim.fs.dirname(fname) or vim.uv.cwd()
					if vim.fs.find("Package.swift", { upward = true, path = start })[1] then
						return
					end
					local root = vim.fs.root(bufnr, {
						".clangd",
						".clang-tidy",
						"compile_commands.json",
						"compile_flags.txt",
						".git",
					})
					on_dir(root or start)
				end,
			})

			vim.lsp.config("sourcekit", {
				capabilities = {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				},
			})

			vim.lsp.enable("clangd")
			vim.lsp.enable("gopls")
			vim.lsp.enable("kotlin_lsp")
			vim.lsp.enable("sourcekit")
			vim.lsp.enable("ts_ls")
		end,
	},
}
