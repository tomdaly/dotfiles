set nocompatible

"" Vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin('$HOME/.vim/bundle/')
"" install plugins here
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'VimWiki/vimwiki'
Bundle 'edkolev/tmuxline.vim'
Plugin 'junegunn/goyo.vim'
call vundle#end()
filetype plugin indent on

"" vimwiki 
let wiki_1 = {}
let wiki_1.path = '~/drive/wiki/wiki.work'
let wiki_1.path_html = '~/drive/wiki/wiki.work_html'
let wiki_1.template_path = '~/drive/wiki/wiki.work/templates'
let wiki_1.template_default = 'default'
let wiki_1.template_ext = '.html'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.custom_wiki2html = 'vimwiki_markdown'
let wiki_1.html_filename_parameterization = 1

let wiki_2 = {}
let wiki_2.path = '~/drive/wiki/wiki.home'
let wiki_2.path_html = '~/drive/wiki/wiki.home_html'
let wiki_2.template_path = '~/drive/wiki/wiki.home/templates'
let wiki_2.template_default = 'default'
let wiki_2.template_ext = '.html'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'
let wiki_2.custom_wiki2html = 'vimwiki_markdown'
let wiki_2.html_filename_parameterization = 1

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_ext2syntax = {'.md' : 'markdown'}
let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_text_ignore_newline = 0
let g:vimwiki_global_ext = 0  " ignore .md files outside wiki dir

"" ale
let g:ale_completion_enabled = 1
let g:ale_linters = {
      \  'javascript': ['eslint'],
      \}

"" goyo
let g:goyo_width = 220

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
filetype on
filetype indent on

"" remaps
" auto brackets
inoremap {<CR> {<CR>}<Esc>O
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
  if &ft =~ 'vimscript\|markdown\'
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal relativenumber
    autocmd WinLeave * setlocal norelativenumber
  endif
augroup END

autocmd BufRead,BufNewFile,BufFilePre *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2

" auto mkdir if saving to dir that doesnt exist
" useful for vimwiki subfolders
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

" auto fill vimwiki diary entries with template
au BufNewFile ~/drive/wiki/wiki.work/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template
