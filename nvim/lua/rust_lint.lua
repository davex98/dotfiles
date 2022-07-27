local lspconfig_util = require("lspconfig.util")
local Job = require("plenary.job")
local Path = require("plenary.path")

local M = {}

local find_root = lspconfig_util.root_pattern("Cargo.toml")

M.run = function()
	local root = find_root(vim.fn.expand("%:p"))
	if not root then
		return
	end

	print("Running cargo clippy:", root)

	local j = Job:new({
		command = "cargo",
		args = { "clippy" },
		-- "| jq '.message | select(.spans | length >=1)'",
		--"| jq '{message: .message, file_name: .spans[0].file_name, column_start: .spans[0].column_start, line_start: .spans[0].line_start}'",

		cwd = root,

		on_exit = vim.schedule_wrap(function(self)
			print("Complete!")
			local output = self:result()
			print(dump(output))

			--local results = {}
			--for _, issue in ipairs(issues) do
			--	table.insert(results, {
			--		filename = issue.file_name,
			--		lnum = issue.line_start,
			--		text = issue.message,
			--		col = issue.column_start,
			--	})
			--end

			--vim.fn.setqflist(results)
			--vim.cmd([[clist]])
		end),
	})

	j:start()
	return root
end

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

return M
