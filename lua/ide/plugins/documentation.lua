return {
	{
		"milisims/nvim-luaref",
	},
	{
		"epwalsh/obsidian.nvim",
		lazy = false,
		event = {
			"BufRead *.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		keys = {
			{
				"gd",
				function()
					if require("obsidian").util.cursor_on_markdown_link() then
						return "<cmd>ObsidianFollowLink<CR>"
					else
						return "gd"
					end
				end,
				noremap = false,
				expr = true,
				mode = "n",
				desc = "Follow Obsidian Link",
			},
      {
        "<leader>oo",
        "<cmd>ObsidianOpen<CR>",
				mode = "n",
				desc = "Open In Obsidian",
      },
      {
        "<leader>ot",
        "<cmd>ObsidianToday<CR>",
				mode = "n",
				desc = "Open Today's Note",
      }
		},
		config = function()
			require("obsidian").setup({
				dir = "~/work/my-vault",
				-- use_advanced_uri = true,
				completion = {
					nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
				},
				notes_subdir = "notes",
				daily_notes = {
					folder = "dailies",
				},
				note_frontmatter_func = function(note)
					local out = { id = note.id, aliases = note.aliases, tags = note.tags }
					-- `note.metadata` contains any manually added fields in the frontmatter.
					-- So here we just make sure those fields are kept in the frontmatter.
					if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
						for k, v in pairs(note.metadata) do
							out[k] = v
						end
					end
					return out
				end,
				note_id_func = function(title)
					-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
					local suffix = ""
					if title ~= nil then
						-- If title is given, transform it into valid file name.
						suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
					else
						-- If title is nil, just add 4 random uppercase letters to the suffix.
						for _ = 1, 4 do
							suffix = suffix .. string.char(math.random(65, 90))
						end
					end
					return tostring(os.time()) .. "-" .. suffix
				end,
			})
		end,
	},
}
