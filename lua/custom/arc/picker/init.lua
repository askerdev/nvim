local M = {}

M.config = {}

setmetatable(M, {
	__index = function(t, k)
		t.config.sources = t.config.sources or require("custom.arc.picker.sources")
		t.config.finders = t.config.finders or require("custom.arc.picker.finders")
		t.config.actions = t.config.actions or require("custom.arc.picker.actions")
		t.config.preview = t.config.preview or require("custom.arc.picker.preview")
		for key, source in pairs(t.config.sources) do
			if key == k then
				source.finder = t.config.finders[source.finder] or source.finder
				source.confirm = t.config.actions[source.confirm] or source.confirm
				source.preview = t.config.actions[source.preview] or source.preview
				t[k] = function()
					Snacks.picker.pick(source)
				end
			end
		end
		return rawget(t, k)
	end,
})

return M
