set nocompatible
set shell=/bin/zsh

"" follow the leader
let mapleader = "\<Space>"

"" plug-vim
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'neovim/nvim-lspconfig'
Plug 'thaerkh/vim-workspace'
Plug 'airblade/vim-gitgutter'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'simeji/winresizer'
Plug 'wincent/terminus'
Plug 'junegunn/goyo.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'tpope/vim-dispatch'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'puremourning/vimspector'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

"" coq.nvim
"let g:coq_settings = { 'keymap.jump_to_mark' : '', 'display.icons.mode': 'none', 'auto_start': 'shut-up' }
""" coq LSP
lua << EOF
require'lspconfig'.tsserver.setup{} -- TypeScript
require'lspconfig'.eslint.setup{} -- ESLint (TS/JS)
require'lspconfig'.gopls.setup{} -- GoLang
require'lspconfig'.solargraph.setup{} -- Ruby
require'lspconfig'.terraformls.setup{} -- Terraform
local lsp = require "lspconfig"
local coq = require "coq"
EOF

"" lsp_lines
lua << EOF
require("lsp_lines").setup()
vim.diagnostic.config({
  virtual_text = false,
})
EOF

"" vimspector
let g:vimspector_base_dir='$HOME/.vim/plugged/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'
nnoremap <Leader>dd :call vimspector#Launch()<CR>
nnoremap <Leader>de :call vimspector#Reset()<CR>
nnoremap <Leader>dc :call vimspector#Continue()<CR>

nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <Leader>dk <Plug>VimspectorRestart
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dj <Plug>VimspectorStepOver


"" tmuxline
let g:tmuxline_theme = 'jellybeans'
let g:tmuxline_preset = 'minimal'
let g:tmuxline_status_justify = 'centre'

"" vim-workspace
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_session_disable_on_args = 1

"" vim-ripgrep + ctrlP
if executable('rg')
  let g:rg_command = 'rg --vimgrep -S'
  let g:ctrlp_user_command = '[ $PWD = $HOME ] && echo "in HOME dir" || rg %s --files --hidden --ignore --color=never --glob ""'
endif

let g:ctrlp_working_path_mode = 0

"" FZF
nnoremap <C-P> :FZF<CR>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>

"" vim-tmux-navigator
"" disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

"" goyo
let g:goyo_width = '80%'
let g:goyo_height = '70%'


"" begin custom
set encoding=utf-8
set scrolloff=4
set noshowmode
set autoread
set cindent
set wrap
set noswapfile
""" stop fucking creating undodir in my local directory PLEASE
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
set undofile
set undodir=~/.vim/undodir/
set backupdir=/.vim/backupdir/
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
set foldcolumn=1 "left margin, for gitgutter
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
let g:netrw_winsize = 20
let g:netrw_altv = 1
let g:netrw_browse_split = 4
let g:netrw_bufsettings="noma nomod nonu nobl nowrap ro nornu"

"" find files recursively using :find
set path=.,/usr/include,,**

"" colours
set termguicolors
colorscheme jellybeans

"" syntax
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
nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ":w<CR>"
" previous buffer
nnoremap <leader>b <C-^><CR>
vnoremap <leader>il y<esc>oconsole.log('<c-r>"', <c-r>");<esc>

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
set statusline+=%3*\%c,%l/%L\\| " lines
set statusline+=%3*\%y" type
hi User1 ctermbg=black ctermfg=grey guibg=black guifg=grey
hi User2 ctermbg=lightgreen ctermfg=black guibg=lightgreen guifg=black
hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue
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
  else
    return "COMMAND"
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

" auto :e to get file changes on focus change
au FocusGained,BufEnter * :checktime

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

" filetypes
au BufRead,BufNewFile,BufFilePre *.htm,*.html,*.css,*.js setlocal tabstop=2 shiftwidth=2 softtabstop=2

au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

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

"" <leader>rt = run tests
"" added ruby specific commands for rspec 2022-06-04
""" available at ~/.vim/ftplugin/ruby
