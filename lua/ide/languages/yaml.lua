LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

YAML = {}
YAML.__index = YAML

function YAML:setup(language_utils)
	language_utils.lspconfig.yamlls.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
		handlers = {
			["textDocument/publishDiagnostics"] = function(a, b, c ,d)
        if vim.bo.filetype ~= "helm" then
          return vim.lsp.diagnostic.on_publish_diagnostics(a, b, c, d)
        end
			end,
		},
	})

	-- this doesn't work...
	-- I think:
	-- vim-helm attaches filetype=helm after BufEnter
	-- when this event happens, the null_ls already attached the yamllint to the file
	local yamllint = language_utils.null_ls.builtins.diagnostics.yamllint.with({
		disabled_filetypes = { "helm" },
		extra_args = { "--config", "/home/sahar/nvim-ide/lua/ide/languages/.yamllint" },
	})

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.yamlfmt,
			-- yamllint,
		},
	})
end

return YAML
