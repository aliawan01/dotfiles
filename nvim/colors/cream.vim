set background=light
hi clear
if exists("syntax_on")
	syntax reset
endif


let g:colors_name="cream"
if has('termguicolors')
	set termguicolors
endif

" General
hi Normal guifg=black guibg=#f9fcd9 gui=NONE
hi Type guifg=black guibg=#f9fcd9 gui=NONE
hi EndOfBuffer guifg=#f9fcd9 guibg=#f9fcd9 gui=NONE
hi ErrorMsg guifg=red guibg=#f9fcd9 gui=NONE
hi Comment guifg=#DB5B4F guibg=#f9fcd9 gui=NONE
hi Todo guifg=red guibg=#f9fcd9 gui=NONE
hi Constant guifg=#008e07 guibg=#f9fcd9 gui=NONE
hi Special guifg=#2f0dc9 guibg=#f9fcd9 gui=NONE
hi Statement guifg=black guibg=#f9fcd9 gui=NONE
hi PreProc guifg=#6a0dad guibg=#f9fcd9 gui=NONE
hi PreCondit guifg=#6a0dad
hi Underlined guifg=black guibg=#f9fcd9 gui=NONE
hi Boolean guifg=#4523de guibg=#f9fcd9 gui=NONE
hi Float guifg=black guibg=#f9fcd9 gui=NONE
hi Function guifg=#4523de guibg=#f9fcd9 gui=NONE
hi Conditional guifg=black guibg=#f9fcd9 gui=NONE
hi Repeat guifg=black guibg=#f9fcd9 gui=NONE
hi Label guifg=#2f0dc9 guibg=#f9fcd9 gui=NONE
hi Keyword guifg=#2f0dc9 guibg=#f9fcd9 gui=NONE
hi Exception guifg=black guibg=#f9fcd9 gui=NONE
hi Include guifg=#8A3324 guibg=#f9fcd9 gui=NONE
hi Define guifg=#8A3324 guibg=#f9fcd9 gui=NONE
hi Macro guifg=black guibg=#8A3324 gui=NONE
hi PreCondit guifg=black guibg=#f9fcd9 gui=NONE
hi StorageClass guifg=black guibg=#f9fcd9 gui=NONE
hi Structure guifg=#2f0dc9 guibg=#f9fcd9 gui=NONE
hi Typedef guifg=#2f0dc9 guibg=#f9fcd9 gui=NONE
hi Type guifg=#2f0dc9 gui=NONE
hi Tag guifg=black guibg=#f9fcd9 gui=NONE
hi SpecialComment guifg=black guibg=#f9fcd9 gui=NONE
hi Debug guifg=black guibg=#f9fcd9 gui=NONE
hi VertSplit guifg=black guibg=#f9fcd9 gui=NONE
hi SpecialKey guifg=#008e07
hi Directory guifg=#4523de guibg=#f9fcd9
hi NvimIdentifier guifg=#4523de
hi Identifier guifg=#4523de
hi NvimIdentifierScope guifg=#4523de
hi NvimIdentifierScopeDelimiter guifg=#4523de
hi NvimIdentifierName guifg=#4523de
hi NvimIdentifierKey guifg=#4523de
hi Visual guibg=#dcdec3
hi LineNr guifg=black 
hi MatchParen guifg=black guibg=#dcdec3

" C/C++
hi cppAccess guifg=#2f0dc9 gui=NONE
hi cOperator guifg=#2f0dc9 gui=NONE
hi cDefine guifg=#8A3324 gui=NONE
hi cppStatement guifg=#6a0dad gui=NONE
hi cStatement guifg=#2f0dc9 gui=NONE
hi cRepeat guifg=#2f0dc9 gui=NONE
hi cConditional guifg=#2f0dc9 gui=NONE
hi cFormat guifg=#008e07 gui=NONE
hi cSpecial guifg=#008e07 gui=NONE
hi cStorageClass guifg=#2f0dc9 gui=NONE
hi cFloat guifg=#008e07 gui=NONE

" Python
hi pythonStatement guifg=#2f0dc9 gui=NONE
hi pythonRepeat guifg=#2f0dc9 gui=NONE

" Vimscript
hi vimCommand guifg=#2f0dc9 gui=NONE

" Lua
hi luaFunction guifg=#2f0dc9 gui=NONE
hi luaStatement guifg=#4523de
hi luaCond guifg=#4523de
hi luaOperator guifg=#4523de
hi luaTable guifg=black

" JavaScript
hi javaScriptBraces guifg=black
hi javaScriptConditional guifg=#2f0dc9 gui=NONE
hi javaScriptException guifg=#2f0dc9 gui=NONE
hi javaScriptStatement guifg=#2f0dc9 gui=NONE
hi javaScriptIdentifier guifg=#4523de
