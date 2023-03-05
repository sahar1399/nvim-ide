local opts = { silent = true }
return {
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<C-t>",
				"<cmd>:ToggleTerm<cr>",
				"n",
				opts,
				desc = "Toogle Terminal",
			},
			{
				"<leader>ts",
				"<cmd>:ToggleTermSendVisualLines<cr>",
				"n",
				opts,
				desc = "Send Line To Terminal",
			},
			{
				"<leader>ts",
				"<cmd>:ToggleTermSendVisualSelection<cr>",
				"v",
				opts,
				desc = "Send Line To Terminal",
			},
		},
		config = function()
			require("toggleterm").setup()
		end,
	},
}
