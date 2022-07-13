" quickfix 预览 + q 快速退出
autocmd BufReadPost quickfix nnoremap <buffer> <c-n> j<CR><c-w><c-p>
autocmd BufReadPost quickfix nnoremap <buffer> <c-p> k<CR><c-w><c-p>
autocmd BufReadPost quickfix nnoremap <buffer> q :ccl<CR>


