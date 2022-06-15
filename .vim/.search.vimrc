"ctrlsf. install rg, ag, ack

nmap     <C-F>f <Plug>CtrlSFPrompt -R 
vmap     <C-F>f <Plug>CtrlSFVwordPath<CR>
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath<CR>
nmap     <C-F>p <Plug>CtrlSFPwordPath<CR>
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

nmap <C-F>p <Plug>CtrlSFPrompt -hidden -G "**/*.py" -R -W 
nmap <C-F>s <Plug>CtrlSFPrompt -hidden -G "**/*.sh" -R -W 
nmap <C-F>c <Plug>CtrlSFPrompt -hidden -G "{**/*.cpp,**/*.hpp,**/*.c,**/*.h}" -R -W 
nmap <C-F>b <Plug>CtrlSFPrompt -hidden -G "{*build*.sh,*[Cc][Oo][Nn][Aa][Nn]*,*[Cc][Mm][Aa][Kk][Ee]*,*[Mm][Aa][Kk][Ee][Ff][Ii][Ll][Ee]*}" -R -W 

let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}

let g:ctrlsf_auto_focus = {
    \ "at": "done",
    \ "duration_less_than": 1000
    \ }

let g:ctrlsf_auto_preview = 1

let g:ctrlsf_default_view_mode = 'compact'

let g:ctrlsf_default_root = 'cwd'

let g:ctrlsf_search_mode = 'async'

let g:ctrlsf_position = 'right'

let g:ctrlsf_confirm_save = 0

" telescope
nnoremap <C-P>f <cmd>Telescope find_files hidden=true<cr>
nnoremap <C-P>g <cmd>Telescope live_grep hidden=true<cr>
nnoremap <C-P>b <cmd>Telescope buffers hidden=true<cr>
nnoremap <C-P>h <cmd>Telescope help_tags hidden=true<cr>

