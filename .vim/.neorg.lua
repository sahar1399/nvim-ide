  require("neorg").setup {
    load = {
      ["core.ui"] = {},
      ["core.mode"] = {},
      ["core.neorgcmd"] = {},
      ["core.highlights"] = {},
      ["core.defaults"] = {},
      ["core.keybinds"] = {
	      config = {
		      default_keybinds = true,
		      neorg_leader = "<Leader>n"
	      }
      },
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.norg.dirman"] = {
	      config = {
		      workspaces = {
			      current_workdir = vim.fn.getcwd()
		      }
	      }
      },
      ["core.export"] = {},
      ["core.norg.journal"] = {
          config = {
	    workspace = "current_workdir",
            journal_folder = ".journal",
  	    strategy = "flat"
   	  },
      },
      ["core.gtd.base"] = {
	      config = {
		      workspace = "current_workdir"
	      }
      },
      ["core.gtd.ui"] = {},
      ["core.gtd.queries"] = {},
      ["core.gtd.helpers"] = {},
      ["core.integrations.nvim-cmp"] = {},
      ["core.integrations.treesitter"] = {},
      ["core.integrations.telescope"] = {},

      ["external.gtd-project-tags"] = {},
      ["external.kanban"] = {},
      ["external.context"] = {},

      ["core.norg.qol.toc"] = {}
  }
}

require('nvim-treesitter.configs').setup {
    ensure_installed = { "norg" },
    highlight = {
        enable = true,
    }
}
