local M = {}

--- @type snacks.picker.Config
M.files = {
	title = "Files",
	finder = "files",
}

--- @type snacks.picker.Config
M.branches = {
	title = "Branches",
	finder = "branches",
	format = "git_branch",
	preview = require("custom.arc.picker.preview").arc_log,
	confirm = "arc_checkout",
	on_show = function(picker)
		for i, item in ipairs(picker:items()) do
			if item.current then
				picker.list:view(i)
				Snacks.picker.actions.list_scroll_center(picker)
				break
			end
		end
	end,
}

return M
