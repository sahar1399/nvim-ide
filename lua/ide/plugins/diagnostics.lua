local opts = { silent = true, noremap = true }

return {
	{
		"folke/trouble.nvim",
		lazy = true,
		enabled = not vim.g.non_modified,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics<cr>",
				opts,
				mode = "n",
				desc = "Open Project Error Panel",
			},
			{
				"<leader>xt",
				"<cmd>Trouble todo<cr>",
				opts,
				mode = "n",
				desc = "Open Todos",
			},
			{
				"<leader>S",
				"<cmd>Trouble symbols<cr>",
				opts,
				mode = "n",
				desc = "Open Symbols",
			},
		},
		config = function()
			require("trouble").setup({
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				max_items = 10000,
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				indent_lines = true, -- add an indent guide below the fold icons
        pinned=true,
        multiline=false,
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = false, -- automatically close the list when you have no diagnostics
				auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				auto_jump = false, -- for the given modes, automatically jump if there is only a single result
				modes = {
					symbols = {
						desc = "document symbols",
						mode = "lsp_document_symbols",
						focus = false,
						win = { position = "right", size = { width = 75 } },
						filter = {
							-- remove Package since luals uses it for control flow structures
							["not"] = { ft = "lua", kind = "Package" },
							any = {
								-- all symbol kinds for help / markdown files
								ft = { "help", "markdown" },
								-- default set of symbol kinds
								kind = {
									"Class",
									"Constructor",
									"Enum",
									"Field",
									"Function",
									"Interface",
									"Method",
									"Module",
									"Namespace",
									"Package",
									"Property",
									"Struct",
									"Trait",
								},
							},
						},
					},
				},
				keys = {
					["?"] = "help",
					r = "refresh",
					R = "toggle_refresh",
					-- q = "close",
					-- o = "jump_close",
					["<esc>"] = "cancel",
					-- ["<cr>"] = "jump",
					-- ["<2-leftmouse>"] = "jump",
					["<c-s>"] = "jump_split",
					["<c-v>"] = "jump_vsplit",
					-- go down to next item (accepts count)
					-- j = "next",
					["}"] = "next",
					["]]"] = "next",
					-- go up to prev item (accepts count)
					-- k = "prev",
					["{"] = "prev",
					["[["] = "prev",
					dd = "delete",
					d = { action = "delete", mode = "v" },
					i = "inspect",
					p = "preview",
					P = "toggle_preview",
					o = "fold_open",
					-- O = "fold_open_recursive",
					zc = "fold_close",
					zC = "fold_close_recursive",
					zR = "fold_toggle_recursive",
					-- zm = "fold_more",
					zM = "fold_close_all",
					-- zr = "fold_reduce",
					-- zR = "fold_open_all",
					-- zx = "fold_update",
					-- zX = "fold_update_all",
					-- zn = "fold_disable",
					-- zN = "fold_enable",
					-- zi = "fold_toggle_enable",
					gb = { -- example of a custom action that toggles the active view filter
						action = function(view)
							view:filter({ buf = 0 }, { toggle = true })
						end,
						desc = "Toggle Current Buffer Filter",
					},
					s = { -- example of a custom action that toggles the severity
						action = function(view)
							local f = view:get_filter("severity")
							local severity = ((f and f.filter.severity or 0) + 1) % 5
							view:filter({ severity = severity }, {
								id = "severity",
								template = "{hl:Title}Filter:{hl} {severity}",
								del = severity == 0,
							})
						end,
						desc = "Toggle Severity Filter",
					},
				},
				signs = {
					-- icons / text used for a diagnostic
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
				use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
			})
		end,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		lazy = true,
		event = "LspAttach",
		enabled = not vim.g.non_modified,
		keys = {
			{ "<Leader>o", "<cmd>lua require('lsp_lines').toggle()<cr>", mode = "n", desc = "Toggle lsp_lines" },
		},
		config = function()
			vim.diagnostic.config({ virtual_lines = false })

			require("lsp_lines").setup()
		end,
	},
}
