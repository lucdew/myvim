"---------------------
" Luc Dewavrin's vimrc
"---------------------
set nocompatible
filetype off

" 
let isDev=0
if filereadable(expand("~/.vim/env")) 
   source ~/.vim/env
endif


" load plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'

if isDev
   Plug 'tpope/vim-surround'
   Plug 'tpope/vim-fugitive'
   Plug 'Raimondi/delimitMate'
   Plug 'godlygeek/tabular'
   Plug 'tpope/vim-sensible'
   Plug 'vim-scripts/ReplaceWithRegister'
   Plug 'ap/vim-buftabline'
   Plug 'Yggdroot/indentLine'
   Plug 'easymotion/vim-easymotion'


   " Plug 'plasticboy/vim-markdown'
   Plug 'cespare/vim-toml'
   " Plug 'rust-lang/rust.vim'

   " Use release branch
   Plug 'neoclide/coc.nvim', {'branch': 'release'}

   " Add git status icons in nerd tree
   Plug 'Xuyuanp/nerdtree-git-plugin'

   " Fzf
   Plug 'junegunn/fzf', { 'do': './install --all' }
   Plug 'junegunn/fzf.vim'

endif

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

" Always use the clipboard for all operations
set clipboard+=unnamedplus

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
" let g:hybrid_use_Xresources = 1
" let g:rehash256 = 1
"set guifont=Inconsolata:h15


if has("gui_running")	" GUI color and font settings
  " fix js regex syntax
  set regexpengine=1
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  let g:solarized_contrast="high"
  set guioptions-=L " Remove left-hand scroll
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
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
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes and colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>hl :set cursorline!<CR>
set cursorline!

set background=dark
let g:gruvbox_guisp_fallback = "bg"

colors gruvbox " terminal color settings
set termguicolors


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimrc autoreload
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set backupcopy=yes	" copy and overwrite on save
set noswapfile          " no .swp file
set copyindent          " copy the previous indentation on autoindenting
"set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context
set nofoldenable        " disable automatic folding

"---- Start: Show special characters (Press <F3>)
function! ToggleSpecialCharactersHighlighting()
    if g:HLSpace
        set listchars=eol:$,tab:→\ ,extends:>,precedes:<,nbsp:·,trail:·,space:·
        set list
    else
        "highlight SpecialKey ctermfg=246
        silent colorscheme "".g:HLColorScheme
        highlight clear
        set nolist
    endif
    let g:HLSpace = !g:HLSpace
endfunction

nmap <silent> <F3> <Esc>:call ToggleSpecialCharactersHighlighting()<CR>

let g:HLSpace = 1
let g:HLColorScheme = g:colors_name
:call ToggleSpecialCharactersHighlighting()
"---- End: Show special characters

" Auto change directory to opened buffer
" commented out it is annoying
" autocmd BufEnter * silent! lcd %:p:h

" Search highlighted text
vnoremap // y/\V<C-R>"<CR>

" command to delete all buffers except the one being edited
command! BufOnly silent! execute "%bd|e#|bd#"

" switch between buffers
noremap <Leader>k :bn<cr>
noremap <Leader>j :bp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Splits and Tabbed Files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright

" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>tv <C-w>t<C-w>H
map <Leader>th <C-w>t<C-w>K

" next window
map <Leader>w <C-w>w

" Removes pipes | that act as seperators on splits
" set fillchars+=vert:\ 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Open terminal inside Vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>tt :50vs \| :term<CR>i<CR>
" escape terminal mode with Esc
tnoremap <Esc> <C-\><C-n>:q!<CR>
au TermOpen term://*fzf* tnoremap <buffer> <Esc> <Esc>

" ========================================================================
"-------------------------------------------------------------------------
"Plugins
"-------------------------------------------------------------------------
" ========================================================================

"-------------------------------------------------------------------------
"NerdTree
"-------------------------------------------------------------------------
map <F2> :NERDTreeToggle %:p:h<CR>
noremap <Leader>n :NERDTreeToggle<cr> \| :wincmd p<CR>
noremap <Leader>f :NERDTreeFind<cr> \| :wincmd p<CR>
noremap <Leader>e :NERDTreeFind<cr>
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
" Disabled not working as expected (close even if there are more than 1 buffer)
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Prevent opening buffers in NerdTree like when using Fzf
autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()

function! PreventBuffersInNERDTree()
  if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
    \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
    \ && &buftype == '' && !exists('g:launching_fzf')
    let bufnum = bufnr('%')
    close
    exe 'b ' . bufnum
    NERDTree
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction
"-------------------------------------------------------------------------

if isDev
   "-------------------------------------------------------------------------
   "  delimitMate
   "-------------------------------------------------------------------------
   " let g:delimitMate_expand_cr = 1
   let g:delimitMate_expand_space = 1
   let g:delimitMate_smart_quotes = 1
   let g:delimitMate_expand_inside_quotes = 0
   let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

   "-------------------------------------------------------------------------
   " fzf
   "-------------------------------------------------------------------------
   
   let $FZF_DEFAULT_COMMAND="rg --files --column --line-number --no-heading --smart-case -g '!{node_modules,.git}'"
   let $FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
   nnoremap <silent> <leader>p :FZF -m<cr>
   nnoremap <silent> <leader>b :Buffers<cr>
   " command below should be project dependant

   command! -bang -complete=dir -nargs=* Rg
     \ call fzf#vim#grep(
     \   "rg --column --line-number --glob='!{node_modules,.git,target}' --no-heading --color=always --smart-case ".<q-args>, 1,
     \   <bang>0 ? fzf#vim#with_preview('up:60%')
     \           : fzf#vim#with_preview('right:50%:hidden', '?'),
     \   <bang>0)

   nnoremap <silent> <Leader>c :call fzf#run({
   \   'source':  'cat ~/.vim/commands',
   \   'sink':   '!bash -c',
   \   'down': '40%'
   \ })<CR>

   "let g:fzf_history_dir = '~/.local/share/fzf-history'
   let g:fzf_history_dir = '~/.local/share/fzf-history'
   " [Buffers] Jump to the existing window if possible
   let g:fzf_buffers_jump = 1


   "-------------------------------------------------------------------------
   " vim replace
   "-------------------------------------------------------------------------
   " replace with clipboard register, needs a motion afterwards and requires
   " +clipboard flag to be set like with gvim
   " nmap <silent> <leader>r "*gr

   "-------------------------------------------------------------------------
   " buftabline
   "-------------------------------------------------------------------------
   set hidden
   "nnoremap <C-N> :bnext<CR>
   "nnoremap <C-P> :bprev<CR>

   "-------------------------------------------------------------------------
   " Coc
   "-------------------------------------------------------------------------
   " use <tab> for trigger completion and navigate to the next complete item
   let g:coc_global_extensions = [
     \ 'coc-tsserver',
     \ 'coc-eslint', 
     \ 'coc-prettier', 
     \ 'coc-json', 
     \ 'coc-rust-analyzer'
     \ ]
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
   " Remap keys for gotos
   nmap <silent> gd <Plug>(coc-definition)
   nmap <silent> gy <Plug>(coc-type-definition)
   nmap <silent> gi <Plug>(coc-implementation)
   nmap <silent> gr <Plug>(coc-references)

   " Remap for rename current word
   nmap <F6> <Plug>(coc-rename)


   " indentLine
   " Issue with NerdTree disabling it
   let g:indentLine_leadingSpaceEnabled = 1
   let g:indentLine_leadingSpaceChar = '·'
   " disable conceal that hides stretches of text based on syntax highlighting 
   " for instance it hides double quotes in json files
   let g:indentLine_setConceal = 0
   autocmd BufEnter NERD_tree* :LeadingSpaceDisable

   " Use `:Format` to format current buffer
   command! -nargs=0 Format :call CocAction('format')

   " Use `:Fold` to fold current buffer
   command! -nargs=? Fold :call     CocAction('fold', <f-args>)

   " use `:OR` for organize import of current buffer
   command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

   " Add status line support, for integration with other plugin, checkout `:h coc-status`
   set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

   " Using CocList
   " Show all diagnostics
   nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
   " Manage extensions
   nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
   " Show commands
   nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
   " Find symbol of current document
   nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
   " Search workspace symbols
   nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
   " Do default action for next item.
   nnoremap <silent> <space>j  :<C-u>CocNext<CR>
   " Do default action for previous item.
   nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
   " Resume latest coc list
   nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

endif

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Enable to load .vimrc in current directory
"    for project specific configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set exrc
set secure

