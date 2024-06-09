LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

JSON = {}
JSON.__index = JSON

function JSON:setup(language_utils)
	language_utils.lspconfig.jsonls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
	})

	return LanguageResults.new({
		null_ls_sources = {
      language_utils.null_ls.builtins.formatting.prettierd
		},
	})
end

return JSON
