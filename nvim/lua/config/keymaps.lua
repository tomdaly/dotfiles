-- ⌨️ non-plugin keymaps
local map = vim.keymap.set

-- split navigation
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")

-- tabs
map("", "<leader>nt", ":tabnew<CR>")
map("", "<leader>tc", ":tabclose<CR>")

-- buffer switching
map("n", "gb", ":ls<CR>:b<Space>")

-- spellcheck toggle
map("", "<leader>c", ":setlocal spell!<CR>")

-- move between wrapped lines
map("n", "j", "v:count ? 'j' : 'gj'", { expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { expr = true })

-- don't jump to next word using * (use *cgn to change word under cursor, then . to repeat)
map("n", "*", ":keepjumps normal! mi*`i<CR>")

-- quick save (enter to save, but not in quickfix)
map("n", "<CR>", function()
  if vim.bo.buftype == "quickfix" then
    return "<CR>"
  end
  return ":update<CR>"
end, { expr = true })

-- quick js console logging
map("v", "<leader>il", "y<esc>oconsole.log('<c-r>\"', <c-r>\");<esc>")

-- paste multiple times
map("x", "p", "pgvy")

-- quick format json
map("n", "=j", ":%!python3 -m json.tool<CR>")

-- indent file and return to location
map("n", "<>", "gg=G''")

-- zoom toggle (like tmux)
map("n", "<leader>z", function()
  if vim.fn.winnr("$") == 1 then
    return
  end
  local restore_cmd = vim.fn.winrestcmd()
  vim.cmd("wincmd |")
  vim.cmd("wincmd _")
  if restore_cmd == vim.fn.winrestcmd() then
    vim.cmd(vim.t.zoom_restore or "")
  else
    vim.t.zoom_restore = restore_cmd
  end
end)

-- close all windows + tabs except current buffer
vim.api.nvim_create_user_command("BufOnly", function()
  vim.cmd("%bdelete!|edit#|bdelete#|normal `\"")
end, {})

-- terminal mode: esc exits terminal (except fzf)
map("t", "<esc>", function()
  if vim.bo.filetype == "fzf" then
    return "<esc>"
  end
  return "<c-\\><c-n>"
end, { expr = true })
