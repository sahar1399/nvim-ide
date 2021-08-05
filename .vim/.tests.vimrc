" vim-test
if has('nvim')
  let test#strategy='neovim'
else
  let test#strategy='vimterminal'
endif

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-a> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-v> :TestVisit<CR>

" TODO: extract project specific configurations to .vimrc that loaded from
" current directory
let test#python#runner = 'pytest'
let test#python#pytest#executable='docker exec -w /opt/ranger/ site ./test.sh'

" vim-coverage
nmap <silent> t<C-c> :CoveragePyToggle<CR>
nmap <silent> t<C-p> :CoveragePytestContext<CR>
