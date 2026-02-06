-- 🔧 LSP: mason + blink.cmp + native vim.lsp.config (nvim 0.11+) + tiny-inline-diagnostic
return {
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "solargraph",
          "jsonls",
          "html",
          "lua_ls",
          "eslint",
          "rubocop",
        },
        automatic_enable = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "saghen/blink.cmp" },
    config = function()
      -- set blink.cmp capabilities for all servers
      vim.lsp.config["*"] = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      }

      -- LspAttach keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local buffer = event.buf
          local map = function(mode, lhs, rhs, description)
            vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = description })
          end

          map("n", "gd", vim.lsp.buf.definition, "go to definition")
          map("n", "gy", vim.lsp.buf.type_definition, "go to type definition")
          map("n", "gi", vim.lsp.buf.implementation, "go to implementation")
          map("n", "gr", vim.lsp.buf.references, "find references")
          map("n", "K", vim.lsp.buf.hover, "hover documentation")
          map("n", "[g", vim.diagnostic.goto_prev, "previous diagnostic")
          map("n", "]g", vim.diagnostic.goto_next, "next diagnostic")
          map("n", "<leader>rn", vim.lsp.buf.rename, "rename symbol")
          map("n", "<leader>qf", vim.lsp.buf.code_action, "code action (quickfix)")
          map("n", "<leader>re", vim.lsp.buf.code_action, "code action (refactor)")
          map("x", "<leader>r", vim.lsp.buf.code_action, "code action (selection)")
          map("n", "<leader>cl", vim.lsp.codelens.run, "run codelens")

          -- :Format command
          vim.api.nvim_buf_create_user_command(buffer, "Format", function()
            vim.lsp.buf.format()
          end, {})

          -- :OR (organize imports)
          vim.api.nvim_buf_create_user_command(buffer, "OR", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports" } },
              apply = true,
            })
          end, {})

          map("n", "<leader>s", vim.lsp.buf.document_symbol, "document symbols")

          -- highlight symbol under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd("CursorHold", {
              buffer = buffer,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
              buffer = buffer,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- eslint auto-fix on save
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              command = "EslintFixAll",
            })
          end
        end,
      })

      -- enable all servers (mason-lspconfig handles this via automatic_enable,
      -- but explicit enable ensures servers work even without mason)
      vim.lsp.enable({
        "ts_ls",
        "solargraph",
        "jsonls",
        "html",
        "lua_ls",
        "eslint",
        "rubocop",
      })
    end,
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      keymap = {
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-b>"] = { "scroll_documentation_up" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = {
          auto_show = true,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("tiny-inline-diagnostic").setup()
    end,
  },
}
