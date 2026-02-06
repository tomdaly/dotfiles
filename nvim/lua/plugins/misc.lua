-- 📦 misc: workspace, winresizer, todo-comments, rails
return {
  {
    "thaerkh/vim-workspace",
    lazy = false,
    init = function()
      vim.g.workspace_session_directory = vim.fn.expand("~/.vim/sessions/")
      vim.g.workspace_session_disable_on_args = 1
      vim.g.workspace_persist_undo_history = 0
    end,
  },
  {
    "simeji/winresizer",
    cmd = "WinResizerStartResize",
    keys = {
      { "<C-e>", ":WinResizerStartResize<CR>", desc = "resize windows" },
    },
  },
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        highlight = {
          pattern = [[.*<((KEYWORDS)%(\(.{-1,}\))?):]],
        },
        search = {
          pattern = [[\b(KEYWORDS)(\(\w*\))*:]],
        },
      })
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}
