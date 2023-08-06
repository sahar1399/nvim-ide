return {
	{
		"weirongxu/plantuml-previewer.vim",
		lazy = true,
		ft = "plantuml",
		dependencies = {
			"tyru/open-browser.vim",
			"aklt/plantuml-syntax",
		},
	},
	{
		"https://gitlab.com/itaranto/plantuml.nvim",
		lazy = false,
		version = "*",
		ft = "plantuml",
		opts = {
			render_on_write = true, -- Set to false to disable auto-rendering.

			renderer = {
				type = "image",
				options = {
					prog = "imv",
					dark_mode = true,
				},
			},

			-- renderer = {
			-- 	type = "text",
			-- 	options = {
			-- 		split_cmd = "vsplit", -- Allowed values: `split`, `vsplit`.
			-- 	},
			-- },
			--
		},
	},
	-- {
	--   "javiorfo/nvim-soil",
	--   lazy = true,
	--   ft = "plantuml",
	--   opts = {
	--     -- If you want to customize the image showed when running this plugin
	--     image = {
	--       darkmode = true, -- Enable or disable darkmode
	--       format = "png", -- Choose between png or svg
	--
	--       -- This is a default implementation of using nsxiv to open the resultant image
	--       -- Edit the string to use your preferred app to open the image
	--       -- Some examples:
	--       -- return "feh " .. img
	--       -- return "xdg-open " .. img
	--     },
	--   },
	-- },
}
