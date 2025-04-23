return {
	"ravitemer/mcphub.nvim",
	lazy = false,
	cmd = "MCPHub", -- lazy load by default
	build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
	config = function()
		-- Basic setup - detailed configuration below
		require("mcphub").setup({
			port = 3000, -- Port for the mcp-hub Express server
			-- CRITICAL: Must be an absolute path
			config = vim.fn.expand("~/.config/nvim/mcpservers.json"),
			log = {
				level = vim.log.levels.WARN, -- Adjust verbosity (DEBUG, INFO, WARN, ERROR)
				to_file = true, -- Log to ~/.local/state/nvim/mcphub.log
			},
			on_ready = function()
				vim.notify("MCP Hub backend server is initialized and ready.", vim.log.levels.INFO)
			end,
		})
	end,
}
