let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:vimspector_base_dir=expand( '$VIM_CONFIG_PATH/vimspector' )

" most common debug
nmap <leader>dc <Plug>VimspectorContinue
nmap <leader>ds <Plug>VimspectorStepOver
nmap <leader>di <Plug>VimspectorStepInto
nmap <leader>dt <Plug>VimspectorRunToCursor
nmap <leader>do <Plug>VimspectorStepOut
nmap <leader>du <Plug>VimspectorUpFrame
nmap <leader>dd <Plug>VimspectorDownFrame

nmap <leader>dl :VimspectorToggleLog<CR>
nmap <leader>drr <Plug>VimspectorRestart

" breakpoint commands
nmap <leader>dbb <Plug>VimspectorToggleBreakpoint
nmap <leader>dbc <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader>dbf <Plug>VimspectorAddFunctionBreakpoint

" More Controls
nmap <leader>ddr :VimspectorReset<CR>
nmap <leader>ddt <Plug>VimspectorStop
nmap <leader>ddp <Plug>VimspectorPause

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval
