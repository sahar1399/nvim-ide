LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Bash = {}
Bash.__index = Bash

function Bash:setup(language_utils)
	language_utils.lspconfig.bashls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
	})

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.shfmt,
			language_utils.null_ls.builtins.formatting.shellharden,
      language_utils.null_ls.builtins.diagnostics.shellcheck,
		},
	})
end

return Bash
