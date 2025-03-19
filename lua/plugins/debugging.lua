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
    require("dap-go").setup({
      dap_configurations = {
        {
          type = "go",
          name = "Debug with DAP-Go",
          request = "launch",
          program = "${file}",
        },
      },
    })

    -- dap.adapters.go = function(callback, config)
    --   -- Use Delve's headless mode
    --   local handle
    --   local port = 38697
    --   handle, _ = vim.loop.spawn("dlv", {
    --     args = { "dap", "-l", "127.0.0.1:" .. port },
    --     detached = true,
    --   }, function(code)
    --     handle:close()
    --     print("Delve exited with code: " .. code)
    --   end)
    --
    --   -- Wait for delve to start
    --   vim.defer_fn(function()
    --     callback({ type = "server", host = "127.0.0.1", port = port })
    --   end, 100)
    -- end

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "go",
        name = "Debug Test (Nearest)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
      {
        type = "go",
        name = "Attach to running process",
        request = "attach",
        mode = "remote",
        host = "127.0.0.1",
        port = 2345,
        program = "${workspaceFolder}",
      },
    }

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
