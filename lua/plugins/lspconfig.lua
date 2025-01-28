return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
		{ "saghen/blink.cmp" },
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local t = require("telescope.builtin")

		local lspconfig = require("lspconfig")

		local mason_lspconfig = require("mason-lspconfig")

		local km = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				km.set("n", "gR", t.lsp_references, opts)

				opts.desc = "Go to declaration"
				km.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				km.set("n", "gd", t.lsp_definitions, opts)

				opts.desc = "Show LSP definitions in separated Window"
				km.set("n", "<C-w>gd", function()
					vim.api.nvim_command("vsplit")
					t.lsp_definitions()
				end, opts)

				opts.desc = "Show LSP implementations"
				km.set("n", "gi", t.lsp_implementations, opts)

				opts.desc = "Show LSP type definitions"
				km.set("n", "gt", t.lsp_type_definitions, opts)

				opts.desc = "See available code actions"
				km.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				km.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				km.set("n", "<leader>DD", function()
					t.diagnostics({ bufnr = 0 })
				end, opts)

				opts.desc = "Show line diagnostics"
				km.set("n", "<leader>D", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				km.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				km.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				km.set("n", "K", vim.lsp.buf.hover, opts)
			end,
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
	end,
}
