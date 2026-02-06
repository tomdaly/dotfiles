-- 🎨 UI: colorscheme, zen mode, dashboard
return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = "wave",
        background = {
          dark = "wave",
        },
      })
      vim.cmd("colorscheme kanagawa")
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#393939" })
      vim.api.nvim_set_hl(0, "VertSplit", { bg = "white", fg = "grey" })
    end,
  },
  {
    "junegunn/goyo.vim",
    cmd = "Goyo",
    init = function()
      vim.g.goyo_width = "80%"
      vim.g.goyo_height = "80%"
    end,
    dependencies = { "junegunn/limelight.vim" },
  },
  {
    "junegunn/limelight.vim",
    cmd = "Limelight",
    init = function()
      vim.g.limelight_conceal_guifg = "#434340"
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        command = "Limelight",
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        command = "Limelight!",
      })
    end,
  },
  {
    "prichrd/netrw.nvim",
    config = function()
      require("netrw").setup({
        icons = {},
      })
    end,
  },
  {
    "edkolev/tmuxline.vim",
    cmd = "Tmuxline",
    init = function()
      vim.g.tmuxline_theme = "jellybeans"
      vim.g.tmuxline_preset = "minimal"
      vim.g.tmuxline_status_justify = "centre"
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = " find files", group = "Label", action = "FZF", key = "f" },
            { desc = " project", group = "Label", action = "Project", key = "p" },
            { desc = "󰋚 recent", group = "Label", action = "History", key = "h" },
            { desc = " vault", group = "Label", action = "FZF ~/vault", key = "v" },
            { desc = " new file", group = "Label", action = "enew", key = "n" },
            { desc = "󰊳 update", group = "Label", action = "Lazy update", key = "u" },
          },
          mru = { limit = 10 },
          project = { enable = false },
          packages = { enable = true },
        },
      })
    end,
  },
}
