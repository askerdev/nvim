return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier", "eslint_d" },
			typescript = { "prettier", "eslint_d" },
			javascriptreact = { "prettier", "eslint_d" },
			typescriptreact = { "prettier", "eslint_d" },
			css = { "prettier", "eslint_d" },
			html = { "prettier" },
			json = { "prettier", "eslint_d" },
			yaml = { "prettier", "eslint_d" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			lua = { "stylua" },
		},
		format_after_save = {
			lsp_fallback = true,
			async = true,
			timeout_ms = 5000,
		},
	},
}
