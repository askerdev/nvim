return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"vtsls",
			"black",
			"css-lsp",
			"eslint_d",
			"html-lsp",
			"lua-language-server",
			"prettier",
			"pylint",
			"python-lsp-server",
			"stylua",
		},
	},
	config = function(_, opts)
		require("mason").setup()
		local r = require("mason-registry")
		for _, package_name in ipairs(opts.ensure_installed) do
			local package = r.get_package(package_name)
			if not package:is_installed() then
				package:install()
			end
		end
	end,
}
