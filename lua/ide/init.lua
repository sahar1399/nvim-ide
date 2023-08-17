require("ide.options")

local only_options = os.getenv("ONLY_OPTIONS")
if only_options == nil or only_options == 0 then
	require("ide.lazy")
end
