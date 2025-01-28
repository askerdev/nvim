local ignore = {
	".git",
	"**/.editorconfig",
	"**/node_modules",
	"configs/localhost.yandex-team.ru.crt",
	"configs/localhost.yandex-team.ru.key",
	"configs/presets/*.json",
	"runner-results",
	"docs/proto",
	"out",
	"in",
	".idea",
	".vscode",
	"*.zip",
	".e2e-auth",
	".env",
	".eslintcache",
	"build",
	"coverage",
	"npm-debug.log*",
	"playwright-report",
	"reports",
	"scripts/all_projects.json",
	"scripts/all_stages.*",
	"snapshots",
	"coverage",
	"public",
	"scripts",
	"ci",
	"e2e",
}

return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	keys = function()
		local fzf = require("fzf-lua")

		-- stylua: ignore
		return {
			{ "<leader><leader>", mode = "n",
				function()
					fzf.files({
						previewer = false,
						rg_opts = [[--color=never --files -g "!{]] .. table.concat(ignore, ",") .. [[}"]],
					})
				end, desc = "Find files" },
			{ "<leader>fb", mode = "n", function() fzf.buffers({ previewer = false }) end, desc = "Find buffers" },
			{ "<leader>fg", mode = "n", function() fzf.live_grep({
				rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g "!{]] .. table.concat(ignore, ",") .. [[}" -e]],
			}) end, desc = "Find buffers" },
		}
	end,
	opts = {},
}
