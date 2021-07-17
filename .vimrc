" General Settings
set number 
syntax on
if has('termguicolors') 
	set termguicolors
endif
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
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartindent
set smarttab
set cmdheight=1
set mouse=a
set autochdir
set visualbell
set t_vb= 
set wildmenu
set autoread
set guicursor=a:block

" Getting rid of previously entered commands in command-mode
augroup cmdline
    autocmd!
    autocmd CmdlineLeave : echo ''
augroup end

" Plugins
call plug#begin()

" Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark

" Shortcuts
let mapleader=" "
