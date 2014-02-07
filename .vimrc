if has('gui')
    set guioptions-=m
    set guioptions-=T
endif
set nocompatible
filetype off
set rtp+=~/dotfiles/solarized/vim-colors-solarized,~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'nvie/vim-flake8'
Bundle 'tmhedberg/SimpylFold'
Bundle 'kien/ctrlp.vim'

filetype plugin indent on
autocmd BufEnter * set colorcolumn=80
syntax on
set smartindent
set nowrap
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
set t_Co=16
colorscheme solarized
set termencoding=utf-8
set encoding=utf-8
set foldlevel=1
set wildignore+=**/*.pyc

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
