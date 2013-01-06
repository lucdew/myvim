"---------------------
" Luc Dewavrin's vimrc
"---------------------
call pathogen#infect()
set langmenu=en_US.UTF-8   " sets the language of the menu (gvim)
let $LANG = 'en'        " menu language

set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

syntax on " syntax highlight


if has("gui_running")	" GUI color and font settings
  set guifont=Consolas:h10
  set background=dark 
  set t_Co=256          " 256 color mode
  set cursorline        " highlight current line
  colors moria
  highlight CursorLine          guibg=#003853 ctermbg=24  gui=none cterm=none
  set lines=999 columns=9999 " Start maximized
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
set copyindent		" copy the previous indentation on autoindenting
"set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context
set nofoldenable        " disable automatic folding

"---------------------------------------------------------------------------
"Plugins
"---------------------------------------------------------------------------

map <F2> :NERDTreeToggle<CR>


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



