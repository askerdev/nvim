return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	-- stylua: ignore
	keys = {
		{ "<leader>ca", mode = { "n", "v" }, vim.lsp.buf.code_action, desc = "Code actions" },
		{ "<leader>cr", mode = "n", vim.lsp.buf.rename, desc = "Lsp Rename" },
		{ "<leader>ds", mode = "n", vim.diagnostic.open_float, desc = "Show line diagnostics" },
		{ "K", mode = "n", function() vim.lsp.buf.hover() end, desc = "Show hover documentation" },
	},
	opts = {
		servers = { "html", "cssls", "lua_ls", "vtsls", "pylsp" },
	},
	config = function(_, opts)
		vim.lsp.enable(opts.servers)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
