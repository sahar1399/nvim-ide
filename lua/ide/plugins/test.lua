return {
	{
		"nvim-neotest/neotest",
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

			local opts = { silent = true }

			vim.keymap.set("n", "<leader>trr", function()
				neotest.run.run()
			end, opts)
			vim.keymap.set("n", "<leader>tra", function()
				neotest.run.run(vim.fn.expand("%"))
			end, opts)
			vim.keymap.set("n", "<leader>trd", function()
				neotest.run.run({ strategy = "dap" })
			end, opts)
			vim.keymap.set("n", "<leader>to", function()
				neotest.summary.open({ enter = true })
			end, opts)
		end,
	},
	{
		"andythigpen/nvim-coverage",
		requires = "nvim-lua/plenary.nvim",
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

			vim.keymap.set("n", "<leader>tcc", "<cmd>CoverageToggle<CR>", {})
			vim.keymap.set("n", "<leader>tcl", "<cmd>CoverageLoad<CR>", {})
			vim.keymap.set("n", "<leader>tcs", "<cmd>CoverageSummary<CR>", {})
		end,
	},
}
