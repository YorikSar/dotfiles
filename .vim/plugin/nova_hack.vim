function CheckHack(all)
    set lazyredraw
    cclose
    let l:old_gfm=&grepformat
    let l:old_gp=&grepprg
    if &readonly == 0
        update
    endif
    let &grepformat="%f:%l:%c: %m\,%f:%l: %m"
    let &grepprg='tox -e pep8'
    if a:all
        let l:files=''
    else
        let l:files='-- '.expand("%")
    endif
    exec 'silent! grep! '.l:files
    let &grepformat=l:old_gfm
    let &grepprg=l:old_gp
    let results=getqflist()
    let fail=(results != []) && (results[-1]['text'] !~ ':)$')
    if fail
        execute 'belowright copen'
        setlocal wrap
        nnoremap <buffer> <silent> c :cclose<CR>
        nnoremap <buffer> <silent> q :cclose<CR>
    endif
    set nolazyredraw
    redraw!
    if fail == 0
        hi Green ctermfg=green
        echohl Green
        echon "tox -e pep8: OK"
        echohl
    endif
endfunction
noremap <F8> :call CheckHack(0)<CR>
noremap <F9> :call CheckHack(1)<CR>
