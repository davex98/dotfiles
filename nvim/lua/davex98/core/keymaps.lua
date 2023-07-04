vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>n", ":nohl<CR>")

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set({ "n", "v" }, "H", "^")
keymap.set({ "n", "v" }, "L", "$")

keymap.set("n", "<leader>w", ":up<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

keymap.set("n", "<leader>co", ":copen<CR>")
keymap.set("n", "<leader>cl", ":cclose<CR>")
keymap.set("n", "<leader>j", ":cnext<CR>zz")
keymap.set("n", "<leader>k", ":cprev<CR>zz")

keymap.set("n", "<leader>v", "<C-w>v")
keymap.set("n", "<leader>s", "<C-w>s")

keymap.set({ "n", "v" }, "<leader>y", '"+y')
keymap.set("n", "<leader>p", '"+p')

keymap.set("n", "<C-h>", ":wincmd h<CR>")
keymap.set("n", "<C-j>", ":wincmd j<CR>")
keymap.set("n", "<C-k>", ":wincmd k<CR>")
keymap.set("n", "<C-l>", ":wincmd l<CR>")

keymap.set("v", '"', '<esc>`>a"<esc>`<i"<esc>')
keymap.set("v", "'", "<esc>`>a'<esc>`<i'<esc>")
keymap.set("v", ")", "<esc>`>a)<esc>`<i(<esc>")
keymap.set("v", "(", "<esc>`>a)<esc>`<i(<esc>")
keymap.set("v", "}", "<esc>`>a}<esc>`<i{<esc>")
keymap.set("v", "{", "<esc>`>a}<esc>`<i{<esc>")
keymap.set("v", "<", "<esc>`>a><esc>`<i<<esc>")
keymap.set("v", ">", "<esc>`>a><esc>`<i<<esc>")

keymap.set("n", "<leader>m", ":MaximizerToggle<CR>")

keymap.set("n", "<C-u>", ":Telescope find_files hidden=true<CR>")
keymap.set("n", "<leader>ff", ":Telescope live_grep<CR>")
