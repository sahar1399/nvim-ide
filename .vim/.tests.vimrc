" " vim-test
" 
" let test#strategy='neovim'
" 
" nmap <silent> t<C-n> :TestNearest<CR>
" nmap <silent> t<C-f> :TestFile<CR>
" nmap <silent> t<C-a> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-v> :TestVisit<CR>
" 
" " TODO: extract project specific configurations to .vimrc that loaded from
" " current directory
" let test#python#runner = 'pytest'
" let test#python#pytest#executable='docker exec -w /opt/ranger/ site ./test.sh'
" 
" " vim-coverage
" nmap <silent> t<C-c> :CoveragePyToggle<CR>
" nmap <silent> t<C-p> :CoveragePytestContext<CR>

lua << EOF

require("neotest").setup({
        diagnostic = {
          enabled = true
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6
        },
        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          skipped = "NeotestSkipped",
          test = "NeotestTest"
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          failed = "✖",
          passed = "✔",
          running = "省",
          skipped = "ﰸ",
          unknown = "?"
        },
        output = {
          enabled = true,
          open_on_run = "short"
        },
        run = {
          enabled = true
        },
        status = {
          enabled = true
        },
        strategies = {
          integrated = {
            height = 40,
            width = 120
          }
        },
        summary = {
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = "a",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            output = "o",
            run = "r",
            short = "O",
            stop = "u"
          }
        },
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false },
      runner = "pytest",
      --args = { "-n", "auto", }
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>lua require("neotest").run.run()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>lua require("neotest").run.run({strategy = "dap"})<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ts', '<cmd>lua require("neotest").run.stop()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ta', '<cmd>lua require("neotest").run.attach()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>tv', '<cmd>lua require("neotest").summary.toggle()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true, short = true })<CR>', opts)


EOF
