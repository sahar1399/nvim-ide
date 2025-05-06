return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nushell/tree-sitter-nu",
			"windwp/nvim-ts-autotag",
			"yioneko/nvim-yati",
			{
				"LiadOz/nvim-dap-repl-highlights",
				config = function()
					require("nvim-dap-repl-highlights").setup()
				end,
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function()
					require("ts_context_commentstring").setup({})
					vim.g.skip_ts_context_commentstring_module = true
				end,
			},
		},
		lazy = false,
		priority = 500,
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the four listed parsers should always be installed)
				ensure_installed = "all",
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				-- List of parsers to ignore installing (for "all")
				ignore_install = { "javascript" },
				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
				autotag = {
					enable = true,
				},
				--
				yati = {
					enable = true,
					-- Disable by languages, see `Supported languages`
					-- disable = { "python" },
					-- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
					default_lazy = true,
					-- Determine the fallback method used when we cannot calculate indent by tree-sitter
					--   "auto": fallback to vim auto indent
					--   "asis": use current indent as-is
					--   "cindent": see `:h cindent()`
					-- Or a custom function return the final indent result.
					default_fallback = "auto",
				},
				indent = {
					enable = false,
				},
				highlight = {
					-- `false` will disable the whole extension
					enable = true,
					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					-- disable = { "c", "rust" },
					-- -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
					-- disable = function(lang, buf)
					-- local max_filesize = 100 * 1024 -- 100 KB
					-- local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					-- if ok and stats and stats.size > max_filesize then
					-- return true
					-- end
					-- end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = { "markdown" },
				},
			})
		end,
	},
	{
		"ckolkey/ts-node-action",
		lazy = true,
		keys = {
			{
				"|",
				"<cmd>lua require('ts-node-action').node_action()<cr>",
				mode = "n",
				desc = "Trigger Node Action",
			},
		},
		dependencies = { "nvim-treesitter" },
		config = function()
			require("ts-node-action").setup({})
		end,
	},
}
