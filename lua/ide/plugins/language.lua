return {
	-- TODO: fix this mess...
	{
		"L3MON4D3/LuaSnip",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip/loaders/from_vscode").load({
				paths = { vim.fn.stdpath("data") .. "/lazy" .. "/friendly-snippets" },
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
			"davidsierradz/cmp-conventionalcommits",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		config = function()
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
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function(entry, vim_item)
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

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
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
			"jose-elias-alvarez/null-ls.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"RRethy/vim-illuminate",
      "folke/neodev.nvim",
		},
		config = function()
			require("neodev").setup({
				library = {
					enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
					-- these settings will be used for your Neovim config directory
					runtime = true, -- runtime path
					types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
					plugins = true, -- installed opt or start plugins in packpath
					-- you can also specify the list of plugins to make available as a workspace library
					-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
				},
				setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
				-- for your Neovim config directory, the config.library settings will be used as is
				-- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
				-- for any other directory, config.library.enabled will be set to false
				-- override = function(root_dir, options) end,
				-- With lspconfig, Neodev will automatically setup your lua-language-server
				-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
				-- in your lsp start options
				lspconfig = true,
				-- much faster, but needs a recent built of lua-language-server
				-- needs lua-language-server >= 3.6.0
				pathStrict = false,
			})

			local wk = require("which-key")
			local null_ls = require("null-ls")
			local lspconfig = require("lspconfig")
			local dap = require("dap")
			local illuminate = require("illuminate")

			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				illuminate.on_attach(client)

				wk.register({
					["gD"] = {
						vim.lsp.buf.declaration,
						"Go To Definition",
						mode = "n",
						noremap = true,
						silent = true,
						buffer = bufnr,
					},
					["gd"] = {
						vim.lsp.buf.definition,
						"Go To Declaration",
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
				ensure_installed = { "lua_ls" },
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			LanguageUtils = require("ide.languages.api.language_utils")

			local language_utils = LanguageUtils.new(null_ls, lspconfig, dap, on_attach, capabilities, lsp_flags)
			local languages = require("ide.languages")

			local null_ls_sources = {}
			for language_name, language in pairs(languages) do
				print("configuring " .. language_name)
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
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = true,
					underline = true,
				},
			})
		end,
	},
	{
		"ThePrimeagen/refactoring.nvim",
		lazy = true,
		event = "LspAttach",
		keys = {
			{
				"<leader>rr",
				":lua require('refactoring').select_refactor()<CR>",
				{ noremap = true, silent = true, expr = false },
				mode = "v",
				desc = "Refactor",
			},
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup()
			require("telescope").load_extension("refactoring")
		end,
	},
}
