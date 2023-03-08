LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Markdown = {}
Markdown.__index = Markdown

function Markdown:setup(language_utils)
	return LanguageResults.new({
		null_ls_sources = {
		},
	})
end

return Markdown
