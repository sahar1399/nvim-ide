return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.cmd([[ 
      let g:VM_leader = '`'
      let g:VM_default_mappings = 0

      let g:VM_maps = {}
      let g:VM_maps['Add Cursor Down']             = '<C-j>'
      let g:VM_maps['Add Cursor Up']               = '<C-k>'
      let g:VM_maps['Find Under']                  = '<C-n>'
      let g:VM_maps['Find Subword Under']          = '<C-n>'
      let g:VM_maps["Select All"]                  = '<leader>A' 
      let g:VM_maps["Start Regex Search"]          = '<leader>/'
      let g:VM_maps["Add Cursor At Pos"]           = '\\\'
    ]] )
    end,
  },
  {
    "terrortylor/nvim-comment",
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
    config = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
      local opts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap("n", "<Leader>kf", ":lua require('neogen').generate({type='func'})<CR>", opts)
      vim.api.nvim_set_keymap("n", "<Leader>kc", ":lua require('neogen').generate({type='class'})<CR>", opts)
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- tag = "*"
  },
  {
    "m4xshen/autoclose.nvim",
    config = function()
      local config = {
        keys = {
          ["("] = { escape = false, close = true, pair = "()" },
          ["["] = { escape = false, close = true, pair = "[]" },
          ["{"] = { escape = false, close = true, pair = "{}" },

          [">"] = { escape = true, close = false, pair = "<>" },
          [")"] = { escape = true, close = false, pair = "()" },
          ["]"] = { escape = true, close = false, pair = "[]" },
          ["}"] = { escape = true, close = false, pair = "{}" },

          ['"'] = { escape = true, close = true, pair = '""' },
          ["'"] = { escape = true, close = true, pair = "''" },
          ["`"] = { escape = true, close = true, pair = "``" },
        },
        options = {
          disabled_filetypes = { "text" },
        },
      }
      require("autoclose").setup(config)
    end,
  },
}
