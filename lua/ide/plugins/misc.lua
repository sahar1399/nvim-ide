local opts = { noremap = true, silent = true }

return {
	{
		"ziontee113/icon-picker.nvim",
		dependencies = { "stevearc/dressing.nvim" },
		lazy = true,
		keys = {
			{ "<leader>i", "<cmd>IconPickerNormal<cr>", opts, mode = "n", desc = "Pick Icon" },
		},
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true,
			})
		end,
	},
	{
		"Pocco81/HighStr.nvim",
		lazy = true,
		keys = {
			{ "<leader>h", ":<c-u>HSHighlight 1<CR>", opts, mode = "v", desc = "Higlight" },
			{ "<leader>H", ":<c-u>HSRmHighlight<CR>", opts, mode = "v", desc = "Remove Higlight" },
		},
		config = function()
			local high_str = require("high-str")

			high_str.setup({
				verbosity = 0,
				saving_path = "/tmp/highstr/",
				highlight_colors = {
					-- color_id = {"bg_hex_code",<"fg_hex_code"/"smart">}
					color_0 = { "#0c0d0e", "smart" }, -- Cosmic charcoal
					color_1 = { "#e5c07b", "smart" }, -- Pastel yellow
					color_2 = { "#7FFFD4", "smart" }, -- Aqua menthe
					color_3 = { "#8A2BE2", "smart" }, -- Proton purple
					color_4 = { "#FF4500", "smart" }, -- Orange red
					color_5 = { "#008000", "smart" }, -- Office green
					color_6 = { "#0000FF", "smart" }, -- Just blue
					color_7 = { "#FFC0CB", "smart" }, -- Blush pink
					color_8 = { "#FFF9E3", "smart" }, -- Cosmic latte
					color_9 = { "#7d5c34", "smart" }, -- Fallow brown
				},
			})
		end,
	},
	{
		"weirongxu/plantuml-previewer.vim",
		lazy = true,
		event = { "BufRead **.puml", "BufRead **.uml", "BufRead **.plantuml", "BufRead **.plant" },
		dependencies = {
			"tyru/open-browser.vim",
			"aklt/plantuml-syntax",
		},
	},
	{
		"davidgranstrom/nvim-markdown-preview",
		lazy = true,
		event = { "BufRead **.markdown", "BufRead **.mkd", "BufRead **.mk", "BufRead **.md" },
	},
}
