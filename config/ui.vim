set nu
set rnu

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction
let g:startify_lists = [
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

 let g:startify_custom_header = [
         \ '                                   ___                       ___                   ___                       ___             ',
         \ '                                  /\  \          ___        /\__\      ___        /\  \          ___        /\__\      ___              ',
         \ '                                 /::\  \        /\  \      /:/  /     /\  \      /::\  \        /\  \      /:/  /     /\  \             ',
         \ '                                /:/\:\  \       \:\  \    /:/  /      \:\  \    /:/\:\  \       \:\  \    /:/  /      \:\  \            ',
         \ '                               /::\~\:\__\      /::\__\  /:/  /       /::\__\  /::\~\:\__\      /::\__\  /:/  /       /::\__\           ',
         \ '                              /:/\:\ \:|__|  __/:/\/__/ /:/__/     __/:/\/__/ /:/\:\ \:|__|  __/:/\/__/ /:/__/     __/:/\/__/           ',
         \ '                              \:\~\:\/:/  / /\/:/  /    \:\  \    /\/:/  /    \:\~\:\/:/  / /\/:/  /    \:\  \    /\/:/  /              ',
         \ '                               \:\ \::/  /  \::/__/      \:\  \   \::/__/      \:\ \::/  /  \::/__/      \:\  \   \::/__/               ',
         \ '                                \:\/:/  /    \:\__\       \:\  \   \:\__\       \:\/:/  /    \:\__\       \:\  \   \:\__\               ',
         \ '                                 \::/__/      \/__/        \:\__\   \/__/        \::/__/      \/__/        \:\__\   \/__/     -- The One',
         \ '                                  ~~                        \/__/                 ~~                        \/__/                       ',
         \ ]











