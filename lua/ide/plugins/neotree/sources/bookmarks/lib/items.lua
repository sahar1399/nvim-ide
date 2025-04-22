local vim = vim
local renderer = require("neo-tree.ui.renderer")
local file_items = require("neo-tree.sources.common.file-items")
local log = require("neo-tree.log")
local git = require("neo-tree.git")

local M = {}

local function read_file(path)
	local file = io.open(path, "rb") -- r read mode and b binary mode
	if not file then
		return nil
	end
	local content = file:read("*a") -- *a or *all reads the whole file
	file:close()
	return content
end

local function find_project_root()
    local current_dir = vim.fn.getcwd()
    local parent_dir = current_dir

    while parent_dir ~= "/" do
        if vim.fn.isdirectory(parent_dir .. "/.git") == 1 then
            return parent_dir
        end
        local new_parent = vim.fn.fnamemodify(parent_dir, ":h")
        if new_parent == parent_dir then -- Reached root or cannot go up
            break
        end
        parent_dir = new_parent
    end

    -- If no .git found, return the original cwd
    return current_dir
end

local project_root = find_project_root()

---Get a table of all open buffers, along with all parent paths of those buffers.
---The paths are the keys of the table, and all the values are 'true'.
M.get_bookmarks = function(state)
  if state.loading then
    return
  end
  state.loading = true

  -- local _, project_root = git.status(state.git_base, true)
  --
  state.path = project_root or state.path or vim.fn.getcwd()
  local context = file_items.create_context()
  context.state = state
  
  -- Create root folder
  local root = file_items.create_item(context, state.path, "directory")

  root.name = vim.fn.fnamemodify(root.path, ":~")
  root.loaded = true
  root.search_pattern = state.search_pattern
  context.folders[root.path] = root

  local bookmarks_file = project_root .. "/.bookmarks.json"
  local bookmarks_content = read_file(bookmarks_file)
  local bookmarks_table = vim.json.decode(bookmarks_content)

  local files = {}
  for k, _ in pairs(bookmarks_table["data"]) do
    files[k] = true
  end

  for path, _ in pairs(files) do
    local success, item = pcall(file_items.create_item, context, path, "file")
    if success then
    else
      log.error("Error creating item for " .. path .. ": " .. item)
    end
  end

  state.default_expanded_nodes = {}
  for id, _ in pairs(context.folders) do
    table.insert(state.default_expanded_nodes, id)
  end

  file_items.advanced_sort(root.children, state)
  renderer.show_nodes({ root }, state)
  state.loading = false
end

return M

