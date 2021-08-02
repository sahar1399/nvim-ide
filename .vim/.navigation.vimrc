" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber 

map <leader>f :NERDTreeFind<cr>
map <leader>o :NERDTree<cr>
map <leader>c :NERDTreeClose<cr>

map <C-m> :MaximizerToggle<cr>

map <C-l> <C-W>l
map <C-k> <C-W>k
map <C-j> <C-W>j
map <C-h> <C-W>h
