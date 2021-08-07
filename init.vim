" General Settings
set number 
syntax on
filetype plugin on
filetype indent on
if has('termguicolors') 
	set termguicolors
endif
set encoding=UTF-8
set hidden
set nowrap
set noerrorbells
set incsearch
set nohlsearch
set clipboard=unnamed
set nobackup
set nowritebackup
set noswapfile
set scrolloff=8
set tabstop=4
set shiftwidth=4 softtabstop=4
set smartindent
set smarttab
set cmdheight=1
set mouse=a
set autochdir
set visualbell
set t_vb= 
set wildmenu
set autoread
set updatetime=50
set guicursor=a:block
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Getting rid of previously entered commands in command-mode
augroup cmdline
	autocmd!
	autocmd CmdlineLeave : echo ''
augroup end

" Plugins
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'tpope/vim-scriptease'

call plug#end()

let g:gruvbox_bold = 0
let g:gruvbox_contrast_dark="hard"
set background=dark
colorscheme gruvbox

" hi Normal guibg=NONE ctermbg=NONE

" Getting rid of ~ at the end of the buffer
" highlight EndOfBuffer guifg=#1d2021

" Shortcuts
let mapleader=" "

" For navigating between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <leader>o <C-w>o

noremap <leader>- :vertical resize -5<CR>
noremap <leader>= :vertical resize +5<CR>

tnoremap <ESC> <C-\><C-n>

" Fixing c/c++ indentation
set cindent 
set cinoptions+=L0,g0,b1 

autocmd FileType cpp,h,c set softtabstop=4
autocmd FileType make setlocal noexpandtab softtabstop=0

" Current Project
let $PROJECT="~/Dev/learningcpp/main.cpp"

" Settings for netrw
let g:netrw_banner = 0
nnoremap <leader>b :Vex<bar>vertical resize 30<CR> 

"Compiling command
autocmd Filetype qf setlocal wrap
autocmd FileType cpp,c nnoremap <leader>c :ccl<bar>silent make<bar>vert copen<bar>vertical resize 50<bar>:wincmd x<CR>  
