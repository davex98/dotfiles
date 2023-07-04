local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect,noinsert"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-j>"] = cmp.mapping(function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	}),
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
})

require("lsp_signature").setup({ hint_prefix = "" })
