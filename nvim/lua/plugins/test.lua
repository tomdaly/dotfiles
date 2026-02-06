-- 🧪 vim-test
return {
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestLast", "TestVisit" },
    init = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#start_normal"] = 0
      vim.g["test#echo_command"] = 0
      vim.g["test#typescript#jest#executable"] = "npm test"
      vim.g["test#javascript#jest#executable"] = "npm test"
      vim.g["test#javascriptreact#jest#executable"] = "npm test"
      vim.g["test#custom_runners"] = { Rego = { "Conftest" } }
    end,
    keys = {
      { "<leader>t", ":TestNearest<CR>", desc = "test nearest" },
      { "<leader>T", ":TestFile<CR>", desc = "test file" },
      { "<leader>l", ":TestLast<CR>", desc = "test last" },
      { "<leader>L", ":TestVisit<CR>", desc = "test visit" },
    },
  },
}
