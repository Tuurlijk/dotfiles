" Vim color file
" Name:           typofree.vim
" Maintainer:     Michiel Roos <vim@typofree.org>
" Created:        ma 06 okt 2008 07:29:31 pm CEST
" Last Modified:  Fri 27 May 2011 02:50u49 pm CEST
" License:        This file is placed in the public domain.
" Version:        0.1 alpha
"
" This is a 256 color theme for xterm-256color

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "typofree"

hi Normal         ctermfg=249   ctermbg=NONE  cterm=NONE
hi SpecialKey     ctermfg=236   ctermbg=NONE  cterm=bold " control characters and listchars
hi NonText        ctermfg=236   ctermbg=NONE  cterm=NONE " e.g. the + symbol on line wrap
hi PreProc        ctermfg=67    ctermbg=NONE  cterm=NONE
hi Directory      ctermfg=67    ctermbg=NONE  cterm=NONE
hi LineNr         ctermfg=238   ctermbg=NONE  cterm=NONE

hi Cursor         ctermfg=130   ctermbg=NONE  cterm=NONE
hi CursorLine     ctermfg=NONE  ctermbg=NONE  cterm=NONE
if v:version >= 734 || has("patch1-547")
	hi CursorLineNR   ctermfg=244   ctermbg=NONE  cterm=NONE
endif
hi CursorColumn   ctermfg=NONE  ctermbg=234   cterm=NONE

hi DiffAdd        ctermfg=NONE  ctermbg=22    cterm=NONE
hi DiffDelete     ctermfg=NONE  ctermbg=52    cterm=NONE
hi DiffChange     ctermfg=NONE  ctermbg=NONE  cterm=NONE
hi DiffText       ctermfg=NONE  ctermbg=17    cterm=underline

hi ModeMsg        ctermfg=65    ctermbg=NONE  cterm=NONE
hi MoreMsg        ctermfg=65    ctermbg=NONE  cterm=NONE
hi Question       ctermfg=65    ctermbg=NONE  cterm=NONE

hi Pmenu          ctermfg=16    ctermbg=23    cterm=NONE
hi PmenuSel       ctermfg=65    ctermbg=23    cterm=NONE
hi PmenuSbar      ctermfg=16    ctermbg=23    cterm=NONE
hi PmenuThumb     ctermfg=65    ctermbg=23    cterm=NONE

hi MatchParen     ctermfg=208   ctermbg=124    cterm=bold
hi IncSearch      ctermfg=208   ctermbg=238   cterm=bold
hi Search         ctermfg=208   ctermbg=236   cterm=bold
"hi NonText        ctermfg=38    ctermbg=NONE  cterm=NONE
hi Visual         ctermfg=231   ctermbg=60    cterm=NONE
hi Error          ctermfg=231   ctermbg=124    cterm=NONE

hi FoldColumn     ctermfg=NONE  ctermbg=NONE  cterm=bold
hi Folded         ctermfg=NONE  ctermbg=NONE  cterm=bold

hi SpellBad       ctermfg=196   ctermbg=235   cterm=underline
hi SpellCap       ctermfg=67    ctermbg=235   cterm=underline
hi SpellRare      ctermfg=126   ctermbg=235E  cterm=underline
hi SpellLocal     ctermfg=208   ctermbg=235   cterm=underline

hi StatusLineNC   ctermfg=94    ctermbg=234   cterm=NONE
hi StatusLine     ctermfg=208   ctermbg=236   cterm=NONE
hi VertSplit      ctermfg=242   ctermbg=234   cterm=NONE
hi ColorColumn    ctermfg=249   ctermbg=234   cterm=NONE

hi TabLineSel     ctermfg=208   ctermbg=NONE  cterm=NONE
hi TabLineFill    ctermfg=94    ctermbg=236   cterm=underline
hi TabLine        ctermfg=94    ctermbg=236   cterm=underline

" Coding
hi Comment        ctermfg=242   ctermbg=NONE  cterm=NONE
hi SpecialComment ctermfg=242   ctermbg=NONE  cterm=NONE
hi Ignore         ctermfg=242   ctermbg=NONE  cterm=NONE
hi Todo           ctermfg=208   ctermbg=NONE  cterm=underline

hi String         ctermfg=65    ctermbg=NONE  cterm=NONE " 'blah'
"hi Character      ctermfg=65    ctermbg=NONE  cterm=NONE
hi Number         ctermfg=124    ctermbg=NONE  cterm=NONE
hi Boolean        ctermfg=126   ctermbg=NONE  cterm=NONE
hi Float          ctermfg=124    ctermbg=NONE  cterm=NONE
hi Constant       ctermfg=126   ctermbg=NONE  cterm=NONE

hi Identifier     ctermfg=67    ctermbg=NONE  cterm=NONE " the text in $blah
hi Function       ctermfg=137   ctermbg=NONE  cterm=NONE " init() substr()

hi Define         ctermfg=28    ctermbg=NONE  cterm=NONE " function new
hi Statement      ctermfg=130   ctermbg=NONE  cterm=NONE " $ = : . return if exit for
hi Conditional    ctermfg=130   ctermbg=NONE  cterm=NONE " if then else
hi Repeat         ctermfg=130   ctermbg=NONE  cterm=NONE " foreach while
hi Label          ctermfg=130   ctermbg=NONE  cterm=NONE "

hi Operator       ctermfg=221   ctermbg=NONE  cterm=NONE " $ = : . return if exit for

hi Include        ctermfg=28    ctermbg=NONE  cterm=NONE " require include
hi Type           ctermfg=28    ctermbg=NONE  cterm=NONE
hi StorageClass   ctermfg=28    ctermbg=NONE  cterm=NONE
hi Structure      ctermfg=28    ctermbg=NONE  cterm=NONE " class ->
hi Typedef        ctermfg=28    ctermbg=NONE  cterm=NONE

hi Special         ctermfg=124    ctermbg=NONE  cterm=NONE " () {} []
hi SpecialChar     ctermfg=124    ctermbg=NONE  cterm=NONE " hex, ocatal etc.
" hi Delimiter      ctermfg=124    ctermbg=NONE  cterm=NONE

" User defined colors
hi User1          ctermfg=124    ctermbg=236   cterm=bold " mark a modification in the status line
hi User2          ctermfg=124    ctermbg=236   cterm=NONE " mark readonly in status lines

hi ShowTrailingWhitespace   ctermfg=NONE  ctermbg=52  cterm=NONE " trailing whitespace

hi TagbarHighlight  ctermfg=231   ctermbg=60    cterm=NONE

hi SignColumn  ctermfg=130 ctermbg=NONE
