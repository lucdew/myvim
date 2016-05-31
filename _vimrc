"---------------------
" Luc Dewavrin's vimrc
"---------------------

set nocompatible
filetype off
if has('win32') || has('win64')
  set rtp+=~/vimfiles/bundle/Vundle.vim/
  call vundle#rc('$HOME/vimfiles/bundle/')
else
  " Usual quickstart instructions
  set rtp+=~/.vim/bundle/Vundle.vim/
  call vundle#rc()
endif

call vundle#begin()

Plugin 'gmarik/Vundle.vim'                 " let Vundle manage Vundle, required
Plugin 'bling/vim-airline'                 " Nice status line
Plugin 'kien/ctrlp.vim'                    " Advanced search in opened buffers
Plugin 'scrooloose/nerdtree'               " File explorer
Plugin 'jlanzarotta/bufexplorer'           " Manage opened buffers
Plugin 'ervandew/supertab'                 " Autocompletion with tab key
Plugin 'fatih/vim-go'                      " Go development
Plugin 'Townk/vim-autoclose'               " Autoclose brackets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'stephpy/vim-yaml'

" Optional:
Plugin 'honza/vim-snippets'



call vundle#end()

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

syntax on " syntax highlight

set langmenu=en_US.UTF-8   " sets the language of the menu (gvim)
let $LANG = 'en'        " menu language

set noruler
set laststatus=2
set autoread		" auto read when file is changed from outside


if has("gui_running")	" GUI color and font settings
  set background=dark 
  set t_Co=256          " 256 color mode
  set cursorline        " highlight current line
  colors moria
  highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
  if has("win32") || has("win16")
     au GUIEnter * simalt ~x "Start in FullScreen
     set guifont=Consolas:h10
  else
     set lines=999 columns=999
     set guifont=Consolas\ 10
  endif
  set guitablabel=\[%N\]\ %t\ %M " Tab label with index of buffer
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-p>")<cr>
else
  colors desert256 " terminal color settings
  imap <nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-p>")<cr>
endif

"---- Start: Show special characters (Press <F3>)
set hls
let g:HLSpace = 1
let g:HLColorScheme = g:colors_name
function ToggleSpaceUnderscoring()
    if g:HLSpace
        highlight Search cterm=underline gui=underline ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
        let @/ = " "
        set listchars=eol:$,tab:>-,extends:>,precedes:<
        set list
    else
        highlight clear
        silent colorscheme "".g:HLColorScheme
        let @/ = ""
        set nolist
    endif
    let g:HLSpace = !g:HLSpace
endfunction

nmap <silent> <F3> <Esc>:call ToggleSpaceUnderscoring()<CR>/<CR>
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
set copyindent		" copy the previous indentation on autoindenting
"set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context
set nofoldenable        " disable automatic folding

"---------------------------------------------------------------------------
"Plugins
"---------------------------------------------------------------------------

"NerdTree
map <F2> :NERDTreeToggle %:p:h<CR>

"Autoclose
let g:AutoClosePairs_add = "<> |"


" Disabled after migration to vundle
" ctrlp
" map <C-b> :CtrlPBuffer<CR>


" Disabled after migration to vundle
" syntastic
" let g:syntastic_mode_map = { 'mode': 'passive',
"                               \ 'active_filetypes': ['go'] }

" Disabled after migration to vundle
"if has('win32')
"   let g:snippets_dir="~/vimfiles/bundle/snipmate/snippets/, ~/vimfiles/bundle/snipmate-nodejs/snippets"
"endif

" Disabled after migration to vundle
" vim-javascript-syntax
" code folding
"au FileType javascript call JavaScriptFold()

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
