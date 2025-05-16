
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set fileformat=unix
set fileformats=unix,dos,mac
try
	lang en_US
catch
endtry

" Load plugins
let g:plug_shallow = 0
call plug#begin()

" Sensible defaults
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" Status bar and prompt
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim', { 'on': [ 'Tmuxline', 'TmuxlineSimpe' ] }
Plug 'edkolev/promptline.vim', { 'on': 'PromptlineSnapshot' }

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Context
Plug 'wellle/context.vim'

" Git
Plug 'airblade/vim-gitgutter'

" Show trailing whitespace in red background
Plug 'bronson/vim-trailing-whitespace'

" File type support
Plug 'rstacruz/sparkup'

" Tagbar
Plug 'preservim/tagbar'

" Colors
Plug 'ap/vim-css-color'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dense-analysis/ale'

" And the rest
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'

call plug#end()

" File-type
filetype on
filetype plugin on
filetype indent on

silent execute '!mkdir -p ~/.config/nvim/backup'
set backupdir=~/.config/nvim/backup/
set backupskip=/tmp/*,/private/tmp/*
helptags ~/.vim/doc
set backup             " keep a backup file
set cindent
set complete=k,.,w,b,u,t,i
set cursorline         " Highlight the current line number
set directory=~/.config/nvim/backup,/tmp " This is where the swapfiles go
set history=1000       " keep 50 lines of command line history
set undolevels=1000
set ignorecase         " Ignore the case when searching
set smartcase          " Override the 'ignorecase' option if the search pattern contains ucase
set laststatus=2       " Show status only when there are more than two windows
set lazyredraw         " Don't redraw while executing macros (good performance config)
set listchars=tab:>-,space:␣,extends:>,precedes:<
set cmdheight=2        " Helps avoiding 'hit enter' prompt
set foldmethod=indent
set foldminlines=5
set foldlevelstart=1
set magic              " Use some magic in search patterns
set matchtime=2        " Show the match for n tenths of a second
set noerrorbells       " Damn error bells!
set noexpandtab
set number relativenumber " Show line numbers
set copyindent
set nostartofline      " Don't jump to start of line on pagedown
set nrformats+=alpha   " Allows CTRL-A and CTRL-X to increment/decrement letters
set pastetoggle=<F11>
set scrolloff=3        " Keep 3 lines above and below the cursor
set shiftwidth=2
set shortmess=aI       " Avoid 'Hit enter to continue' message, no intro msg
set showbreak=➦        " Show character at beginning of wrapped line
set showcmd            " Show uncompleted command
set showmatch          " Show the matching closing bracket
set showmode           " Show current edit mode
set smartindent        " Indent after { has been typed
set softtabstop=2
set splitbelow         " Create new window below current one
set splitright         " Create new window to the right of the current one
set tabstop=2
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set ttyfast            " We're running on a fast terminal
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :50  :  up to 50 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:50,%,n~/.viminfo
set visualbell         " Better than a beep
set nowrap             " Don't wrap long lines
set whichwrap=<,>,h,l,~,[,]   " Left/right motion line wrap
set wildmenu
" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
set wildchar=<TAB>     " the char used for "expansion" on the command line

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79
set mouse=a

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" statusbar
let g:airline_theme='distinguished'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0

" Toggle relative line numbers
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Set up pretty colors
syntax enable
set background=dark
let myColorscheme = 'typofree'

if &term ==? 'xterm-256color' || &term ==? 'screen-256color-bce' || &term ==? 'screen-256color'
	set t_Co=256
	execute "colorscheme ".myColorscheme
	let g:solarized_termtrans = 1
else
	colorscheme default
endif

" Map key to toggle opt - http://vim.wikia.com/wiki/Quick_generic_option_toggling
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <F3> list
MapToggle <F5> wrap

" Fuzzy Find
" Custom command to override :e
command! -nargs=? -complete=dir E call s:EditWithFzf(<q-args>)
cnoreabbrev e E

" Function to handle :e with fzf
function! s:EditWithFzf(dir)
  if empty(a:dir)
    " If no directory is provided, use the current working directory
    Files
  else
    " Use the provided directory (expanding ~ to full path)
    let l:dir = expand(a:dir)
    if isdirectory(l:dir)
      execute 'Files ' . fnameescape(l:dir)
    else
      " Fallback to default :e behavior if the argument is not a directory
      execute 'edit ' . fnameescape(l:dir)
    endif
  endif
endfunction

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Fast editing of the init.vim
map <leader>e :tabedit! ~/.config/nvim/init.vim<cr>
" When vimrc is edited, reload it
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" Fast editing of the colorscheme
silent execute "map <leader>co :tabedit! ~/.config/nvim/colors/".myColorscheme.".vim<cr>"
" When colorscheme is edited, reload it
autocmd! bufwritepost ~/.config/nvim/colors/*.vim execute "colorscheme ".myColorscheme

" Fast editing of the .zshrc
map <leader>z :tabedit! ~/.zshrc<cr>

" Fast saving
nmap <M-s> :w!<cr>

" Make ;w work http://nvie.com/posts/how-i-boosted-my-vim/
nnoremap ; :

" Saving shortcuts
nmap <F2> :w<C-M>
nmap <F10> :qall<C-M>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Surround
nmap <leader>s ysiw
nmap <leader>cs cs
nmap <leader>ds ds

" Specific surrounds for common use cases
nmap <leader>' ysiw'
nmap <leader>" ysiw"
nmap <leader>( ysiw(
nmap <leader>[ ysiw[

" Visual mode surround
xmap <leader>s S
xmap <leader>' S'
xmap <leader>" S"

" Use system-wide clipboard
set clipboard^=unnamed,unnamedplus

" Copy to clipboard
map <leader>c :!xclip -f -sel clip<cr>

" Session management
" Maybe checkout http://peterodding.com/code/vim/session/
silent execute '!mkdir -p ~/.vim/sessions'
nmap SM :wa<C-M>:mksession! ~/.vim/sessions/
nmap SO :wa<C-M>:source ~/.vim/sessions/

" View management
"au BufWritePost,BufLeave,WinLeave ?* mkview
"au BufWritePost,BufLeave,WinLeave quickfix au!
"au BufWinEnter ?* silent loadview
"au BufWinEnter quickfix au!

" Delete trailing whitespace
nmap <leader>wd :%s/\s\+$//<cr>
vmap <leader>wd :s/\s\+$//<cr>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" NERDTree
map <leader>f :NERDTreeFocus<CR>
map <leader>n :NERDTreeCR>
map <leader>t :NERDTreeToggle<CR>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-k> mz:m-2<cr>`z
nmap <M-j> mz:m+<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Only works in GUI mode
if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

" Create new windows horizontal (-) and vertical (/)
map <leader>- <C-W>n
map <leader>/ :vne<cr>

" Resize splits evenly automatically
autocmd VimResized * wincmd =

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <Left> :tabprevious<cr>
map <Right> :tabnext<cr>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<cr>gvdi<C-R>=current_reg<cr><Esc>

" Specify the behavior when switching between buffers
try
	set switchbuf=usetab
	set stal=2
catch
endtry

" http://cloudhead.io/2010/04/24/staying-the-hell-out-of-insert-mode/
inoremap kj <Esc>

" TAG Jumping
" Create the `tags` file (may need to install ctags)
command! MakeTags !ctags -R .

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	set hlsearch
	map <C-\> :nohlsearch<cr>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" When editing a file, always jump to the last cursor position.
	" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
	function! ResCur()
		if line("'\"") <= line("$")
			normal! g`"
			return 1
		endif
	endfunction

	augroup resCur
		autocmd!
		autocmd BufWinEnter * call ResCur()
	augroup END

endif " has("autocmd")

" open and close folds
" Toggle fold state between closed and opened.
"
" If there is no fold at current line, just moves forward.
" If it is present, reverse its state.
fun! ToggleFold()
	if foldlevel('.') == 0
		normal! l
	else
		if foldclosed('.') < 0
			. foldclose
		else
			. foldopen
		endif
	endif
	" Clear status line
	echo
endfun

" Map this function to Space key.
nnoremap <space> :call ToggleFold()<cr>
vnoremap <space> :call ToggleFold()<cr>

" have the usual indentation keystrokes still work in visual mode:
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
"inoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Cope
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>ccc :botright cope 20<cr>
map <leader>\ :ccl<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Rust
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Toggles
nmap <C-n> :tabnew<CR>

" Fuzzy file, buffer, mru, tag, etc finder
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn|vim/(backup|view))$',
			\ 'file': '\v\.(zwc|exe|so|dll)$',
			\ }

" Haskell
 let g:haddock_browser="/usr/bin/env lynx"

" Sparkup
let g:sparkupNextMapping = '<c-n>'
let g:sparkupExecuteMapping = '<c-e>'

" CommandT
let g:CommandTMaxHeight = 30
noremap <leader>ct :CommandT<cr>
noremap <leader>cty :CommandTFlush<cr>

" Commentary
noremap <leader>cc :Commentary<cr>

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 14
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
