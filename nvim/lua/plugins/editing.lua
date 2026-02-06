-- ✏️ editing: surround, sneak, abolish, quickfix-reflector
return {
  {
    "tpope/vim-surround",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "justinmk/vim-sneak",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "tpope/vim-abolish",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "stefandtw/quickfix-reflector.vim",
    ft = "qf",
  },
}
