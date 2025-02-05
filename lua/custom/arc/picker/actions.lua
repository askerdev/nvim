local M = {}

function M.arc_checkout(picker, item)
	picker:close()
	if item then
		local what = item.branch or item.commit
		if not what then
			Snacks.notify.warn("No branch or commit found", { title = "Snacks Picker" })
			return
		end
		local cmd = { "arc", "checkout", what }
		if item.file then
			vim.list_extend(cmd, { "--", item.file })
		end
		Snacks.picker.util.cmd(cmd, function()
			Snacks.notify("Checkout " .. what, { title = "Snacks Picker" })
			vim.cmd.checktime()
		end, { cwd = item.cwd })
	end
end

function M.arc_view(picker, item)
	picker:close()
	if item then
		local what = item.id
		if not what then
			Snacks.notify.warn("No branch found", { title = "Snacks Picker" })
			return
		end
		local cmd = { "arc", "pr", "view", what }
		Snacks.picker.util.cmd(cmd, function()
			Snacks.notify("View pr " .. what, { title = "Snacks Picker" })
			vim.cmd.checktime()
		end, { cwd = item.cwd })
	end
end

return M
