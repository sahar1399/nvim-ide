return {
  -- {
  -- "kristijanhusak/vim-dadbod-ui",
  -- lazy = true,
  -- dependencies = {
  -- 	"tpope/vim-dadbod",
  -- 	"kristijanhusak/vim-dadbod-completion",
  -- },
  -- cmd = {
  -- 	"DBUI",
  -- 	"DBUIToggle",
  -- 	"DBUIAddConnection",
  -- },
  -- config = function()
  -- 	vim.cmd([[
  --           let g:db_ui_use_nerd_fonts = 1
  --           let g:db_ui_auto_execute_table_helpers = 1
  --
  --           let g:db_ui_icons = {
  --           \  'expanded': {
  --           \    'db': '▾ ',
  --           \    'buffers': '▾ ',
  --           \    'saved_queries': '▾ ',
  --           \    'schemas': '▾ ',
  --           \    'schema': '▾ פּ',
  --           \    'tables': '▾ 藺',
  --           \    'table': '▾ ',
  --           \  },
  --           \  'collapsed': {
  --           \    'db': '▸ ',
  --           \    'buffers': '▸ ',
  --           \    'saved_queries': '▸ ',
  --           \    'schemas': '▸ ',
  --           \    'schema': '▸ פּ',
  --           \    'tables': '▸ 藺',
  --           \    'table': '▸ ',
  --           \  },
  --           \  'saved_query': '',
  --           \  'new_query': '璘',
  --           \  'tables': '離',
  --           \  'buffers': '﬘',
  --           \  'add_connection': '',
  --           \  'connection_ok': '✓',
  --           \  'connection_error': '✕',
  --           \ }
  --
  --           autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  -- 	]])
  -- end,
  -- },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },

    lazy = true,
    keys = {
      {
        "<leader>q",
        function()
          require("dbee").toggle()
        end,
      },
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      -- use BB to run a query
      require("dbee").setup({
        sources = {
          require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
          require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
        },
        drawer = {
          mappings = {
            action_1 = { key = "o", mode = "n" },
            toggle = { key = "<cr>", mode = "n" },
          },
        },
        result = {
          -- mappings for the buffer
          mappings = {
            -- next/previous page
            page_next = { key = "L", mode = "" },
            page_prev = { key = "H", mode = "" },
            -- yank rows as csv/json
            yank_current_json = { key = "yaj", mode = "n" }, -- to paste, use " to register: ""p
            yank_selection_json = { key = "yaj", mode = "v" }, -- to paste, use " to register: ""p
            yank_all_json = { key = "yaJ", mode = "" },  -- to paste, use " to register: ""p
            yank_current_csv = { key = "yac", mode = "n" }, -- to paste, use " to register: ""p
            yank_selection_csv = { key = "yac", mode = "v" }, -- to paste, use " to register: ""p
            yank_all_csv = { key = "yaC", mode = "" },
          },
        },
      })
    end,
  },
}
