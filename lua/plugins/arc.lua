---@module 'arc'

return {
	"askerdev/arc.nvim",
	lazy = false,
	dependencies = { "folke/snacks.nvim", "MunifTanjim/nui.nvim" },
	opts = {},
	-- stylua: ignore
	keys = {
		{ "<leader>hr", function() Arc.signs.hunk_reset() end, desc = "Arc Hunk Reset" },
		{ "<leader>hp", function() Arc.signs.hunk_preview() end, desc = "Arc Hunk Preview" },
		{ "<leader>fg", function() Arc.picker.files() end, desc = "Arc Files" },
		{ "<leader>gb", function() Arc.picker.branches() end, desc = "Arc Branches" },
		{ "<leader>gp", function() Arc.picker.pr_list() end, desc = "Arc Pull Requests" },
	},
}
