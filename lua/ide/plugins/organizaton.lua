return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			neorg = require("neorg")
			neorg.setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.syntax"] = {},

					["core.export"] = {
						config = {
							export_dir = ".",
						},
					},

					["core.completion"] = {
						config = {
							name = "[Neorg]",
							engine = "nvim-cmp",
						},
					},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes/work",
								home = "~/notes/home",
							},
						},
					},
				},
			})
		end,
	},
}
