return {
	{
		"jellydn/hurl.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		ft = "hurl",
		opts = {
      auto_close = false,
			-- Show debugging info
			debug = false,
			-- Show notification on run
			show_notification = false,
			-- Show response in popup or split
			mode = "split",
			-- Default formatter
			formatters = {
				json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
				html = {
					"prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
					"--parser",
					"html",
				},
			},
		},
		keys = {
			-- Run API request
			{ "<leader>hR", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
			{ "<leader>hr", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
			{ "<leader>hte", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
			{ "<leader>htm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
			{ "<leader>htv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
			-- Run Hurl request in visual mode
			{ "<leader>hr", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
		},
	},
}
