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
          require("none-ls.diagnostics.eslint_d").with({
            command = "eslint_d",
            extra_args = { "--stdin-filename", "$FILENAME", "--config", "eslint.config.mjs" },
            prefer_local = "node_modules/.bin",
          }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier.with({
            extra_args = { "--single-quote", "false" },
            filetypes = { "javascript", "typescript", "typescriptreact", "css", "html", "json" },
          }),
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.diagnostics.golangci_lint,
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
}
