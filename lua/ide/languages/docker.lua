LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Docker = {}
Docker.__index = Docker

function Docker:setup(language_utils)
	return LanguageResults.new({
		null_ls_sources = {
      language_utils.null_ls.builtins.diagnostics.hadolint,
		},
	})
end

return Docker

