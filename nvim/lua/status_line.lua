local progress = {
	"lsp_progress",
	display_components = { "lsp_client_name", "spinner", { "percentage", "message" } },
}

require("lualine").setup({
	sections = {
		lualine_x = { progress },
	},
})
