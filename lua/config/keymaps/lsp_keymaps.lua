local M = {}
M.lsp_keymaps = function(buf)
  local bufopts = { noremap = true, silent = true, buffer = buf }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set("n", "gd", function()
  --   require("telescope.builtin").lsp_definitions({
  --     jump_type = "never",
  --   })
  --   vim.cmd("copen")
  -- end, { noremap = true, silent = true })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
end
return M
