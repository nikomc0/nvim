return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        debug = true,
        sources = {
          require("none-ls.diagnostics.eslint_d"),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "css", "html", "json" }, -- Exclude "markdown"
          }),
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.diagnostics.golangci_lint,
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
}
