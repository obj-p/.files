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
				end,
			})

			-- Source/header switch. Filetype-based, not LSP-based: works for
			-- clangd, sourcekit-lsp (which doesn't implement clangd's
			-- textDocument/switchSourceHeader extension), and no-LSP buffers.
			-- Knows about SwiftPM's Sources/<Target>/include/ convention.
			local source_exts = { "cpp", "cc", "cxx", "c++", "c", "m", "mm" }
			local header_exts = { "h", "hpp", "hh", "hxx", "h++" }
			local function find_counterpart(dir, stem, exts)
				for _, ext in ipairs(exts) do
					local path = dir .. "/" .. stem .. "." .. ext
					if vim.uv.fs_stat(path) then
						return path
					end
				end
			end
			local function switch_source_header()
				local file = vim.api.nvim_buf_get_name(0)
				if file == "" then
					vim.notify("Buffer has no file", vim.log.levels.WARN)
					return
				end
				local dir, name = vim.fs.dirname(file), vim.fs.basename(file)
				local stem, ext = name:match("^(.+)%.([^.]+)$")
				if not stem then
					vim.notify("No extension on " .. name, vim.log.levels.WARN)
					return
				end
				local is_header = vim.tbl_contains(header_exts, ext)
				local candidates = is_header and source_exts or header_exts
				local found = find_counterpart(dir, stem, candidates)
				if not found then
					-- SwiftPM: Sources/<Target>/include/Foo.h <-> Sources/<Target>/Foo.cpp
					if is_header and vim.fs.basename(dir) == "include" then
						found = find_counterpart(vim.fs.dirname(dir), stem, candidates)
					elseif not is_header then
						found = find_counterpart(dir .. "/include", stem, candidates)
					end
				end
				if found then
					vim.cmd.edit(vim.fn.fnameescape(found))
				else
					vim.notify(
						"No matching " .. (is_header and "source" or "header") .. " for " .. name,
						vim.log.levels.INFO
					)
				end
			end
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "cpp", "objc", "objcpp" },
				callback = function(args)
					vim.keymap.set("n", "<leader>ch", switch_source_header, {
						buffer = args.buf,
						noremap = true,
						silent = true,
						desc = "Switch source/header",
					})
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "bzl",
				callback = function(args)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = args.buf,
						callback = function()
							local input = table.concat(vim.api.nvim_buf_get_lines(args.buf, 0, -1, false), "\n")
							local result = vim.system(
								{ "buildifier", "-path=" .. vim.api.nvim_buf_get_name(args.buf) },
								{ stdin = input }
							):wait()
							if result.code ~= 0 or not result.stdout then
								return
							end
							local lines = vim.split(result.stdout, "\n")
							if lines[#lines] == "" then
								table.remove(lines)
							end
							vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
						end,
					})
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

			vim.lsp.config("starpls", {
				cmd = function(dispatchers, config)
					return vim.lsp.rpc.start({ "starpls" }, dispatchers, { cwd = config.root_dir })
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
			vim.lsp.enable("starpls")
			vim.lsp.enable("ts_ls")
		end,
	},
}
