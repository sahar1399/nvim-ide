return {
	{
		"nvim-neotest/neotest",
		lazy = true,
		keys = {
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				"n",
				{ silent = true },
				desc = "Run Nearst Test",
			},
			{
				"<leader>ta",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				"n",
				{ silent = true },
				desc = "Run All Test In File",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				"n",
				{ silent = true },
				desc = "Debug Nearst Test",
			},
			{
				"<leader>to",
				function()
					require("neotest").summary.open({ enter = true })
				end,
				"n",
				{ silent = true },
				desc = "Toggle Test Summary Window",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
		},
		config = function()
			local neotest = require("neotest")

			neotest.setup({
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
						args = { "--cov=." },
					}),
					require("neotest-plenary"),
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
				"n",
				{},
				desc = "Toggle Test Coverage",
			},
			{
				"<leader>tcl",
				"<cmd>CoverageLoad<CR>",
				"n",
				{},
				desc = "Load Test Coverage",
			},
			{
				"<leader>tcs",
				"<cmd>CoverageSummary<CR>",
				"n",
				{},
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
