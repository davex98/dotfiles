local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim")

	use("sainnhe/gruvbox-material")

	use("nvim-lualine/lualine.nvim")
	use("arkav/lualine-lsp-progress")

	use("christoomey/vim-tmux-navigator")

	use("szw/vim-maximizer")

	use("numToStr/Comment.nvim")

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	use({ "benfowler/telescope-luasnip.nvim" })
	use({
		"ray-x/lsp_signature.nvim",
	})

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")

	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use("windwp/nvim-autopairs")

	use("neovim/nvim-lspconfig")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})
	use("jose-elias-alvarez/typescript.nvim")

	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
