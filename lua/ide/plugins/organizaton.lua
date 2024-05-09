return {
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",

		commit = "99f33e08fe074126b491e02854e5d00dab10f5ae",
		init = function()
			vim.o.conceallevel = 3
		end,

		lazy = not vim.g.non_modified,
		ft = "norg",

		dependencies = {
			"nvim-lua/plenary.nvim",
      "tyru/open-browser.vim",
			{
				"sahar1399/neorg-telescope",
				branch = "task/sahar/add_defs_to_insert",
			},
		},

		-- TODO: make all plugins use opts
		config = function()
      local modules = {
					["core.concealer"] = {
						config = {
							markup_preset = "brave",
							icon_preset = "diamond",
							icons = {
								code_block = {
									conceal = true,
								},
							},
						},
					},

					["core.qol.todo_items"] = {
						config = {
							order = {
								{ "undone", " " },
								{ "pending", "-" },
								{ "done", "x" },
							},

							order_with_children = {
								{ "undone", " " },
								{ "done", "x" },
							},

							create_todo_parents = true,
							create_todo_items = true,
						},
					},

					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes/work",
							},
						},
					},

					["core.autocommands"] = {},
					["core.integrations.treesitter"] = {},
					["core.integrations.telescope"] = {},
					["core.scanner"] = {},

					["core.export"] = {},
					["core.export.markdown"] = {},

					["core.summary"] = {},

					["core.defaults"] = {}, -- Loads default behaviour

					["core.neorgcmd.commands.module.list"] = {},
					["core.neorgcmd.commands.module.load"] = {},
          ["core.esupports.hop"] = {}
      }
      if not vim.g.non_modified then
				-- modules["core.syntax"] = {}

        modules["core.integrations.nvim-cmp"] = {}
        modules["core.completion"] = {
						config = {
							name = "[Neorg]",
							engine = "nvim-cmp",
						}
					}

      end

			require("neorg").setup({
				load = modules,
			})

			local neorg_callbacks = require("neorg.callbacks")
			-- local neorg_callbacks = require("neorg.core.callbacks")

			-- TODO: do better
			-- TODO: do visual
			-- TODO: fork neorg-telescope and add support for definitions

			neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
				local leader = keybinds.leader

				-- Map all the below keybinds only when the "norg" mode is active
				keybinds.map_event_to_mode("norg", {
					n = { -- Bind keys in normal mode
            { "gd", "core.esupports.hop.hop-link", opts = { desc = "Jump to Link" } },
						{ "<leader>fd", "core.integrations.telescope.find_linkable" },
						{ "<leader>i", "core.integrations.telescope.insert_link" },
						{
							"Tu",
							"core.qol.todo_items.todo.task_undone",
							opts = { desc = "Mark as Undone" },
						},

						-- Marks the task under the cursor as "pending"
						-- ^mark Task as Pending
						{
							"Tp",
							"core.qol.todo_items.todo.task_pending",
							opts = { desc = "Mark as Pending" },
						},

						-- Marks the task under the cursor as "done"
						-- ^mark Task as Done
						{
							"Td",
							"core.qol.todo_items.todo.task_done",
							opts = { desc = "Mark as Done" },
						},

						-- Marks the task under the cursor as "on_hold"
						-- ^mark Task as on Hold
						{
							"Th",
							"core.qol.todo_items.todo.task_on_hold",
							opts = { desc = "Mark as On Hold" },
						},

						-- Marks the task under the cursor as "cancelled"
						-- ^mark Task as Cancelled
						{
							"Tc",
							"core.qol.todo_items.todo.task_cancelled",
							opts = { desc = "Mark as Cancelled" },
						},

						-- Marks the task under the cursor as "recurring"
						-- ^mark Task as Recurring
						{
							"Tr",
							"core.qol.todo_items.todo.task_recurring",
							opts = { desc = "Mark as Recurring" },
						},

						-- Marks the task under the cursor as "important"
						-- ^mark Task as Important
						{
							"Ti",
							"core.qol.todo_items.todo.task_important",
							opts = { desc = "Mark as Important" },
						},

						-- Marks the task under the cursor as "ambiguous"
						-- ^mark Task as ambiguous
						{
							"Ta",
							"core.qol.todo_items.todo.task_ambiguous",
							opts = { desc = "Mark as Ambigous" },
						},
					},
				}, {
					silent = true,
					noremap = true,
				})
			end)
		end,
	},
}
