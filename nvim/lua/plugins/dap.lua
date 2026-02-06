-- 🐛 DAP: ruby debugger
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "suketa/nvim-dap-ruby",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "toggle breakpoint" },
      { "<leader>dT", function() require("dap").clear_breakpoints() end, desc = "clear breakpoints" },
      { "<leader>dd", function() require("dap").continue() end, desc = "continue" },
      { "<leader>dx", function() require("dap").terminate() end, desc = "terminate" },
      { "<leader>dj", function() require("dap").step_over() end, desc = "step over" },
      { "<leader>dl", function() require("dap").step_into() end, desc = "step into" },
      { "<leader>dh", function() require("dap").step_out() end, desc = "step out" },
      { "<leader>di", function() require("dapui").eval() end, desc = "eval" },
      { "<leader>dI", function() require("dapui").toggle() end, desc = "toggle dap ui" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("dap-ruby").setup()

      -- ruby: attach to puma
      table.insert(dap.configurations.ruby, {
        type = "ruby",
        name = "run zeroheight/rails puma",
        bundle = "bundle",
        request = "attach",
        command = "puma",
        args = { "-b", "tcp://localhost:38698" },
        port = 38698,
        server = "127.0.0.1",
        options = {
          source_filetype = "ruby",
        },
        localfs = true,
        waiting = 1000,
      })

      -- auto open/close dap ui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
