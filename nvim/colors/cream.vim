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
hi Normal guifg=black guibg=#eeefe0 gui=NONE
hi Type guifg=black guibg=#eeefe0 gui=NONE
hi EndOfBuffer guifg=#4523de guibg=#eeefe0 gui=NONE
hi ErrorMsg guifg=red guibg=#eeefe0 gui=NONE
hi Comment guifg=#476b6b guibg=#eeefe0 gui=NONE
hi Todo guifg=red guibg=#eeefe0 gui=bold
hi Constant guifg=#b36b00 guibg=#eeefe0 gui=NONE
hi Special guifg=SeaGreen guibg=#eeefe0 gui=NONE
hi Statement guifg=black guibg=#eeefe0 gui=NONE
hi PreProc guifg=#6a0dad guibg=#eeefe0 gui=NONE
hi PreCondit guifg=#6a0dad
hi Underlined guifg=black guibg=#eeefe0 gui=NONE
hi Boolean guifg=#4523de guibg=#eeefe0 gui=NONE
hi Float guifg=black guibg=#eeefe0 gui=NONE
hi Function guifg=#4523de guibg=#eeefe0 gui=NONE
hi Conditional guifg=black guibg=#eeefe0 gui=NONE
hi Repeat guifg=black guibg=#eeefe0 gui=NONE
hi Label guifg=SeaGreen guibg=#eeefe0 gui=bold
hi Keyword guifg=SeaGreen guibg=#eeefe0 gui=bold
hi Exception guifg=black guibg=#eeefe0 gui=NONE
hi Include guifg=#6a0dad guibg=#eeefe0 gui=NONE
hi Define guifg=#6a0dad guibg=#eeefe0 gui=NONE
hi Macro guifg=black guibg=#eeefe0 gui=NONE
hi PreCondit guifg=black guibg=#eeefe0 gui=NONE
hi StorageClass guifg=black guibg=#eeefe0 gui=NONE
hi Structure guifg=SeaGreen guibg=#eeefe0 gui=bold
hi Typedef guifg=SeaGreen guibg=#eeefe0 gui=bold
hi Type guifg=SeaGreen gui=bold
hi Tag guifg=black guibg=#eeefe0 gui=NONE
hi SpecialComment guifg=black guibg=#eeefe0 gui=NONE
hi Debug guifg=black guibg=#eeefe0 gui=NONE
hi VertSplit guifg=black guibg=#eeefe0 gui=NONE
hi SpecialKey guifg=#4523de
hi Directory guifg=#4523de
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
hi cppAccess guifg=SeaGreen gui=bold
hi cDefine guifg=#6a0dad gui=NONE
hi cppStatement guifg=#6a0dad gui=NONE
hi cStatement guifg=SeaGreen gui=bold
hi cRepeat guifg=SeaGreen gui=bold
hi cConditional guifg=SeaGreen gui=bold

" Python
hi pythonStatement guifg=SeaGreen gui=bold
hi pythonRepeat guifg=SeaGreen gui=bold

" Vimscript
hi vimCommand guifg=SeaGreen gui=bold

" Lua
hi luaFunction guifg=SeaGreen gui=bold
hi luaStatement guifg=#4523de
hi luaCond guifg=#4523de

" JavaScript
hi javaScriptBraces guifg=black
hi javaScriptConditional guifg=SeaGreen gui=bold
hi javaScriptException guifg=SeaGreen gui=bold
hi javaScriptStatement guifg=SeaGreen gui=bold
hi javaScriptIdentifier guifg=#4523de

