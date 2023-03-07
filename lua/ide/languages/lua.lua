LanguageResults = require("ide.languages.api.language_results")

Lua = {}
Lua.__index = Lua

function Lua:setup(language_utils)
	language_utils.lspconfig.lua_ls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
		settings = {
			Lua = {
				callSnippet = "Replace",
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	})

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.stylua,
			language_utils.null_ls.builtins.code_actions.refactoring,
		},
	})
end

return Lua
