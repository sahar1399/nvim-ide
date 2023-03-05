return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip/loaders/from_vscode").load({
        paths = { vim.fn.stdpath("data") .. "/lazy" .. "/friendly-snippets" },
      })
      local opts = { noremap = true, silent = true }

      vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
      vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
      vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
      vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
    end,
  },
  {
    "hrsh7th/nvim-cmp",
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
        repo_list = {
          { "Name of repo", "PATH/TO/FILE.json" },
        },
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
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "jose-elias-alvarez/null-ls.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "RRethy/vim-illuminate",
    },
    config = function()
      local null_ls = require("null-ls")
      local lspconfig = require("lspconfig")
      local dap = require("dap")
      local illuminate = require("illuminate")

      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        illuminate.on_attach(client)

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
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
        sources = null_ls_sources,
      })
    end,
  },
  {
    "folke/lsp-colors.nvim",
    config = function()
      require("lsp-colors").setup()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("hlargs").setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
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
}
