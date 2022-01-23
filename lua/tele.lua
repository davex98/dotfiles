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

-- Mappings --
local function buf_set_keymap(...)
	vim.api.nvim_buf_set_keymap(bufnr, ...)
end

local opts = { noremap = true, silent = true }
buf_set_keymap(
	"n",
	"<space>b",
	"<Cmd>lua require('telescope.builtin').live_grep({search_dirs={vim.fn.expand('%:p')}})<CR>",
	opts
)
buf_set_keymap("n", "<space>r", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
