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
