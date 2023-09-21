LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

JQ = {}
JQ.__index = JQ

function JQ:setup(language_utils)
	language_utils.lspconfig.jqls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
	})

	return LanguageResults.new({
		null_ls_sources = {},
	})
end

return JQ
