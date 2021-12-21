" General Setting
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
set guicursor=a:block
set updatetime=50
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
Plug 'zefei/cake16'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-commentary'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

set background=light
color cake16

hi EndOfBuffer gui=NONE

" Nvim-tree
let g:nvim_tree_refresh_wait = 500

lua << EOF
-- Telescope Setup
require('telescope').setup {
	defaults = {
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
	pickers = {
		find_files = {
			prompt_prefix="🔍 ",
			theme = "dropdown",
		},
		buffers = {
			prompt_prefix = "📄 ",
			theme = "dropdown",
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

-- cmp
vim.o.completeopt = 'menuone,noselect'

require('cmp').setup{
	sources = require('cmp').config.sources{
		{ name = 'buffer', max_item_count = 8},
		{ name = 'path', max_item_count = 4},
	}
}

-- Nvim-tree
require('nvim-tree').setup{disable_netrw = true}
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

" Nvim-Tree bindings
nnoremap <leader>b :NvimTreeToggle<CR>
nnoremap <leader>br :NvimTreeRefresh<CR>

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
"nnoremap <C-b>c :e C:\Dev\LearningCplusplus\thing.py<CR>
nnoremap <C-b>c :e C:\Dev\ayaans_game\main.py<CR>

" Keybindings for Telescope
nnoremap <silent> <C-e> :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <C-p> :lua require('telescope.builtin').buffers()<CR>

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
	" For running python code
	autocmd FileType python nnoremap <buffer> <leader>c :silent let python_file=expand('%:p')<CR>:silent BDExt<CR>:silent call FindCompilationWindow()<CR>:silent execute 'term python ' .. python_file<CR>:silent call FindPreviousWindow()<CR>
	" For building and running c/c++ code
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
