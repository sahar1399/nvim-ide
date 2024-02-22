local opts = { silent = true }
return {
	{
		"akinsho/toggleterm.nvim",
    enabled = not vim.g.non_modified,
		keys = {
			{
				"<C-t>",
				"<cmd>:ToggleTerm<cr>",
				opts,
				mode = "n",
				desc = "Toogle Terminal",
			},
			{
				"<leader>ts",
				"<cmd>:ToggleTermSendVisualLines<cr>",
				opts,
				mode = "n",
				desc = "Send Line To Terminal",
			},
			{
				"<leader>ts",
				"<cmd>:ToggleTermSendVisualSelection<cr>",
				opts,
				mode = "v",
				desc = "Send Line To Terminal",
			},
		},
		config = function()
			require("toggleterm").setup()
		end,
	},
}
