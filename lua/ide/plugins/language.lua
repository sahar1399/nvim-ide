return {
	-- TODO: fix this mess...
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			if vim.g.non_modified then
				return
			end

			require("luasnip/loaders/from_vscode").load({
				paths = {
					vim.fn.stdpath("data") .. "/lazy" .. "/friendly-snippets",
					vim.fn.stdpath("config") .. "/snippets",
				},
			})
		end,
	},
	-- TODO: fix this mess...
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"Dosx001/cmp-commit",
			"rcarriga/cmp-dap",
			"davidsierradz/cmp-conventionalcommits",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			if vim.g.non_modified then
				return
			end

			local cmp = require("cmp")
			local lspkind = require("lspkind")

			require("cmp_commit").setup({
				set = true,
				format = { "<<= ", " =>>" },
				length = 9,
				block = { "__pycache__", "CMakeFiles", "node_modules", "target" },
				word_list = "~/cmpcommit.json",
			})

			cmp.setup({
				enabled = function()
					return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
				end,
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "luasnip" },
					{ name = "neorg" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
					{ name = "buffer" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
							vim_item.menu = ({
								buffer = "[Buffer]",
								nvim_lsp = "[LSP]",
								luasnip = "[LuaSnip]",
								nvim_lua = "[Lua]",
								latex_symbols = "[LaTeX]",
							})[entry.source.name]
							return vim_item
						end,
					}),
				},
			})
			--
			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" },
					{ name = "conventionalcommits" },
					{ name = "commit" },
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
				sources = {
					{ name = "dap" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "cmp_docs",
				callback = function()
					vim.treesitter.start(0, "markdown")
				end,
			})
		end,
	},
	-- TODO: fix this mess...
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			"nvimtools/none-ls.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"RRethy/vim-illuminate",
			"folke/neodev.nvim",
			{
				"utilyre/barbecue.nvim",
				after = "nvim-web-devicons",
				dependencies = {
					{
						"SmiteshP/nvim-navic",
						lazy = false,
						dependencies = "neovim/nvim-lspconfig",
					},
					"nvim-tree/nvim-web-devicons", -- optional dependency
					{
						"rmagatti/goto-preview",
						opts = {
							opacity = 15, -- 0-100 opacity level of the floating window where 100 is fully transparent.
						},
					},
				},
				config = function()
					require("barbecue").setup({
						---Whether to attach navic to language servers automatically.
						---
						---@type boolean
						attach_navic = false,
						---Whether to create winbar updater autocmd.
						---
						---@type boolean
						create_autocmd = true,
						---Buftypes to enable winbar in.
						---
						---@type string[]
						include_buftypes = { "" },
						---Filetypes not to enable winbar in.
						---
						---@type string[]
						exclude_filetypes = { "gitcommit", "toggleterm" },
						modifiers = {
							---Filename modifiers applied to dirname.
							---
							---See: `:help filename-modifiers`
							---
							---@type string
							dirname = ":~:.",
							---Filename modifiers applied to basename.
							---
							---See: `:help filename-modifiers`
							---
							---@type string
							basename = "",
						},
						---Whether to display path to file.
						---
						---@type boolean
						show_dirname = true,
						---Whether to display file name.
						---
						---@type boolean
						show_basename = true,
						---Whether to replace file icon with the modified symbol when buffer is
						---modified.
						---
						---@type boolean
						show_modified = false,
						---Get modified status of file.
						---
						---NOTE: This can be used to get file modified status from SCM (e.g. git)
						---
						---@type fun(bufnr: number): boolean
						modified = function(bufnr)
							return vim.bo[bufnr].modified
						end,
						---Whether to show/use navic in the winbar.
						---
						---@type boolean
						show_navic = true,
						---Get leading custom section contents.
						---
						---NOTE: This function shouldn't do any expensive actions as it is run on each
						---render.
						---
						---@type fun(bufnr: number): barbecue.Config.custom_section
						lead_custom_section = function()
							return " "
						end,
						---@alias barbecue.Config.custom_section
						---|string # Literal string.
						---|{ [1]: string, [2]: string? }[] # List-like table of `[text, highlight?]` tuples in which `highlight` is optional.
						---
						---Get custom section contents.
						---
						---NOTE: This function shouldn't do any expensive actions as it is run on each
						---render.
						---
						---@type fun(bufnr: number): barbecue.Config.custom_section
						custom_section = function()
							return " "
						end,
						---@alias barbecue.Config.theme
						---|'"auto"' # Use your current colorscheme's theme or generate a theme based on it.
						---|string # Theme located under `barbecue.theme` module.
						---|barbecue.Theme # Same as '"auto"' but override it with the given table.
						---
						---Theme to be used for generating highlight groups dynamically.
						---
						---@type barbecue.Config.theme
						theme = "auto",
						---Whether context text should follow its icon's color.
						---
						---@type boolean
						context_follow_icon_color = false,
						symbols = {
							---Modification indicator.
							---
							---@type string
							modified = "●",
							---Truncation indicator.
							---
							---@type string
							ellipsis = "…",
							---Entry separator.
							---
							---@type string
							separator = "",
						},
						---@alias barbecue.Config.kinds
						---|false # Disable kind icons.
						---|table<string, string> # Type to icon mapping.
						---
						---Icons for different context entry kinds.
						---
						---@type barbecue.Config.kinds
						kinds = {
							File = " ",
							Module = " ",
							Namespace = " ",
							Package = " ",
							Class = " ",
							Method = " ",
							Property = " ",
							Field = " ",
							Constructor = " ",
							Enum = "練",
							Interface = "練",
							Function = " ",
							Variable = " ",
							Constant = " ",
							String = " ",
							Number = " ",
							Boolean = "◩ ",
							Array = " ",
							Object = " ",
							Key = " ",
							Null = "ﳠ ",
							EnumMember = " ",
							Struct = " ",
							Event = " ",
							Operator = " ",
							TypeParameter = " ",
						},
					})
				end,
			},
		},
		config = function()
			local neodev = require("neodev").setup({
				library = {
					enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
					-- these settings will be used for your Neovim config directory
					runtime = true, -- runtime path
					types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
					plugins = true, -- installed opt or start plugins in packpath
					-- you can also specify the list of plugins to make available as a workspace library
					-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
					--
				},
				setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
				-- for your Neovim config directory, the config.library settings will be used as is
				-- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
				-- for any other directory, config.library.enabled will be set to false
				override = function(root_dir, library)
					library.plugins = true
				end,
				-- With lspconfig, Neodev will automatically setup your lua-language-server
				-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
				-- in your lsp start options
				lspconfig = true,
				-- much faster, but needs a recent built of lua-language-server
				-- needs lua-language-server >= 3.6.0
				pathStrict = true,
			})

			local null_ls = require("null-ls")
			local lspconfig = require("lspconfig")
			local dap = require("dap")
			local illuminate = require("illuminate")
			local navic = require("nvim-navic")
			local goto_preview = require("goto-preview")

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end

				if client.server_capabilities.inlayHintProvider then
					require("vim.lsp.inlay_hint")(bufnr, true)
				end

				illuminate.on_attach(client)

				if vim.g.non_modified then
					return
				end

				local wk = require("which-key")

				-- TODO: do this to every command
				if client.server_capabilities.implementationProvider then
					wk.register({
						["gpi"] = {
							function()
								require("goto-preview").goto_preview_implementation()
							end,
							"Preview Implementation",
							mode = "n",
							noremap = true,
							silent = true,
							buffer = bufnr,
						},
						["gi"] = {
							vim.lsp.buf.implementation,
							"Go To Implementation",
							mode = "n",
							noremap = true,
							silent = true,
							buffer = bufnr,
						},
					})
				end

				if client.server_capabilities.definitionProvider then
					wk.register({
						["gd"] = {
							vim.lsp.buf.definition,
							"Go To Definition",
							mode = "n",
							noremap = true,
							silent = true,
							buffer = bufnr,
						},
						["gpd"] = {
							function()
								require("goto-preview").goto_preview_definition()
							end,
							"Preview Definition",
							mode = "n",
							noremap = true,
							silent = true,
							buffer = bufnr,
						},
						["gpt"] = {
							function()
								require("goto-preview").goto_preview_type_definition()
							end,
							"Preview Type Definition",
							mode = "n",
							noremap = true,
							silent = true,
							buffer = bufnr,
						},
						["gpr"] = {
							function()
								require("goto-preview").goto_preview_references()
							end,
							"Preview References",
							mode = "n",
							noremap = true,
							silent = true,
							buffer = bufnr,
						},
					})
				end

				wk.register({
					["gpc"] = {
						function()
							require("goto-preview").close_all_win()
						end,
						"Close all Previews",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["gD"] = {
						vim.lsp.buf.declaration,
						"Go To Declaration",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["K"] = {
						vim.lsp.buf.signature_help,
						"Signature Help",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["<leader>D"] = {
						vim.lsp.buf.type_definition,
						"Type Definition",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["<leader>a"] = {
						vim.lsp.buf.code_action,
						"Code Actions",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["<leader>rn"] = {
						vim.lsp.buf.rename,
						"Rename Symbol",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["<leader>rf"] = {
						function()
							vim.lsp.buf.format({ async = true })
						end,
						"Format File",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
				})
			end

			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				debounce_text_changes = 150,
			}

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			LanguageUtils = require("ide.languages.api.language_utils")

			local language_utils = LanguageUtils.new(null_ls, lspconfig, dap, on_attach, capabilities, lsp_flags)
			local languages = require("ide.languages")

			local null_ls_sources = {}
			for language_name, language in pairs(languages) do
				-- print("configuring " .. language_name)
				local result = language:setup(language_utils)
				for _, v in ipairs(result.null_ls_sources) do
					table.insert(null_ls_sources, v)
				end
			end

			null_ls.setup({
				debounce = 150,
				save_after_format = false,
				sources = null_ls_sources,
				on_attach = on_attach,
				root_dir = require("null-ls.utils").root_pattern(".git"),
			})
		end,
	},
	{
		"folke/lsp-colors.nvim",
		event = "LspAttach",
		config = function()
			require("lsp-colors").setup()
		end,
	},
	{
		"m-demare/hlargs.nvim",
		event = "LspAttach",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("hlargs").setup()
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("illuminate").configure({})
		end,
	},
	-- {
	-- 	"zbirenbaum/neodim",
	-- 	event = "LspAttach",
	-- 	config = function()
	-- 		require("neodim").setup({
	-- 			alpha = 0.75,
	-- 			blend_color = "#000000",
	-- 			update_in_insert = {
	-- 				enable = true,
	-- 				delay = 100,
	-- 			},
	-- 			hide = {
	-- 				virtual_text = true,
	-- 				signs = true,
	-- 				underline = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"ThePrimeagen/refactoring.nvim",
		lazy = true,
		event = "LspAttach",
		keys = {
			{
				"<leader>rr",
				function()
					require("telescope").extensions.refactoring.refactors()
				end,
				{ noremap = true },
				mode = "v",
				desc = "Refactor",
			},
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			if vim.g.non_modified then
				return
			end

			require("refactoring").setup()
			require("telescope").load_extension("refactoring")
		end,
	},
	{
		"stevearc/aerial.nvim",
		lazy = false,
		tag = "stable",
		keys = {
			{
				"<leader>S",
				"<cmd>AerialToggle!<CR>",
				mode = "n",
				desc = "Toggle Symbol Tree",
			},
			{
				"<leader>fa",
				function()
					require("telescope").extensions.aerial.aerial()
				end,
				mode = "n",
				desc = "Search in Symbol Tree",
			},
			{
				"<leader>N",
				"<cmd>AerialNavToggle<CR>",
				mode = "n",
				desc = "Navigate",
			},
		},
		config = function()
			local aerial = require("aerial")

			-- TODO: restore config after goto definition is fixed on aerial + splits/quickfix.
			aerial.setup({
				layout = {
					win_opts = {
						relativenumber = true,
						number = true,
					},
				},
				disable_max_lines = 20000,
				-- layout = {
				-- 	-- These control the width of the aerial window.
				-- 	-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- 	-- min_width and max_width can be a list of mixed types.
				-- 	-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
				-- 	max_width = { 40, 0.2 },
				-- 	width = nil,
				-- 	min_width = { 40, 0.2 },
				-- 	-- key-value pairs of window-local options for aerial window (e.g. winhl)
				-- 	win_opts = {
				-- 		number = true,
				-- 		relativenumber = true,
				-- 	},
				-- 	-- Determines the default direction to open the aerial window. The 'prefer'
				-- 	-- options will open the window in the other direction *if* there is a
				-- 	-- different buffer in the way of the preferred direction
				-- 	-- Enum: prefer_right, prefer_left, right, left, float
				-- 	default_direction = "prefer_right",
				-- 	-- Determines where the aerial window will be opened
				-- 	--   edge   - open aerial at the far right/left of the editor
				-- 	--   window - open aerial to the right/left of the current window
				-- 	placement = "window",
				-- 	-- Preserve window size equality with (:help CTRL-W_=)
				-- 	preserve_equality = true,
				-- },
				-- -- Determines how the aerial window decides which buffer to display symbols for
				-- --   window - aerial window will display symbols for the buffer in the window from which it was opened
				-- --   global - aerial window will display symbols for the current window
				-- attach_mode = "global",
				-- -- List of enum values that configure when to auto-close the aerial window
				-- --   unfocus       - close aerial when you leave the original source window
				-- --   switch_buffer - close aerial when you change buffers in the source window
				-- --   unsupported   - close aerial when attaching to a buffer that has no symbol source
				-- close_automatic_events = { "unsupported", "unfocus" },
				-- -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
				-- -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
				-- -- Additionally, if it is a string that matches "actions.<name>",
				-- -- it will use the mapping at require("aerial.actions").<name>
				-- -- Set to `false` to remove a keymap
				-- keymaps = {
				-- 	["?"] = "actions.show_help",
				-- 	["g?"] = "actions.show_help",
				-- 	["<CR>"] = "actions.jump",
				-- 	["<2-LeftMouse>"] = "actions.jump",
				-- 	["<C-v>"] = "actions.jump_vsplit",
				-- 	["<C-s>"] = "actions.jump_split",
				-- 	["p"] = "actions.scroll",
				-- 	["<C-j>"] = "actions.down_and_scroll",
				-- 	["<C-k>"] = "actions.up_and_scroll",
				-- 	["{"] = "actions.prev",
				-- 	["}"] = "actions.next",
				-- 	["[["] = "actions.prev_up",
				-- 	["]]"] = "actions.next_up",
				-- 	["q"] = "actions.close",
				-- 	["o"] = "actions.tree_toggle",
				-- 	["za"] = "actions.tree_toggle",
				-- 	["O"] = "actions.tree_toggle_recursive",
				-- 	["zA"] = "actions.tree_toggle_recursive",
				-- 	["l"] = "actions.tree_open",
				-- 	["zo"] = "actions.tree_open",
				-- 	["L"] = "actions.tree_open_recursive",
				-- 	["zO"] = "actions.tree_open_recursive",
				-- 	["h"] = "actions.tree_close",
				-- 	["zc"] = "actions.tree_close",
				-- 	["H"] = "actions.tree_close_recursive",
				-- 	["zC"] = "actions.tree_close_recursive",
				-- 	["zr"] = "actions.tree_increase_fold_level",
				-- 	["zR"] = "actions.tree_open_all",
				-- 	["zm"] = "actions.tree_decrease_fold_level",
				-- 	["zM"] = "actions.tree_close_all",
				-- 	["zx"] = "actions.tree_sync_folds",
				-- 	["zX"] = "actions.tree_sync_folds",
				-- },
				-- -- When true, don't load aerial until a command or function is called
				-- -- Defaults to true, unless `on_attach` is provided, then it defaults to false
				-- lazy_load = false,
				-- -- Disable aerial on files with this many lines
				-- disable_max_lines = 10000,
				-- -- Disable aerial on files this size or larger (in bytes)
				-- disable_max_size = 2000000, -- Default 2MB
				-- -- A list of all symbols to display. Set to false to display all symbols.
				-- -- This can be a filetype map (see :help aerial-filetype-map)
				-- -- To see all available values, see :help SymbolKind
				-- filter_kind = {
				-- 	"Class",
				-- 	"Constructor",
				-- 	"Enum",
				-- 	"Function",
				-- 	"Interface",
				-- 	"Module",
				-- 	"Method",
				-- 	"Struct",
				-- },
				-- -- Determines line highlighting mode when multiple splits are visible.
				-- -- split_width   Each open window will have its cursor location marked in the
				-- --               aerial buffer. Each line will only be partially highlighted
				-- --               to indicate which window is at that location.
				-- -- full_width    Each open window will have its cursor location marked as a
				-- --               full-width highlight in the aerial buffer.
				-- -- last          Only the most-recently focused window will have its location
				-- --               marked in the aerial buffer.
				-- -- none          Do not show the cursor locations in the aerial window.
				-- highlight_mode = "split_width",
				-- -- Highlight the closest symbol if the cursor is not exactly on one.
				-- highlight_closest = true,
				-- -- Highlight the symbol in the source buffer when cursor is in the aerial win
				-- highlight_on_hover = false,
				-- -- When jumping to a symbol, highlight the line for this many ms.
				-- -- Set to false to disable
				-- highlight_on_jump = 300,
				--
				-- -- Jump to symbol in source window when the cursor moves
				-- autojump = false,
				--
				-- -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
				-- -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
				-- -- default collapsed icon. The default icon set is determined by the
				-- -- "nerd_font" option below.
				-- -- If you have lspkind-nvim installed, it will be the default icon set.
				-- -- This can be a filetype map (see :help aerial-filetype-map)
				-- icons = {},
				-- -- Control which windows and buffers aerial should ignore.
				-- -- Aerial will not open when these are focused, and existing aerial windows will not be updated
				-- ignore = {
				-- 	-- Ignore unlisted buffers. See :help buflisted
				-- 	unlisted_buffers = false,
				-- 	-- List of filetypes to ignore.
				-- 	filetypes = {},
				-- 	-- Ignored buftypes.
				-- 	-- Can be one of the following:
				-- 	-- false or nil - No buftypes are ignored.
				-- 	-- "special"    - All buffers other than normal, help and man page buffers are ignored.
				-- 	-- table        - A list of buftypes to ignore. See :help buftype for the
				-- 	--                possible values.
				-- 	-- function     - A function that returns true if the buffer should be
				-- 	--                ignored or false if it should not be ignored.
				-- 	--                Takes two arguments, `bufnr` and `buftype`.
				-- 	buftypes = "special",
				-- 	-- Ignored wintypes.
				-- 	-- Can be one of the following:
				-- 	-- false or nil - No wintypes are ignored.
				-- 	-- "special"    - All windows other than normal windows are ignored.
				-- 	-- table        - A list of wintypes to ignore. See :help win_gettype() for the
				-- 	--                possible values.
				-- 	-- function     - A function that returns true if the window should be
				-- 	--                ignored or false if it should not be ignored.
				-- 	--                Takes two arguments, `winid` and `wintype`.
				-- 	wintypes = "special",
				-- },
				-- -- Use symbol tree for folding. Set to true or false to enable/disable
				-- -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
				-- -- This can be a filetype map (see :help aerial-filetype-map)
				-- manage_folds = true,
				-- -- When you fold code with za, zo, or zc, update the aerial tree as well.
				-- -- Only works when manage_folds = true
				-- link_folds_to_tree = false,
				-- -- Fold code when you open/collapse symbols in the tree.
				-- -- Only works when manage_folds = true
				-- link_tree_to_folds = true,
				-- -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
				-- -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
				-- nerd_font = "auto",
				-- -- Call this function when aerial first sets symbols on a buffer.
				-- on_first_symbols = function(bufnr) end,
				-- -- Automatically open aerial when entering supported buffers.
				-- -- This can be a function (see :help aerial-open-automatic)
				--         open_automatic = false,
				-- -- open_automatic = function(bufnr)
				-- -- 	-- Enforce a minimum line count
				-- -- 	return vim.api.nvim_buf_line_count(bufnr) > 80
				-- -- 		-- Enforce a minimum symbol count
				-- -- 		and aerial.num_symbols(bufnr) > 4
				-- -- 		-- A useful way to keep aerial closed when closed manually
				-- -- 		and not aerial.was_closed()
				-- -- end,
				-- --
				-- -- Run this command after jumping to a symbol (false will disable)
				-- post_jump_cmd = "normal! zz",
				-- -- Invoked after each symbol is parsed, can be used to modify the parsed item,
				-- -- or to filter it by returning false.
				-- --
				-- -- bufnr: a neovim buffer number
				-- -- item: of type aerial.Symbol
				-- -- ctx: a record containing the following fields:
				-- --   * backend_name: treesitter, lsp, man...
				-- --   * lang: info about the language
				-- --   * symbols?: specific to the lsp backend
				-- --   * symbol?: specific to the lsp backend
				-- --   * syntax_tree?: specific to the treesitter backend
				-- --   * match?: specific to the treesitter backend, TS query match
				-- post_parse_symbol = function(bufnr, item, ctx)
				-- 	return true
				-- end,
				-- -- Invoked after all symbols have been parsed and post-processed,
				-- -- allows to modify the symbol structure before final display
				-- --
				-- -- bufnr: a neovim buffer number
				-- -- items: a collection of aerial.Symbol items, organized in a tree,
				-- --        with 'parent' and 'children' fields
				-- -- ctx: a record containing the following fields:
				-- --   * backend_name: treesitter, lsp, man...
				-- --   * lang: info about the language
				-- --   * symbols?: specific to the lsp backend
				-- --   * syntax_tree?: specific to the treesitter backend
				-- post_add_all_symbols = function(bufnr, items, ctx)
				-- 	return items
				-- end,
				-- -- When true, aerial will automatically close after jumping to a symbol
				-- close_on_select = false,
				-- -- The autocmds that trigger symbols update (not used for LSP backend)
				-- update_events = "TextChanged,InsertLeave",
				-- -- Show box drawing characters for the tree hierarchy
				-- show_guides = true,
				-- -- Customize the characters used when show_guides = true
				-- guides = {
				-- 	-- When the child item has a sibling below it
				-- 	mid_item = "├─",
				-- 	-- When the child item is the last in the list
				-- 	last_item = "└─",
				-- 	-- When there are nested child guides to the right
				-- 	nested_top = "│ ",
				-- 	-- Raw indentation
				-- 	whitespace = "  ",
				-- },
				-- -- Set this function to override the highlight groups for certain symbols
				-- get_highlight = function(symbol, is_icon)
				-- 	-- return "MyHighlight" .. symbol.kind
				-- end,
				-- -- Options for opening aerial in a floating win
				-- float = {
				-- 	-- Controls border appearance. Passed to nvim_open_win
				-- 	border = "rounded",
				-- 	-- Determines location of floating window
				-- 	--   cursor - Opens float on top of the cursor
				-- 	--   editor - Opens float centered in the editor
				-- 	--   win    - Opens float centered in the window
				-- 	relative = "cursor",
				-- 	-- These control the height of the floating window.
				-- 	-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- 	-- min_height and max_height can be a list of mixed types.
				-- 	-- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
				-- 	max_height = 0.9,
				-- 	height = nil,
				-- 	min_height = { 8, 0.1 },
				-- 	override = function(conf, source_winid)
				-- 		-- This is the config that will be passed to nvim_open_win.
				-- 		-- Change values here to customize the layout
				-- 		return conf
				-- 	end,
				-- },
				-- -- Options for the floating nav windows
				-- nav = {
				-- 	border = "rounded",
				-- 	max_height = 0.9,
				-- 	min_height = { 10, 0.1 },
				-- 	max_width = 0.5,
				-- 	min_width = { 0.2, 20 },
				-- 	win_opts = {
				-- 		cursorline = true,
				-- 		winblend = 10,
				-- 	},
				-- 	-- Jump to symbol in source window when the cursor moves
				-- 	autojump = false,
				-- 	-- Keymaps in the nav window
				-- 	keymaps = {
				-- 		["<CR>"] = "actions.jump",
				-- 		["<2-LeftMouse>"] = "actions.jump",
				-- 		["<C-v>"] = "actions.jump_vsplit",
				-- 		["<C-s>"] = "actions.jump_split",
				-- 		["h"] = "actions.left",
				-- 		["l"] = "actions.right",
				-- 		["<C-c>"] = "actions.close",
				-- 	},
				-- },
				-- lsp = {
				-- 	-- Fetch document symbols when LSP diagnostics update.
				-- 	-- If false, will update on buffer changes.
				-- 	diagnostics_trigger_update = true,
				-- 	-- Set to false to not update the symbols when there are LSP errors
				-- 	update_when_errors = true,
				-- 	-- How long to wait (in ms) after a buffer change before updating
				-- 	-- Only used when diagnostics_trigger_update = false
				-- 	update_delay = 300,
				-- 	-- Map of LSP client name to priority. Default value is 10.
				-- 	-- Clients with higher (larger) priority will be used before those with lower priority.
				-- 	-- Set to -1 to never use the client.
				-- 	priority = {
				-- 		-- pyright = 10,
				-- 	},
				-- },
				-- treesitter = {
				-- 	-- How long to wait (in ms) after a buffer change before updating
				-- 	update_delay = 300,
				-- },
				-- markdown = {
				-- 	-- How long to wait (in ms) after a buffer change before updating
				-- 	update_delay = 300,
				-- },
				-- man = {
				-- 	-- How long to wait (in ms) after a buffer change before updating
				-- 	update_delay = 300,
				-- },
				-- on_attach = function(bufnr)
				-- 	-- Jump forwards/backwards with '{' and '}'
				-- 	-- for i, winnr in ipairs(vim.fn.win_findbuf(bufnr)) do
				-- 	-- 	vim.wo[winnr].number = false
				-- 	-- 	vim.wo[winnr].relativenumber = false
				-- 	-- end
				--
				-- 	wk.register({
				-- 		["{"] = {
				-- 			"<cmd>AerialPrev<CR>",
				-- 			mode = "n",
				-- 			buffer = bufnr,
				-- 			noremap = true,
				-- 			silent = true,
				-- 		},
				-- 		["}"] = {
				-- 			"<cmd>AerialNext<CR>",
				-- 			mode = "n",
				-- 			buffer = bufnr,
				-- 			noremap = true,
				-- 			silent = true,
				-- 		},
				-- 	})
				-- end,
			})

			require("telescope").load_extension("aerial")
		end,
	},
	{
		"towolf/vim-helm",
		"towolf/vim-helm",
	},
}
