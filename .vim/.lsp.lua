local util = require "lspconfig".util

require("lsp-format").setup {}
require("nvim-lsp-installer").setup {}
local lsp_config = require('lspconfig')
-- enable when nvim 0.8.0 is out
-- require("inc_rename").setup {
--   cmd_name = "IncRename", -- the name of the command
--   hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
--}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- disable when nvim 0.8.0 is out
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ra', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ra', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
  vim.cmd [[cabbrev w execute "Format sync" <bar> w]]
  -- enable when nvim 0.8.0 is out
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true })

end

-- Completion and Snippets
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

require('luasnip/loaders/from_vscode').load()

local luasnip = require('luasnip')
local cmp = require'cmp'

local function check_backspace()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
    ["<C-y>"] = cmp.config.disable,
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expandable() then  luasnip.expand()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      elseif check_backspace() then fallback()
      else fallback()
      end
    end, { "i", "s"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback()
      end
    end, { "i", "s"}),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        luasnip = "[snip]",
        path = "[path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'buffer', keyword_length = 3 }
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  }
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('nvim-autopairs').setup{}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Refactoring
-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

require('refactoring').setup({})
-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true })
-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.api.nvim_set_keymap(
	"n",
	"<leader>rp",
	":lua require('refactoring').debug.printf({below = false})<CR>",
	{ noremap = true }
)

-- Print var: this remap should be made in visual mode
vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
  init_options = {
    provideFormatter = true,
    documentFormatting = true
  },
  single_file_support = true
}

require'lspconfig'.dockerls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = { documentFormatting = true },
  cmd = { "docker-langserver", "--stdio" },
  root_dir = util.root_pattern("Dockerfile"),
  single_file_support = true
}

require'lspconfig'.cmake.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "cmake-language-server" },
  init_options = {
    buildDirectory = "build",
    init_options = { documentFormatting = true },
  },
  root_dir = util.root_pattern(".git", "compile_commands.json", "build"),
  single_file_support = true
}

require'lspconfig'.bashls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = { documentFormatting = true },
  cmd = { "bash-language-server", "start" },
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
  },
  filetypes = { "sh", "bash" },
  root_dir = util.find_git_ancestor,
  single_file_support = true
}

require'lspconfig'.pylsp.setup{
    on_attach = on_attach,
    cmd = { "/usr/local/bin/pylsp" },
    settings = {
        configurationSources = {"flake8"},
	formatCommand = {"black"},
    	pylsp = {
	    plugins = {
	        jedi_completion = {
		    enabled = true,
		    fuzzy = true,
		    eager = true,
		    include_params = true,
		    --cache_for = {"numpy", "scipy"}
		},
		jedi_definition = {
		    enabled = true,
		    follow_imports = true,
		    follow_builtin_imports = true,
		},
		jedi_hover = { enabled = true },
		jedi_references = { enabled = true },
		jedi_signature_help = { enabled = true },
		jedi_symbols = { enabled = true, all_scopes = true, include_import_symbols = true },
		black = { enbalde = true, line_length = 120 },
		--preload = { enabled = true, modules = {"numpy", "scipy"} },
		--mccabe = { enabled = true },
		mypy = { enabled = true },
		isort = { enabled = true },
		--spyder = { enabled = true },
		memestra = { enabled = true },
		pycodestyle = { enabled = true },
		flake8 = { enabled = true },
		pyflakes = { enabled = true },
		yapf = { enabled = true },
		pylint = { enabled=true, debounce=200
		    --args = {
	--		"-f",
	--		"json",
	--		"--rcfile=" .. "~/.pylintrc"
	--	    }
		},
		rope = { enabled = true },
	    }
	}
}
}

lsp_config.pyright.setup{
    cmd = { "pyright-langserver", "--stdio" },
    capabilities = capabilities,
    filetypes = {"python"},
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true
        },
      },
    },
    single_file_support = true
}

lsp_config.clangd.setup{
        capabilities = capabilities,
	cmd = { "clangd",
		"--all-scopes-completion",
		"--background-index",
		"--clang-tidy",
		"--completion-style=bundled",
		"--header-insertion-decorators",
		"--inlay-hints",
		"-j=10",
		"--limit-references=0",
		"--limit-results=0"
	},
        filetypes = {"h", "hpp", "c", "cpp", "objc", "objcpp"},
        on_attach = on_attach,
    	init_options = { documentFormatting = true },
        flags = {
          debounce_text_changes = 150
        },
	single_file_support = true
}

lsp_config.prosemd_lsp.setup{ 
        capabilities = capabilities,
	cmd = { "prosemd-lsp", "--stdio" },
        filetypes = {"markdown"},
        on_attach = on_attach,
    	init_options = { documentFormatting = true },
        flags = {
          debounce_text_changes = 150
        },
	single_file_support = true
}

lsp_config.vimls.setup{
	cmd = { "vim-language-server", "--stdio" },
	filetype = { "vim" },
	on_attach = on_attach,
	init_options = {
		  diagnostic = {
		    enable = true
		  },
		  indexes = {
		    count = 3,
		    gap = 100,
		    projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
		    runtimepath = true
		  },
		  isNeovim = true,
		  iskeyword = "@,48-57,_,192-255,-#",
		  runtimepath = "",
		  suggest = {
		    fromRuntimepath = true,
		    fromVimruntime = true
		  },
		  vimruntime = ""
	},
	single_file_support = true
}

lsp_config.yamlls.setup{
	cmd = { "yaml-language-server", "--stdio" },
	filetype = { "yaml" },
        on_attach=on_attach,
	settings = {
		yaml = {
			-- yamlVersion
			format = {
				enable = true,
				singleQuote = true,
				bracketSpacing = true,
				--proseWrap
				--printWidth
			},
			validate = true,
			hover = true,
			completion = true,
			-- schemas = require('schemastore').json.schemas(),
			-- schemas
			-- schemaStore = {
			--	enable = true,
			--	-- url
			--},
			--customTags
			--maxItemsComputed
			editor = {
				tabSize = 4,
				formatOnType = true,
			}
			-- http.proxy
			-- http.proxyStrictSSL
			-- disableDefaultProperties
			-- suggest.parentSkeletonSelectedFirst
		}
	},
	single_file_support = true
}

lsp_config.sumneko_lua.setup {
    settings = {
        Lua = {
        runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
            enable = false,
        },
        },
    },
}
