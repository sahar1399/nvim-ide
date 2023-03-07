local opts = { silent = true }

return {
	{
		"marko-cerovac/material.nvim",
		lazy = false,
		config = function()
			vim.g.material_style = "darker"

			require("material").setup({
				contrast = {
					terminal = true, -- Enable contrast for the built-in terminal
					sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
					floating_windows = true, -- Enable contrast for floating windows
					cursor_line = true, -- Enable darker background for the cursor line
					non_current_windows = true, -- Enable darker background for non-current windows
					filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
				},
				styles = {
					-- Give comments style such as bold, italic, underline etc.
					comments = { --[[ italic = true ]]
					},
					strings = { --[[ bold = true ]]
					},
					keywords = { --[[ underline = true ]]
					},
					functions = { --[[ bold = true, undercurl = true ]]
					},
					variables = {},
					operators = {},
					types = {},
				},
				plugins = { -- Uncomment the plugins that you use to highlight them
					-- Available plugins:
					"dap",
					-- "dashboard",
					"gitsigns",
					-- "hop",
					"indent-blankline",
					"lspsaga",
					-- "mini",
					"neogit",
					"nvim-cmp",
					-- "nvim-navic",
					-- "nvim-tree",
					"nvim-web-devicons",
					-- "sneak",
					"telescope",
					"trouble",
					"which-key",
				},
				disable = {
					colored_cursor = false, -- Disable the colored cursor
					borders = false, -- Disable borders between verticaly split windows
					background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
					term_colors = false, -- Prevent the theme from setting terminal colors
					eob_lines = false, -- Hide the end-of-buffer lines
				},
				high_visibility = {
					lighter = false, -- Enable higher contrast text for lighter style
					darker = false, -- Enable higher contrast text for darker style
				},
				lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
				async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
				custom_colors = nil, -- If you want to everride the default colors, set this to a function
				custom_highlights = {}, -- Overwrite highlights with your own
			})

			vim.cmd([[colorscheme material]])
		end,
	},
	{
		"declancm/cinnamon.nvim",
		lazy = false,
		config = function()
			require("cinnamon").setup({
				-- KEYMAPS:
				default_keymaps = true, -- Create default keymaps.
				extra_keymaps = false, -- Create extra keymaps.
				extended_keymaps = false, -- Create extended keymaps.
				override_keymaps = false, -- The plugin keymaps will override any existing keymaps.
				-- OPTIONS:
				always_scroll = false, -- Scroll the cursor even when the window hasn't scrolled.
				centered = true, -- Keep cursor centered in window when using window scrolling.
				disabled = true, -- Disables the plugin.
				default_delay = 3, -- The default delay (in ms) between each line when scrolling.
				hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
				horizontal_scroll = true, -- Enable smooth horizontal scrolling when view shifts left or right.
				max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
				-- re-calculated. Setting to -1 will disable this option.
				scroll_limit = 150, -- Max number of lines moved before scrolling is skipped. Setting
				-- to -1 will disable this option.
			})
		end,
	},
	{
		{
			"luukvbaal/stabilize.nvim",
			lazy = false,
			config = function()
				require("stabilize").setup()
			end,
		},
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = "LspAttach",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		lazy = true,
		event = "BufRead *",
		dependencies = { "kevinhwang91/nvim-hlslens", "lewis6991/gitsigns.nvim" },
		config = function()
			require("scrollbar").setup({})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		keys = {
			{ "gp", ":BufferLinePick<CR>", "n", opts, desc = "Pick Tab" },
			{ "gx", ":BufferLinePickClose<CR>", "n", opts, desc = "Close Tab" },
			{ "gt", ":BufferLineCycleNext<CR>", "n", opts, desc = "Next Tab" },
			{ "gT", ":BufferLineCyclePrev<CR>", "n", opts, desc = "Prev Tab" },
		},
		version = "v3.*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- set to "tabs" to only show tabpages instead
					numbers = "ordinal",
					close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
					right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
					left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
					middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not 'icon'
						style = "icon",
					},
					buffer_close_icon = "",
					modified_icon = "●",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					--- name_formatter can be used to change the buffer's label in the bufferline.
					--- Please note some names can/will break the
					--- bufferline so use this at your discretion knowing that it has
					--- some limitations that will *NOT* be fixed.
					name_formatter = function(buf) -- buf contains:
						-- name                | str        | the basename of the active file
						-- path                | str        | the full path of the active file
						-- bufnr (buffer only) | int        | the number of the active buffer
						-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
						-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
					end,
					max_name_length = 18,
					max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
					truncate_names = true, -- whether or not tab names should be truncated
					tab_size = 18,
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,
					-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						return "(" .. count .. ")"
					end,
					-- NOTE: this will be called a lot so don't do any heavy processing here
					custom_filter = function(buf_number, buf_numbers)
						-- filter out filetypes you don't want to see
						if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
							return true
						end
						-- filter out by buffer name
						if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
							return true
						end
						-- filter out based on arbitrary rules
						-- e.g. filter out vim wiki buffer from tabline in your work repo
						if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
							return true
						end
						-- filter out by it's index number in list (don't show first buffer)
						if buf_numbers[1] ~= buf_number then
							return true
						end
					end,
					offsets = {
						{
							filetype = "NeoTree",
							text = "File Explorer",
							text_align = "left",
							separator = true,
						},
					},
					color_icons = true, -- whether or not to add the filetype icon highlights
					show_buffer_icons = true, -- disable filetype icons for buffers
					show_buffer_close_icons = true,
					show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
					show_close_icon = true,
					show_tab_indicators = true,
					show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
					persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
					-- can also be a table containing 2 custom separators
					-- [focused and unfocused]. eg: { '|', '|' }
					separator_style = "thin", -- "slant" | "thick" | "thin" | { "any", "any" },
					enforce_regular_tabs = false,
					always_show_bufferline = true,
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
					sort_by = "relative_directory", -- "insert_after_current" | "insert_at_end" | "id" | "extension" | "relative_directory" | "directory" | "tabs" | function(buffer_a, buffer_b) return buffer_a.modified > buffer_b.modified end
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = "BufRead **",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "material-stealth",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						"packer",
						"NVimTree",
						"NeoTree",
						"neo-tree",
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_d = {},
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = "BufRead **",
		config = function()
			vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
			vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

			vim.opt.list = true
			vim.opt.listchars:append("space:⋅")
			vim.opt.listchars:append("eol:↴")

			require("indent_blankline").setup({
				space_char_blankline = " ",
				char_highlight_list = {
					"IndentBlanklineIndent1",
					"IndentBlanklineIndent2",
					"IndentBlanklineIndent3",
					"IndentBlanklineIndent4",
					"IndentBlanklineIndent5",
					"IndentBlanklineIndent6",
				},
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufRead **",
		config = function()
			require("illuminate").configure({})
		end,
	},
	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		config = function()
			require("transparent").setup({
				enable = true, -- boolean: enable transparent
				extra_groups = { -- table/string: additional groups that should be cleared
					-- In particular, when you set it to 'all', that means all available groups

					-- example of akinsho/nvim-bufferline.lua
					"BufferLineTabClose",
					"BufferlineBufferSelected",
					"BufferLineFill",
					"BufferLineBackground",
					"BufferLineSeparator",
					"BufferLineIndicatorSelected",
				},
				exclude = {}, -- table: groups you don't want to clear
			})
		end,
	},
	{
		"anuvyklack/pretty-fold.nvim",
		lazy = true,
		event = "BufRead **",
		config = function()
			require("pretty-fold").setup({
				keep_indentation = false,
				fill_char = "━",
				sections = {
					left = {
						"━ ",
						function()
							return string.rep("*", vim.v.foldlevel)
						end,
						" ━┫",
						"content",
						"┣",
					},
					right = {
						"┫ ",
						"number_of_folded_lines",
						": ",
						"percentage",
						" ┣━━",
					},
				},
				remove_fold_markers = true,
				-- Possible values:
				-- "delete" : Delete all comment signs from the fold string.
				-- "spaces" : Replace all comment signs with equal number of spaces.
				-- false    : Do nothing with comment signs.
				process_comment_signs = "spaces",
				-- Comment signs additional to the value of `&commentstring` option.
				comment_signs = {},
				-- List of patterns that will be removed from content foldtext section.
				stop_words = {
					"@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
				},
				add_close_pattern = true, -- true, 'last_line' or false
				matchup_patterns = {
					{ "{", "}" },
					{ "%(", ")" }, -- % to escape lua pattern char
					{ "%[", "]" }, -- % to escape lua pattern char
				},
				ft_ignore = { "neorg" },
			})
		end,
	},
}
