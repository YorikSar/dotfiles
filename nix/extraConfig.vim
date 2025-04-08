set nocompatible
filetype off
source ~/.local/state/nvim/background.vim
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

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
if $TMUX !~ 'tmate'
  colorscheme solarized8
else
  colorscheme torte
endif
"set termencoding=utf-8
set encoding=utf-8
set foldlevel=1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" paste in terminal mode
for c in ['0', '+', '-', '"']
  exe 'tnoremap <C-r>' . c . ' <Cmd>put ' . c . '<cr>'
endfor
tnoremap <C-r><Space> <C-r>
