" General Settings
set number 
syntax on
set termguicolors
set hidden
set nowrap
set noerrorbells
set incsearch
set nohlsearch
set clipboard=unnamedplus
set nobackup
set nowritebackup
set noswapfile
set scrolloff=8
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set smarttab
set cmdheight=2
set mouse=a

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'ayu-theme/ayu-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

colorscheme ayu
let ayucolor='dark'
set background=dark

let g:python_highlight_space_errors=0

" Netrw
let g:netrw_banner=0

" Shortcuts
let mapleader=" "
nnoremap <silent> <leader>b :wincmd v <bar> :Ex <bar> :vertical resize 25 <CR>
nnoremap <leader>p :FZF<CR>


" This is just for WSL as it was not letting me copy and paste due to an issue with the clipboards
"let s:clip = '/mnt/c/Windows/System32/clip.exe' 
"if executable(s:clip)
"	    augroup WSLYank
"			        autocmd!
"					        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"							    augroup END
"							endif


