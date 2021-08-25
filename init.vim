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
set wrap
set noerrorbells
set incsearch
set nohlsearch
set clipboard=unnamedplus
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
set splitright
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

Plug 'morhetz/gruvbox'
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


" Autocompletion by pressing tab
inoremap <TAB> <C-n>

nnoremap <C-s> :w<CR>

inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <C-o> <C-c>O

" For navigating between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


nnoremap ; :

nnoremap <leader>o <C-w>o

noremap <C--> :vertical resize -5<CR>
noremap <C-=> :vertical resize +5<CR>

" Increasing and decreasing font size
let font="Consolas"
let font_size=13

nnoremap <leader>- :execute "set guifont=" . font . ":h" . string(font_size - 1)<CR>
nnoremap <leader>= :execute "set guifont=" . font . ":h" . string(font_size + 1)<CR>

" Fixing c/c++ indentation
set cindent 
set cindent
set cinoptions+=L0,g0,b1 

autocmd FileType cpp,h,c set softtabstop=4
autocmd FileType make setlocal noexpandtab softtabstop=0

" Shortcuts to Switching Projects
nnoremap <C-b>c :e name_of_project<CR>
nnoremap <C-b>p :e name_of_project<CR>

" Settings for netrw
let g:netrw_banner = 0
nnoremap <leader>b :Vex<bar>vertical resize 30<CR> 

function! s:BDExt()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "term*"')
  if empty(buffers)
  else
	  exe 'bd! '.join(buffers, ' ')
  endif
endfunction

command! -nargs=0 BDExt :call s:BDExt()

"Compiling command
augroup compiling_commands
	autocmd!
	autocmd Filetype qf setlocal wrap
	autocmd FileType python nnoremap <buffer> <leader>c :setlocal makeprg=python\ %<bar>ccl<bar>silent make<bar>vert copen<bar>vertical resize 50<bar>:wincmd x<CR>
	"autocmd FileType cpp,c nnoremap <leader>c :vs<bar>wincmd l<CR>:vertical resize 50<CR>:term make<CR>
	autocmd FileType cpp,c nnoremap <leader>c :silent BDExt<CR>:vnew<CR>:vertical resize 50<CR>:term make<CR>:wincmd h<CR>
	autocmd FileType cpp,c nnoremap <leader>cl :ccl<bar>silent make<bar>vert copen<bar>vertical resize 50<bar>:wincmd x<CR>
augroup END

" Terminal mode commands
augroup nvim_terminal
	autocmd!
	autocmd TermOpen * setlocal nonumber
	tnoremap <C-[> <C-\><C-n>
	nnoremap <leader>t :vs<CR>:term<CR>
augroup END
