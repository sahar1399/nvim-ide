LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

YAML = {}
YAML.__index = YAML

function YAML:setup(language_utils)
	language_utils.lspconfig.yamlls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
	})

	return LanguageResults.new({
		null_ls_sources = {
      language_utils.null_ls.builtins.formatting.yamlfmt,
			language_utils.null_ls.builtins.diagnostics.yamllint,
		},
	})
end

return YAML
