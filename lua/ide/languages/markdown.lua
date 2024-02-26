LanguageResults = require("ide.languages.api.language_results")
Consts = require("ide.consts")

Markdown = {}
Markdown.__index = Markdown

function Markdown:setup(language_utils)
  if not vim.g.non_modified then
    language_utils.lspconfig.grammarly.setup({
      on_attach = language_utils.on_attach,
      capabilities = language_utils.capabilities,
      flags = language_utils.lsp_flags,
      filetypes = { "markdown", "norg" },
      clientId = "client_Ho2fSR5ooHtVvFGJ3x9szi",
    })
  end

  return LanguageResults.new({
    null_ls_sources = {},
  })
end

return Markdown
