-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
-- Auto-format on save for specific file types
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.tsx", "*.css", "*.html", "*.json" },
  callback = function()
    if vim.bo.buftype ~= "" then
      print("Skipping formatting for this buffer")
      return
    end

    print("Formatting with null-ls") -- Debug
    vim.lsp.buf.format({
      filter = function(client)
        return client.name == "null-ls"
      end,
      timeout_ms = 2000,
    })
  end,
})
