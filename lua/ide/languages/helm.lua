LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Helm = {}
Helm.__index = Helm

function Helm:setup(language_utils)
	language_utils.lspconfig.helm_ls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
	})

	return LanguageResults.new({
		null_ls_sources = {},
	})
end

return Helm
