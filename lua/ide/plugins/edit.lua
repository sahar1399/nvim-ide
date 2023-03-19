local opts = { noremap = true, silent = true }
return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		lazy = true,
		keys = {
			{ "<C-n>", mode = "n", desc = "Find Under" },
			{ "<C-j>", mode = "n", desc = "Add Cursor Down" },
			{ "<C-k>", mode = "n", desc = "Add Cursor Up" },
			{ "<leader>A", mode = "n", desc = "Select All" },
			{ "<leader>/", mode = "n", desc = "Start Regex Search" },
		},
		init = function()
			vim.cmd([[
      let g:VM_leader = '`'
      let g:VM_default_mappings = 0

      let g:VM_maps = {}
      let g:VM_maps['Add Cursor Down']             = '<C-j>'
      let g:VM_maps['Add Cursor Up']               = '<C-k>'
      let g:VM_maps['Find Under']                  = '<C-n>'
      let g:VM_maps["Select All"]                  = '<leader>A'
      let g:VM_maps["Start Regex Search"]          = '<leader>/'
      let g:VM_maps["Add Cursor At Pos"]           = '\\\'
    ]])
		end,
	},
	{
		"terrortylor/nvim-comment",
		lazy = true,
		keys = {
			{ "gc", mode = "n", noremap = true, desc = "Comment" },
			{ "gc", mode = "v", noremap = true, desc = "Comment" },
			{ "ic", mode = { "o", "x" }, noremap = true, desc = "Comment" },
		},
		config = function()
			require("nvim_comment").setup({
				-- Linters prefer comment and line to have a space in between markers
				marker_padding = true,
				-- should comment out empty or whitespace only lines
				comment_empty = true,
				-- trim empty comment whitespace
				comment_empty_trim_whitespace = true,
				-- Should key mappings be created
				create_mappings = true,
				-- Normal mode mapping left hand side
				line_mapping = "gcc",
				-- Visual/Operator mapping left hand side
				operator_mapping = "gc",
				-- text object mapping, comment chunk,,
				comment_chunk_text_object = "ic",
				-- Hook function to call before commenting takes place
				hook = nil,
			})
		end,
	},
	{
		"danymat/neogen",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"L3MON4D3/LuaSnip",
		},
		lazy = true,
		keys = {
			{
				"<leader>kf",
				":lua require('neogen').generate({type='func'})<CR>",
				opts,
				mode = "n",
				desc = "Generate function annotation",
			},
			{
				"<leader>kc",
				":lua require('neogen').generate({type='class'})<CR>",
				opts,
				mode = "n",
				desc = "Generate class annotation",
			},
		},
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup({
				check_ts = true,
				-- ts_config = {
				-- 	lua = { "string" }, -- it will not add a pair on that treesitter node
				-- 	javascript = { "template_string" },
				-- 	java = false, -- don't check treesitter on java
				-- },
			})

			local ts_conds = require("nvim-autopairs.ts-conds")

			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
				Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
			})

			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"anuvyklack/fold-preview.nvim",
		lazy = true,
		keys = {
			{ "zp", mode = "n" },
			{ "h", mode = "n" },
			{ "l", mode = "n" },
			{ "zo", mode = "n" },
			{ "zO", mode = "n" },
			{ "zc", mode = "n" },
			{ "zR", mode = "n" },
			{ "zM", mode = "n" },
		},
		dependencies = { "anuvyklack/keymap-amend.nvim" },
		config = function()
			local fp = require("fold-preview")
			local map = require("fold-preview").mapping
			local keymap = vim.keymap
			keymap.amend = require("keymap-amend")

			fp.setup({
				default_keybindings = false,
				-- another settings
			})

			keymap.amend("n", "zp", function(original)
				if not fp.toggle_preview() then
					original()
				end
			end)
			keymap.amend("n", "h", map.close_preview_open_fold)
			keymap.amend("n", "l", map.close_preview_open_fold)
			keymap.amend("n", "zo", map.close_preview)
			keymap.amend("n", "zO", map.close_preview)
			keymap.amend("n", "zc", map.close_preview_without_defer)
			keymap.amend("n", "zR", map.close_preview)
			keymap.amend("n", "zM", map.close_preview_without_defer)
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = {
			"BufRead *puml",
		},
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
		event = {
			"BufRead *md",
		},
		config = function()
			vim.cmd([[
        let g:table_mode_corner_corner='+`
        let g:table_mode_header_fillchar='='
      ]])
		end,
	},
}
