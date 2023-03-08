function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

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
				"<leader>fr",
				function()
					local text = vim.getVisualSelection()
					require("telescope.builtin").lsp_references({ default_text = text })
				end,
				mode = "v",
				desc = "Find References",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				mode = "n",
				desc = "Find References",
			},
			{
				"<leader>ci",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_incoming_calls({ default_text = text })
				end,
				mode = "v",
				desc = "Find Incoming Calls",
			},
			{
				"<leader>ci",
				function()
					require("telescope.builtin").lsp_incoming_calls()
				end,
				mode = "n",
				desc = "Find Incoming Calls",
			},
			{
				"<leader>co",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_outgoing_calls({ default_text = text })
				end,
				mode = "v",
				desc = "Find Outgoing Calls",
			},
			{
				"<leader>co",
				function()
					require("telescope.builtin").lsp_outgoing_calls()
				end,
				mode = "n",
				desc = "Find Outgoing Calls",
			},
			{
				"<leader>fd",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_definitions({ default_text = text })
				end,
				mode = "v",
				desc = "Find Definitions",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				mode = "n",
				desc = "Find Definitions",
			},
			{
				"<leader>ft",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_type_definitions({ default_text = text })
				end,
				mode = "v",
				desc = "Find Type Definitions",
			},
			{
				"<leader>ft",
				function()
					require("telescope.builtin").lsp_type_definitions()
				end,
				mode = "n",
				desc = "Find Type Definitions",
			},
			{
				"<leader>fi",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_implementations({ default_text = text })
				end,
				mode = "v",
				desc = "Find Implementations",
			},
			{
				"<leader>fi",
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				mode = "n",
				desc = "Find Implementations",
			},
			{
				"<leader>fS",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_dynamic_workspace_symbols({ default_text = text })
				end,
				mode = "v",
				desc = "Find Symbols",
			},
			{
				"<leader>fS",
				function()
					require("telescope.builtin").lsp_dynamic_workspace_symbols()
				end,
				mode = "n",
				desc = "Find Symbols",
			},
			{
				"<leader>fs",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").lsp_document_symbols({ default_text = text })
				end,
				mode = "v",
				desc = "Find Symbols",
			},
			{
				"<leader>fs",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				mode = "n",
				desc = "Find Symbols",
			},
			{
				"<leader>ff",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").find_files({ default_text = text })
				end,
				mode = "v",
				desc = "Find Files",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				mode = "n",
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").live_grep({ default_text = text })
				end,
				mode = "v",
				desc = "Grep In Files",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				mode = "n",
				desc = "Grep In Files",
			},
			{
				"<leader>fb",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").buffers({ default_text = text })
				end,
				mode = "v",
				desc = "Find Buffers",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				mode = "n",
				desc = "Find Buffers",
			},
			{
				"<leader>fh",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").help_tags({ default_text = text })
				end,
				mode = "v",
				desc = "Search in Neovim Help",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				mode = "n",
				desc = "Search in Neovim Help",
			},
			{
				"<leader>fm",
				function()
					text = vim.getVisualSelection()
					require("telescope.builtin").man_pages({ default_text = text })
				end,
				mode = "v",
				desc = "Search in Man Pages",
			},
			{
				"<leader>fm",
				function()
					require("telescope.builtin").man_pages()
				end,
				mode = "n",
				desc = "Search in Man Pages",
			},
			{
				"<leader>fn",
				"<cmd>Telescope noice<CR>",
				mode = "n",
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
				mode = "n",
				desc = "Search In System Clipboard",
			},
			{
				"<leader>fM",
				"<cmd>Telescope macroscope<CR>",
				mode = "n",
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
	{
		"lpoto/telescope-docker.nvim",
		lazy = true,
		keys = {
			{
				"<leader>fD",
				function()
					require("telescope").extensions.docker.containers( --[[opts...]])
				end,
				mode = "n",
				desc = "Search In Docker Containers",
			},
			{
				"<leader>fI",
				function()
					require("telescope").extensions.docker.images()
				end,
				mode = "n",
				desc = "Search In Docker Images",
			},
			{
				"<leader>fC",
				function()
					require("telescope").extensions.docker.compose()
				end,
				mode = "n",
				desc = "Search In Docker Compose",
			},
		},
		config = function()
			require("telescope").load_extension("docker")
		end,
	},
	{
		"tsakirist/telescope-lazy.nvim",
		lazy = true,
		keys = {
			{
				"<leader>fP",
				"<cmd>Telescope lazy<CR>",
				mode = "n",
				desc = "Search In Plugins",
			},
		},
		config = function()
			require("telescope").load_extension("lazy")
		end,
	},
}
