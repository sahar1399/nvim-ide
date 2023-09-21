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
					autoSearchPaths = false,
					useLibraryCodesForTypes = false,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
		single_file_support = true,
	})

	-- language_utils.lspconfig.ruff_lsp.setup({
	-- 	on_attach = language_utils.on_attach,
	-- 	capabilities = language_utils.capabilities,
	-- 	flags = language_utils.lsp_flags,
	-- 	settings = {
	-- 		-- Any extra CLI arguments for `ruff` go here.
	-- 		args = {},
	-- 	},
	-- })
	--
	-- local util = require("lspconfig").util
	--
	-- language_utils.lspconfig.pylyzer.setup({
	-- 	on_attach = language_utils.on_attach,
	-- 	capabilities = language_utils.capabilities,
	-- 	flags = language_utils.lsp_flags,
	--
	-- 	filetypes = { "python" },
	--
	-- 	root_dir = function(fname)
	-- 		local root_files = {
	-- 			"setup.py",
	-- 			"tox.ini",
	-- 			"requirements.txt",
	-- 			"Pipfile",
	-- 			"pyproject.toml",
	-- 		}
	-- 		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
	-- 	end,
	--
	-- 	settings = {
	-- 		python = {
	-- 			diagnostics = true,
	-- 			inlayHints = true,
	-- 			smartCompletion = true,
	-- 			checkOnType = false,
	-- 		},
	-- 	},
	-- })
	--
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
					"-l",
					"120",
					"-",
					-- "--config",
					-- "./pyproject.toml",
				},
			}),
			language_utils.null_ls.builtins.formatting.isort,
			language_utils.null_ls.builtins.formatting.usort,
			language_utils.null_ls.builtins.formatting.autoflake,
			-- language_utils.null_ls.builtins.diagnostics.flake8,
			language_utils.null_ls.builtins.code_actions.refactoring,
		},
	})
end

return Python
