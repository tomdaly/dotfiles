-- 🔍 fzf + fzf.vim + custom commands
return {
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end,
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    event = "VeryLazy",
    init = function()
      vim.g.fzf_vim = {
        preview_window = { "right:40%" },
        tags_command = "rg --files | ctags -R --links=no -L -",
      }
      vim.g.fzf_action = {
        ["ctrl-q"] = function(lines)
          vim.fn.setqflist(vim.tbl_map(function(val)
            return { filename = val, lnum = 1 }
          end, lines))
          vim.cmd("copen")
          vim.cmd("cc")
        end,
        ["ctrl-t"] = "tab split",
        ["ctrl-x"] = "split",
        ["ctrl-v"] = "vsplit",
      }
    end,
    config = function()
      -- custom :Rg command
      vim.api.nvim_create_user_command("Rg", function(opts)
        local query = opts.args
        local command = "rg --column --line-number --no-column --no-heading --color=always --smart-case -- "
          .. vim.fn.shellescape(query)
        if opts.bang then
          vim.fn["fzf#vim#grep"](
            command,
            1,
            vim.fn["fzf#vim#with_preview"]({ options = "--delimiter : --nth 3.." })
          )
        else
          vim.fn["fzf#vim#grep"](command, 1, vim.fn["fzf#vim#with_preview"]("right:40%", "?"))
        end
      end, { bang = true, nargs = "*" })

      -- custom :Project command
      vim.api.nvim_create_user_command("Project", function()
        vim.fn["fzf#run"](vim.fn["fzf#wrap"]("projects", {
          sink = function(project)
            vim.cmd("lcd ~/dev/" .. project)
            vim.cmd("tabedit ~/dev/" .. project)
          end,
          source = "find ~/dev -name .git -maxdepth 2 | cut -d '/' -f 5 | sort",
        }))
      end, {})
    end,
    keys = {
      { "<leader>p", ":FZF<CR>", desc = "fzf files" },
      { "<leader>P", ":Project<CR>", desc = "fzf projects" },
      { "<leader>h", ":History<CR>", desc = "fzf history" },
      { "<leader>f", ":Rg<CR>", desc = "ripgrep search" },
      { "<leader>rg", ":Rg <C-R><C-W><CR>", desc = "ripgrep word under cursor" },
    },
  },
}
