local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.gofumpt,
		diagnostics.golangci_lint,
		code_actions.gomodifytags,
	},
	on_attach = function(current_client, bufnr)
		print(current_client)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
