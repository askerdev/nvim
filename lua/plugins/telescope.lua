return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ dir = "~/repos/arc.nvim" },
	},
	keys = function()
		local builtin = require("telescope.builtin")
		local arc_builtin = require("arc.telescope.builtin")
		local arc_utils = require("arc.utils")

		local files = function()
			if arc_utils.is_arc_repo() then
				arc_builtin.ls_files()
			elseif arc_utils.is_git_repo() then
				builtin.git_files()
			else
				builtin.find_files()
			end
		end

		return {
			{ "<leader><leader>", mode = "n", files, desc = "Find files" },
			{ "<leader>sb", mode = "n", builtin.buffers, desc = "Find buffer" },
			{ "<leader>sh", mode = "n", builtin.help_tags, desc = "Find help tags" },
			{ "<leader>sg", mode = "n", builtin.live_grep, desc = "Find grep string" },
		}
	end,
	config = function()
		local t = require("telescope")
		t.setup({})
		t.load_extension("arc")
	end,
}
