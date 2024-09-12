LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Nix = {}
Nix.__index = Nix

function Nix:setup(language_utils)
	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.nixfmt,
			language_utils.null_ls.builtins.code_actions.statix,
			language_utils.null_ls.builtins.diagnostics.deadnix,
		},
	})
end

return Nix
