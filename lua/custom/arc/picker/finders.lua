local M = {}

local uv = vim.uv or vim.loop

local commit_pat = ("[a-z0-9]"):rep(7)

local arc_cache = {} ---@type table<string, boolean>
function M.is_arc_root(dir)
	if arc_cache[dir] == nil then
		arc_cache[dir] = (vim.uv or vim.loop).fs_stat(dir .. "/.arcignore") ~= nil
	end
	return arc_cache[dir]
end

--- Gets the git root for a buffer or path.
--- Defaults to the current buffer.
---@param path? number|string buffer or path
---@return string?
function M.get_root(path)
	path = path or 0
	path = type(path) == "number" and vim.api.nvim_buf_get_name(path) or path --[[@as string]]
	path = vim.fs.normalize(path)
	path = path == "" and (vim.uv or vim.loop).cwd() or path

	local todo = { path } ---@type string[]
	for dir in vim.fs.parents(path) do
		table.insert(todo, dir)
	end

	-- check cache first
	for _, dir in ipairs(todo) do
		if arc_cache[dir] then
			return vim.fs.normalize(dir) or nil
		end
	end

	for _, dir in ipairs(todo) do
		if M.is_arc_root(dir) then
			return vim.fs.normalize(dir) or nil
		end
	end

	return nil
end

---@module 'snacks'
---@param opts snacks.picker.git.files.Config
---@type snacks.picker.finder
function M.files(opts, ctx)
	local args = { "ls-files" }
	if not opts.cwd then
		opts.cwd = M.get_root() or uv.cwd() or "."
		ctx.picker:set_cwd(opts.cwd)
	end
	local cwd = vim.fs.normalize(opts.cwd) or nil
	return require("snacks.picker.source.proc").proc({
		opts,
		{
			cmd = "arc",
			args = args,
			---@param item snacks.picker.finder.Item
			transform = function(item)
				item.cwd = cwd
				item.file = item.text
			end,
		},
	}, ctx)
end

---@module 'snacks'
---@param opts snacks.picker.git.files.Config
---@type snacks.picker.finder
function M.pr_list(opts, ctx)
	local args = { "pr", "list" }
	if not opts.cwd then
		opts.cwd = M.get_root() or uv.cwd() or "."
		ctx.picker:set_cwd(opts.cwd)
	end
	local cwd = vim.fs.normalize(opts.cwd) or nil
	return require("snacks.picker.source.proc").proc({
		opts,
		{
			cmd = "arc",
			args = args,
			---@param item snacks.picker.finder.Item
			transform = function(item)
				item.cwd = cwd
				item.id, item.summary = item.text:match("(%S+)%s+%S+%s+%S+%s+(.+)")
				if item.id == "Id" then
					return false
				end
			end,
		},
	}, ctx)
end

---@param opts snacks.picker.Config
---@type snacks.picker.finder
function M.branches(opts, ctx)
	local args = { "branch", "-vvl" }
	local cwd = vim.fs.normalize(opts and opts.cwd or uv.cwd() or ".") or nil
	cwd = M.get_root(cwd)

	local patterns = {
    -- stylua: ignore start
    --- e.g. "* (HEAD detached at f65a2c8) f65a2c8 chore(build): auto-generate docs"
    "^(.)%s(%b())%s+(" .. commit_pat .. ")%s*(.*)$",
    --- e.g. "  main                       d2b2b7b [origin/main: behind 276] chore(build): auto-generate docs"
    "^(.)%s(%S+)%s+(".. commit_pat .. ")%s*(.*)$",
		-- stylua: ignore end
	} ---@type string[]

	return require("snacks.picker.source.proc").proc({
		opts,
		{
			cwd = cwd,
			cmd = "arc",
			args = args,
			---@param item snacks.picker.finder.Item
			transform = function(item)
				item.cwd = cwd
				for p, pattern in ipairs(patterns) do
					local status, branch, commit, msg = item.text:match(pattern)
					if status then
						local detached = p == 1
						item.current = status == "*"
						item.branch = not detached and branch or nil
						item.commit = commit
						item.msg = msg
						item.detached = detached
						return
					end
				end
				Snacks.notify.warn("failed to parse branch: " .. item.text)
				return false -- skip items we could not parse
			end,
		},
	}, ctx)
end

return M
