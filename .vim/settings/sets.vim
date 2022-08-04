"set backup folders
set undodir=$HOME/vimtmp/undo
set backupdir=$HOME/vimtmp/bk
set directory=$HOME/vimtmp/swap
set noswapfile

"about search
set hlsearch
set ignorecase
set smartcase

"tab
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"command line mode
set wildmenu
set wildmode=longest:full,full

"folding
set foldmethod=manual
set foldcolumn=1

"encoding
set encoding=utf-8
set fileencodings=utf-8,sjis
set termencoding=utf-8
set fileformats=unix,dos

"etc.
set cursorline
set background=dark
set termguicolors
set ruler
set number
set title
set showmatch
set showcmd
set clipboard=unnamed
set mouse=a
set iminsert=0
set imsearch=-1
set incsearch
set t_Co=256
set wrap
set breakindent
set linebreak
set virtualedit+=block
set matchpairs+=<:>
set belloff=all
set noshowmode
set conceallevel=0
set ambiwidth=single
set hidden
set scrolloff=1
set updatetime=150
set noequalalways
set lazyredraw
set signcolumn=yes

if has('nvim')
    set pumblend=30
    set winblend=30
endif

augroup setsAuGroup
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=toml
    autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
