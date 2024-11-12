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
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "gopls", -- Go
          "eslint", --Javascript/Typescript Linters
        },
        highlight = {
          enable = true,
        },
      })
    end,
  },

  -- LSPConfig: Configuring each LSP server
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      vim.diagnostic.config({
        virtual_text = false, -- Completely disables inline virtual text for diagnostics
        float = {
          source = "if_many", -- shows the source of the diagnostic (e.g., LSP name) in floating windows
          border = "rounded", -- Optional: adds a rounded border to the floating window
          format = function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
          end,
        },
        signs = true, -- Show signs in the sign column
        underline = true, -- Underline diagnostic issues in the code
        update_in_insert = false, -- Update diagnostics only in Normal mode
        severity_sort = true, -- Sort diagnostics by severity
      })
      vim.opt.signcolumn = "auto" -- Set sign column to auto

      -- Lua server setup
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- Recognize `vim` as a global variable
            },
          },
        },
      })

      -- Go server setup
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
          end
          -- Optional: Set autocommands for formatting on save
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
        settings = {
          gopls = {
            gofumpt = true, -- Enable additional formatting settings
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      -- ESLint server setup
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Enable document formatting for eslint
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end
        end,
        settings = {
          eslint = {
            -- Add any Eslint specific settings here
            autoFixOnSave = true, -- Automatically fixes issues on save
            format = {
              enable = true, -- Enable formatting with eslint
            },
          },
        },
      })

      -- Typescript server setup
      lspconfig.tsserver.setup({})

      -- Optional: Set up LSP keymaps for attached buffers
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local bufopts = { noremap = true, silent = true, buffer = buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)

          -- Floating diagnostic on hover
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = buf,
            callback = function()
              vim.diagnostic.open_float(nil, { focusable = false })
            end,
          })
        end,
      })
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
