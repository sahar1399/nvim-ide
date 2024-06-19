return {
	{
		"nvim-neotest/neotest",
		lazy = true,
		enabled = not vim.g.non_modified,
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				{ silent = true },
				mode = "n",
				desc = "Run Nearst Test",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				{ silent = true },
				mode = "n",
				desc = "Run All Test In File",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				{ silent = true },
				mode = "n",
				desc = "Debug Nearst Test",
			},
			{
				"<leader>tt",
				function()
					require("neotest").summary.open({ enter = true })
				end,
				{ silent = true },
				mode = "n",
				desc = "Toggle Test Summary Window",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- "antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
		},
		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						args = {
							-- "--cov=."
							"--log-level",
							"DEBUG",
						},
						python = ".venv/bin/python",
						pytest_discover_instances = false,
					}),
					require("neotest-plenary"),
				},
				discovery = {
					enabled = true,
					depth = 3,
				},
				output_panel = {
					enabled = true,
					open = "botright split",
				},
				icons = {
					child_indent = "│",
					child_prefix = "├",
					collapsed = "─",
					expanded = "╮",
					failed = "𝚇",
					final_child_indent = " ",
					final_child_prefix = "╰",
					non_collapsible = "─",
					passed = "𝚅",
					running = "",
					running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
					skipped = "嶺",
					unknown = "",
				},
				summary = {
					animated = true,
					enabled = true,
					expand_errors = true,
					follow = true,
					mappings = {
						attach = "a",
						clear_marked = "M",
						clear_target = "T",
						debug = "d",
						debug_marked = "D",
						expand = { "<CR>", "<2-LeftMouse>" },
						expand_all = "e",
						jumpto = "i",
						mark = "m",
						next_failed = "J",
						output = "o",
						prev_failed = "K",
						run = "r",
						run_marked = "R",
						short = "O",
						stop = "u",
						target = "t",
						watch = "W",
					},
					open = "botright vsplit | vertical resize 50",
				},
			})
		end,
	},
	{
		"andythigpen/nvim-coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		keys = {
			{
				"<leader>tcc",
				"<cmd>CoverageToggle<CR>",
				mode = "n",
				desc = "Toggle Test Coverage",
			},
			{
				"<leader>tcl",
				"<cmd>CoverageLoad<CR>",
				mode = "n",
				desc = "Load Test Coverage",
			},
			{
				"<leader>tcs",
				"<cmd>CoverageSummary<CR>",
				mode = "n",
				desc = "Test Coverage Summary",
			},
		},
		config = function()
			require("coverage").setup({
				commands = true, -- create commands
				auto_reload = true,
				highlights = {
					-- customize highlight groups created by the plugin
					covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
					uncovered = { fg = "#F07178" },
				},
				signs = {
					-- use your own highlight groups or text markers
					covered = { hl = "CoverageCovered", text = "▎" },
					uncovered = { hl = "CoverageUncovered", text = "▎" },
				},
				summary = {
					-- customize the summary pop-up
					min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
				},
				lang = {
					-- customize language specific settings
				},
				load_coverage_cb = function(ftype)
					vim.notify("Loaded " .. ftype .. " coverage")
				end,
			})
		end,
	},
}
