local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	definition = {
		edit = "<CR>",
	},
	lightbulb = {
		enable = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
})
