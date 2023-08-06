return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		lazy = true,
		opts = {},
		keys = {
			{
				"<leader>D",
				mode = "n",
				desc = "Toogle Lazy Docker",
			},
			{
				"<leader>K",
				mode = "n",
				desc = "Toogle K9S",
			},
		},
		config = function()
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>0]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

			local Terminal = require("toggleterm.terminal").Terminal

			-- define terminals
			local k9s = Terminal:new({
				cmd = "k9s",
				hidden = true,
				direction = "tab",
				close_on_exit = true,
				auto_scroll = false,
			})

			K9s_toggle = function()
				k9s:toggle()
			end

			-- define terminals
			local lazydocker = Terminal:new({
				cmd = "lazydocker",
				hidden = true,
				direction = "tab",
				close_on_exit = true,
				auto_scroll = false,
			})

			Lazydocker_toggle = function()
				lazydocker:toggle()
			end

			vim.api.nvim_set_keymap("n", "<leader>K", "<cmd>lua K9s_toggle()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>D",
				"<cmd>lua Lazydocker_toggle()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
