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
set mmp=5000  "pattern uses more memory than 'maxmempattern' 
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set fillchars=vert:\|
set background=light
" set background=dark
"set nu
"set rnu

set re=1
set ttyfast
set lazyredraw

colorscheme PaperColor 
"colorscheme one 
"color tender 
"hi Normal guibg=NONE ctermbg=NONE
"highlight Visual guibg=#323232
"highlight Normal guibg=#000001
"highlight StatusLine guibg=#444444 guifg=#b3deef
"highlight StatusLineTerm guibg=#444444 guifg=#b3deef
"highlight StatusLineTermNC guibg=#444444 guifg=#999999
nnoremap <silent> <c-u> :Mru<cr>
"nnoremap <silent> <c-p> :call fzflv#Open()<cr>
nnoremap <silent> <c-p> :GFiles<cr>
nnoremap <silent> <leader>t :TagbarToggle<cr>
nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <silent> <leader>f :NERDTreeFind<cr>

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
			\ execute "normal! g`\"" |
			\ endif
autocmd BufReadPost *.js,*.jsx,*.css,*.less,*.scss,*.json call lv#ExpandTab(2)
autocmd InsertLeave,CompleteDone *.go if pumvisible() == 0 | pclose | endif
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd VimEnter,VimLeave * silent !tmux set status

" let g:NERDTreeIndicatorMapCustom = {
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
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'gopls'

"function! s:find_git_root()
"  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
"endfunction

" proto buf 锁进调整
autocmd Filetype proto setlocal ts=4 sw=4 sts=0 expandtab

" 加载拆分的配置
for f in glob('~/.vim/config/*.vim', 0, 1)
    execute 'source' f
endfor

