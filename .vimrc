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
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'neovim/nvim-lspconfig'
Plug 'thaerkh/vim-workspace'
Plug 'airblade/vim-gitgutter'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'simeji/winresizer'
Plug 'wincent/terminus'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'github/copilot.vim'
Plug 'vim-test/vim-test'
Plug 'mfussenegger/nvim-dap'
Plug 'suketa/nvim-dap-ruby' " requires `gem install debug`
Plug 'leoluz/nvim-dap-go' " requires `go install github.com/go-delve/delve/cmd/dlv@latest`
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'jackMort/ChatGPT.nvim'
Plug 'MunifTanjim/nui.nvim' " for chatgpt.nvim
Plug 'nvim-lua/plenary.nvim' " for chatgpt.nvim, todo-comments.nvim, octo.nvim
Plug 'nvim-telescope/telescope.nvim' " for chatgpt.nvim, octo.nvim
Plug 'justinmk/vim-sneak'
Plug 'vimwiki/vimwiki'
Plug 'folke/todo-comments.nvim'
Plug 'nvim-tree/nvim-web-devicons' " for octo.nvim
Plug 'pwntester/octo.nvim'
Plug 'rebelot/kanagawa.nvim'

call plug#end()

"" coq.nvim
""" coq LSP
lua << EOF
vim.g.coq_settings = {
  keymap = {
    jump_to_mark = '',
  },
  auto_start = false, -- 'false' or 'shut-up'. enabled 2023-10-30
  display = {
    pum = {
      fast_close = false
    },
    icons = {
      mode = 'long' -- 'none', 'short' or 'long'
    }
  },
}
require'lspconfig'.eslint.setup({ -- ESLint (TS/JS)
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
require'lspconfig'.gopls.setup{} -- GoLang
require'lspconfig'.solargraph.setup{} -- Ruby
-- require'lspconfig'.terraformls.setup{} -- Terraform
 -- (disabled 2022-10-05 as crashes M1! https://github.com/hashicorp/terraform/issues/31467)
 -- (re-enabled 2022-11-11 after disabling IPv6 on M1 (System Preferences, Wi-Fi, Advanced, TCP/IP, IPv6 -> 'Link-local only'))
 -- disabled again 2022-12-09, slow as fuck
local lsp = require "lspconfig"
local coq = require "coq"
-- third party LSPs for copilot + coq
-- disabled 2022-12-08 as not working
require("coq_3p") {
  { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
}
EOF

"" copilot remapping (default: <Tab>)
imap <silent><script><expr> <Leader><CR> copilot#Accept("\<CR>")
"let g:copilot_no_tab_map = v:true
imap <silent> <C-]> <Plug>(copilot-next)
imap <silent> <C-[> <Plug>(copilot-previous)
imap <silent> <C-#> <Plug>(copilot-dismiss)
""" temporarily disable typescript copilot for exercism
let g:copilot_filetypes = {
      \ 'markdown': v:false,
      \ 'vimwiki': v:false,
      \ 'typescript': v:false,
      \ }

"" lsp_lines
lua << EOF
require('lsp_lines').setup()
vim.diagnostic.config({
  virtual_text = false,
})
EOF

"" todo-comments.nvim
lua << EOF
require("todo-comments").setup({
  highlight = {
    pattern = [[.*<(KEYWORDS)(\(.*\))?\s*:]],
  }
})
EOF

"" vimwiki
let g:vimwiki_list = [{'path': '~/vault/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {}
let g:vimwiki_folding = 'expr:quick'
let g:vimwiki_listsyms = ' .ox'
let g:vimwiki_listsym_rejected = '~'
au BufNewFile ~/vault/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'


"" vimspector
"let g:vimspector_base_dir=expand('$HOME/.vim/plugged/vimspector')
"let g:vimspector_enable_mappings = 'HUMAN'
"nnoremap <Leader>dd :call vimspector#Launch()<CR>
"nnoremap <Leader>dx :call vimspector#Reset()<CR>
"nnoremap <Leader>dc :call vimspector#Continue()<CR>
"
"nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
"nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
"
"nmap <Leader>dr <Plug>VimspectorRestart
"nmap <Leader>dh <Plug>VimspectorStepOut
"nmap <Leader>dl <Plug>VimspectorStepInto
"nmap <Leader>dj <Plug>VimspectorStepOver

"" nvim-dap
lua << EOF
local dap = require('dap')
require('dap-ruby').setup()
require('dap-go').setup()
require('dapui').setup()
require('nvim-dap-virtual-text').setup()
require('nvim-treesitter.configs').setup({
  ensure_installed = {'ruby', 'go', 'typescript', 'javascript', 'terraform', 'python', 'json', 'yaml', 'html', 'css', 'bash', 'lua', 'vim', 'vimdoc'},
  sync_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})
vim.keymap.set('n', '<Leader>dt', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dT', function() dap.clear_breakpoints() end)
vim.keymap.set('n', '<Leader>dd', function() dap.continue() end)
vim.keymap.set('n', '<Leader>dx', function() dap.terminate() end)
vim.keymap.set('n', '<Leader>dj', function() dap.step_over() end)
vim.keymap.set('n', '<Leader>dl', function() dap.step_into() end)
vim.keymap.set('n', '<Leader>dh', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>di', function() require('dapui').eval() end)
vim.keymap.set('n', '<Leader>dI', function() require('dapui').toggle() end)
EOF

"" tmuxline
let g:tmuxline_theme = 'jellybeans'
let g:tmuxline_preset = 'minimal'
let g:tmuxline_status_justify = 'centre'

"" vim-workspace
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_session_disable_on_args = 1

"" vim-fugitive
nnoremap <silent> <Leader>g :G<CR>

"" octo.nvim
lua << EOF
require('octo').setup()
EOF

"" FZF + Rg
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right:40%']
""" the 'delimiter' option with nth 3 is dependent on the '--no-column' flag
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-column --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}), <bang>0)
  "\   fzf#vim#with_preview('right:hidden', 'ctrl-/'), <bang>0)
nnoremap <silent> <Leader>p :FZF<CR>
nnoremap <silent> <Leader>P :Project<CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
""" fzf project navigation
function! s:change_to_project(project)
  exec 'lcd ~/dev/' . a:project
  exec 'tabedit ~/dev/' . a:project
endfunction
command! -nargs=0 Project
    \ call fzf#run(fzf#wrap('projects', {
    \   'sink': function('s:change_to_project'),
    \   'source': 'find ~/dev -name .git -maxdepth 2 | cut -d ''/'' -f 5 | sort',
    \ }))
""" fzf ctags generation using rgignore to exclude
let g:fzf_vim.tags_command = 'rg --files | ctags -R --links=no -L -'

"" vim-tmux-navigator
"" disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1

"" goyo
let g:goyo_width = '80%'
let g:goyo_height = '90%'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_guifg = '#434340'


"" vim-test
let test#strategy = "neovim"
let g:test#neovim#start_normal = 0
let g:test#echo_command = 0
let test#neovim#term_position = "horizontal bot 40"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>l :TestLast<CR>
""" visits last run test file
nmap <silent> <leader>L :TestVisit<CR>
let test#typescript#jest#executable = 'yarn jest'
let test#javascript#jest#executable = 'yarn jest'

"" chatgpt.nvim
lua << EOF
  local home = vim.fn.expand("$HOME")
  require("chatgpt").setup({
      api_key_cmd = "gpg --decrypt " .. home .. "/openai_api_key.txt.gpg"
  })
EOF
nmap <silent> <leader>c :ChatGPT<CR>
nmap <silent> <leader>ce :ChatGPTEditWithInstructions<CR>


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
set foldcolumn=0
set foldlevel=9 " to stop all folds being closed on first 'zc'
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
set conceallevel=2
set signcolumn=auto:2 " show vimspector breakpoints + gitgutter signs
"set noequalalways " don't resize splits when opening a new one
" (disabled on 2023-08-16)
"set clipboard=unnamed " yank to system clipboard

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
set background=dark
lua << EOF
require('kanagawa').setup({
    transparent = true,         -- do not set background color
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- "dragon"/"wave"
    },
})
EOF
colorscheme kanagawa

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
map <leader>nt :tabnew<CR>
map <leader>tc :tabclose<CR>
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
vnoremap <leader>il y<esc>oconsole.log('<c-r>"', <c-r>");<esc>

"" statusline
set laststatus=3
set statusline=                   " left
set statusline+=%2*\  " blank
set statusline+=%2*\%{StatuslineMode()}
set statusline+=%2*\  " blank
set statusline+=%1*\ <<
set statusline+=%1*\ %f " file              
set statusline+=%1*\ >>
set statusline+=%=                " right
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%3*\%h%m%r  " flags
"set statusline+=%4*\%{b:gitbranch} " git branch. removed 2022-11-23 as its
""  getting in the way of file names
"set statusline+=%3*\%.25F
set statusline+=%3*\::
set statusline+=%3*\%c,%l/%L\\| " lines
set statusline+=%3*\%y  " type
hi StatusLine ctermbg=none ctermfg=black guibg=none guifg=black
hi StatusLineNC ctermbg=none ctermfg=grey guibg=none guifg=grey
hi User1 ctermbg=none ctermfg=grey guibg=none guifg=grey
hi User2 ctermbg=lightmagenta ctermfg=black guibg=lightmagenta guifg=black
hi User3 ctermbg=none ctermfg=lightblue guibg=none guifg=lightblue
hi User4 ctermbg=none ctermfg=lightcyan guibg=none guifg=lightcyan

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
""" removed in favour of vim-test rt 2023-05-26

"" close all windows + tabs except current buffer 2022-11-10
command! BufOnly execute '%bdelete!|edit#|bdelete#|normal `"'

"" paste multiple times 2022-11-11
xnoremap p pgvy

"" quick format json file 2022-11-29
nmap =j :%!python3 -m json.tool<CR>

"" syntax folding w auto open
"" commands: za toggle open/close, zA toggle nested, zR open all, zM close all
"set foldmethod=syntax
"au BufAdd,BufRead,BufWinEnter * normal zR
" fold using nvim-treesitter 2023-05-26
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                     " Disable folding at startup.

"" terminal mode improvements 2022-12-01
""" allow fzf to use different binding
tnoremap <expr> <esc> &filetype == 'fzf' ? "\<esc>" : "\<c-\>\<c-n>"
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd TermOpen * setlocal nonumber norelativenumber

"" ctags 2023-01-04
set tags=./tags;$HOME

"" indent file & return to location 2023-05-26
nmap == gg=G''

" fix whatever plugin keeps stealing my Esc key 2023-05-26
iunmap <Esc>

" no background for vertical split bar
hi VertSplit guibg=white
hi VertSplit guifg=grey
" add split bar colour to kanagawa dragon colorscheme 2024-07-01
hi WinSeparator guifg=#272733

" markdown checkbox auto-mapping on '-' 2023-12-08
augroup MarkdownCheckbox
  autocmd!
  autocmd FileType markdown nnoremap <buffer> <silent> - :call winrestview(<SID>toggle('^\s*-\s*\[\zs.\ze\]', {' ': 'x', 'x': 'o', 'o': ' '}))<cr>
  autocmd FileType vimwiki nnoremap <buffer> <silent> - :call winrestview(<SID>toggle('^\s*-\s*\[\zs.\ze\]', {' ': 'x', 'x': 'o', 'o': ' '}))<cr>
  autocmd FileType markdown nnoremap <buffer> <silent> ~ :call winrestview(<SID>toggle('^\s*-\s*\[\zs.\ze\]', {' ': '~', '~': ' '}))<cr>
  autocmd FileType vimwiki nnoremap <buffer> <silent> ~ :call winrestview(<SID>toggle('^\s*-\s*\[\zs.\ze\]', {' ': '~', '~': ' '}))<cr>
augroup END

function s:toggle(pattern, dict, ...)
  let view = winsaveview()
  execute 'keeppatterns s/' . a:pattern . '/\=get(a:dict, submatch(0), a:0 ? a:1 : " ")/e'
  return view
endfunction

" better markdown viewing 2024-06-25
autocmd FileType markdown,vimwiki setlocal nonumber norelativenumber syntax=markdown
