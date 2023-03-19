LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

CPP = {}
CPP.__index = CPP

function CPP:setup(language_utils)
	local clang_d_on_attach = function(client, bufnr)
		language_utils.on_attach(client, bufnr)

		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "<leader>ko", ":ClangdSwitchSourceHeader<CR>", bufopts)
	end

	language_utils.lspconfig["clangd"].setup({
		on_attach = clang_d_on_attach,
		flags = language_utils.lsp_flags,
		capabilities = language_utils.capabilities,
	})

	language_utils.lspconfig["cmake"].setup({
		on_attach = language_utils.on_attach,
		flags = language_utils.lsp_flags,
		capabilities = language_utils.capabilities,
	})

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.cmake_format,
      -- TODO: this is loaded in python... please fix this.
			-- language_utils.null_ls.builtins.code_actions.refactoring,
		},
	})
end

return CPP
