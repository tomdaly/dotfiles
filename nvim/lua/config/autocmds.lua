-- 🔄 autocommands

-- auto :e to get file changes on focus
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

-- cursorline only in active window
local cursorline_group = vim.api.nvim_create_augroup("CursorLineOnlyInActiveWindow", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- python indentation
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.py",
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.fileformat = "unix"
  end,
})

-- auto mkdir when saving to non-existent directory
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- wrap git commit lines to 72 chars
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.bo.textwidth = 72
  end,
})

-- auto close netrw buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.bo.bufhidden = "wipe"
  end,
})

-- fix ctrl-L in netrw (vim-tmux-navigator conflict)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "<c-l>", ":wincmd l<cr>", { buffer = true })
  end,
})

-- terminal: start in insert mode, hide line numbers
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- markdown: no line numbers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.bo.syntax = "markdown"
  end,
})

