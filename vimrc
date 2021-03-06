" vim: fdm=marker

let s:MYVIMDIR="~/.vim"

set nocompatible

filetype plugin indent on

" vim-plug {{{

" Install Vim-Plug at startup if it isn't installed
if !filereadable(expand(s:MYVIMDIR . "/autoload/plug.vim"))
  echo "Installing Vim-Plug and plugins, "
  echo "restart Vim to finish installation."
  silent! call mkdir(expand(s:MYVIMDIR . "/autoload"), 'p')
  silent! execute "!curl -fLo ".expand(s:MYVIMDIR . "/autoload/plug.vim")
        \ ." https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  au VimEnter * PlugInstall
endif

call plug#begin(expand(s:MYVIMDIR . "/bundle"))

" Visual
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim'}
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-Startify' " nice startup screen

" tpope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' " cis
" :%Subvert/facilit{y,ies}/bulding{,s}
" word jump MixedCase (crm) camelCase (crc) snake_case (crs) UPPERE_CASE (cru)
Plug 'tpope/vim-abolish'

" util
Plug 'tmhedberg/matchit' " extended % for various langs
" Plug 'rhysd/clever-f.vim'
" Plug 'helino/vim-json'
" Plug 'greyblake/vim-preview'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'osyo-manga/vim-over' " visualize substitute cmd

" programming
Plug 'tomtom/tcomment_vim'
Plug 'Raimondi/delimitMate'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'scrooloose/syntastic'
" snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Toogable panels
Plug 'sjl/gundo.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" C/C++
Plug 'justinmk/vim-syntax-extra' " improved C syntax highlighting
Plug 'Mizuchi/STL-Syntax' " C++ 11/14 syntax
Plug 'derekwyatt/vim-fswitch'

" Tex/Latex
Plug 'lervag/vimtex'

call plug#end()
" }}}

" Init {{{
" This must be first, because it changes other options as a side effect.
set ttyfast
let mapleader="," " set <Leader> to ,

let g:tex_flavor="latex" " default filetype for .tex = latex

if has('syntax') && !exists('g:syntax_on')
  syntax enable
  " Syntax coloring lines that are too long just slows down the world
  set synmaxcol=200
endif
" }}} Init

" VIM Options {{{
set modeline " allow per file settings in modeline

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set hidden " Allow buffer switching without saving
set autoread " auto change files modified outside of vim
set ignorecase
set smartcase  " case-sensitive if search contains an uppercase character
set hlsearch " highlights the search results
set incsearch " find as you type search
set gdefault " substitutes all by default (:s///g is default)
set splitright " or set splitbelow
set tabstop=4 " size of a hard tabstop
set softtabstop=4
set shiftwidth=4 " size of an "indent"
set autoindent " Indent at the same level of the previous line
set smartindent " smart auto indenting
set breakindent " indent wrapped lines
set smarttab " make "tab" insert indents instead of tabs at the beginning of a line
set expandtab " always uses spaces instead of tab characters
" set scrolljump=1 " Lines to scroll when cursor leaves screen
" set scrolloff=4 " Minimum lines to keep above and below cursor
set foldmethod=indent " code on same indent is in one fold
set foldlevel=99
set linebreak " break lines at 'breakat'

if has('mouse')
  set mouse= " disable the mouse in all modes
  set mousehide " hide mouse while typing (only in gui)
endif

" backup/persistance settings
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set writebackup

" persist (g)undo tree between sessions
set undofile
set history=100
set undolevels=100

set wildmenu " <Tab> in menu in vim console brings up suggestions
set wildmode =full,full
set wildignore+=.hg,.git,svn
set wildignore+=*.aux,*.out,*.toc " Latex intermediadte files
set wildignore+=*.o,*.obj,*.bak,*.exe,*.d
set wildignore+=*DS_Store*,log/**,tmp/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf
set wildignore+=*.class
set wildignorecase

set spell " spell checking on
" }}} VIM Options

" UI Changes {{{
set number " show the current line as total number not 0
" set relativenumber " shows numbers relative to current line SLOW SCROLLING?
" set cursorline " highlights the current line SLOW SCROLLING!!
" set lazyredraw " solves slow scrolling speed but scrolling looks ugly
set list " show tapstop and eol
set listchars=eol:¬,tab:›\ ,trail:•,nbsp:.,extends:❯,precedes:❮
set laststatus=2 " always show statusline"
set showcmd " display incomplete commands
set showmode " show current mode in last line
set showmatch " got to next match
set background=dark

" colorscheme solarized
" colorscheme Tomorrow-Night
let g:seoul256_background = 234
colorscheme seoul256

highlight clear LineNr " Current line number row will have same background color in relative mode

if has('gui_running')
  set guioptions-=r " hide right scrollbar
  set guioptions-=l " hide left scrollbar
  set guioptions-=L " hide situationally left scrollbar
  set guioptions-=T " Remove the toolbar
  set guioptions-=m
  set guioptions=ci
  " set guifont=Ubuntu\ Mono\ 12 "PragmataPro\ 10
  set guifont=Hack\ 10
  " set lines=999 columns=999 " Maximize gvim window.
  set lines=40 columns=100
endif
" }}} UI Changes

" Autocmd {{{
augroup source_reload
    au!
    " Source the vimrc file after saving it
    au bufwritepost vimrc source $MYVIMRC
    au bufwritepost .vimrc source $MYVIMRC
    " autocmd bufwritepost gimrc source $MYGVIMRC
augroup end

augroup spell_au
    au!
    au FileType latex,tex setlocal spelllang=de
augroup end

augroup filetype_tabsize
    au!
    au FileType make    :setlocal ts=8 sts=8 sw=8 noet
    au FileType vim     :setlocal ts=2 sts=2 sw=2 et fdm=marker
    au FileType sh,html :setlocal ts=2 sts=2 sw=2 et
augroup end
" }}} Autocmd

" Mappings {{{

" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
nnoremap <F1> <ESC>
inoremap <F1> <Esc> " get out of insertmode
noremap <F1> :call MapF1()<CR> " toogle help otherwise

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction

" change to current buffer's directory
nnoremap <leader>cd :cd <c-r>=expand("%:p:h")<cr><cr>

" remap change window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" resize windows
noremap <silent> <c-left>  :verical resize -1<cr>
noremap <silent> <c-up>    :resize  +1<cr>
noremap <silent> <c-down>  :resize  -1<cr>
noremap <silent> <c-right> :verical resize +1<cr>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk
" nnoremap 0 g0
" nnoremap $ g$

" Visual shifting does not exit Visual mode
vnoremap < <gv
vnoremap > >gv

"make Y consistent with C and D
nnoremap Y y$

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" format text with Q
vnoremap Q gq
nnoremap Q gqap

nnoremap <silent> <leader><space> :nohlsearch<cr>

" make tab movement
nnoremap <tab> %
vnoremap <tab> %

" write with sudo
cnoremap w!! w !sudo tee % > /dev/null

"create a new line cmd mode without going to insert
nnoremap <leader>k O<esc>
nnoremap <leader>j o<esc>
"insert space without going to insert
nnoremap <leader>h i <esc>
nnoremap <leader>l a <esc>
"Break a line into two and retain cursor position
nnoremap <leader>b i<cr><esc>k$

" quick safe quit and search
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>s :%s/
vnoremap <leader>s :s/

" open vimrc
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>V :tabnew ~/.vimrc<CR>

nnoremap <silent> <Leader>lc :VimtexCompileToggle<cr>
nnoremap <silent> <Leader>lv :VimtexView<cr>
nnoremap <silent> <Leader>le :VimtexError<cr>
nnoremap <silent> <Leader>lt :VimtexTocToogle<cr>

nnoremap <silent> <F3> :YcmCompleter GoToDeclaration<CR>
nnoremap <silent> <F4> :YcmCompleter GoToDefinition<CR>
nnoremap <silent> <F5> :YcmCompleter GoTo<CR>
nnoremap <silent> <F7> :GundoToggle<CR>
nnoremap <silent> <F8> :NERDTreeToggle<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <F10> :IndentGuidesToggle<CR>

nnoremap <silent> <Leader>of :FSHere<cr>
nnoremap <silent> <Leader>ol :FSRight<cr>
nnoremap <silent> <Leader>oL :FSSplitRight<cr>
nnoremap <silent> <Leader>oh :FSLeft<cr>
nnoremap <silent> <Leader>oH :FSSplitLeft<cr>
nnoremap <silent> <Leader>ok :FSAbove<cr>
nnoremap <silent> <Leader>oK :FSSplitAbove<cr>
nnoremap <silent> <Leader>oj :FSBelow<cr>
nnoremap <silent> <Leader>oJ :FSSplitBelow<cr>

" }}} Mappings

" Plugin Config {{{

" airline {{{
set noshowmode
let g:airline#extensions#branch#empty_message = "No SCM"
" let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamecollapse = 1
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'

" let g:airline_theme='solarized'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" let g:airline_left_sep = ''
let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
let g:airline_symbols.readonly = 'ro'
" let g:airline_symbols.linenr = ''
" let g:airline_symbols.space = "\ua0"
" let g:airline_section_y=''
" }}} airline

" delimitMate {{{
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
" let delimitMate_jump_expansion = 1
" }}} delimitMate

" fswitcher {{{
" au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = 'reg:/src/include/,ifrel:|/src/|../include|,../include,../inc,./'
" au! BufEnter *.hpp *.h let b:fswitchdst = 'cpp,cxx,cc,C' | let b:fswitchlocs = 'reg:/include/src/,ifrel:|/include/|../src|,../src,../source,./'
" }}} fswitcher

" indent guide {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'tex']
" }}} indent guide

" Syntastic {{{
" let g:syntastic_check_on_open = 0
" let g:syntastic_error_symbol = "✗"
" let g:syntastic_warning_symbol = "⚠"
" let g:syntastic_cpp_checkers=['gcc']
" let g:syntastic_cpp_check_header = 1
" let g:syntastic_cpp_compiler_options = '-std=c++11'
"}}}

" tagbar {{{
" }}} tagbar

" UltiSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader>."
"let g:UltiSnipsListSnippets="<leader><c-tab>"
let g:UltiSnipsJumpForwardTrigger="<leader>."
let g:UltiSnipsJumpBackwardTrigger="<leader>m"
let g:UltiSnipsEditSplit="vertical"
" }}} UltiSnips

" YouCompleteMe {{{
let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol = "⚠"
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
" }}} YouCompleteMe

" vimtex {{{
let g:vimtex_enabled = 1
" let g:vimtex_viewer = 'mupdf -r 95'
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_mappings_enabled= 0
let g:vimtex_fold_enabled = 0
let g:vimtex_indent_enabled = 1
" let g:vimtex_motion_enabled = 1
" let g:vimtex_motion_matchparen = 1
let g:vimtex_complete_enabled = 0
" }}} vimtex

" eclim {{{
let g:EclimCompletionMethod = 'omnifunc'
" }}} eclim

" rainbow {{{
" let g:rainbow_active = 1
"
" let g:rainbow_load_separately = [
"     \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
"     \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"     \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"     \ ]
"
" let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
" let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
" }}} rainbow
" }}} Plugin Config
