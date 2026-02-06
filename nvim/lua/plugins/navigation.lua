-- 🧭 navigation: tmux-navigator, vinegar, projectionist
return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    "tpope/vim-vinegar",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "tpope/vim-projectionist",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "ga", ":A<CR>", desc = "alternate file" },
    },
  },
}
