" load plugins
execute pathogen#infect()
call pathogen#helptags()

set nocompatible          " be iMproved, required
filetype off              " required
" syntax on
filetype plugin indent on " required

"===================================
" Settings
"===================================
set noerrorbells                    " No beeps
set relativenumber                  " Show relative line numbers
" set backspace=indent,eol,start      " Makes backspace key more powerful
" set showcmd                         " Show me what I'm typing
" set showmode                        " Show current mode

set noswapfile                      " No swapfiles
set nobackup                        " Don't create backup files
set nowritebackup
set splitright                      " Split vertical windows right to the current windows
set splitbelow                      " Split horizontal windows below to the current windows
set encoding=utf-8                  " Set default encoding to UTF-8
set autowrite                       " Automatically save before :next, :make etc.
set autoread                        " Automatically reread changed files without asking me anything
set laststatus=2
set hidden

set ruler                           " Show the cursor position all the time
au FocusLost * :wa                  " Set vim to save the file on focus out

set fileformats=unix,dos,mac        " Prefer Unix over Windows over OS 9 formats

set noshowmatch                     " Do not show matching brackets by flickering
set noshowmode                      " We show the mode with airline or lightline
set incsearch                       " Shows the match while typing
set hlsearch                        " Highlight found searches
set ignorecase                      " Search case insensitive...
set smartcase                       " ... but not when search pattern contains upper case characters
set ttyfast
set lazyredraw                      " Wait to redraw

" speed up syntax highlighting
set nocursorcolumn
set nocursorline

syntax sync minlines=256
set synmaxcol=300
set re=1

" do not hide markdown
set conceallevel=0

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" folding
set foldmethod=manual

" Make Vim handle long lines nicely
set wrap
set textwidth=79
set formatoptions=qrn1
"set colorcolumn=79
"set relativenumber
"set norelativenumber

" mail line wrapping
au BufRead /tmp/mutt-* set tw=72

set autoindent
set complete-=i
set showmatch

set et
set tabstop=4
set shiftwidth=4
set expandtab

set nrformats-=octal
set shiftround

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely
set notimeout
set ttimeout
set ttimeoutlen=10


" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

if &history < 1000
  set history=50
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
  set viminfo^=!
endif

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" CTRL-U in insert mode deletes a lot.	Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
  set ttymouse=xterm
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \	exe "normal! g`\"" |
          \ endif

  augroup END
else
endif " has("autocmd")


syntax enable
if has('gui_running')
  set transparency=3
  " fix js regex syntax
  set regexpengine=1
  syntax enable
endif
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" let g:hybrid_use_Xresources = 1
" let g:rehash256 = 1
colorscheme solarized
set guifont=Inconsolata:h15
set guioptions-=L

"===================================
" Key mappings
"===================================
" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = "\\"

" This trigger takes advantage of the fact that the quickfix window can be
" easily distinguished by its file-type, qf. The wincmd J command is
" equivalent to the Ctrl+W, Shift+J shortcut telling Vim to move a window to
" the very bottom (see :help :wincmd and :help ^WJ).
autocmd FileType qf wincmd J

" Dont show me any output when I build something
" Because I am using quickfix for errors
"nmap <leader>m :make<CR><enter>

" Some useful quickfix shortcuts
":cc      see the current error
":cn      next error
":cp      previous error
":clist   list all errors
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" allow jumping between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" New escape mapping
inoremap jk <esc>
vnoremap jk <esc>
" Disabling escape key in insert mode to train new escape mapping
inoremap <esc> <nop>
vnoremap <esc> <nop>
" Moving cursor
nnoremap H 0
nnoremap L $
" Move current line downwards
nnoremap - ddp
" Move current line upwards
nnoremap _ ddkP
" Deleting line in insert mode
inoremap <c-d> <esc>ddO
" Converting current word to uppercase
inoremap <c-u> <esc>viwUviw<esc>a
nnoremap <c-u> viwUviw<esc>
" Surrounding a word in double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" Surrounding a word in single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
" Surrounding a word with brackets
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
" Surrounding selected text with double quotes
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>l
" Surrounding selected text with single quote
vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>l
" Surrounding selected text with brackets
vnoremap <leader>( <esc>a)<esc>`<i(<esc>`>l

" Making easier to (make it easier to edit text)
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Reloading vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviations
" Signature
iabbrev ssig -- <cr>Wai Lam Jonathan Lee<cr>walee@uc.cl
" Email
iabbrev @@ walee@uc.cl

"===================================
" File Type settings
"===================================
au BufNewFile,BufRead *.vim setlocal noet ts=4 sw=4 sts=4
au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4
au BufNewFile,BufRead *.yml,*.yaml setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.cpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.hpp setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.json setlocal expandtab ts=2 sw=2
au BufNewFile,BufRead *.jade setlocal expandtab ts=2 sw=2

augroup filetypedetect
  au BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  au BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
augroup END

au FileType nginx setlocal noet ts=4 sw=4 sts=4

" Go settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
" autocmd BufEnter *.go colorscheme nofrils-dark

" scala settings
autocmd BufNewFile,BufReadPost *.scala setl shiftwidth=2 expandtab

" Markdown Settings
autocmd BufNewFile,BufReadPost *.md setl ts=4 sw=4 sts=4 expandtab

" lua settings
autocmd BufNewFile,BufRead *.lua setlocal noet ts=4 sw=4 sts=4

" Dockerfile settings
autocmd FileType dockerfile set noexpandtab

" shell/config/systemd settings
autocmd FileType fstab,systemd set noexpandtab
autocmd FileType gitconfig,sh,toml set noexpandtab

" python indent
autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80 smarttab expandtab

" toml settings
au BufRead,BufNewFile MAINTAINERS set ft=toml

" hcl settings
au BufRead,BufNewFile *.workflow set ft=hcl

" mips settings
au BufRead,BufNewFile *.mips set ft=mips

" spell check for git commits
autocmd FileType gitcommit setlocal spell

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

"===================================
" Plugin configs
"===================================

" ============ Nerd tree ===========

" open nerd tree using Ctrl-N
map <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

" Close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" =================== vim-airline ========================

let g:airline_theme='solarized'

" set to use powerline fonts when not in a ssh session
let g:remoteSession = ($STY == "")
if !g:remoteSession
  let g:airline_powerline_fonts=1
endif

" ================== solarized ===========================
call togglebg#map("<F5>")
