LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Python = {}
Python.__index = Python

function Python:setup(language_utils)
	language_utils.lspconfig.pyright.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
		settings = {
			pyright = {
				autoImportCompletion = true,
			},
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
		single_file_support = true,
	})

	language_utils.lspconfig.sourcery.setup({
		on_attach = language_utils.on_attach,
		capabilities = language_utils.capabilities,
		flags = language_utils.lsp_flags,
		init_options = {
			--- The Sourcery token for authenticating the user.
			--- This is retrieved from the Sourcery website and must be
			--- provided by each user. The extension must provide a
			--- configuration option for the user to provide this value.
			token = Consts.SOURCERY_TOKEN,
			--- The extension's name and version as defined by the extension.
			extension_version = "vim.lsp",
			--- The editor's name and version as defined by the editor.
			editor_version = "vim",
		},
		single_file_support = true,
	})

	require("dap-python").setup(Consts.PYTHON3_PATH, {})
	require("dap.ext.vscode").load_launchjs()

	return LanguageResults.new({
		null_ls_sources = {
			language_utils.null_ls.builtins.formatting.black.with({
				args = {
					"--stdin-filename",
					"$FILENAME",
					"--quiet",
					"-",
					-- "--config",
					-- "pyproject.toml",
				},
			}),
			language_utils.null_ls.builtins.formatting.isort,
			language_utils.null_ls.builtins.formatting.usort,
			language_utils.null_ls.builtins.formatting.autoflake,
			language_utils.null_ls.builtins.code_actions.refactoring,
		},
	})
end

return Python
