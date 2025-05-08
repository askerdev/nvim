---@module 'arc'

return {
	"askerdev/arc.nvim",
	event = { "BufEnter", "BufWinEnter" },
	dependencies = { "folke/snacks.nvim" },
	opts = {},
	-- stylua: ignore
	keys = {
		{ "<leader>hp", function() Arc.signs.hunk_preview() end, desc = "Arc Hunk Preview" },
		{ "<leader>fg", function() Arc.picker.files() end, desc = "Arc Files" },
		{ "<leader>gb", function() Arc.picker.branches() end, desc = "Arc Branches" },
		{ "<leader>gp", function() Arc.picker.pr_list() end, desc = "Arc Pull Requests" },
	},
}
