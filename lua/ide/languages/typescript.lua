LanguageResults = require("ide.languages.api.language_results")

TypeScript = {}
TypeScript.__index = TypeScript

function TypeScript:setup(language_utils)
	language_utils.lspconfig.tsserver.setup({})

	return LanguageResults.new({
		null_ls_sources = {},
	})
end

return TypeScript
