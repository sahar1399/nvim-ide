local handle = io.popen("tmux display-message -p '#S'")
local tmux_session_name = handle:read("*l")
handle:close()
local venv_search_path = os.getenv("VENV_SEARCH_PATH")
if tmux_session_name ~= nil and tmux_session_name ~= "" then
	vim.g.wenrix_workdir = venv_search_path
		or (os.getenv("HOME") .. "/work/wenrix/" .. string.gsub(tmux_session_name, "DEV--", "") .. "/src" )
end

local non_modified = os.getenv("NON_MODIFIED")
if non_modified == nil or non_modified == 0 then
	vim.g.non_modified = false
else
	vim.g.non_modified = true
	vim.cmd([[
    :cabbrev q q!
    :cabbrev q!! q!
  ]])
end

require("ide.options")

local only_options = os.getenv("ONLY_OPTIONS")
if only_options == nil or only_options == 0 then
	require("ide.lazy")
end
