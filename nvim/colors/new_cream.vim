set background=light
hi clear
if exists("syntax_on")
	syntax reset
endif


let g:colors_name="new_cream"
if has('termguicolors')
	set termguicolors
endif

" Considering to change the background to this: #ffffd7
" General
hi Normal guifg=black	guibg=#ffffd7 gui=NONE
hi Type guifg=black		guibg=#ffffd7 gui=NONE
hi EndOfBuffer guifg=#ffffd7 guibg=#ffffd7 gui=NONE
hi ErrorMsg guifg=black guibg=#ffffd7 gui=NONE
hi Comment guifg=#DB5B4F guibg=#ffffd7 gui=NONE
hi Todo guifg=red guibg=#ffffd7 gui=NONE
hi Constant guifg=black guibg=#ffffd7 gui=NONE
hi Special guifg=black guibg=#ffffd7 gui=NONE
hi Statement guifg=black guibg=#ffffd7 gui=NONE
hi PreProc guifg=black guibg=#ffffd7 gui=NONE
hi PreCondit guifg=black
hi Underlined guifg=black guibg=#ffffd7 gui=NONE
hi Boolean guifg=black guibg=#ffffd7 gui=NONE
hi Float guifg=black guibg=#ffffd7 gui=NONE
hi Function guifg=black guibg=#ffffd7 gui=NONE
hi Conditional guifg=black guibg=#ffffd7 gui=NONE
hi Repeat guifg=black guibg=#ffffd7 gui=NONE
hi Label guifg=black guibg=#ffffd7 gui=NONE
hi Keyword guifg=black guibg=#ffffd7 gui=NONE
hi Exception guifg=black guibg=#ffffd7 gui=NONE
hi Include guifg=black guibg=#ffffd7 gui=NONE
hi Define guifg=black guibg=#ffffd7 gui=NONE
hi Macro guifg=black guibg=#8A3324 gui=NONE
hi PreCondit guifg=black guibg=#ffffd7 gui=NONE
hi StorageClass guifg=black guibg=#ffffd7 gui=NONE
hi Structure guifg=black guibg=#ffffd7 gui=NONE
hi Typedef guifg=black guibg=#ffffd7 gui=NONE
hi Type guifg=black gui=NONE
hi Tag guifg=black guibg=#ffffd7 gui=NONE
hi SpecialComment guifg=black guibg=#ffffd7 gui=NONE
hi Debug guifg=black guibg=#ffffd7 gui=NONE
hi VertSplit guifg=black guibg=#ffffd7 gui=NONE
hi SpecialKey guifg=black
hi Directory guifg=black guibg=#ffffd7
hi NvimIdentifier guifg=black
hi Identifier guifg=black
hi NvimIdentifierScope guifg=black
hi NvimIdentifierScopeDelimiter guifg=black
hi NvimIdentifierName guifg=black
hi NvimIdentifierKey guifg=black
hi Visual guibg=#dcdec3
hi LineNr guifg=black 
hi MatchParen guifg=black guibg=#dcdec3
hi cDefine guifg=black guibg=#ffffd7
