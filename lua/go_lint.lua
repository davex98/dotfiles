local lspconfig_util = require("lspconfig.util")
local Job = require("plenary.job")
local Path = require("plenary.path")

local M = {}

local find_root = lspconfig_util.root_pattern("go.mod")

M.run = function()
	local root = find_root(vim.fn.expand("%:p"))
	if not root then
		return
	end

	print("Running golangci-lint:", root)
	local lint_exe = "/home/kuba/go/bin/golangci-lint"

	local j = Job:new({
		lint_exe,
		"run",
		"--out-format",
		"json",

		cwd = root,

		on_exit = vim.schedule_wrap(function(self)
			print("Complete!")
			local output = self:result()
			local issues = vim.fn.json_decode(output).Issues

			if not issues or vim.tbl_isempty(issues) then
				print("[golangci lint] No Issues")
				return
			end

			local results = {}
			for _, issue in ipairs(issues) do
				table.insert(results, {
					filename = issue.Pos.Filename,
					lnum = issue.Pos.Line,
					text = issue.Text,
					col = issue.Pos.Columnd,
				})
			end

			vim.fn.setqflist(results)
			vim.cmd([[clist]])
		end),
	})

	j:start()
	return root
end

return M
