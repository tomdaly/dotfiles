"" CMDER SETTINGS, do not edit
set nocompatible
filetype off
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"" Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle/')
"" install plugins here
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()
filetype plugin indent on

let g:ale_completion_enabled = 1
let g:ale_linters = {
\  'javascript': ['eslint'],
\}

"" follow the leader
let mapleader = "\<Space>"
let maplocalleader = "\\"

"" begin custom
set encoding=utf-8
set scrolloff=4
set noshowmode
set autoread
set ai "autoindent
set si "smartindent
set wrap
set nobackup
set noswapfile
set noundofile
set nowb
set number relativenumber
set cursorline
set showcmd
set wildmenu "cli completion
set lazyredraw
set ruler
set nohlsearch
set incsearch
set ignorecase
set smartcase
set magic "regex
set showmatch
set mat=2
set foldcolumn=1 "left margin
set novisualbell
set noerrorbells
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set modelines=0
set nowrapscan
set splitbelow
set splitright
set completeopt=longest,menuone
set so=4
set backspace=indent,eol,start

"" file explorer
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 15
let g:netrw_altv = 1
let g:netrw_browse_split = 4

"" syntax
colorscheme desert
syntax on
filetype on
filetype indent on

"" remaps
" auto brackets
inoremap {<CR> {<CR>}<Esc>O
" jk/kj as esc
inoremap jk <esc>
inoremap kj <esc>
" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" fast saving
nmap <leader>w :w!<CR>
" tabs
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>
map <leader>to :tabonly<CR>
map <leader>tm :tabmove<CR>
" buffer switching
nnoremap gb :ls<CR>:b<Space>
" spellcheck
map <leader>s :setlocal spell!<CR>


"" statusline
set laststatus=2
set statusline=                   " left
set statusline+=%2*\ " blank
set statusline+=%2*\%{StatuslineMode()}
set statusline+=%2*\  " blank
set statusline+=%1*\ <<
set statusline+=%1*\ %f " file              
set statusline+=%1*\ >>
set statusline+=%=                " right
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%3*\%h%m%r  " flags
set statusline+=%4*\%{b:gitbranch}
set statusline+=%3*\%.25F
set statusline+=%3*\::
set statusline+=%3*\%l/%L\\| " lines
set statusline+=%3*\%y" type
hi User1 ctermbg=black ctermfg=grey guibg=black guifg=grey
hi User2 ctermbg=green ctermfg=black guibg=green guifg=black
hi User3 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen
hi User4 ctermbg=black ctermfg=lightcyan guibg=black guifg=lightcyan

"" statusline functions
function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#"n"
        return "NORMAL"
    elseif l:mode==?"v"
        return "VISUAL"
    elseif l:mode==#"i"
        return "INSERT"
    elseif l:mode==#"R"
        return "REPLACE"
    endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    lcd %:p:h
    let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
    lcd -
    if l:gitrevparse!~"fatal: not a git repository"
      let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
    endif
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

augroup HybridNumberOnlyInActiveWindow
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

autocmd BufRead,BufNewFile *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.tex,*.bib setlocal nocursorline
