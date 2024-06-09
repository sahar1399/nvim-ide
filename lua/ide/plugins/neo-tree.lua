local function read_file(path)
	local file = io.open(path, "rb") -- r read mode and b binary mode
	if not file then
		return nil
	end
	local content = file:read("*a") -- *a or *all reads the whole file
	file:close()
	return content
end

local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end
---Get a table of all open buffers, along with all parent paths of those buffers.
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		enabled = not vim.g.non_modified,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"miversen33/netman.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				event = "VeryLazy",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						-- type of hints you want to get
						-- following types are supported
						-- 'statusline-winbar' | 'floating-big-letter'
						-- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
						-- 'floating-big-letter' draw big letter on a floating window
						-- used
						hint = "floating-big-letter",

						-- when you go to window selection mode, status bar will show one of
						-- following letters on them so you can use that letter to select the window
						selection_chars = "ABCDEFJHIJK",

						-- This section contains picker specific configurations
						picker_config = {
							statusline_winbar_picker = {
								-- You can change the display string in status bar.
								-- It supports '%' printf style. Such as `return char .. ': %f'` to display
								-- buffer file path. See :h 'stl' for details.
								selection_display = function(char, windowid)
									return "%=" .. char .. "%="
								end,

								-- whether you want to use winbar instead of the statusline
								-- "always" means to always use winbar,
								-- "never" means to never use winbar
								-- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
								use_winbar = "never", -- "always" | "never" | "smart"
							},

							floating_big_letter = {
								-- window picker plugin provides bunch of big letter fonts
								-- fonts will be lazy loaded as they are being requested
								-- additionally, user can pass in a table of fonts in to font
								-- property to use instead

								font = "ansi-shadow", -- ansi-shadow |
							},
						},

						-- whether to show 'Pick window:' prompt
						show_prompt = true,

						-- prompt message to show to get the user input
						prompt_message = "Pick window: ",

						-- if you want to manually filter out the windows, pass in a function that
						-- takes two parameters. You should return window ids that should be
						-- included in the selection
						-- EX:-
						-- function(window_ids, filters)
						--    -- folder the window_ids
						--    -- return only the ones you want to include
						--    return {1000, 1001}
						-- end
						filter_func = nil,

						-- following filters are only applied when you are using the default filter
						-- defined by this plugin. If you pass in a function to "filter_func"
						-- property, you are on your own
						filter_rules = {
							-- when there is only one window available to pick from, use that window
							-- without prompting the user to select
							autoselect_one = true,

							-- whether you want to include the window you are currently on to window
							-- selection or not
							include_current_win = false,

							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = {
									"NvimTree",
									"neo-tree",
									"notify",
									"aerial",
									"NeogitStatus",
									"neo-tree",
									"qf",
									"Trouble",
									"noice",
								},

								-- if the file type is one of following, the window will be ignored
								buftype = { "terminal", "popup" },
							},

							-- filter using window options
							wo = {},

							-- if the file path contains one of following names, the window
							-- will be ignored
							file_path_contains = {},

							-- if the file name contains one of following names, the window will be
							-- ignored
							file_name_contains = {},
						},

						-- You can pass in the highlight name or a table of content to set as
						-- highlight
						highlights = {
							statusline = {
								focused = {
									fg = "#ededed",
									bg = "#e35e4f",
									bold = true,
								},
								unfocused = {
									fg = "#ededed",
									bg = "#44cc41",
									bold = true,
								},
							},
							winbar = {
								focused = {
									fg = "#ededed",
									bg = "#e35e4f",
									bold = true,
								},
								unfocused = {
									fg = "#ededed",
									bg = "#44cc41",
									bold = true,
								},
							},
						},
					})
				end,
			},
		},
		keys = {
			{
				"<leader>G",
				function()
					vim.cmd([[:Neotree source=git_status git_base=develop]])
				end,
				mode = "n",
				desc = "Open Git File Tree",
			},
			{
				"<leader>F",
				function()
					vim.cmd([[:Neotree source=filesystem]])
				end,
				mode = "n",
				desc = "Open File Tree",
			},
			{
				"<leader>B",
				function()
					vim.cmd([[:Neotree source=bookmarks]])
				end,
				mode = "n",
				desc = "Open Buffer Tree",
			},
			{
				"<leader>j",
				function()
					vim.cmd([[:Neotree reveal_force_cwd last]])
				end,
				mode = "n",
				desc = "Focus File In File Tree",
			},
			-- {
			-- 	"<leader>c",
			-- 	function()
			-- 		vim.cmd([[:NeoTreeClose]])
			-- 	end,
			-- 	mode = "n",
			-- 	desc = "Close File Tree",
			-- },
		},
		config = function()
			-- Unless you are still migrating, remove the deprecated commands from v1.x
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

			-- If you want icons for diagnostic errors, you'll need to define them somewhere:
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
			-- NOTE: this is changed from v1.x, which used the old style of highlight groups
			-- in the form "LspDiagnosticsSignWarning"
			local project_root = vim.fn.getcwd()
			local include_dir_file = project_root .. "/.include_dirs.json"
			local include_dir_table = nil

			if file_exists(include_dir_file) then
				local include_dir_content = read_file(include_dir_file)
				if include_dir_content then
					include_dir_table = vim.json.decode(include_dir_content)
				end
			end

			local hide_by_pattern = include_dir_table == nil and {} or { "*" }
			-- print(dump(hide_by_pattern))
			local always_show = include_dir_table or {}
			-- print(dump(always_show))

			require("neo-tree").setup({
				sources = {
					"filesystem",
					"buffers",
					"git_status",
					"ide.plugins.neotree.sources.bookmarks",
				},
				close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				-- enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs.
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
				sort_case_insensitive = false, -- used when sorting files and directories in the tree
				sort_function = nil, -- use a custom function for sorting files and directories in the tree
				-- sort_function = function (a,b)
				--       if a.type == b.type then
				--           return a.path > b.path
				--       else
				--           return a.type > b.type
				--       end
				--   end , -- this sorts files and directories descendantly
				default_component_configs = {
					container = {
						enable_character_fade = true,
					},
					indent = {
						indent_size = 2,
						padding = 1, -- extra padding on left hand side
						-- indent guides
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						-- expander config, needed for nesting files
						with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
						-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
						-- then these will never be used.
						default = "*",
						highlight = "NeoTreeFileIcon",
					},
					modified = {
						symbol = "[+]",
						highlight = "NeoTreeModified",
					},
					name = {
						trailing_slash = false,
						use_git_status_colors = true,
						highlight = "NeoTreeFileName",
					},
					git_status = {
						symbols = {
							-- Change type
							added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
							deleted = "✖", -- this can only be used in the git_status source
							renamed = "󰁕", -- this can only be used in the git_status source
							-- Status type
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
							conflict = "",
						},
					},
				},
				-- A list of functions, each representing a global custom command
				-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
				-- see `:h neo-tree-custom-commands-global`
				commands = {},
				window = {
					position = "left",
					width = 40,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
					mappings = {
						["<space>"] = {
							"toggle_node",
							nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
						},
						["<2-LeftMouse>"] = "open",
						["<cr>"] = "open",
						["<esc>"] = "cancel", -- close preview or floating neo-tree window
						["P"] = { "toggle_preview", config = { use_float = true } },
						["l"] = "focus_preview",
						["S"] = "open_split",
						["s"] = "open_vsplit",
						["o"] = "open_with_window_picker",
						-- ["S"] = "split_with_window_picker",
						-- ["s"] = "vsplit_with_window_picker",
						["t"] = "open_tabnew",
						-- ["<cr>"] = "open_drop",
						-- ["t"] = "open_tab_drop",
						["w"] = "noop", -- nothing is illegal. its in order to disable this
						--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
						["C"] = "close_node",
						-- ['C'] = 'close_all_subnodes',
						["z"] = "noop", -- nothing is illegal. its in order to disable this
						["Z"] = "expand_all_nodes",
						["a"] = {
							"add",
							-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
							-- some commands may take optional config options, see `:h neo-tree-mappings` for details
							config = {
								show_path = "none", -- "none", "relative", "absolute"
							},
						},
						["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
						-- ["c"] = {
						--  "copy",
						--  config = {
						--    show_path = "none" -- "none", "relative", "absolute"
						--  }
						--}
						["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
						["q"] = "close_window",
						["R"] = "refresh",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
					},
				},
				nesting_rules = {},
				filesystem = {
					filtered_items = {
						visible = true, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
						hide_by_name = {
							--"node_modules"
						},
						-- uses glob style patterns
						hide_by_pattern = {},
						-- remains visible even if other settings would normally hide it
						always_show = always_show,
						never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
							--".DS_Store",
							--"thumbs.db"
						},
						never_show_by_pattern = hide_by_pattern,
					},
					follow_current_file = {
						enabled = false, -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					group_empty_dirs = true, -- when true, empty folders will be grouped together
					hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
					-- in whatever position is specified in window.position
					-- "open_current",  -- netrw disabled, opening a directory opens within the
					-- window like netrw would, regardless of window.position
					-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
					use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
					-- instead of relying on nvim autocmd events.
					window = {
						mappings = {
							["<bs>"] = "navigate_up",
							["."] = "set_root",
							["/"] = "noop", -- nothing is illegal. its in order to disable this
							["H"] = "toggle_hidden",
							["f"] = "fuzzy_finder",
							["D"] = "fuzzy_finder_directory",
							["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
							-- ["D"] = "fuzzy_sorter_directory",
							["F"] = "filter_on_submit",
							["<c-x>"] = "clear_filter",
							["[g"] = "prev_git_modified",
							["]g"] = "next_git_modified",
						},
						fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
							["<down>"] = "move_cursor_down",
							["<C-n>"] = "move_cursor_down",
							["<up>"] = "move_cursor_up",
							["<C-p>"] = "move_cursor_up",
						},
					},

					commands = {}, -- Add a custom command or override a global one using the same function name

					bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
				},
				buffers = {
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--              -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					group_empty_dirs = true, -- when true, empty folders will be grouped together
					show_unloaded = true,
					window = {
						mappings = {
							["bd"] = "buffer_delete",
							["<bs>"] = "navigate_up",
							["."] = "set_root",
						},
					},
				},
				git_status = {
					window = {
						position = "left",
						-- position = "float",
						mappings = {
							["A"] = "noop", -- "git_add_all",
							["gu"] = "noop", -- "git_unstage_file",
							["ga"] = "noop", -- "git_add_file",
							["gr"] = "noop", -- "git_revert_file",
							["gc"] = "noop", -- "git_commit",
							["gp"] = "noop", -- "git_push",
							["gg"] = "noop", -- "git_commit_and_push",
						},
					},
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function(arg)
							vim.cmd([[
          setlocal relativenumber number
        ]])
						end,
					},
				},
			})
		end,
	},
}
