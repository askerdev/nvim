return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	opts = {
		lsp = { "vtsls", "html", "cssls", "lua_ls" },
		linter = { "eslint_d" },
		formatter = { "prettier", "stylua" },
	},
	config = function(_, opts)
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_enable = false,
			ensure_installed = opts.lsp,
		})

		local tools = {}

		for _, val in ipairs(opts.linter) do
			table.insert(tools, val)
		end

		for _, val in ipairs(opts.formatter) do
			table.insert(tools, val)
		end

		mason_tool_installer.setup({
			ensure_installed = tools,
		})
	end,
}
