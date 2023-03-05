LanguageResults = {}
LanguageResults.__index = LanguageResults

function LanguageResults.new(obj)
  return {
    null_ls_sources = obj.null_ls_sources,
  }
end

return LanguageResults
