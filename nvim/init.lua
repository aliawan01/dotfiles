vim.cmd [[
	syntax on
	filetype plugin on
	filetype indent on
]] 

local options = {
	encoding = 'UTF-8',
	background = 'light',
	hidden = true,
	wrap = false,
	errorbells = false,
	incsearch = true,
	autoindent = true,
	hlsearch = false,
	clipboard = 'unnamedplus',
	backup = false,
	writebackup = false,
	swapfile = false,
	scrolloff = 8,
	tabstop = 4,
	shiftwidth = 4,
	softtabstop = 4,
	smartindent = true,
	smarttab = true,
	cmdheight = 1,
	mouse = 'a',
	autochdir = true,
	splitright = true,
	visualbell = true,
	wildmenu = true,
	autoread = true,
	guicursor = 'a:block',
	updatetime = 50,
	completeopt = {'menuone', 'noselect'},
	cindent = true,
	cindent = true,
	cinoptions = {'L0', 'g0', 'b1'},
}

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = true
end

for setting, option in pairs(options) do
	vim.opt[setting] = option
end

vim.cmd [[
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
Plug 'sainnhe/everforest'
Plug 'C:\Dev\nvim-build\'

call plug#end()
]] 

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

require('cmp').setup {
	sources = require('cmp').config.sources{
		{ name = 'buffer', max_item_count = 8},
		{ name = 'path', max_item_count = 4},
	}
}

-- Colorscheme
local colorscheme = 'cake16'
local check_colorscheme = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not check_colorscheme then
	print("Colorscheme " .. colorscheme .. " is not installed!")
end

-- Keybindings
local key_options = { silent = true, noremap = true }
function set_key(mode, left_hand, right_hand)
	vim.api.nvim_set_keymap(mode, left_hand, right_hand, key_options)
end

vim.g.mapleader = " "

set_key('i', '<C-e>', '<C-n>')
set_key('i', '<C-h>', '<left>')
set_key('i', '<C-k>', '<up>')
set_key('i', '<C-l>', '<right>')
set_key('i', '<C-o>', '<C-c>O')

set_key('n', '<C-h>', '<C-w>h')
set_key('n', '<C-l>', '<C-w>l')
set_key('n', '<C-j>', '<C-w>j')
set_key('n', '<C-k>', '<C-w>k')

set_key('n', 'j', 'gj')
set_key('n', 'k', 'gk')

vim.cmd [[nnoremap ; :]]

set_key('n', '<C-b>c', [[:e C:\Dev\ayaans_game\main.py<CR>]])
set_key('n', '<C-b>l', [[:e C:\Dev\nvim-build\lua\nvim-build-plugin\init.lua<CR>]])

set_key('n', '<leader>o', '<C-w>o')


set_key('n', '<C-->', ':vertical resize -5<CR>')
set_key('n', '<C-=>', ':vertical resize +5<CR>')

set_key('n', '<leader>s', ':wincmd r<CR>')

set_key('n', '<leader>u', ':Commentary<CR>')
set_key('v', '<leader>u', ':Commentary<CR>')


set_key('n', '<C-e>', ':lua require("telescope.builtin").find_files()<CR>')
set_key('n', '<C-p>', ':lua require("telescope.builtin").buffers()<CR>')

-- Don't ask
set_key('n', '<F10>', ':echo \"hi<\" . synIDattr(synID(line(\".\"),col(\".\"),1),\"name\") . \'> trans<\' . synIDattr(synID(line(\".\"),col(\".\"),0),\"name\") . \"> lo<\" . synIDattr(synIDtrans(synID(line(\".\"),col(\".\"),1)),\"name\") . \">"<CR>')

-- Functions to find windows
local win_num = vim.api.nvim_win_get_number(0)
function wincmd(command) 
	vim.cmd(':silent wincmd ' .. command)
end

function FindCompilationWindow() 
	if win_num == 1  then
		wincmd('l')
		if win_num == 1 then
			vim.cmd('vnew')
			wincmd('l')
		end
	elseif win_num ~= 1 then
		wincmd('h')
	end
end

function FindPreviousWindow()
	if win_num == 1 then
		wincmd('l')
	elseif win_num == 2 then
		wincmd('h')
	end
end

vim.cmd [[
function! s:BDExt()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "term*"')
  if empty(buffers)
  else
	  exe 'bd! '.join(buffers, ' ')
  endif
endfunction

command! -nargs=0 BDExt :call s:BDExt()
]] 

-- Autocommands
vim.cmd [[
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	autocmd FileType cpp,h,c set softtabstop=4
	autocmd FileType make setlocal noexpandtab softtabstop=0
	autocmd FileType text setlocal linebreak

	"Compiling command
	augroup compiling_commands
		autocmd!
		autocmd Filetype qf setlocal wrap
		" For running python code
		autocmd FileType python nnoremap <buffer> <leader>c :silent let python_file=expand('%:p')<CR>:silent BDExt<CR>:silent lua FindCompilationWindow()<CR>:silent execute 'term python ' .. python_file<CR>:silent lua FindPreviousWindow()<CR>
		" For building and running c/c++ code
		autocmd FileType message,cpp,c nnoremap <leader>c :silent BDExt<CR>:silent lua FindCompilationWindow()<CR>:term build.bat<CR>:silent lua FindPreviousWindow()<CR>
		autocmd FileType cpp,c nnoremap <leader>r :silent BDExt<CR>:silent lua FindCompilationWindow()<CR>:term run.bat<CR>:silent lua FindPreviousWindow()<CR>
	augroup END

	" Terminal mode commands
	"autocmd TermOpen * setlocal nonumber
	augroup nvim_terminal
		autocmd!
		autocmd TermOpen * set filetype=message
		tnoremap <C-[> <C-\><C-n>
		nnoremap <leader>t :vs<CR>:term<CR>
	augroup END
]] 
