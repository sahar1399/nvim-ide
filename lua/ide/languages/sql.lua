LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

SQL = {}
SQL.__index = SQL

function SQL:setup(language_utils)
	language_utils.lspconfig.sqlls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
	})

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.diagnostics.sqlfluff,
			language_utils.null_ls.builtins.formatting.sql_formatter,
		},
	})
end

return SQL
