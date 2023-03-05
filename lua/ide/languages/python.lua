LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Python = {}
Python.__index = Python

function Python:setup(language_utils)
  language_utils.lspconfig.pyright.setup({
    on_attach = language_utils.on_attach,
    capabilities = language_utils.capabilities,
    flags = language_utils.lsp_flags,
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
  })

  require("dap-python").setup(Consts.PYTHON3_PATH, {})

  return LanguageResults.new({
    null_ls_sources = {
      language_utils.null_ls.builtins.formatting.black,
      language_utils.null_ls.builtins.formatting.isort,
    },
  })
end

return Python