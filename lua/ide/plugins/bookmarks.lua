return {
	{
		"chentoast/marks.nvim",
		lazy = true,
		event = "BufRead *",
		config = function()
			require("marks").setup({
				-- whether to map keybinds or not. default true
				default_mappings = true,
				-- which builtin marks to show. default {}
				builtin_marks = { ".", "<", ">", "^" },
				-- whether movements cycle back to the beginning/end of buffer. default true
				cyclic = true,
				-- whether the shada file is updated after modifying uppercase marks. default false
				force_write_shada = false,
				-- how often (in ms) to redraw signs/recompute mark positions.
				-- higher values will have better performance but may cause visual lag,
				-- while lower values may cause performance penalties. default 150.
				refresh_interval = 250,
				-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
				-- marks, and bookmarks.
				-- can be either a table with all/none of the keys, or a single number, in which case
				-- the priority applies to all marks.
				-- default 10.
				sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
				-- disables mark tracking for specific filetypes. default {}
				excluded_filetypes = {},
				-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
				-- sign/virttext. Bookmarks can be used to group together positions and quickly move
				-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
				-- default virt_text is "".
				bookmark_0 = {
					sign = "⚑",
					virt_text = "hello world",
					-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
					-- defaults to false.
					annotate = false,
				},
				mappings = {},
			})
		end,
	},
	-- {
	-- 	"MattesGroeger/vim-bookmarks",
	-- 	lazy = false,
	-- 	keys = {
	-- 		{
	-- 			"<leader>ba",
	-- 			"<Plug>BookmarkAnnotate",
	-- 			mode = "n",
	-- 			desc = "Bookmark Annotate",
	-- 		},
	-- 		{
	-- 			"<leader>bb",
	-- 			"<Plug>BookmarkToggle",
	-- 			mode = "n",
	-- 			desc = "Bookmark Toggle",
	-- 		},
	-- 		{
	-- 			"<leader>bC",
	-- 			"<Plug>BookmarkClearAll",
	-- 			mode = "n",
	-- 			desc = "Bookmark Clear All",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		vim.cmd([[
	--           highlight BookmarkSign ctermbg=NONE ctermfg=160
	--           highlight BookmarkLine ctermbg=194 ctermfg=NONE
	--           let g:bookmark_sign = ''
	--           let g:bookmark_annotation_sign = ''
	--           let g:bookmark_highlight_lines = 1
	--           let g:bookmark_save_per_working_dir = 1
	--           let g:bookmark_auto_save = 1
	--           let g:bookmark_center = 1
	--           let g:bookmark_no_default_key_mappings = 1
	--           let g:bookmark_manage_per_buffer = 1
	--       ]])
	-- 	end,
	-- },
	-- {
	-- 	"tom-anders/telescope-vim-bookmarks.nvim",
	-- 	lazy = true,
	-- 	keys = {
	-- 		{
	-- 			"<leader>fl",
	-- 			function()
	-- 				local bookmark_actions = require("telescope").extensions.vim_bookmarks.actions
	-- 				require("telescope").extensions.vim_bookmarks.all({
	-- 					attach_mappings = function(_, map)
	-- 						map("n", "dd", bookmark_actions.delete_selected_or_at_cursor)
	-- 						return true
	-- 					end,
	-- 				})
	-- 			end,
	-- 			mode = "n",
	-- 			desc = "Show Bookmarks",
	-- 		},
	-- 	},
	-- 	config = function()
	-- 		require("telescope").load_extension("vim_bookmarks")
	-- 	end,
	-- },
	{
		{
			"tomasky/bookmarks.nvim",

			lazy = false,

			dependecies = {
				"nvim-telescope/telescope.nvim",
			},

			keys = {
				{
					"<leader>fl",
					":Telescope bookmarks list<cr>",
					mode = "n",
					desc = "Show Bookmarks",
				},
				{
					"<leader>ba",
					mode = "n",
					desc = "Bookmark Annotate",
				},
				{
					"<leader>bb",
					mode = "n",
					desc = "Bookmark Toggle",
				},
				{
					"<leader>bc",
					mode = "n",
					desc = "Bookmark Clear All",
				},
				{
					"<leader>bp",
					mode = "n",
					desc = "Previous Bookmark",
				},
				{
					"<leader>bn",
					mode = "n",
					desc = "Next Bookmark",
				},
				{
					"<leader>bl",
					mode = "n",
					desc = "Bookmark QuickList",
				},
			},

			config = function()
				local proj_dir = vim.fn.getcwd()
				local git_root_dir = vim.fn.finddir(".git", ".;")

				if git_root_dir ~= "" then
					proj_dir = vim.fn.expand(git_root_dir .. "/..")
				end

				local bookmarks_file_path = vim.fn.expand(proj_dir .. "/.bookmarks.json")
				print(bookmarks_file_path)
				local bm = require("bookmarks")

				bm.setup({
					sign_priority = 80,  --set bookmark sign priority to cover other sign
					save_file = bookmarks_file_path, -- bookmarks save file path

					keywords = {
						["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
						["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
						["@f"] = "⛏", -- mark annotation startswith @f ,signs this icon as `Fix`
						["@n"] = "📓", -- mark annotation startswith @n ,signs this icon as `Note`
						["@q"] = "❓", -- mark annotation startswith @q ,signs this icon as `Question`
					},

					on_attach = function(bufnr)
						vim.keymap.set("n", "<leader>bb", bm.bookmark_toggle) -- add or remove bookmark at current line
						vim.keymap.set("n", "<leader>ba", bm.bookmark_ann) -- add or edit mark annotation at current line
						vim.keymap.set("n", "<leader>bc", bm.bookmark_clean) -- clean all marks in local buffer
						vim.keymap.set("n", "<leader>bn", bm.bookmark_next) -- jump to next mark in local buffer
						vim.keymap.set("n", "<leader>bp", bm.bookmark_prev) -- jump to previous mark in local buffer
						vim.keymap.set("n", "<leader>bl", bm.bookmark_list) -- show marked file list in quickfix window
					end,
				})

				require("telescope").load_extension("bookmarks")
			end,
		},
	},
}
