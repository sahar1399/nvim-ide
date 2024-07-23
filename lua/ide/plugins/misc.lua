local opts = { noremap = true, silent = true }

return {
	{
		"ziontee113/icon-picker.nvim",
		dependencies = { "stevearc/dressing.nvim" },
		lazy = true,
		keys = {
			{ "<leader>I", "<cmd>IconPickerNormal<cr>", opts, mode = "n", desc = "Pick Icon" },
		},
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},
	{
		"Pocco81/HighStr.nvim",
		lazy = true,
		keys = {
			{ "<leader>h", ":<c-u>HSHighlight 1<CR>", opts, mode = "v", desc = "Higlight" },
			{ "<leader>H", ":<c-u>HSRmHighlight<CR>", opts, mode = "v", desc = "Remove Higlight" },
		},
		config = function()
			local high_str = require("high-str")

			high_str.setup({
				verbosity = 0,
				saving_path = "/tmp/highstr/",
				highlight_colors = {
					-- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
					color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
					color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
					color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
					color_3 = { "#8A2BE2", "smart" }, -- Proton purple
					color_4 = { "#FF4500", "smart" }, -- Orange red
					color_5 = { "#008000", "smart" }, -- Office green
					color_6 = { "#0000FF", "smart" }, -- Just blue
					color_7 = { "#FFC0CB", "smart" }, -- Blush pink
					color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
					color_9 = { "#7d5c34", "smart" }, -- Fallow brown
				},
			})
		end,
	},
	{
		"weirongxu/plantuml-previewer.vim",
		lazy = true,
		event = { "BufRead *.puml", "BufRead *.uml", "BufRead *.plantuml", "BufRead *.plant" },
		dependencies = {
			"tyru/open-browser.vim",
			"aklt/plantuml-syntax",
		},
	},
	{
		"davidgranstrom/nvim-markdown-preview",
		lazy = true,
		event = { "BufRead *.markdown", "BufRead *.mkd", "BufRead *.mk", "BufRead *.md" },
	},
	{
		"3rd/image.nvim",
		lazy = true,
		enabled = not vim.g.non_modified,
		ft = { "markdown", "norg" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neorg/neorg",
		},
		config = function()
			require("image").setup({
				backend = "kitty",
				integrations = {
					markdown = {
						enabled = true,
						sizing_strategy = "auto",
						download_remote_images = true,
						clear_in_insert_mode = false,
					},
					neorg = {
						enabled = true,
						download_remote_images = true,
						clear_in_insert_mode = false,
					},
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				kitty_method = "normal",
				kitty_tmux_write_delay = 10, -- makes rendering more reliable with Kitty+Tmux
				window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			})
		end,
	},
	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
		opts = {
			-- if a buffer has been inactive for this many minutes, close it
			retirementAgeMins = 20,

			-- filetypes to ignore
			ignoredFiletypes = {},

			-- ignore files matching this lua pattern; empty string disables this setting
			ignoreFilenamePattern = "",

			-- will not close the alternate file
			ignoreAltFile = true,

			-- minimum number of open buffers for auto-closing to become active. E.g.,
			-- by setting this to 4, no auto-closing will take place when you have 3
			-- or fewer open buffers. Note that this plugin never closes the currently
			-- active buffer, so a number < 2 will effectively disable this setting.
			minimumBufferNum = 1,

			-- will ignore buffers with unsaved changes. If false, the buffers will
			-- automatically be written and then closed.
			ignoreUnsavedChangesBufs = true,

			-- ignore non-empty buftypes, for example terminal buffers
			ignoreSpecialBuftypes = true,

			-- ignore visible buffers ("a" in `:buffers`). Buffers that are open in
			-- a window or in a tab are considered visible by vim.
			ignoreVisibleBufs = true,

			-- ignore unloaded buffers. Session-management plugin often add buffers
			-- to the buffer list without loading them.
			ignoreUnloadedBufs = false,

			-- Show notification on closing. Works with nvim-notify or noice.nvim
			notificationOnAutoClose = false,
		},
	},
	{
		"mistweaverco/kulala.nvim",
		lazy = false,
		ft = "http",
		keys = {
			{
				"<leader>Rr",
				function()
					require("kulala").run()
				end,
				opts,
				mode = "n",
				desc = "HTTP REST Run",
			},
			{
				"<leader>Rv",
				function()
					require("kulala").toggle_view()
				end,
				opts,
				mode = "n",
				desc = "HTTP REST toggle view",
			},
		},
		config = function()
			-- Setup is required, even if you don't pass any options
			require("kulala").setup({
				-- default_view, body or headers
				default_view = "body",
				-- dev, test, prod, can be anything
				-- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
				default_env = "dev",
				-- enable/disable debug mode
				debug = false,
				-- default formatters for different content types
				formatters = {
					json = { "jq", "." },
					xml = { "xmllint", "--format", "-" },
					html = { "xmllint", "--format", "--html", "-" },
				},
				-- default icons
				icons = {
					inlay = {
						loading = "⏳",
						done = "✅ ",
					},
					lualine = "🐼",
				},
				-- additional cURL options
				-- e.g. { "--insecure", "-A", "Mozilla/5.0" }
				additional_curl_options = {},
			})
		end,
	},
	{
		"tomiis4/Hypersonic.nvim",

		lazy = false,

		keys = {
			{
				"<leader>er",
				"<cmd>Hypersonic<cr>",
				opts,
				mode = "n",
				desc = "Toggle Regex Explainer",
			},
			{
				"<leader>er",
				":<c-u>Hypersonic<cr>",
				opts,
				mode = "v",
				desc = "Toggle Regex Explainer",
			},
		},

		opts = {},
	},
	{ "mipmip/vim-scimark" },
	{
		"chrisgrieser/nvim-scissors",
		keys = {
			{
				"<leader>se",
				function()
					require("scissors").editSnippet()
				end,
				mode = "n",
				"Snippet Edit",
			},
			{
				"<leader>sa",
				function()
					require("scissors").addNewSnippet()
				end,
				mode = { "n", "x", "v" },
				"Snippet Add",
			},
		},
		config = function()
			require("scissors").setup({
				snippetDir = vim.fn.stdpath("config") .. "/snippets",
				editSnippetPopup = {
					height = 0.4, -- relative to the window, number between 0 and 1
					width = 0.6,
					border = "rounded",
					keymaps = {
						cancel = "q",
						saveChanges = "<CR>",
						goBackToSearch = "<BS>",
						delete = "<C-BS>",
						openInFile = "<C-o>",
						insertNextToken = "<C-t>", -- works in insert & normal mode
					},
				},
				-- `none` writes as a minified json file using `vim.encode.json`.
				-- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
				-- you version control your snippets.
				jsonFormatter = "jq", -- "yq"|"jq"|"none"
			})
		end,
	},
	{
		"rafcamlet/nvim-luapad",
		ft = "lua",
		config = function()
			require("luapad").setup({})
		end,
	},
	{
		"krivahtoo/silicon.nvim",
		build = "./install.sh build",
		branch = "nvim-0.9",
		config = function()
			require("silicon").setup({
				font = "JetBrainsMono Nerd Font=16",
				theme = "Monokai Extended",
				output = {
					path = "/home/sahar/notes/code-screenshots",
					clipboard = false,
					format = "silicon_[year][month][day]_[hour][minute][second].png",
				},
				line_number = true,
				gobble = true,
				round_corner = true,
				window_controls = false,
				window_title = function()
					return vim.fn.fnamemodify(vim.fn.bufname(vim.fn.bufnr()), ":~:.")
				end,
			})
		end,
	},
}
