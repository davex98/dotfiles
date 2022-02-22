local actions = require("telescope.actions")

require("telescope").setup({
	mappings = {
		i = {
			["<C-q>"] = actions.send_to_qflist,
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
	},
})

require("telescope").load_extension("fzy_native")
require("telescope").load_extension("goimpl")

local M = {}

M.symbols = function()
	require("telescope.builtin").lsp_document_symbols({ symbols = { "function", "struct", "method", "interface" } })
end

return M
