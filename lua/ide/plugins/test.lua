local opts = { silent = true }

return {
	{
		"nvim-neotest/neotest",
		lazy = true,
		keys = {
			{
				"<leader>ta",
				function()
					local neotest = require("neotest")
					neotest.run.run()
				end,
				"n",
				opts,
			},
			{
				"<leader>tr",
				function()
					local neotest = require("neotest")
					neotest.run.run(vim.fn.expand("%"))
				end,
				"n",
				opts,
			},
			{
				"<leader>td",
				function()
					local neotest = require("neotest")
					neotest.run.run({ strategy = "dap" })
				end,
				"n",
				opts,
			},
			{
				"<leader>tt",
				function()
					local neotest = require("neotest")
					neotest.summary.open()
				end,
				"n",
				opts,
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
					require("neotest-plenary"),
					require("neotest-python")({
						dap = { justMyCode = false },
					}),
				},
			})
		end,
	},
	{
		"andythigpen/nvim-coverage",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("coverage").setup({
				commands = true, -- create commands
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
			})
		end,
	},
}
