return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"folke/noice.nvim",
		},
		lazy = true,
		keys = {
			{
				"<leader>fS",
				function()
					require("telescope.builtin").lsp_workspace_symbols()
				end,
				{},
				"n",
				desc = "Find Symbols",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				{},
				"n",
				desc = "Find Symbols",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				{},
				"n",
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				{},
				"n",
				desc = "Grep In Files",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				{},
				"n",
				desc = "Find Buffers",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				{},
				"n",
				desc = "Search in Neovim Help",
			},
			{
				"<leader>fm",
				function()
					require("telescope.builtin").man_pages()
				end,
				{},
				"n",
				desc = "Search in Man Pages",
			},
			{
				"<leader>fn",
				"<cmd>Telescope noice<CR>",
				"n",
				{},
				desc = "Search in Noice",
			},
		},
		config = function()
			local telescope = require("telescope")

			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					-- path_display = { "smart" },

					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-c>"] = actions.close,
							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,
							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,
							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.complete_tag,
							["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
						},
						n = {
							["<esc>"] = actions.close,
							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["H"] = actions.move_to_top,
							["M"] = actions.move_to_middle,
							["L"] = actions.move_to_bottom,
							["<Down>"] = actions.move_selection_next,
							["<Up>"] = actions.move_selection_previous,
							["gg"] = actions.move_to_top,
							["G"] = actions.move_to_bottom,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,
							["?"] = actions.which_key,
						},
					},
				},
				pickers = {},
				extensions = {},
			})

			require("telescope").load_extension("noice")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		lazy = true,
		keys = {
			{
				"<leader>fy",
				"<cmd>Telescope neoclip extra=star,plus,b<CR>",
				"n",
				{},
				desc = "Search In System Clipboard",
			},
			{
				"<leader>fM",
				"<cmd>Telescope macroscope<CR>",
				"n",
				{},
				desc = "Search In Macros",
			},
		},
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neoclip").setup({
				history = 1000,
				enable_persistent_history = false,
				length_limit = 1048576,
				continuous_sync = false,
				db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
				filter = nil,
				preview = true,
				prompt = nil,
				default_register = '"',
				default_register_macros = "q",
				enable_macro_history = true,
				content_spec_column = false,
				on_select = {
					move_to_front = false,
				},
				on_paste = {
					set_reg = false,
					move_to_front = false,
				},
				on_replay = {
					set_reg = false,
					move_to_front = false,
				},
				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-p>",
							paste_behind = "<c-k>",
							replay = "<c-q>", -- replay a macro
							delete = "<c-d>", -- delete an entry
							custom = {},
						},
						n = {
							select = "<cr>",
							paste = "p",
							--- It is possible to map to more than one key.
							-- paste = { 'p', '<c-p>' },
							paste_behind = "P",
							replay = "q",
							delete = "d",
							custom = {},
						},
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						select = "default",
						paste = "ctrl-p",
						paste_behind = "ctrl-k",
						custom = {},
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("neoclip")
			require("telescope").load_extension("macroscope")
		end,
	},
}
