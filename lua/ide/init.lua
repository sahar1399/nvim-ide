local non_modified = os.getenv("NON_MODIFIED")
if non_modified == nil or non_modified == 0 then
	vim.g.non_modified = false
else
	vim.g.non_modified = true
	vim.cmd([[
    :cabbrev q q!
  ]])
end

require("ide.options")

local only_options = os.getenv("ONLY_OPTIONS")
if only_options == nil or only_options == 0 then
	require("ide.lazy")
end
