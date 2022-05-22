vim.cmd [[
	syntax on
	filetype on
]] 

local options = {
	encoding = 'UTF-8',
	background = 'light',
	hidden = true,
	wrap = false,
	errorbells = false,
	incsearch = true,
	linespace = 4,
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

-- Plugins
vim.cmd [[
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'mileszs/ack.vim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'quangnguyen30192/cmp-nvim-tags'

call plug#end()
]] 

-- Ack.vim
vim.cmd [[
	let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
	let g:ack_use_cword_for_empty_search = 1
	cnoreabbrev Ack Ack!
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
vim.o.completeopt = 'menuone,noselect,noinsert'

local cmp = require('cmp')
cmp.setup {
	sources = require('cmp').config.sources{
		{ name = 'tags', max_item_count=5 },
		{ name = 'buffer', max_item_count = 3},
	},

    mapping = {
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i" }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i" }),
    }

}

-- Colorscheme
local colorscheme = 'cream'
vim.cmd("colorscheme " .. colorscheme)

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

set_key('n', '<leader>q', ':cclose<CR>')
set_key('n', '<C-j>', ':cnext<CR>')
set_key('n', '<C-k>', ':cprev<CR>')

set_key('n', 'j', 'gj')
set_key('n', 'k', 'gk')

vim.cmd [[nnoremap ; :]]

set_key('n', '<C-f>', ':find ')

set_key('n', '<leader>pf', [[:e C:\tools\4coder\build.bat<bar>set path=.,**<bar>e custom\4coder_ali.cpp<CR>]])
set_key('n', '<leader>po', [[:e C:\Dev\opengl\main.c<CR>]])

set_key('n', '<leader>o', '<C-w>o')

set_key('n', '<leader>s', ':Ack!<CR>')
set_key('n', '<leader>/', ':Ack!<space>')

set_key('n', '<C-->', ':vertical resize -5<CR>')
set_key('n', '<C-=>', ':vertical resize +5<CR>')

set_key('n', '<leader>s', ':wincmd r<CR>')

set_key('n', '<leader>u', ':Commentary<CR>')
set_key('v', '<leader>u', ':Commentary<CR>')

set_key('n', '<C-e>', ':lua require("telescope.builtin").find_files()<CR>')
set_key('n', '<C-p>', ':lua require("telescope.builtin").buffers()<CR>')

-- Helped me when making my colorscheme
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

local function del_parent_dir(path)
    local before, after = path:match("(.*\\)[^\\]+\\([^\\]+)")
    return before and before .. after or path
end

local function get_parent_dir(path) 
    local path_to_parent, filename = path:match[[^(.+)\.-\(.-)$]]
	return path_to_parent
end

function build(build_cmd_or_file, is_cmd_or_file) 
	local build_cmd
	if (is_cmd_or_file == "file") then 
    	local build_file_name = build_cmd_or_file
    	local build_script_exists = false
    	local build_dir = string.format("%s", io.popen"cd":read'*l')
    	local build_script_path = string.format("%s\\%s", build_dir, build_file_name)
    	local build_paths_table = { build_script_path }
    	
       	while (build_script_exists == false) do
       		local build_script = io.open(build_paths_table[#build_paths_table], "r")
   
       		if build_script~=nil then 
       			io.close(build_script)
       			if (#build_paths_table ~= 1) then
       				build_dir = get_parent_dir(build_paths_table[#build_paths_table - 1])
       			end
   
       			build_script_exists = true 
       		else 
       			table.insert(build_paths_table, del_parent_dir(build_paths_table[#build_paths_table]))
       		end
   
       		if (build_paths_table[#build_paths_table] == string.format("C:\\%s", build_file_name)) then
       			print(string.format("Could not find %s!", build_file_name))
       			return
       		end
   
       	end
       	build_cmd = string.format(":term pushd %s&%s&popd", build_dir, build_file_name)
	else 
		local cmd = build_cmd_or_file
		local cmd_dir = string.format("%s", io.popen"cd":read'*l')
		build_cmd = string.format(":term pushd %s&%s&popd", cmd_dir, cmd)
	end

	vim.cmd(build_cmd)
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
		autocmd FileType message,cpp,c,dosbatch,make nnoremap <leader>c :silent BDExt<CR>:silent lua FindCompilationWindow()<CR>:lua build("build.bat", "file")<CR>:silent lua FindPreviousWindow()<CR>
		autocmd FileType message,cpp,c,dosbatch,make nnoremap <leader>t :silent BDExt<CR>:silent lua FindCompilationWindow()<CR>:lua build("run.bat", "file")<CR>:silent lua FindPreviousWindow()<CR>
	augroup END

	" Terminal mode commands
	"autocmd TermOpen * setlocal nonumber
	augroup nvim_terminal
		autocmd!
		autocmd TermOpen * set filetype=message
		tnoremap <C-[> <C-\><C-n>
		nnoremap <C-t> :vs<CR>:term<CR>
	augroup END
]] 
