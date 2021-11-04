" Use Vim settings, rather then Vi settings (much better!).
" {{{ Plug Initialization
if filereadable(expand("~/.vim/plug.vim"))
  source ~/.vim/plug.vim
endif
au BufNewFile,BufRead *.vundle set filetype=vim
" }}}

" This must be first, because it changes other options as a side effect.
set nocompatible

" {{{ General Config
set number                      " Line numbers are good
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom
set visualbell                  " No sounds
set autoread                    " Reload files changed outside vim
set autowrite                   " Auto save files when focus is lost
set cursorline                  " Highlight current line
set encoding=utf-8 nobomb       " Use UTF-8 without BOM
set ttyfast                     " Optimize for fast terminal connections
set title
set titlestring=%F
set laststatus=2
set noshowmode
set hidden
syntax on

" Colorscheme
colorscheme night-owl
set t_Co=256
set background=dark

if (has("termguicolors"))
  set termguicolors
endif

let mapleader=","

" Turn Off Swap Files
set noswapfile
set nobackup
set nowb

" Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set textwidth=80
set signcolumn=yes

" Auto indent pasted text
" nnoremap p p=`]<C-o>
" nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" Folds
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

" Completion
" set wildmode=longest:list,full
set wildmode=list:longest
set wildmenu                " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=node_modules/**

" Scrolling
set scrolloff=8         " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Search
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wqa wqa
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev E e

" General Key Bindings
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :e %%
map <leader>i mmgg=G`m<CR>

noremap <leader><leader> <c-^>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader>c :let @+ = expand("%")<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Re-select visual block after indenting
vnoremap < <gv
vnoremap > >gv
" }}}

" {{{ Callbacks
augroup WhiteSpace
  autocmd!
  autocmd BufWritePre,FileWritePre * :%s/\s\+$//e | %s/\r$//e
augroup END

augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
    \   call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

augroup myvimrchooks
  autocmd!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
" }}}

