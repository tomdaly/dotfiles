""
"" .vimrc
""

"" useful hotkeys
"" :sp fname - horizontal split from file
"" :vsp fname - vertical split from file
"" ctrl-w {-,+} - change split size by -line,+line
"" ctrl-w = - normalize split size
"" gg=G - auto indent all lines
"" %s/find/replace/gc - find replace whole document
"" <leader>T - new empty buffer
"" <leader>l - next buffer
"" <leader>h - previous buffer
"" <leader>bq - close buffer, move to previous
"" <leader>bl - list buffers and status

set nocompatible
set modelines=0
set nowrapscan

"" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_theme='bubblegum'
set laststatus=2

"" buffers
set hidden
nmap <leader>T :enew<CR>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

"" navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"" numbering
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"" editor related
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set showmatch
set ruler
set visualbell
set incsearch
syntax on

"" searching
set ignorecase
set smartcase
set incsearch
set hlsearch

"" backup, swap, undo dirs
set backup
set backupdir=~/.vim/backup//
set swapfile
set directory=~/.vim/swap//
set undofile
set undodir=~/.vim/undo//

"" mouse support
if has('mouse')
  set mouse=a
endif

set showcmd
set wildmenu
set lazyredraw

"" disable arrow keys to improve hjkl
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
