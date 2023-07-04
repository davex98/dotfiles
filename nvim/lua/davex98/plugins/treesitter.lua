local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	ensure_installed = {
		"typescript",
		"tsx",
		"yaml",
		"graphql",
		"bash",
		"lua",
		"vim",
		"go",
		"dockerfile",
		"gitignore",
		"markdown",
		"markdown_inline",
	},
	auto_install = true,
})
