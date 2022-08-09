syntax on
filetype plugin indent on
set noswapfile
set noshowmode
set ignorecase
set smartcase
set smartindent
set fileformat=unix
set fileencodings=ucs-bom,utf-8,cp936,gb18030
set linebreak
"set colorcolumn=80
set laststatus=2
set termguicolors
set number
set foldmethod=indent
set foldlevelstart=99
set completeopt=longest,menuone
set t_Co=256
set mmp=5000  "pattern uses more memory than 'maxmempattern'
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set fillchars=vert:\|
" set background=light
"set nu
"set rnu

set re=1
set ttyfast
set lazyredraw

" let g:material_style = 'lighter'
let g:material_style = 'oceanic'
colorscheme PaperColor
" colorscheme material
" colorscheme OceanicNext
"colorscheme one

nnoremap <silent> <c-u> :Mru<cr>
"nnoremap <silent> <c-p> :call fzflv#Open()<cr>
" nnoremap <silent> <c-p> :GFiles<cr>
" nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>tt :GoDecls<cr>
nnoremap <silent> <leader>te :NERDTreeToggle<cr>
nnoremap <silent> <leader>tf :NERDTreeFind<cr>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
 \ execute "normal! g`\"" |
 \ endif

autocmd BufReadPost *.js,*.jsx,*.css,*.less,*.scss,*.json call lv#ExpandTab(2)
autocmd InsertLeave,CompleteDone *.go if pumvisible() == 0 | pclose | endif
autocmd FileType json syntax match Comment +\/\/.\+$+
" autocmd VimEnter,VimLeave * silent !tmux set status

let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" 彩虹括号
let g:rainbow_active = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:ackprg = 'ag --vimgrep'
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_iconchars = ['▸', '▾']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:prettier#autoformat = 0
" vsnip
let g:vsnip_snippet_dir = '~/.vim/vsnip/'

"function! s:find_git_root()
"  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
"endfunction

" proto buf 锁进调整
autocmd Filetype proto setlocal ts=4 sw=4 sts=0 expandtab

" 加载拆分的配置
for f in glob('~/.config/nvim/config/*.vim', 0, 1)
    execute 'source' f
endfor

autocmd BufReadPost quickfix nnoremap <buffer> <c-n> j<CR><c-w><c-p>
autocmd BufReadPost quickfix nnoremap <buffer> <c-p> k<CR><c-w><c-p>

map <Leader>g <Plug>(easymotion-prefix)
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)

" map <Leader>s <Plug>(Startify)
" nmap <silent><leader>s <Plug>(Startify)
nnoremap <silent> <leader>s :Startify<CR>
let g:startify_change_to_vcs_root = 1

xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>

lua require('plugins')
runtime vim.lua

" 自动导包交给了 null-ls
" 在 normal 模式下更新文本后自动导包
" 比如 删除某一行，或者填充 struct 等
" autocmd TextChanged *.go :lua require('modules').org_imports()
" 代码补全结束后自动导包
" autocmd CompleteDone *.go :lua require('modules').org_imports()
" autocmd BufWritePre *.go :lua vim.lsp.buf.formatting()
" autocmd BufWritePre *.go :lua require('modules').org_imports()

" augroup NvimGoInternal
"   autocmd!
"   autocmd User NvimGoPopupPre ""
" augroup END

command! GoTest lua require('go.test').test()
command! GoTestAll lua require('go.test').test_all()
command! GoTestFunc lua require('go.test').test_func()
command! GoTestFile lua require('go.test').test_file()
command! -nargs=? -complete=command GoToTest lua require('go.test').test_open(<f-args>)
" struct tag
command! -nargs=* -range GoAddTags lua require('go.struct_tag').add_tags({<line1>, <line2>, <count>, <f-args>})
command! -nargs=* -range GoRemoveTags lua require('go.struct_tag').remove_tags({<line1>, <line2>, <count>, <f-args>})
command! -nargs=* -range GoClearTags lua require('go.struct_tag').clear_tags({<line1>, <line2>, <count>, <f-args>})

 let g:copilot_filetypes = {
                              \ '*': v:false,
                              \ 'python': v:true,
                              \ 'go': v:true,
                              \ 'golang': v:true,
                              \ }

" command! -nargs=* -range GoAddTags call lv#gomodifytags(<line1>, <line2>, <count>, '-add-tags', <f-args>)
" command! -nargs=* -range GoAddJsonTags call lv#gomodifytags(<line1>, <line2>, <count>, '-add-tags', 'json', <f-args>)
" command! -nargs=* -range GoAddOptionTags call lv#gomodifytags(<line1>, <line2>, <count>, '-add-tags', 'json', '-add-options json=omitempty', <f-args>)
" command! -nargs=* -range GoClearTags call lv#gomodifytags(<line1>, <line2>, <count>, '-clear-tags', <f-args>)
" command! -nargs=* -range GoRemoveTags call lv#gomodifytags(<line1>, <line2>, <count>, '-remove-tags', <f-args>)
" command! -nargs=* -range GoRemoveJsonTags call lv#gomodifytags(<line1>, <line2>, <count>, '-remove-tags', 'json', <f-args>)
"
"
"
"
"
" function! OmniPopup(action)
"     " print("========2", vim.inspect(action))
"     if pumvisible()
"         echo a:action
"         if a:action == 'q'
"             return ":q"
"         elseif a:action == 'k'
"             return "\<C-P>"
"         endif
"     endif
"     return a:action
" endfunction
"
" nnoremap <silent>q :call OmniPopup('q')<CR>
