" General Settings
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
set linespace=4
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
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'junegunn/goyo.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'zefei/cake16'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-commentary'

call plug#end()

set background=light
color cake16

" TODO - Fix todo colour and change the colour of matching braces
hi EndOfBuffer gui=NONE

lua << EOF
-- Telescope Setup
require('telescope').setup {
	defaults = {
		prompt_prefix = " > ",
		mappings = {
			i = {
				["<C-w>"] = require('telescope.actions').close,
				["<C-q>"] = require('telescope.actions').send_to_qflist,
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
			},
			n = {
				["<C-w>"] = require('telescope.actions').close,
				["<C-q>"] = require('telescope.actions').send_to_qflist,
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
			},
		}
	},
	extensions = {
		fzy_native = {
			override_general_sorter = false,
			override_file_sorter = true,
		}
	}	
}
require('telescope').load_extension('fzy_native')
EOF

" Shortcuts
let mapleader=" "

" Autocompletion by pressing tab
inoremap <C-e> <C-n>
inoremap <C-h> <left>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <C-o> <C-c>O

" For navigating between windows
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" For going through a quickfixlist
noremap <C-j> :cnext<CR>
noremap <C-k> :cprevious<CR>

" General Keybindings
nnoremap j gj
nnoremap k gk

nnoremap ; :

nnoremap <leader>o <C-w>o

noremap <C--> :vertical resize -5<CR>
noremap <C-=> :vertical resize +5<CR>

nnoremap <leader>s :wincmd r<CR>

" Commenting out code
nnoremap <C-/> :Commentary<CR>
vnoremap <C-/> :Commentary<CR>

" Increasing and decreasing font size
nnoremap <leader>= :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>

nnoremap <leader>- :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>

" Fixing c/c++ indentation
set cindent 
set cindent
set cinoptions+=L0,g0,b1 

autocmd FileType cpp,h,c set softtabstop=4
autocmd FileType make setlocal noexpandtab softtabstop=0

" Shortcuts to Switching Projects
nnoremap <C-b>c :e C:\Dev\LearningC++\main.cpp<CR>
nnoremap <C-b>p :e C:\Users\aliaw\Documents\creator-dark_copy.xml<CR>

" Keybindings for Telescope
nnoremap <silent> <C-e> :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <C-p> :lua require('telescope.builtin').buffers()<CR>

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

fun! FindCompilationWindow() abort
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

fun! FindPreviousWindow() abort
	if winnr() == 1
		wincmd l
	elseif winnr() == 2
		wincmd h
	endif
endfunction

autocmd FileType text setlocal linebreak

"Compiling command
augroup compiling_commands
	autocmd!
	autocmd Filetype qf setlocal wrap
	autocmd FileType python nnoremap <buffer> <leader>c :setlocal makeprg=python\ %<bar>ccl<bar>silent make<bar>vert copen<bar>vertical resize 50<bar>:wincmd x<CR>
	"autocmd FileType cpp,c nnoremap <leader>c :vs<bar>wincmd l<CR>:vertical resize 50<CR>:term make<CR>
	autocmd FileType message,cpp,c nnoremap <leader>c :silent BDExt<CR>:call FindCompilationWindow()<CR>:term build.bat<CR>:silent call FindPreviousWindow()<CR>
	autocmd FileType cpp,c nnoremap <leader>r :silent BDExt<CR>:call FindCompilationWindow()<CR>:term run.bat<CR>:silent call FindPreviousWindow()<CR>
augroup END

" Terminal mode commands
"autocmd TermOpen * setlocal nonumber
augroup nvim_terminal
	autocmd!
	autocmd TermOpen * set filetype=message
	tnoremap <C-[> <C-\><C-n>
	nnoremap <leader>t :vs<CR>:term<CR>
augroup END

nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
