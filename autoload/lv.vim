function! lv#ExpandTab(len)
	if a:len
		setlocal expandtab
		execute 'setlocal shiftwidth='.a:len
		execute 'setlocal softtabstop='.a:len
		execute 'setlocal tabstop='.a:len
	else
		setlocal noexpandtab
		execute 'setlocal shiftwidth&vim'
		execute 'setlocal softtabstop&vim'
		execute 'setlocal tabstop&vim'
	endif
endfunction

function! ExitTerm(...)
	bdelete!
endfunction

function! lv#Term()
	tabnew
	if has('nvim')
		let options = {'on_exit': 'ExitTerm'}
		call termopen($SHELL, options)
		startinsert
	else
		terminal ++curwin
	endif
endfunction

" gomodifytags
function lv#gomodifytags(s,e,c,cmd,tag,...)
        let path = expand('%p')
        let v = winsaveview()
        if a:c < 0
                execute 'normal va{^['
                let range = line("'<").",".line("'>")
        else
                let range = a:s.",".a:e
        end
        call system('gomodifytags '.a:cmd.' '.a:tag.' -file '.path.' -line '.range.' -w '.join(a:000, ' '))
        e
        call winrestview(v)
endfunction
