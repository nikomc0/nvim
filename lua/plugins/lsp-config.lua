return {
  -- Mason: LSP server manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason-LSPConfig: Bridge between Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local masonlspconfig = require("mason-lspconfig")

      masonlspconfig.setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "gopls", -- Go
          "eslint", --Javascript/Typescript Linters
        },
        automatic_installation = true,
        highlight = {
          enable = true,
        },
      })

      masonlspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({})
        end,
      })
    end,
  },

  -- LSPConfig: Configuring each LSP server
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", { "antosha417/nvim-lsp-file-operations", config = true } },
    config = function()
      -- vim.diagnostic.config({
      --   virtual_text = false, -- Completely disables inline virtual text for diagnostics
      --   float = {
      --     source = "if_many", -- shows the source of the diagnostic (e.g., LSP name) in floating windows
      --     border = "rounded", -- Optional: adds a rounded border to the floating window
      --     format = function(diagnostic)
      --       return string.format("%s (%s)", diagnostic.message, diagnostic.source)
      --     end,
      --   },
      --   signs = true, -- Show signs in the sign column
      --   underline = true, -- Underline diagnostic issues in the code
      --   update_in_insert = false, -- Update diagnostics only in Normal mode
      --   severity_sort = true, -- Sort diagnostics by severity
      -- })
      vim.opt.signcolumn = "auto" -- Set sign column to auto

      local keymap = require("config.keymaps.lsp_keymaps")

      -- Optional: Set up LSP keymaps for attached buffers
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          keymap.lsp_keymaps(args.buf)
        end,
      })

      -- Floating diagnostic on hover
      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   buffer = buf,
      --   callback = function()
      --     vim.diagnostic.open_float(nil, { focusable = true })
      --   end,
      -- })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = {
          border = "rounded",
        },
      })
    end,
  },
}
