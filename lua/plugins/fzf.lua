return {
	"askerdev/fzf.nvim",
	keys = function()
		local fzf = require("fzf")

		return {
			{ "<leader><leader>", mode = "n", fzf.all_files, desc = "Find files" },
		}
	end,
}
