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

  -- this doesn't work...
  -- I think:
  -- vim-helm attaches filetype=helm after BufEnter
  -- when this event happens, the null_ls already attached the yamllint to the file
  local yamllint = language_utils.null_ls.builtins.diagnostics.yamllint.with({
    disabled_filetypes = { "helm" },
  })

  return LanguageResults.new({
    null_ls_sources = {
      language_utils.null_ls.builtins.formatting.yamlfmt,
      yamllint,
    },
  })
end

return YAML
