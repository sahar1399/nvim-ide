if !exists('*Preserve')
    function! Preserve(command)
        try
            " Preparation: save last search, and cursor position.
            let l:win_view = winsaveview()
            let l:old_query = getreg('/')
            silent! execute 'keepjumps' . a:command
        finally
            " try restore / reg and cursor position
            call winrestview(l:win_view)
            call setreg('/', l:old_query)
        endtry
    endfunction
endif

nmap ftG :call Preserve(':normal gg0vG$ga*\|')<cr>
nmap ftp :call Preserve(':normal vipga*\|')<cr>

let g:table_mode_corner='|'

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
