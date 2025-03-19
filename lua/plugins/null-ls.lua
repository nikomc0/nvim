return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Formatting
          null_ls.builtins.formatting.prettier, -- JS/TS/HTML/CSS
          null_ls.builtins.formatting.stylua, -- Lua
        },

        -- Disable completion provider from null-ls
        on_attach = function(client, bufnr)
          -- Prevent null-ls from acting as an LSP for completions
          -- client.server_capabilities.completionProvider = false

          -- Set up formatting on save
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  async = false,
                  filter = function(lsp_client)
                    return lsp_client.name == "null-ls"
                  end,
                })
              end,
            })
          end
        end,
      })
    end,
  },
}
