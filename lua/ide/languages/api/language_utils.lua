LanguageUtils = {}
LanguageUtils.__index = LanguageUtils

function LanguageUtils.new(null_ls, lspconfig, dap, on_attach, capabilities, lsp_flags)
	return {
		null_ls = null_ls,
		lspconfig = lspconfig,
		dap = dap,
		on_attach = on_attach,
		capabilities = capabilities,
		lsp_flags = lsp_flags,
	}
end

return LanguageUtils
