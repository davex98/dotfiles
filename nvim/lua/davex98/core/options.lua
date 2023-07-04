local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.guicursor = ""

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.cursorline = true
opt.cursorcolumn = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.colorcolumn = "80"

opt.scrolloff = 8

opt.backspace = "indent,eol,start"

opt.splitright = true
opt.splitbelow = true

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])
