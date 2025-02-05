local M = {}

setmetatable(M, {
	__index = function(t, k)
		---@diagnostic disable-next-line: no-unknown
		t[k] = require("custom.arc." .. k)
		return rawget(t, k)
	end,
})

---@type arc.plugins
_G.Arc = M

return M
