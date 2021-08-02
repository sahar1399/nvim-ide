let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:vimspector_base_dir=expand( '$VIM_CONFIG_PATH/vimspector' )

" most common debug
nmap <leader>c <Plug>VimspectorContinue
nmap <leader>s <Plug>VimspectorStepOver
nmap <leader>i <Plug>VimspectorStepInto
nmap <leader>t <Plug>VimspectorRunToCursor
nmap <leader>so <Plug>VimspectorStepOut

nmap <leader>l :VimspectorToggleLog<CR>
nmap <leader>r <Plug>VimspectorRestart

" breakpoint commands
nmap <leader>dbb <Plug>VimspectorToggleBreakpoint
nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dbf <Plug>VimspectorAddFunctionBreakpoint

" More Controls
nmap <leader>dr :VimspectorReset<CR>
nmap <leader>ds <Plug>VimspectorStop
nmap <leader>dp <Plug>VimspectorPause

nmap <leader>du <Plug>VimspectorUpFrame
nmap <leader>dd <Plug>VimspectorDownFrame

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval


