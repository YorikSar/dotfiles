if has('gui')
    set guioptions-=m
    set guioptions-=T
endif
set nocompatible
filetype off

function s:ensure_vundle()
    let l:vundle_path = expand("~/.vim/bundle/Vundle.vim")
    if !filereadable(l:vundle_path . "/README.md")
        call mkdir(l:vundle_path, "p")
        let l:clone_uri = "https://github.com/gmarik/Vundle.vim.git"
        execute 'silent !git clone' l:clone_uri l:vundle_path
        if v:shell_error != 0
            echoerr "Failed to clone Vundle.vim :("
            return 0
        endif
        autocmd VimEnter * PluginUpdate
    endif
    execute 'set rtp+=' . l:vundle_path
    call vundle#rc()
    Plugin 'gmarik/Vundle.vim'
    return 1
endfunction

if s:ensure_vundle()
    Plugin 'tpope/vim-fugitive'
    Plugin 'nvie/vim-flake8'
    Plugin 'tmhedberg/SimpylFold'
    Plugin 'kien/ctrlp.vim'
    Plugin 'ludovicchabant/vim-lawrencium'
    Plugin 'saltstack/salt-vim'
endif

set rtp+=~/dotfiles/solarized/vim-colors-solarized
set bg=dark
filetype plugin indent on
autocmd BufEnter * set colorcolumn=80
syntax on
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set incsearch
set hlsearch
if !&diff
    set viewoptions=cursor
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
