return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"folke/todo-comments.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = function()
		local builtin = require("telescope.builtin")
		local ext = require("telescope").extensions

		local file_browser = function()
			ext.file_browser.file_browser({
				grouped = true,
			})
		end

		return {
			{ "<leader><leader>", mode = "n", file_browser, desc = "Explorer" },
			{ "<leader>sf", mode = "n", builtin.find_files, desc = "Find files" },
			{ "<leader>sb", mode = "n", builtin.buffers, desc = "Find buffer" },
			{ "<leader>sh", mode = "n", builtin.help_tags, desc = "Find help tags" },
			{ "<leader>sg", mode = "n", builtin.live_grep, desc = "Find grep string" },
		}
	end,
	opts = function()
		local actions = require("telescope.actions")
		local fb_actions = require("telescope._extensions.file_browser.actions")

		local telescope_buffer_dir = function()
			return vim.fn.expand("%:p:h")
		end

		return {
			defaults = {
				preview = false,
				file_ignore_patterns = {
					"node_modules",
					".idea",
					".vscode",
					"coverage",
					"public",
					"reports",
					"scripts",
					"__mocks__",
					"ci",
					"configs",
					"e2e",
				},
				mappings = {
					n = {
						["q"] = actions.close,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = false, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "ignore_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				file_browser = {
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					theme = "ivy",
					hijack_netrw = true,
					mappings = {
						["i"] = {
							["<C-w>"] = false,
							["<C-e>"] = fb_actions.goto_cwd,
						},
					},
				},
			},
		}
	end,

	config = function(_, opts)
		local t = require("telescope")
		t.setup(opts)
		t.load_extension("fzf")
		t.load_extension("file_browser")
	end,
}
