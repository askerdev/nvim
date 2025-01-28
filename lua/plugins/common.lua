return {
	{ "stevearc/dressing.nvim", opts = {} },
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = { enabled = true },
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		---@module 'noice'
		---@class NoiceConfig
		opts = {
			messages = {
				enabled = false,
			},
			presets = {
				lsp_doc_border = true,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"echasnovski/mini.nvim",
		opts = {
			ai = {},
			comment = {},
			icons = {},
			pairs = {},
			statusline = {},
			sessions = {},
			files = {
				windows = {
					max_number = 1,
				},
			},
		},
		keys = function()
			local files = require("mini.files")
			-- stylua: ignore
			return {
				{	"<leader>e", mode = "n", function()	files.open(vim.fn.expand("%:p")) end, desc = "File tree" },
			}
		end,
		config = function(_, opts)
			for plugin, options in pairs(opts) do
				require("mini." .. plugin).setup(options)
			end
		end,
	},
}
