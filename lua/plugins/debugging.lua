return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dapui").setup()
    require("dap-go").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "<Leader>dc", function()
      dap.continue()
    end)
    vim.keymap.set("n", "<Leader>dst", function()
      dap.step_over()
    end)
    vim.keymap.set("n", "<Leader>dsi", function()
      dap.step_into()
    end)
    vim.keymap.set("n", "<Leader>dso", function()
      dap.step_out()
    end)
    vim.keymap.set("n", "<Leader>dt", function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>dbp", function()
      dap.set_breakpoint()
    end)
    vim.keymap.set("n", "<Leader>lp", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end)
  end,
}