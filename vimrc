"---------------------
" Luc Dewavrin's vimrc
"---------------------

set nocompatible
filetype off

" load plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'ap/vim-buftabline'
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'


Plug 'plasticboy/vim-markdown'
Plug 'stephpy/vim-yaml'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go'
Plug 'dense-analysis/ale'

" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Or latest tag
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}


" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
" Add git status icons in nerd tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" Fzf
" Set in PATH the following commands
" export FZF_DEFAULT_COMMAND="fd --type f --exclude node_modules"
" export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
" export FZF_ALT_C_COMMAND="fd -t d --exclude node_modules . $HOME"

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'


call plug#end()

let mapleader = ","
let g:mapleader = ","

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

syntax on " syntax highlight

set langmenu=en_US.UTF-8   " sets the language of the menu (gvim)
let $LANG = 'en'        " menu language

set noruler
set laststatus=2
set autoread		" auto read when file is changed from outside


" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

" Wildmenu completion {{{
set wildmenu
" set wildmode=list:longest
set wildmode=list:full

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files


syntax enable
if has('gui_running')
  set transparency=3
  " fix js regex syntax
  set regexpengine=1
endif
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="high"
" let g:hybrid_use_Xresources = 1
" let g:rehash256 = 1
colorscheme solarized
set guifont=Inconsolata:h15
set guioptions-=L



"if has("gui_running")	" GUI color and font settings
"  set background=dark 
"  set t_Co=256          " 256 color mode
"  set cursorline        " highlight current line
"  colors moria
"  highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
"  if has("win32") || has("win16")
"     au GUIEnter * simalt ~x "Start in FullScreen
"     set guifont=Consolas:h10
"  else
"     set lines=999 columns=999
"     set guifont=Consolas\ 10
"  endif
"  set guitablabel=\[%N\]\ %t\ %M " Tab label with index of buffer
"else
"  colors desert256 " terminal color settings
"endif
"
set hls
let g:HLSpace = 1
let g:HLColorScheme = g:colors_name
"---- End: Show special characters

" auto reload vimrc when editing it
if has("unix")
  autocmd! bufwritepost .vimrc source ~/.vimrc
endif


" disable sound on errors
set noerrorbells
set visualbell
set t_vb=

" TAB setting{
set expandtab        "replace <TAB> with spaces
set softtabstop=3
set shiftwidth=3

set autoindent		" auto indentation
set incsearch		" incremental search
set nobackup		" no *~ backup files
set noswapfile          " no .swp file
set copyindent          " copy the previous indentation on autoindenting
"set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context
set nofoldenable        " disable automatic folding

function ToggleSpaceUnderscoring()
    if g:HLSpace
        highlight Search cterm=underline gui=underline ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
        let @/ = " "
        set listchars=eol:$,tab:→\ ,extends:>,precedes:<,nbsp:∙
        set list
    else
        highlight clear
        silent colorscheme "".g:HLColorScheme
        let @/ = ""
        set nolist
    endif
    let g:HLSpace = !g:HLSpace
endfunction

"---- Start: Show special characters (Press <F3>)
nmap <silent> <F3> <Esc>:call ToggleSpaceUnderscoring()<CR>/<CR>

highlight SpecialKey ctermfg=246
set list
set list lcs=trail:·,tab:→\ 


" Auto change directory to opened buffer
" commented out it is annoying
" autocmd BufEnter * silent! lcd %:p:h

" Search highlighted text
vnoremap // y/\V<C-R>"<CR>

"---------------------------------------------------------------------------
"Plugins
"---------------------------------------------------------------------------

"NerdTree
map <F2> :NERDTreeToggle %:p:h<CR>
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store', 'node_modules']

autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'yy',
        \ 'callback': 'NERDTreeYankCurrentNode',
        \ 'quickhelpText': 'put full path of current node into the default register' })

function! NERDTreeYankCurrentNode()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
       call setreg('+', (fnamemodify(n.path.str(), ':.')))
    endif
endfunction

" Close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"  delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

" fzf
nnoremap <silent> <leader>p :FZF -m<cr>
nnoremap <silent> <leader>b :Buffers<cr>
" command below should be project dependant
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --glob=!node_modules --glob=!target --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" ale
let g:ale_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
" let g:ale_javascript_prettier_use_local_config = 1
let g:ale_linters = { 'javascript': ['eslint']}
let g:ale_fixers = {
\   'javascript': ['prettier-eslint'],
\   'css': ['prettier'],
\}


" vim replace
" replace with clipboard register, needs a motion afterwards and requires
" +clipboard flag to be set like with gvim
nmap <silent> <leader>r "*gr

" buftabline
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Coc
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" indentLine
" Issue with NerdTree disabling it
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
autocmd BufEnter NERD_tree* :LeadingSpaceDisable

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,latin1

fun! ViewUTF8()
	set encoding=utf-8
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun


