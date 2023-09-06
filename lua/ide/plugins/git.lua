local agitator_opts = { silent = true }

return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = true, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 100,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than t (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local wk = require("which-key")

					wk.register({
						["]c"] = {
							function()
								if vim.wo.diff then
									return "]c"
								end
								vim.schedule(function()
									gs.next_hunk()
								end)
								return "<Ignore>"
							end,
							"Next Hunk",
							mode = "n",
							expr = true,
							buffer = bufnr,
						},
						["[c"] = {
							function()
								if vim.wo.diff then
									return "[c"
								end
								vim.schedule(function()
									gs.prev_hunk()
								end)
								return "<Ignore>"
							end,
							"Prev Hunk",
							mode = "n",
							expr = true,
							buffer = bufnr,
						},
						["<leader>"] = {
							g = {
								s = {
									gs.stage_hunk,
									"Stage Hunk",
									mode = { "n" },
									buffer = bufnr,
								},
								r = {
									gs.reset_hunk,
									"Reset Hunk",
									mode = { "n" },
									buffer = bufnr,
								},
								D = {
									gs.diffthis,
									"Diff This",
									mode = { "n" },
									buffer = bufnr,
								},
								S = { gs.stage_buffer, "Stage Buffer", mode = "n", buffer = bufnr },
								u = { gs.undo_stage_hunk, "Stage Buffer", mode = "n", buffer = bufnr },
								R = { gs.reset_buffer, "Reset Buffer", mode = "n", buffer = bufnr },
								p = { gs.preview_hunk, "Preview Hunk", mode = "n", buffer = bufnr },
							},
						},
					})

					wk.register({
						["<leader>"] = {
							g = {
								s = {
									function()
										gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
									end,
									"Stage Hunk",
									mode = { "v" },
									buffer = bufnr,
								},
								r = {
									function()
										gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
									end,
									"Reset Hunk",
									mode = { "v" },
									buffer = bufnr,
								},
								D = {
									function()
										gs.diffthis("~")
									end,
									"Diff This",
									mode = { "v" },
									buffer = bufnr,
								},
							},
						},
					})
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = {
			"DiffviewOpen",
			"DiffviewFocusFiles",
			"DiffviewFileHistory",
			"DiffviewToggleFiles",
		},
		keys = {
			{
				"<leader>gd",
				"<cmd>DiffviewOpen<CR>",
				mode = "n",
				desc = "Git Diff (Toggle)",
			},
			{
				"<leader>gh",
				"<cmd>DiffviewFileHistory %<CR>",
				mode = "n",
				desc = "Git Commit History (Toggle)",
			},
		},
		config = function()
			local actions = require("diffview.actions")

			vim.cmd([[highlight DiffAdd gui=none guifg=none guibg=#103235]])
			vim.cmd([[highlight DiffChange gui=none guifg=none guibg=#272D43]])
			vim.cmd([[highlight DiffText gui=none guifg=none guibg=#394b70]])
			vim.cmd([[highlight DiffDelete gui=none guifg=none guibg=#6F2D3D]])
			vim.cmd([[highlight DiffviewDiffAddAsDelete guibg=#3f2d3d gui=none guifg=none]])
			vim.cmd([[highlight DiffviewDiffDelete gui=none guifg=#3B4252 guibg=none]])

			require("diffview").setup({
				diff_binaries = false, -- Show diffs for binaries
				enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
				git_cmd = { "git" }, -- The git executable followed by default args.
				hg_cmd = { "hg" }, -- The hg executable followed by default args.
				use_icons = true, -- Requires nvim-web-devicons
				show_help_hints = true, -- Show hints for how to open the help panel
				watch_index = true, -- Update views and index buffers when the git index changes.
				icons = {
					-- Only applies when use_icons is true.
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},
				view = {
					-- Configure the layout and behavior of different types of views.
					-- Available layouts:
					--  'diff1_plain'
					--    |'diff2_horizontal'
					--    |'diff2_vertical'
					--    |'diff3_horizontal'
					--    |'diff3_vertical'
					--    |'diff3_mixed'
					--    |'diff4_mixed'
					-- For more info, see ':h diffview-config-view.x.layout'.
					default = {
						-- Config for changed files, and staged files in diff views.
						layout = "diff2_horizontal",
						winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
					},
					merge_tool = {
						-- Config for conflicted files in diff views during a merge or rebase.
						layout = "diff3_horizontal",
						disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
						winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
					},
					file_history = {
						-- Config for changed files in file history views.
						layout = "diff2_horizontal",
						winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
					},
				},
				file_panel = {
					listing_style = "tree", -- One of 'list' or 'tree'
					tree_options = {
						-- Only applies when listing_style is 'tree'
						flatten_dirs = true, -- Flatten dirs that only contain one single dir
						folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
					},
					win_config = {
						-- See ':h diffview-config-win_config'
						position = "left",
						width = 35,
						win_opts = {},
					},
				},
				file_history_panel = {
					log_options = {
						-- See ':h diffview-config-log_options'
						git = {
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
						hg = {
							single_file = {},
							multi_file = {},
						},
					},
					win_config = {
						-- See ':h diffview-config-win_config'
						position = "bottom",
						height = 16,
						win_opts = {},
					},
				},
				commit_log_panel = {
					win_config = { -- See ':h diffview-config-win_config'
						win_opts = {},
					},
				},
				default_args = {
					-- Default args prepended to the arg-list for the listed commands
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},
				keymaps = {
					disable_defaults = false, -- Disable the default keymaps
					view = {
						-- The `view` bindings are active in the diff buffers, only when the current
						-- tabpage is a Diffview.
						{
							"n",
							"<tab>",
							actions.select_next_entry,
							{ desc = "Open the diff for the next file" },
						},
						{
							"n",
							"<s-tab>",
							actions.select_prev_entry,
							{ desc = "Open the diff for the previous file" },
						},
						{
							"n",
							"gf",
							actions.goto_file_edit,
							{ desc = "Open the file in the previous tabpage" },
						},
						{
							"n",
							"<C-w><C-f>",
							actions.goto_file_split,
							{ desc = "Open the file in a new split" },
						},
						{
							"n",
							"<C-w>gf",
							actions.goto_file_tab,
							{ desc = "Open the file in a new tabpage" },
						},
						{
							"n",
							"<leader>e",
							actions.focus_files,
							{ desc = "Bring focus to the file panel" },
						},
						{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
						{
							"n",
							"g<C-x>",
							actions.cycle_layout,
							{ desc = "Cycle through available layouts." },
						},
						{
							"n",
							"[x",
							actions.prev_conflict,
							{ desc = "In the merge-tool: jump to the previous conflict" },
						},
						{
							"n",
							"]x",
							actions.next_conflict,
							{ desc = "In the merge-tool: jump to the next conflict" },
						},
						{
							"n",
							"<leader>co",
							actions.conflict_choose("ours"),
							{ desc = "Choose the OURS version of a conflict" },
						},
						{
							"n",
							"<leader>ct",
							actions.conflict_choose("theirs"),
							{ desc = "Choose the THEIRS version of a conflict" },
						},
						{
							"n",
							"<leader>cb",
							actions.conflict_choose("base"),
							{ desc = "Choose the BASE version of a conflict" },
						},
						{
							"n",
							"<leader>ca",
							actions.conflict_choose("all"),
							{ desc = "Choose all the versions of a conflict" },
						},
						{
							"n",
							"dx",
							actions.conflict_choose("none"),
							{ desc = "Delete the conflict region" },
						},
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
					},
					diff1 = {
						-- Mappings in single window diff layouts
						{ "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
					},
					diff2 = {
						-- Mappings in 2-way diff layouts
						{ "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
					},
					diff3 = {
						-- Mappings in 3-way diff layouts
						{
							{ "n", "x" },
							"2do",
							actions.diffget("ours"),
							{ desc = "Obtain the diff hunk from the OURS version of the file" },
						},
						{
							{ "n", "x" },
							"3do",
							actions.diffget("theirs"),
							{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
						},
						{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
					},
					diff4 = {
						-- Mappings in 4-way diff layouts
						{
							{ "n", "x" },
							"1do",
							actions.diffget("base"),
							{ desc = "Obtain the diff hunk from the BASE version of the file" },
						},
						{
							{ "n", "x" },
							"2do",
							actions.diffget("ours"),
							{ desc = "Obtain the diff hunk from the OURS version of the file" },
						},
						{
							{ "n", "x" },
							"3do",
							actions.diffget("theirs"),
							{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
						},
						{ "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
					},
					file_panel = {
						{
							"n",
							"j",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"<down>",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"k",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<up>",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<cr>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"o",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"<2-LeftMouse>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"-",
							actions.toggle_stage_entry,
							{ desc = "Stage / unstage the selected entry." },
						},
						{ "n", "S", actions.stage_all, { desc = "Stage all entries." } },
						{ "n", "U", actions.unstage_all, { desc = "Unstage all entries." } },
						{
							"n",
							"X",
							actions.restore_entry,
							{ desc = "Restore entry to the state on the left side." },
						},
						{
							"n",
							"L",
							actions.open_commit_log,
							{ desc = "Open the commit log panel." },
						},
						{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
						{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
						{
							"n",
							"<tab>",
							actions.select_next_entry,
							{ desc = "Open the diff for the next file" },
						},
						{
							"n",
							"<s-tab>",
							actions.select_prev_entry,
							{ desc = "Open the diff for the previous file" },
						},
						{
							"n",
							"gf",
							actions.goto_file_edit,
							{ desc = "Open the file in the previous tabpage" },
						},
						{
							"n",
							"<C-w><C-f>",
							actions.goto_file_split,
							{ desc = "Open the file in a new split" },
						},
						{
							"n",
							"<C-w>gf",
							actions.goto_file_tab,
							{ desc = "Open the file in a new tabpage" },
						},
						{
							"n",
							"i",
							actions.listing_style,
							{ desc = "Toggle between 'list' and 'tree' views" },
						},
						{
							"n",
							"f",
							actions.toggle_flatten_dirs,
							{ desc = "Flatten empty subdirectories in tree listing style." },
						},
						{
							"n",
							"R",
							actions.refresh_files,
							{ desc = "Update stats and entries in the file list." },
						},
						{
							"n",
							"<leader>e",
							actions.focus_files,
							{ desc = "Bring focus to the file panel" },
						},
						{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
						{ "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
						{
							"n",
							"[x",
							actions.prev_conflict,
							{ desc = "Go to the previous conflict" },
						},
						{ "n", "]x", actions.next_conflict, { desc = "Go to the next conflict" } },
						{ "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
					},
					file_history_panel = {
						{ "n", "g!", actions.options, { desc = "Open the option panel" } },
						{
							"n",
							"<C-A-d>",
							actions.open_in_diffview,
							{ desc = "Open the entry under the cursor in a diffview" },
						},
						{
							"n",
							"y",
							actions.copy_hash,
							{ desc = "Copy the commit hash of the entry under the cursor" },
						},
						{ "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
						{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
						{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
						{
							"n",
							"j",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"<down>",
							actions.next_entry,
							{ desc = "Bring the cursor to the next file entry" },
						},
						{
							"n",
							"k",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<up>",
							actions.prev_entry,
							{ desc = "Bring the cursor to the previous file entry." },
						},
						{
							"n",
							"<cr>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"o",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"<2-LeftMouse>",
							actions.select_entry,
							{ desc = "Open the diff for the selected entry." },
						},
						{
							"n",
							"<c-b>",
							actions.scroll_view(-0.25),
							{ desc = "Scroll the view up" },
						},
						{
							"n",
							"<c-f>",
							actions.scroll_view(0.25),
							{ desc = "Scroll the view down" },
						},
						{
							"n",
							"<tab>",
							actions.select_next_entry,
							{ desc = "Open the diff for the next file" },
						},
						{
							"n",
							"<s-tab>",
							actions.select_prev_entry,
							{ desc = "Open the diff for the previous file" },
						},
						{
							"n",
							"gf",
							actions.goto_file_edit,
							{ desc = "Open the file in the previous tabpage" },
						},
						{
							"n",
							"<C-w><C-f>",
							actions.goto_file_split,
							{ desc = "Open the file in a new split" },
						},
						{
							"n",
							"<C-w>gf",
							actions.goto_file_tab,
							{ desc = "Open the file in a new tabpage" },
						},
						{
							"n",
							"<leader>e",
							actions.focus_files,
							{ desc = "Bring focus to the file panel" },
						},
						{
							"n",
							"<leader>b",
							actions.toggle_files,
							{ desc = "Toggle the file panel" },
						},
						{
							"n",
							"g<C-x>",
							actions.cycle_layout,
							{ desc = "Cycle available layouts" },
						},
						{
							"n",
							"g?",
							actions.help("file_history_panel"),
							{ desc = "Open the help panel" },
						},
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
					},
					option_panel = {
						{ "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
						{ "n", "q", actions.close, { desc = "Close the panel" } },
						{ "n", "<esc>", actions.close, { desc = "Close the panel" } },
						{ "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
					},
					help_panel = {
						{ "n", "q", actions.close, { desc = "Close help menu" } },
						{ "n", "<esc>", actions.close, { desc = "Close help menu" } },
					},
				},
			})
		end,
	},
	{
		"TimUntersberger/neogit",
		lazy = true,
		cmd = { "G" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ttibsi/pre-commit.nvim",
		},
		config = function()
			local neogit = require("neogit")

			neogit.setup({
				disable_signs = false,
				disable_hint = false,
				disable_context_highlighting = false,
				disable_commit_confirmation = true,
				-- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
				-- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
				auto_refresh = true,
				disable_builtin_notifications = false,
				use_magit_keybindings = false,
				-- Change the default way of opening neogit
				kind = "tab",
				-- The time after which an output console is shown for slow running commands
				console_timeout = 2000,
				-- Automatically show console if a command takes more than console_timeout milliseconds
				auto_show_console = true,
				-- Change the default way of opening the commit popup
				commit_popup = {
					kind = "split",
				},
				-- Change the default way of opening popups
				popup = {
					kind = "split",
				},
				-- customize displayed signs
				signs = {
					-- { CLOSED, OPENED }
					section = { ">", "v" },
					item = { ">", "v" },
					hunk = { "", "" },
				},
				integrations = {
					diffview = true,
				},
				-- Setting any section to `false` will make the section not render at all
				sections = {
					untracked = {
						folded = false,
					},
					unstaged = {
						folded = false,
					},
					staged = {
						folded = false,
					},
					stashes = {
						folded = true,
					},
					unpulled = {
						folded = true,
						hidden = true,
					},
					unmerged = {
						folded = false,
						hidden = false,
					},
					recent = {
						folded = true,
					},
				},
				-- override/add mappings
				mappings = {
					-- modify status buffer mappings
					status = {
						-- Adds a mapping with "B" as key that does the "BranchPopup" command
						["B"] = "BranchPopup",
						-- Removes the default mapping of "s"
					},
				},
			})

			vim.cmd([[ command! G execute 'lua require("neogit").open{kind = "split"}' ]])
		end,
	},
	{
		"emmanueltouzery/agitator.nvim",
		lazy = true,
		keys = {
			{
				"<leader>gc",
				function()
					local commit_sha = require("agitator").git_blame_commit_for_line()
					vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
				end,
				agitator_opts,
				mode = "n",
				desc = "Blame Commit For Line",
			},
		
			{
				"<leader>gb",
				function()
					require("agitator").git_blame({
						formatter = function(r)
							return string.format("%02d-%02d-%02d %s", r.date.year, r.date.month, r.date.day, r.author)
								.. " => "
								.. string.sub(r.summary, 1, 11)
						end,
					})
				end,
				agitator_opts,
				mode = "n",
				desc = "Git Blame",
			},
		},
	},
	{
		-- "FabijanZulj/blame.nvim",
		-- lazy = true,
		-- keys = {
		-- 	{
		-- 		"<leader>gb",
		-- 		":ToggleBlame virtual<CR>",
		-- 		mode = "n",
		-- 		desc = "Git Blame",
		-- 	},
		-- },
	},
}
