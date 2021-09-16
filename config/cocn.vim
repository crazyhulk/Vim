" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_doc_popup_window = 1
let g:go_term_enabled = 1
let g:go_decls_mode = 'fzf'

" coc.vim settings
" set cmdheight=2 	" Better display for messages
set updatetime=300 	" Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c 	" don't give |ins-completion-menu| messages.
set signcolumn=yes 	" always show signcolumns

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"autocmd CursorMoved * silent call  show_documentation()

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" coc-snippets completion

nmap <silent><leader>gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

function! Rename()
  execute "normal \<Plug>(coc-rename)"
endfunc

command! Rename call Rename()

let g:go_fillstruct_mode = 'gopls' 
" let g:go_fillstruct_mode = 'fillstruct'
