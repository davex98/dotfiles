local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		theme = "gruvbox",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "lsp_progress" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
