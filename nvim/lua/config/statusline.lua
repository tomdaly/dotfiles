-- 📊 custom statusline

local function statusline_mode()
  local mode_map = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "VISUAL",
    ["\22"] = "VISUAL",
    R = "REPLACE",
    c = "COMMAND",
    t = "TERMINAL",
  }
  return mode_map[vim.fn.mode()] or "COMMAND"
end

function StatuslineMode()
  return statusline_mode()
end

vim.o.statusline = table.concat({
  " ",
  "%2*",
  " %{v:lua.StatuslineMode()} ",
  "%1*",
  " << %f >>",
  "%3*",
  "%h%m%r",
  "%=",
  "%4*",
  "%{FugitiveStatusline()}",
  "%3*",
  "::",
  "%c,%l/%L| ",
  "%y ",
})

-- statusline highlights
local highlights = {
  { "StatusLine", { bg = "NONE", fg = "black" } },
  { "StatusLineNC", { bg = "NONE", fg = "grey" } },
  { "User1", { bg = "NONE", fg = "grey" } },
  { "User2", { bg = "grey", fg = "white" } },
  { "User3", { bg = "NONE", fg = "lightblue" } },
  { "User4", { bg = "NONE", fg = "lightcyan" } },
}

for _, highlight in ipairs(highlights) do
  vim.api.nvim_set_hl(0, highlight[1], highlight[2])
end
