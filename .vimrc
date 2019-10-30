set nocompatible
if has('gui')
    set guioptions-=m
    set guioptions-=T
endif
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
    Plugin 'lifepillar/vim-solarized8'
    Plugin 'fatih/vim-go'
    Plugin 'ElmCast/elm-vim'
    Plugin 'LnL7/vim-nix'
    Plugin 'tpope/vim-dispatch'
endif

set bg=dark
filetype plugin indent on
autocmd BufEnter * set colorcolumn=80
syntax on
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set scrolloff=2
set sidescroll=5
set sidescrolloff=2
set incsearch
set hlsearch
set wildmenu
if !&diff
    set viewoptions=cursor
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview
endif
au InsertEnter * let b:oldfdm = &l:fdm | setlocal fdm=manual
au InsertLeave * let &l:fdm = b:oldfdm
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"set t_8f = "[38;2;%lu;%lu;%lum"
"set t_8b = "[48;2;%lu;%lu;%lum"
"set t_Co=256
"let g:solarized_use16 = 1
colorscheme solarized8
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

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
