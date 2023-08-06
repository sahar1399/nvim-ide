return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",

    commit = "99f33e08fe074126b491e02854e5d00dab10f5ae",

		lazy = true,
		ft = "norg",

		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"sahar1399/neorg-telescope",
				branch = "task/sahar/add_defs_to_insert",
			},
		},

		-- TODO: make all plugins use opts
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.syntax"] = {},

					["core.concealer"] = {
						config = {
							markup_preset = "brave",
							icon_preset = "diamond",
						},
					},

					["core.export"] = {},
					["core.export.markdown"] = {},

					["core.qol.todo_items"] = {},

					["core.autocommands"] = {},
					["core.integrations.treesitter"] = {},
					["core.integrations.telescope"] = {},
					["core.scanner"] = {},
					["core.esupports.indent"] = {},
					["core.esupports.hop"] = {},

					["core.integrations.nvim-cmp"] = {},
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
							},
						},
					},
					["core.summary"] = {},
				},
			})

			local neorg_callbacks = require("neorg.callbacks")
      -- local neorg_callbacks = require("neorg.core.callbacks")

			-- TODO: do better
			-- TODO: do visual
			-- TODO: fork neorg-telescope and add support for definitions
			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				-- Map all the below keybinds only when the "norg" mode is active
				keybinds.map_event_to_mode("norg", {
					n = { -- Bind keys in normal mode
						{ "<leader>fd", "core.integrations.telescope.find_linkable" },
						{ "<leader>i", "core.integrations.telescope.insert_link" },
					},
				}, {
					silent = true,
					noremap = true,
				})
			end)
		end,
	},
}
