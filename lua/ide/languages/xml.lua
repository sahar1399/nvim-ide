LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

XML = {}
XML.__index = XML

function XML:setup(language_utils)
	language_utils.lspconfig.lemminx.setup({})

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.tidy,
			-- language_utils.null_ls.builtins.formatting.xmlformat,
		},
	})
end

return XML
