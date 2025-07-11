vim.cmd [[
	syntax on
	filetype on
]] 

local options = {
    encoding = 'UTF-8',
    hidden = true,
    background = "dark",
    wrap = false,
    errorbells = false,
    incsearch = true,
    linespace = 1,
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
    updatetime = 50,
    expandtab = true,
    showmode = false,
    laststatus = 3,
    autoread = true,
    cinoptions = {'L0', 'g0', 'b1'},
    cursorline = false,
    sidescroll = 1,
    sidescrolloff = 5,
    guicursor = ""
}

if vim.fn.has('termguicolors') then
	vim.opt.termguicolors = false
end


for setting, option in pairs(options) do
	vim.opt[setting] = option
end


-- Plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'm4xshen/autoclose.nvim'
    use 'markonm/traces.vim' 
    use 'tpope/vim-commentary'
    use 'tpope/vim-vinegar'

    use { 
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release'
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = {
            {'nvim-lua/plenary.nvim'},
        }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use 'nvim-lualine/lualine.nvim'
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind.nvim'
    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}
    use "ray-x/lsp_signature.nvim"
    use "ellisonleao/gruvbox.nvim"
    use {
        'aliawan01/ouroboros.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function() 
            require('colorizer').setup()
        end
    }
    use "vim-scripts/CursorLineCurrentWindow"
end)

vim.keymap.set("n",    "<F10>",
    function()
        local result = vim.treesitter.get_captures_at_cursor(0)
        print(vim.inspect(result))
    end,
    { noremap = true, silent = false }
)

require("gruvbox").setup({
    terminal_colors = true,
    undercurl = false,
    underline = false,
    strikethrough = false,
    bold = false,
    italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
    },
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, 
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {
        ["@punctuation.bracket"] = { fg = "#ebdbb2" },
        ["@punctuation.delimiter"] = { fg = "#ebdbb2" },
        ["@operator"] = { fg = "#ebdbb2" },
        ["@constructor"] = { fg = "#ebdbb2" },
        ["Normal"] = {bg = "#1b1b1a", fg = "#ebdbb2"},
        ["@lsp.mod.deprecated.c"] = {link = "GruvboxGreenBold"}
    },
    dim_inactive = false,
    transparent_mode = false,
})

vim.cmd("colorscheme gruvbox")

require('autoclose').setup()
require('mason').setup()
require('ouroboros').setup({
    extension_preferences_table = {
          c = {h = 2, hpp = 1},
          h = {c = 2, cpp = 1},
          cpp = {hpp = 2, h = 1},
          hpp = {cpp = 1, c = 2},
    },

    switch_to_open_pane_if_possible = true,
})

vim.keymap.set('n', '<C-f>', function() require("ouroboros").switch(true) end)
vim.keymap.set('n', '<C-S-f>', function() require("ouroboros").switch(false) end)

-- GUI Configuration
if vim.g.neovide then 
	-- vim.opt.guifont = "IBM Plex Mono,Cousine Nerd Font Mono:h14"
	vim.g.neovide_padding_top = 5
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 5
	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_scroll_animation_length = 0.12
	vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_no_idle = true
    vim.g.neovide_fullscreen = true
end


-- ToggleTerm
vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], {})
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], {})
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], {})
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], {})
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], {})
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], {})

function ClearTerm(is_win)
  vim.opt_local.scrollback = 1

  if is_win == 1 then
    vim.api.nvim_feedkeys("cls", 't', false)
  else
    vim.api.nvim_feedkeys("clear", 't', false)
  end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<cr>', true, false, true), 't', true)

  vim.opt_local.scrollback = 10000
end

vim.keymap.set('t', '<C-l>', [[<C-\><C-N>:lua ClearTerm(0)<CR>]], mapping_opts)

require('toggleterm').setup {
    open_mapping = [[<C-'>]],
    autochdir = false,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'horizontal',
    shell = vim.o.shell,
    auto_scroll = true,
    size = 20,
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
}

vim.cmd("autocmd BufEnter * if &buftype ==# 'terminal' | startinsert! | endif")

-- Treesitter Configuration
-- NOTE(ali): Enable this on Windows.
-- require('nvim-treesitter.install').compilers = { "cl" }
require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "asm", "bash", "javascript", "html", "css", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,


  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Autocomplete
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
    completion = {
        keyword_length = 2
    },
    performance = {
        max_view_entries = 7
    },
    view = {
        docs = {
            auto_open = false
        }
    },
    formatting = {
        fields = {'abbr', 'kind', 'menu'},
        format = lspkind.cmp_format({
            with_text = true,

            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                path = "[Path]"
            },

            before = function (_, vim_item)
                if vim_item.menu ~= nil and string.len(vim_item.menu) > 0 then
                  vim_item.menu = string.sub(vim_item.menu, 1, 0) .. ""
                end
                return vim_item
            end
        })

    },

    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = {
        { name = "nvim_lsp"},
        { name = "path"},
        { name = "buffer"}
    }
})
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"}),
}

local on_attach = function(client, bufnr)
    local bufopts = {buffer = bufnr, remap = false}

	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', require("telescope.builtin").lsp_definitions, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<leader>t', require("telescope.builtin").lsp_type_definitions, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>r', require("telescope.builtin").lsp_references, bufopts)

	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wd', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)

	vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
end


require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
	handlers = handlers,
    capabilities = capabilities
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
	handlers = handlers,
    capabilities = capabilities
}

require('lspconfig')['lua_ls'].setup{
    on_attach = on_attach,
	handlers = handlers,
    capabilities = capabilities
}

require('lspconfig')['jdtls'].setup{
    on_attach = on_attach,
	handlers = handlers,
    capabilities = capabilities
}

require('lspconfig').rust_analyzer.setup{
    on_attach = on_attach,
	handlers = handlers,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                enable = false
            }
        }
    }
}

-- LSP Signature 
require("lsp_signature").setup {
    bind = true,
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    -- the value need >= 40
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    hint_enable = false,
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:

    close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
    },

    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = "<C-S-space>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
    -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
    -- may not popup when typing depends on floating_window setting

    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating window
    -- e.g. move_cursor_key = '<M-p>',
    -- once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down

}


-- Lualine
require('lualine').setup{
    options = { 
        section_separators = '',
        component_separators = '',
        theme = 'gruvbox',
        globalstatus = false,
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}


-- Keybindings
local key_options = { silent = true, noremap = true }
function set_key(mode, left_hand, right_hand)
	vim.api.nvim_set_keymap(mode, left_hand, right_hand, key_options)
end

vim.keymap.set('n', '<F11>', function() vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen end, {noremap = true})

vim.g.mapleader = " "

-- Telescope Setup
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-[>"] = require('telescope.actions').close,
				["<C-q>"] = require('telescope.actions').send_to_qflist,
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
			},
			n = {
				["<C-[>"] = require('telescope.actions').close,
				["<C-q>"] = require('telescope.actions').send_to_qflist,
				["<C-j>"] = require('telescope.actions').move_selection_next,
				["<C-k>"] = require('telescope.actions').move_selection_previous,
			},
		}
	},
	pickers = {
		find_files = {
			prompt_prefix="> ",
            previewer = false
		},
		buffers = {
			prompt_prefix = "> ",
            previewer = false
		},
		git_files = {
			prompt_prefix = "> ",
            previewer = false
		},
	},
   extensions = {
       fzf = {
           fuzzy = true,                    -- false will only do exact matching
           override_generic_sorter = true,  -- override the generic sorter
           override_file_sorter = true,     -- override the file sorter
           case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
       }
   }
}

require('telescope').load_extension('fzf')

vim.g.telescope_current_working_dir = nil
function ToggleTelescopeWorkingDir(dir)
    if (vim.g.telescope_current_working_dir == nil or vim.g.telescope_current_working_dir ~= dir) then
        vim.g.telescope_current_working_dir = dir
        vim.keymap.set('n', '<C-p>', function() require("telescope.builtin").find_files({cwd=dir}) end, {})
        print("[TELESCOPE WORKING DIR] Set current working dir to " .. vim.g.telescope_current_working_dir)
        
    else
        vim.g.telescope_current_working_dir = nil
        vim.keymap.set('n', '<C-p>', require("telescope.builtin").find_files, {})
        print("[TELESCOPE WORKING DIR] Reset working dir to nil")
    end
end

function GetTelescopeWorkingDir()
    local current_dir = nil
    if vim.g.telescope_current_working_dir == nil then
        current_dir = "nil"
    else
        current_dir = vim.g.telescope_current_working_dir
    end
    print("[TELESCOPE WORKING DIR] Current working dir: " .. current_dir)
end


-- Automatically sets the working directory
ToggleTelescopeWorkingDir(vim.fn.getcwd())
vim.keymap.set('n', '<leader>d', function() ToggleTelescopeWorkingDir(vim.fn.getcwd()) end, {})
vim.keymap.set('n', '<leader>D', function() GetTelescopeWorkingDir() end, {})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-S-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
vim.keymap.set('n', '<leader>a', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>s', builtin.lsp_workspace_symbols, {})

set_key('n', '<leader>e', ":Ex<CR>")

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')

vim.keymap.set('n', '<leader>o', '<C-w>o')

vim.cmd [[nnoremap ; :]]
vim.keymap.set('n', '<C-[>', '<ESC>:echo ""<CR>', {silent = true})

set_key('n', '<C-->', ':vertical resize -5<CR>')
set_key('n', '<C-=>', ':vertical resize +5<CR>')

set_key('n', '<C-/>', ':Commentary<CR>')
set_key('v', '<C-/>', ':Commentary<CR>')

set_key('v', 'J', ":m '>+1<CR>gv=gv")
set_key('v', 'K', ":m '<-2<CR>gv=gv")

set_key('n', '<C-d>', '<C-d>zz')
set_key('n', '<C-u>', '<C-u>zz')

set_key("x", "<leader>p", [["_dP]])

set_key('n', '<C-n>', ':cnext<CR>')
set_key('n', '<C-m>', ':cprev<CR>')

-- Autocommands
vim.cmd [[
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
	autocmd FileType cpp,h,c set softtabstop=4
	autocmd FileType make setlocal noexpandtab softtabstop=0
	autocmd FileType text setlocal linebreak
]]

-- Ingenius Project Management System
local projectsFilePath = vim.fn.stdpath("config") .. "/" .. "projects.info"
local projectFileExists = io.open(projectsFilePath , "r")
if projectFileExists ~= nil then
    io.close(projectFileExists)
else 
    projectFileExists = io.open(projectsFilePath, "w")
    projectFileExists:close()
end

function GetProjectsTable()
    local fileContents = vim.fn.readfile(projectsFilePath, "", 100)
    if fileContents[1] == nil then
        return {}
    else
        return vim.json.decode(fileContents[1])
    end
end

function AddProjectToProjectsTable(projectInfoTable) 
    local fileTable = GetProjectsTable()
    fileTable[#fileTable+1] = projectInfoTable
    vim.fn.writefile({vim.json.encode(fileTable)}, projectsFilePath)
end

function DeleteProjectInProjectsTable(projectName) 
    local projectsTable = GetProjectsTable()

    foundMatchingProjectName = false
    for index, value in ipairs(projectsTable) do
        for key, res in pairs(value) do
            if key == "name" and res == projectName then 
                print("Deleted project with name: `" .. projectName .. "`")
                table.remove(projectsTable, index)
                foundMatchingProjectName = true
                break
            end
        end
        
        if foundMatchingProjectName then
            break
        end
    end

    vim.fn.writefile({vim.json.encode(projectsTable)}, projectsFilePath)
end

local pickers     = require("telescope.pickers")
local finders     = require("telescope.finders")
local conf        = require("telescope.config").values
local actions     = require("telescope.actions")
local actionState = require("telescope.actions.state")

function PickProject() 
    local projectFileNames = {}
    for index, value in ipairs(GetProjectsTable()) do
        projectFileNames[index] = value.name
    end

    pickers.new({}, {
        prompt_title = "Pick Project",
        finder = finders.new_table {
            results = projectFileNames
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(promptBufnr, map)
            actions.select_default:replace(function()
                actions.close(promptBufnr)
                local selection = actionState.get_selected_entry()
                for index, value in ipairs(GetProjectsTable()) do
                    if selection[1] == value.name then
                        vim.cmd("edit " .. value.baseDir)
                        vim.g.telescope_current_working_dir = value.baseDir
                        vim.keymap.set('n', '<C-p>', function() require("telescope.builtin").find_files({cwd=value.baseDir}) end, {})
                        print("[TELESCOPE WORKING DIR] Set current working dir to " .. vim.g.telescope_current_working_dir)

                        local ctrl1Command = ':wa!<CR><C-l>:TermExec cmd="cd ' .. value.baseDir .. '&&clear&&' .. value.ctrl1  .. '"<CR>'
                        local ctrl2Command = ':wa!<CR><C-l>:TermExec cmd="cd ' .. value.baseDir .. '&&clear&&' .. value.ctrl2  .. '"<CR>'

                        vim.keymap.set("n", "<C-1>", ctrl1Command, {noremap = true, silent = true})
                        vim.keymap.set("n", "<C-2>", ctrl2Command, {noremap = true, silent = true})

                        vim.keymap.set("t", "<C-1>", '<C-\\><C-n>' .. ctrl1Command, {noremap = true, silent = true})
                        vim.keymap.set("t", "<C-2>", '<C-\\><C-n>' .. ctrl2Command, {noremap = true, silent = true})
                    end
                end

            end)
            return true
        end,
    }):find()
end

function DeleteProject() 
    local projectFileNames = {}
    for index, value in ipairs(GetProjectsTable()) do
        projectFileNames[index] = value.name
    end

    pickers.new({}, {
        prompt_title = "Delete Project",
        finder = finders.new_table {
            results = projectFileNames
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(promptBufnr, map)
            actions.select_default:replace(function()
                actions.close(promptBufnr)
                local selection = actionState.get_selected_entry()
                for index, value in ipairs(GetProjectsTable()) do
                    if selection[1] == value.name then
                        DeleteProjectInProjectsTable(value.name)
                    end
                end

            end)
            return true
        end,
    }):find()
end

function AddProject() 
    local projectInfo = {}

    local invalidProjectName = true
    while invalidProjectName do
        vim.ui.input({ prompt = 'Enter project name: ' }, function(input)
            local foundExistingProjectWithSameName = false
            for index, value in ipairs(GetProjectsTable()) do
                if input == value.name then
                    foundExistingProjectWithSameName = true
                    break
                end
            end

            if not foundExistingProjectWithSameName then
                projectInfo.name = input
                invalidProjectName = false
            else
                print("\nA project already exists with that name try again")
            end
        end)
    end

    vim.ui.input({ prompt = 'Enter project directory: ' }, function(input)
        projectInfo.baseDir = input
    end)

    vim.ui.input({ prompt = 'Enter <C-1> command: ' }, function(input)
        projectInfo.ctrl1 = input
    end)

    vim.ui.input({ prompt = 'Enter <C-2> command: ' }, function(input)
        projectInfo.ctrl2 = input
    end)

    AddProjectToProjectsTable(projectInfo)
end

vim.keymap.set('n', '<leader>pf', function() PickProject() end, {})
vim.keymap.set('n', '<leader>pd', function() DeleteProject() end, {})
vim.keymap.set('n', '<leader>pa', function() AddProject() end, {})
