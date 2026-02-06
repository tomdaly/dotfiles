-- 🌳 treesitter + textobjects
local parsers = {
  "ruby",
  "typescript",
  "javascript",
  "python",
  "json",
  "yaml",
  "html",
  "css",
  "bash",
  "lua",
  "vim",
  "vimdoc",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = parsers,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "outer function" })
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, { desc = "outer class" })
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "inner class" })
    end,
  },
}
