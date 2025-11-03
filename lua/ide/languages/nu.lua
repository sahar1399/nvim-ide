LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

NU = {}
NU.__index = NU

function NU:setup(language_utils)
  language_utils.lspconfig.nushell.setup({
      on_attach = language_utils.on_attach,
      capabilities = language_utils.capabilities,
      flags = language_utils.lsp_flags,
      filetypes = { "nu" },
    })

  return LanguageResults.new({
    null_ls_sources = {},
  })
end

return NU
