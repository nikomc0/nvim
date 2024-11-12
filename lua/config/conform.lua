local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    css = { "prettier" },
    html = { "prettier" },
  },
}

return options
