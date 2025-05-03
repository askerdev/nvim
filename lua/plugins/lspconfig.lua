return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>ca", mode = { "n", "v" }, vim.lsp.buf.code_action, desc = "Code actions" },
		{ "<leader>cr", mode = "n", vim.lsp.buf.rename, desc = "Lsp Rename" },
		{ "<leader>dd", mode = "n", vim.lsp.diagnostic.open_float, desc = "Show line diagnostics" },
		{ "K", mode = "n", vim.lsp.buf.hover, desc = "Show hover documentation" },
	},
	config = function()
		local lspconfig = require("lspconfig")

		local mason_lspconfig = require("mason-lspconfig")

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local km = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "See available code actions"
				km.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				km.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

				opts.desc = "Show line diagnostics"
				km.set("n", "<leader>D", vim.diagnostic.open_float, opts)

				opts.desc = "Show documentation for what is under cursor"
				km.set("n", "K", vim.lsp.buf.hover, opts)
			end,
		})

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
