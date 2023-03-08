return {
	{
		"kristijanhusak/vim-dadbod-ui",
		lazy = true,
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
		},
		config = function()
			vim.cmd([[
          let g:db_ui_use_nerd_fonts = 1
          let g:db_ui_auto_execute_table_helpers = 1

          let g:db_ui_icons = {
          \  'expanded': {
          \    'db': '▾ ',
          \    'buffers': '▾ ',
          \    'saved_queries': '▾ ',
          \    'schemas': '▾ ',
          \    'schema': '▾ פּ',
          \    'tables': '▾ 藺',
          \    'table': '▾ ',
          \  },
          \  'collapsed': {
          \    'db': '▸ ',
          \    'buffers': '▸ ',
          \    'saved_queries': '▸ ',
          \    'schemas': '▸ ',
          \    'schema': '▸ פּ',
          \    'tables': '▸ 藺',
          \    'table': '▸ ',
          \  },
          \  'saved_query': '',
          \  'new_query': '璘',
          \  'tables': '離',
          \  'buffers': '﬘',
          \  'add_connection': '',
          \  'connection_ok': '✓',
          \  'connection_error': '✕',
          \ }

          autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
			]])
		end,
	},
}
