" General Settings
set nonumber
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
set autoindent
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

Plug 'jiangmiao/auto-pairs'
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'colors/handmade.vim'

call plug#end()

set background=dark
colorscheme handmade

" Shortcuts
let mapleader=" "

" Autocompletion by pressing tab
inoremap <TAB> <C-n>

inoremap <C-h> <left>
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

nnoremap <leader>s :wincmd r<CR>

let font="Liberation Mono"
let font_size=13

" Increasing and decreasing font size
nnoremap <leader>- :execute "Guifont! " . font . ":h" . string(font_size - 1)<CR>
nnoremap <leader>= :execute "Guifont! " . font . ":h" . string(font_size + 1)<CR>

" Fixing c/c++ indentation
set cindent 
set cindent
set cinoptions+=L0,g0,b1 

autocmd FileType cpp,h,c set softtabstop=4
autocmd FileType make setlocal noexpandtab softtabstop=0

" Shortcuts to Switching Projects
nnoremap <C-b>c :e C:\Dev\LearningC++\main.cpp<CR>
nnoremap <C-b>p :e C:\Users\aliaw\Documents\creator-dark_copy.xml<CR>

" Keybindings for FZF
nnoremap <silent> <C-p> :Denite buffer<CR>
nnoremap <silent> <C-e> :DeniteProjectDir file/rec<CR>

" Settings for netrw
let g:netrw_banner = 0
nnoremap <silent> <leader>b :Vex<bar>vertical resize 30<CR> 

function! s:BDExt()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "term*"')
  if empty(buffers)
  else
	  exe 'bd! '.join(buffers, ' ')
  endif
endfunction

command! -nargs=0 BDExt :call s:BDExt()

fun! FindCompilationWindow() 
	if winnr() == 1 
		wincmd l
		if winnr() == 1
			vnew
			wincmd l
		endif
	elseif winnr() != 1
		wincmd h
	endif
endfunction

fun! FindPreviousWindow()
	if winnr() == 1
		wincmd l
	elseif winnr() == 2
		wincmd h
	endif
endfunction

"Compiling command
augroup compiling_commands
	autocmd!
	autocmd Filetype qf setlocal wrap
	autocmd FileType python nnoremap <buffer> <leader>c :setlocal makeprg=python\ %<bar>ccl<bar>silent make<bar>vert copen<bar>vertical resize 50<bar>:wincmd x<CR>
	"autocmd FileType cpp,c nnoremap <leader>c :vs<bar>wincmd l<CR>:vertical resize 50<CR>:term make<CR>
	autocmd FileType message,cpp,c nnoremap <leader>c :silent BDExt<CR>:call FindCompilationWindow()<CR>:term build.bat<CR>:silent call FindPreviousWindow()<CR>
	autocmd FileType message,cpp,c nnoremap <leader>r :silent BDExt<CR>:call FindCompilationWindow()<CR>:term run.bat<CR>:silent call FindPreviousWindow()<CR>
augroup END

" Terminal mode commands
"autocmd TermOpen * setlocal nonumber
augroup nvim_terminal
	autocmd!
	autocmd TermOpen * set filetype=message
	tnoremap <C-[> <C-\><C-n>
	nnoremap <leader>t :vs<CR>:term<CR>
augroup END

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction
