local opts = { silent = true }

local function getnavic()
	local navic = require("nvim-navic")

	if navic.is_available() then
		return navic.get_location()
	else
		return
	end
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "day", -- The theme is used when the background is set to light
				transparent = true, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

				--- You can override specific color groups to use other groups or a hex color
				--- function will be called with a ColorScheme table
				---@param colors ColorScheme
				on_colors = function(colors)
					colors.bg_statusline = colors.none
				end,

				--- You can override specific highlights to use other groups or a hex color
				--- function will be called with a Highlights and ColorScheme table
				---@param hl Highlights
				---@param c ColorScheme
				on_highlights = function(hl, c)
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}

					-- STATUS BUFFER
					hl.NeogitBranch = { fg = c.magenta }
					hl.NeogitBranchHead = { fg = c.magenta }
					hl.NeogitRemote = { fg = c.purple }
					-- hl.NeogitObjectId = {}
					hl.NeogitStash = { fg = c.red }
					-- hl.NeogitFold = {}
					-- hl.NeogitRebaseDone = {}
					hl.NeogitTagName = { fg = c.red }
					-- hl.NeogitTagDistance = {}
					hl.NeogitStatusHEAD = { fg = c.red }

					-- STATUS BUFFER SECTION HEADERS
					hl.NeogitSectionHeader = { fg = c.green }
					hl.NeogitUnpushedTo = { fg = c.cyan }
					hl.NeogitUnmergedInto = { fg = c.cyan }
					hl.NeogitUnpulledFrom = { fg = c.cyan }
					hl.NeogitUntrackedfiles = { fg = c.comment }
					-- hl.NeogitUnstagedchanges = {}
					-- hl.NeogitUnmergedchanges = {}
					-- hl.NeogitUnpushedchanges = {}
					-- hl.NeogitUnpulledchanges = {}
					hl.NeogitRecentcommits = { fg = c.cyan }
					-- hl.NeogitStagedchanges = {}
					hl.NeogitStashes = { fg = c.red1 }
					hl.NeogitRebasing = { fg = c.red }
					hl.NeogitReverting = { fg = c.red }
					hl.NeogitPicking = { fg = c.red }
					hl.NeogitMerging = { fg = c.red }
					-- hl.NeogitBisecting = {}
					hl.NeogitSectionHeaderCount = { fg = c.magenta }

					-- STATUS BUFFER FILE
					hl.NeogitChangeModified = { fg = c.git.change, bg = c.diff.change }
					hl.NeogitChangeAdded = { fg = c.git.add, bg = c.diff.add }
					hl.NeogitChangeDeleted = { fg = c.git.delete, bg = c.diff.delete }
					hl.NeogitChangeRenamed = { fg = c.git.change, bg = c.diff.change }
					hl.NeogitChangeUpdated = { fg = c.git.change, bg = c.diff.change }
					hl.NeogitChangeCopied = { fg = c.git.add, bg = c.diff.add }
					hl.NeogitChangeNewFile = { fg = c.git.add, bg = c.diff.add }
					-- hl.NeogitChangeUnmerged = {}
				end,
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

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
				plugins = {
					"dap",
					"gitsigns",
					"hop",
					"illuminate",
					"indent-blankline",
					"neogit",
					"neotest",
					"neo-tree",
					"neorg",
					"noice",
					"nvim-cmp",
					"nvim-navic",
					"nvim-tree",
					"nvim-web-devicons",
					"rainbow-delimiters",
					"telescope",
					"trouble",
					"which-key",
					"nvim-notify",
				},
				disable = {
					colored_cursor = false, -- Disable the colored cursor
					borders = false, -- Disable borders between verticaly split windows
					background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
					term_colors = false, -- Prevent the theme from setting terminal colors
					eob_lines = false, -- Hide the end-of-buffer lines
				},
				high_visibility = {
					lighter = true, -- Enable higher contrast text for lighter style
					darker = true, -- Enable higher contrast text for darker style
				},
				lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )
				async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)
				custom_colors = nil, -- If you want to everride the default colors, set this to a function
				custom_highlights = {
					DiffAdd = { bg = "#104935" },
					DiffChange = { bg = "#272D43" },
					DiffText = { bg = "#394b70" },
					DiffDelete = { bg = "#6F2D3D" },
					DiffviewDiffAddAsDelete = { bg = "#3f2d3d" },
					DiffviewDiffDelete = { fg = "#3B4252" },
				}, -- Overwrite highlights with your own
			})
			--
			-- vim.cmd([[colorscheme material]])
		end,
	},
	-- {
	-- 	"declancm/cinnamon.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("cinnamon").setup({
	-- 			-- KEYMAPS:
	-- 			default_keymaps = true, -- Create default keymaps.
	-- 			extra_keymaps = false, -- Create extra keymaps.
	-- 			extended_keymaps = false, -- Create extended keymaps.
	-- 			override_keymaps = false, -- The plugin keymaps will override any existing keymaps.
	-- 			-- OPTIONS:
	-- 			always_scroll = false, -- Scroll the cursor even when the window hasn't scrolled.
	-- 			centered = true, -- Keep cursor centered in window when using window scrolling.
	-- 			disabled = true, -- Disables the plugin.
	-- 			default_delay = 3, -- The default delay (in ms) between each line when scrolling.
	-- 			hide_cursor = false, -- Hide the cursor while scrolling. Requires enabling termguicolors!
	-- 			horizontal_scroll = true, -- Enable smooth horizontal scrolling when view shifts left or right.
	-- 			max_length = -1, -- Maximum length (in ms) of a command. The line delay will be
	-- 			-- re-calculated. Setting to -1 will disable this option.
	-- 			scroll_limit = 150, -- Max number of lines moved before scrolling is skipped. Setting
	-- 			-- to -1 will disable this option.
	-- 		})
	-- 	end,
	-- },
	{
		-- "luukvbaal/stabilize.nvim",
		-- lazy = false,
		-- config = function()
		-- 	require("stabilize").setup()
		-- end,
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
		enabled = not vim.g.non_modified,
		keys = {
			{ "gp", ":BufferLinePick<CR>", opts, mode = "n", desc = "Pick Tab" },
			{ "gx", ":BufferLinePickClose<CR>", opts, mode = "n", desc = "Close Tab" },
			{ "gt", ":BufferLineCycleNext<CR>", opts, mode = "n", desc = "Next Tab" },
			{ "gT", ":BufferLineCyclePrev<CR>", opts, mode = "n", desc = "Prev Tab" },
		},
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
		event = "BufRead *",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
			-- "stevearc/aerial.nvim",
			"f-person/git-blame.nvim",
		},
		config = function()
			local navic = require("nvim-navic")
			local git_blame = require("gitblame")

			require("lualine").setup({
				options = {
					icons_enabled = true,
					-- theme = "material-stealth",
					theme = "tokyonight",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						"packer",
						"NVimTree",
						"NeoTree",
						"neo-tree",
						-- "aerial",
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
					lualine_d = {
						{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
					},
					lualine_e = { { getnavic } },
					lualine_f = {},
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
		main = "ibl",
		branch = "master",
		lazy = false,
		config = function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })

			require("ibl").setup({
				enabled = true,
				debounce = 50,
				viewport_buffer = {
					min = 30,
					max = 500,
				},
				indent = {
					char = "▎",
					tab_char = nil,
					highlight = {
						"RainbowRed",
						"RainbowYellow",
						"RainbowBlue",
						"RainbowOrange",
						"RainbowGreen",
						"RainbowViolet",
						"RainbowCyan",
					},
					smart_indent_cap = true,
					priority = 1,
				},
				whitespace = {
					highlight = "Whitespace",
					remove_blankline_trail = true,
				},
				scope = {
					enabled = false,
					show_start = true,
					show_end = true,
					injected_languages = true,
					-- highlight = "LineNr",
					priority = 1024,
					exclude = {
						language = {
							"markdown",
							"markdown_inline",
							"comment",
							"jsdoc",
							"org",
						},
						node_type = {
							["*"] = {
								"source_file",
								"comment",
								"line_comment",
							},
							rust = {
								"use_declaration",
								"identifier",
								"scoped_identifier",
							},
							lua = {
								"chunk",
								"block",
							},
							typescript = {
								"identifier",
								"import_statement",
								"program",
							},
							python = {
								"module",
							},
							html = {
								"fragment",
							},
							bash = {
								"program",
							},
						},
					},
				},
				exclude = {
					filetypes = {
						"lspinfo",
						"packer",
						"checkhealth",
						"help",
						"man",
						"gitcommit",
						"TelescopePrompt",
						"TelescopeResults",
						"",
					},
					buftypes = {
						"terminal",
						"nofile",
						"quickfix",
						"prompt",
					},
				},
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = "BufRead *",
		config = function()
			require("illuminate").configure({})
		end,
	},
	{
		"xiyaowong/nvim-transparent",
		lazy = false,
		config = function()
			require("transparent").setup({
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
			})
		end,
	},
	-- {
	-- 	"anuvyklack/pretty-fold.nvim",
	-- 	lazy = true,
	-- 	event = "BufRead *",
	-- 	config = function()
	-- 		require("pretty-fold").setup({
	-- 			keep_indentation = false,
	-- 			fill_char = "━",
	-- 			sections = {
	-- 				left = {
	-- 					"━ ",
	-- 					function()
	-- 						return string.rep("*", vim.v.foldlevel)
	-- 					end,
	-- 					" ━┫",
	-- 					"content",
	-- 					"┣",
	-- 				},
	-- 				right = {
	-- 					"┫ ",
	-- 					"number_of_folded_lines",
	-- 					": ",
	-- 					"percentage",
	-- 					" ┣━━",
	-- 				},
	-- 			},
	-- 			remove_fold_markers = true,
	-- 			-- Possible values:
	-- 			-- "delete" : Delete all comment signs from the fold string.
	-- 			-- "spaces" : Replace all comment signs with equal number of spaces.
	-- 			-- false    : Do nothing with comment signs.
	-- 			process_comment_signs = "spaces",
	-- 			-- Comment signs additional to the value of `&commentstring` option.
	-- 			comment_signs = {},
	-- 			-- List of patterns that will be removed from content foldtext section.
	-- 			stop_words = {
	-- 				"@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
	-- 			},
	-- 			add_close_pattern = true, -- true, 'last_line' or false
	-- 			matchup_patterns = {
	-- 				{ "{", "}" },
	-- 				{ "%(", ")" }, -- % to escape lua pattern char
	-- 				{ "%[", "]" }, -- % to escape lua pattern char
	-- 			},
	-- 			ft_ignore = { "neorg" },
	-- 		})
	-- 	end,
	-- },
	{
		"kwkarlwang/bufresize.nvim",
		lazy = false,
		config = function()
			local opts = { noremap = true, silent = true }
			require("bufresize").setup({
				register = {
					keys = {
						{ "n", "<C-w><", "<C-w><", opts },
						{ "n", "<C-w>>", "<C-w>>", opts },
						{ "n", "<C-w>+", "<C-w>+", opts },
						{ "n", "<C-w>-", "<C-w>-", opts },
						{ "n", "<C-w>_", "<C-w>_", opts },
						{ "n", "<C-w>=", "<C-w>=", opts },
						{ "n", "<C-w>|", "<C-w>|", opts },
						{ "", "<LeftRelease>", "<LeftRelease>", opts },
						{ "i", "<LeftRelease>", "<LeftRelease><C-o>", opts },
					},
					trigger_events = { "BufWinEnter", "WinEnter", "VimResized" },
				},
				resize = {
					keys = {},
					trigger_events = { "VimResized" },
					increment = 1,
				},
			})
		end,
	},
}
