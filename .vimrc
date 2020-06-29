set nocompatible

"" plug-vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'thaerkh/vim-workspace'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'wakatime/vim-wakatime'
call plug#end()

"" access wiki
nmap <leader>ww :e ~/drive/wiki/SUMMARY.md<CR>
:noremap <leader>gf :e <cfile>

"" tmuxline
let g:tmuxline_preset = 'zenburn'

"" goyo/limelight writing mode
let g:goyo_width='80%'
let g:goyo_height='70%'
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
:command Write colorscheme typewriter | Goyo | Limelight!!
:command Code colorscheme gruvbox-material | set background='dark' | Goyo! | Limelight!!

"" coc
""" from neoclide/coc.nvim README
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]


"" vim-workspace
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_session_disable_on_args = 1

"" vim-ripgrep + ctrlP
if executable('rg')
  let g:rg_command = 'rg --vimgrep -S'
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

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
set noswapfile
set backupdir=/tmp/
set undodir=/tmp/
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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set modelines=0
set nowrapscan
set splitbelow
set splitright
set completeopt=longest,menuone
set so=4
set backspace=indent,eol,start
set hidden
set cmdheight=2
set shortmess+=c
set signcolumn=yes


"" file explorer
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 10
let g:netrw_altv = 1
let g:netrw_browse_split = 4
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro nornu"

"" find files recursively using :find
set path=.,/usr/include,,**

"" syntax
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material
set background=dark
syntax on
syntax sync fromstart
filetype on
filetype indent on
filetype plugin indent on

"" remaps
" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" tabs
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>
map <leader>to :tabonly<CR>
map <leader>tm :tabmove<CR>
" buffer switching
nnoremap gb :ls<CR>:b<Space>
" spellcheck
map <leader>s :setlocal spell!<CR>
" move between lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
" don't jump to next word using *
" aka use *cgn to change word under cursor, then . to repeat
nnoremap * :keepjumps normal! mi*`i<CR>
" quick save
nnoremap <Return> :w<CR>

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
  if &ft =~ 'vimscript\|markdown\'
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal relativenumber
    autocmd WinLeave * setlocal norelativenumber
  endif
augroup END

autocmd BufRead,BufNewFile,BufFilePre *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2

" auto mkdir if saving to dir that doesnt exist
fun! <SID>AutoMakeDirectory()
  let s:directory = expand("<afile>:p:h")
  if !isdirectory(s:directory)
    call mkdir(s:directory, "p")
  endif
endfun
autocmd BufWritePre,FileWritePre * :call <SID>AutoMakeDirectory()

" wrap git commit lines to 72 chars
au FileType gitcommit setlocal tw=72

" auto close netrw buffer
autocmd FileType netrw setl bufhidden=wipe

" fix ctrl-L refreshing netrw instead of moving vim-tmux-navigator right 2020-02-04
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <buffer> <c-l> :wincmd l<cr>
endfunction

"" zettel template 2020-05-15
:command Zettel call LoadZettel()
function LoadZettel()
  lcd $HOME/drive/kasten
  enew
  silent! execute '0r ~/.vim/templates/zettel.tpl'
  %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
endfunction

"" quick compile/run c++, python3 2020-05-29
autocmd FileType cpp map <buffer> <F6> :w<CR>:exec '!clear;g++ -o out % && ./out' shellescape(@%, 1)<CR>
autocmd FileType cpp imap <buffer> <F6> <esc>:w<CR>:exec '!clear;g++ -o out % && ./out' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F6> :w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F6> <esc>:w<CR>:exec '!clear;python3' shellescape(@%, 1)<CR>

"" zoom into split (like tmux) 2020-06-05
function! s:zoom_toggle() abort
  if 1 == winnr('$') | return | endif
  let restore_cmd = winrestcmd()
  wincmd |
  wincmd _
  " If the layout did not change, it's a toggle (un-zoom).
  if restore_cmd ==# winrestcmd()
    exe t:zoom_restore
  else
    let t:zoom_restore = restore_cmd
  endif
endfunction
nnoremap <leader>z :<C-u>call <SID>zoom_toggle()<CR>
