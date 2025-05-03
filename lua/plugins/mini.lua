return {
	"echasnovski/mini.nvim",
	opts = {
		ai = {},
		comment = {},
		icons = {},
		statusline = {},
		sessions = {},
	},
	config = function(_, opts)
		for plugin, options in pairs(opts) do
			require("mini." .. plugin).setup(options)
		end
	end,
}
