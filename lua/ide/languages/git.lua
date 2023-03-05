LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Git = {}
Git.__index = Git

function Git:setup(language_utils)
	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.diagnostics.gitlint.with({
				filetypes = { "gitcommit", "NeogitCommitMessage" },
			}),
		},
	})
end

return Git
