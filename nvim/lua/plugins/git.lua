-- 🌿 git: fugitive, rhubarb, gitgutter
return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      { "<leader>g", ":G<CR>", desc = "fugitive status" },
    },
  },
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
  },
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
  },
}
