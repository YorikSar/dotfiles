function CheckHack(all)
    set lazyredraw
    cclose
    let l:old_gfm=&grepformat
    let l:old_gp=&grepprg
    if &readonly == 0
        update
    endif
    let &grepformat="%f:%l:%c: %m\,%f:%l: %m"
    let &grepprg=getcwd().'/tools/hacking.py'
    if a:all
        let l:file_list=expand("bin/*")."\n"
        let l:file_list.=expand("nova/**/*.py")."\n"
        let l:file_list.=expand("tools/**/*.py")
        let l:file_list=substitute(l:file_list, "[^\n]*/migrate_repo/[^\n]*\n", "", "g")
        if match(l:file_list, "migrate_repo") != -1
            echo "BADBADBOY"
            return
        endif
        let l:files=substitute(l:file_list,"\n"," ","g")
    else
        let l:files=expand("%")
    endif
    exec 'silent! grep! --repeat '.l:files
    let &grepformat=l:old_gfm
    let &grepprg=l:old_gp
    let has_results=getqflist() != []
    if has_results
        execute 'belowright copen'
        setlocal wrap
        nnoremap <buffer> <silent> c :cclose<CR>
        nnoremap <buffer> <silent> q :cclose<CR>
    endif
    set nolazyredraw
    redraw!
    if has_results == 0
        hi Green ctermfg=green
        echohl Green
        echon "OK"
        echohl
    endif
endfunction
noremap <F8> :call CheckHack(0)<CR>
noremap <F9> :call CheckHack(1)<CR>
