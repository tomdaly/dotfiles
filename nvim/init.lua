-- 🚀 neovim config (nvim 0.11+)
--
-- migrated from ~/.vimrc (vim-plug, coc.nvim) → lua + lazy.nvim + native LSP
-- backups: ~/.vimrc.bak, ~/.config/nvim/init.vim.bak, ~/.config/nvim/coc-settings.json.bak
--
-- 📂 structure:
--   config/options.lua    — vim.opt settings
--   config/lazy.lua       — lazy.nvim bootstrap (auto-loads lua/plugins/*.lua)
--   config/statusline.lua — custom statusline (uses FugitiveStatusline())
--   config/keymaps.lua    — non-plugin keymaps
--   config/autocmds.lua   — autocommands
--   lsp/*.lua             — native vim.lsp.config server configs (auto-discovered by nvim 0.11)
--
-- 🔌 plugins (lazy.nvim):
--   lsp.lua        — mason + mason-lspconfig + blink.cmp (completion) + LspAttach keymaps + tiny-inline-diagnostic
--   treesitter.lua — treesitter + textobjects (if/af/ic/ac)
--   git.lua        — fugitive (non-lazy), rhubarb, gitgutter
--   fzf.lua        — fzf + fzf.vim + custom :Rg/:Project commands
--   dap.lua        — nvim-dap + ruby + dap-ui
--   test.lua       — vim-test (neovim strategy)
--   editing.lua    — surround, sneak, abolish, quickfix-reflector
--   navigation.lua — tmux-navigator, vinegar, projectionist
--   ui.lua         — kanagawa (transparent), goyo/limelight, netrw, tmuxline, dashboard
--   agentic.lua    — agentic.nvim
--   misc.lua       — workspace, winresizer, todo-comments, rails
--
-- 🗄️ data dirs (preserved from ~/.vim/):
--   ~/.vim/undodir/   — persistent undo
--   ~/.vim/sessions/  — vim-workspace sessions
--   ~/.vim/spell/     — spellfile

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.lazy")
require("config.statusline")
require("config.keymaps")
require("config.autocmds")
