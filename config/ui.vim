set nu
set rnu

" returns all modified files of the current git repo, relative to git root
function! s:gitFiles(args) abort
    let roots = systemlist('git rev-parse --show-toplevel 2>/dev/null')
    if empty(roots)
        return []
    endif

    let root = roots[0]
    let files = systemlist('git -C ' . shellescape(root) . ' ls-files ' . a:args . ' 2>/dev/null')
    return map(files, "{'line': v:val, 'path': root . '/' . v:val}")
endfunction

function! s:gitModified() abort
    return s:gitFiles('-m')
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked() abort
    return s:gitFiles('-o --exclude-standard')
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










