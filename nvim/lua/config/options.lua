local option = vim.opt

option.shell = "/bin/zsh"
option.encoding = "utf-8"
option.updatetime = 300
option.scrolloff = 4
option.showmode = false
option.autoread = true
option.cindent = true
option.wrap = true
option.swapfile = false
option.backup = false
option.writebackup = false

-- undo
vim.fn.mkdir(vim.fn.expand("~/.vim/undodir"), "p")
option.undodir = vim.fn.expand("~/.vim/undodir")
option.undofile = true
option.backupdir = vim.fn.expand("~/.vim/backupdir/")

option.number = true
option.relativenumber = true
option.cursorline = true
option.showcmd = true
option.wildmenu = true
option.lazyredraw = true
option.ruler = true
option.hlsearch = false
option.incsearch = true
option.ignorecase = true
option.smartcase = true
option.magic = true
option.showmatch = true
option.mat = 2
option.foldcolumn = "0"
option.foldlevel = 9
option.visualbell = false
option.errorbells = false
option.tabstop = 2
option.shiftwidth = 2
option.softtabstop = 2
option.expandtab = true
option.smarttab = true
option.modelines = 0
option.wrapscan = false
option.splitbelow = true
option.splitright = true
option.completeopt = { "longest", "menuone" }
option.backspace = { "indent", "eol", "start" }
option.hidden = true
option.cmdheight = 2
option.shortmess:append("c")
option.conceallevel = 2
option.signcolumn = "auto:2"
option.laststatus = 3
option.termguicolors = true
option.background = "dark"

-- treesitter folding
option.foldmethod = "expr"
option.foldexpr = "v:lua.vim.treesitter.foldexpr()"
option.foldenable = false

-- find files recursively
option.path = ".,/usr/include,,**"

-- ctags
option.tags = "./tags;$HOME"

-- netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

-- spellfile
option.spellfile = vim.fn.expand("~/.vim/spell/en.utf-8.add")
