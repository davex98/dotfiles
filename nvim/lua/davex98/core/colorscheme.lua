local status, _ = pcall(vim.cmd, "colorscheme gruvbox-material")
if not status then
	print("Colorscheme not found")
	return
end

vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_background = "soft"
