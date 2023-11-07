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
		ft = { "markdown", "norg" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neorg/neorg",
		},
		config = function()
			if vim.g.non_modified then
				return
			end

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
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		ft = "http",
		keys = {
			{
				"<leader>Rr",
				function()
					require("rest-nvim").run()
				end,
				opts,
				mode = "n",
				desc = "HTTP REST Run",
			},
			{
				"<leader>Rp",
				function()
					require("rest-nvim").run(true)
				end,
				opts,
				mode = "n",
				desc = "HTTP REST Preview",
			},
			{
				"<leader>Rl",
				function()
					require("rest-nvim").last()
				end,
				opts,
				mode = "n",
				desc = "HTTP REST Run Last",
			},
		},
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					-- show the generated curl command in case you want to launch
					-- the same request via the terminal (can be verbose)
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end,
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = ".env",
				custom_dynamic_variables = {},
				yank_dry_run = true,
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
}
