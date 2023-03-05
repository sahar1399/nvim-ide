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
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
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
							h = {
								s = {
									gs.stage_hunk,
									"Stage Hunk",
									mode = { "n", "v" },
									buffer = bufnr,
								},
								r = {
									gs.reset_hunk,
									"Reset Hunk",
									mode = { "n", "v" },
									buffer = bufnr,
								},
								S = { gs.stage_buffer, "Stage Buffer", mode = "n", buffer = bufnr },
								u = { gs.undo_stage_hunk, "Stage Buffer", mode = "n", buffer = bufnr },
								R = { gs.reset_buffer, "Reset Buffer", mode = "n", buffer = bufnr },
								p = { gs.preview_hunk, "Preview Hunk", mode = "n", buffer = bufnr },
								d = { gs.diffthis, "Diff This", mode = "n", buffer = bufnr },
								D = {
									function()
										gs.diffthis("~")
									end,
									"Diff This Buffer",
									mode = "n",
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
					},
					unmerged = {
						folded = false,
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
				"<leader>hc",
				function()
					local commit_sha = require("agitator").git_blame_commit_for_line()
					vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
				end,
				"n",
				agitator_opts,
				desc = "Blame Commit For Line",
			},

			{
				"<leader>hb",
				function()
					require("agitator").git_blame({
						formatter = function(r)
							return r.author .. " => " .. r.summary
						end,
					})
				end,
				"n",
				agitator_opts,
				desc = "Git Blame",
			},
		},
	},
}
