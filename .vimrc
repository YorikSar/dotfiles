if has('gui')
    set guioptions-=m
    set guioptions-=T
endif
call pathogen#infect()
filetype plugin indent on
autocmd BufEnter * set colorcolumn=80
syntax on
set smartindent
set nowrap
set nocompatible
set expandtab
set tabstop=4
set shiftwidth=4
set incsearch
set hlsearch
if !&diff
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview
endif
au InsertEnter * let b:oldfdm = &l:fdm | setlocal fdm=manual
au InsertLeave * let &l:fdm = b:oldfdm
colorscheme torte
set termencoding=utf-8
set encoding=utf-8
set foldlevel=1

if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    set csto=0
    set cscopetag
    set nocscopeverbose
    if filereadable("cscope.out")
        cscope add cscope.out
    endif
    set cscopeverbose
    for key in ["s","g","c","t","e","d"]
        let cmd="cs find ".key." <C-R>=expand(\"<cword>\")<CR><CR>"
        exec "nmap <C-_>".key." :".cmd
        exec "nmap <C-Space>".key." :s".cmd
        exec "nmap <C-Space><C-Space>".key." :vert s".cmd
    endfor
endif
